import debugLib from 'debug';
import { Request, Response, Router } from 'express';
import { constants } from 'http2';
import IPersonDto from '../models/IPersonDto';
import PersonService from '../services/PersonService';
import PatientService from '../services/PatientService';
import * as jwt from 'jsonwebtoken';
import IUserDto from '../models/IUserDto';
import config from '../config';
import { compare, verifyToken } from '../utilities/AuthUtilities';
import IPersonalDataDto from '../models/IPersonalDataDto';
import multer from '../utilities/multer';
import ISymptomsFormDto from '../models/ISymptomsFormDto';
import DoctorService from '../services/DoctorService';
import CarerService from '../services/CarerService';
import fs from 'fs';
import OTPUtilities from '../utilities/OTPUtilities';
import EmailUtilities from '../utilities/EmailUtilities';
import IPersonResetDto from '../models/IPersonResetDto';

const debug = debugLib('AppKinson:UserController');
const UserController = Router();
const secretKey = config.secretKey;

UserController.post('/registro', async (req: Request, res: Response) => {
    debug('Register Body: %j', req.body);
    const person = req.body as IPersonDto;
    let status;
    try {
        const response = await PersonService.savePerson(person);
        debug('Register response db: %j', response);
        if(response) {
            status =  constants.HTTP_STATUS_OK;
            res.status(status).send('Guardado');
        } else {
            status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
            res.status(status).send('Error');
        }
    }  catch (error) {
        debug('Register failed, error: %j', error);
        const errorString: string = error.message;
        let responseError;
        if(errorString.includes('Duplicate entry')) {
            responseError = 'Existe';
            status = constants.HTTP_STATUS_BAD_REQUEST;
        } else {
            status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
            responseError = { status, error: 'An error has ocurred'};
        }
        res.status(status).send(responseError);
    }
});

UserController.get('/users', async (req: Request, res: Response) => {
    debug('Users Get');
    try {
        const response = await PersonService.getPeople();
        debug('User get response db: %j', response);
        if(response) {
            const status =  constants.HTTP_STATUS_OK;
            res.status(status).send(response);
        } else {
            const status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
            res.status(status).send('Error');
        }
    } catch (error) {
        debug('getting users failed. Error: %j', error);
        const status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});

UserController.post('/login', async (req: Request, res: Response) => {
    debug('Login user entry: %j', req.body.email);
    const credentials = req.body as IPersonDto;
    try {
        const responseDB = await PersonService.getPersonByEmail(credentials.email);
        debug('Login Credentials: %j', credentials.email);
        const responseJSON = JSON.parse(JSON.stringify(responseDB));
        debug('Login: responseDB ', responseJSON.length);
        debug('User get response db: %j', responseDB);
        let status;
        if (responseJSON.length === 0 ) {
            status =  constants.HTTP_STATUS_NOT_FOUND;
            res.status(status).send({ message:'Invalid Email' });
        } else {
            const isValid = await compare(credentials.password, responseJSON[0].PASSWORD);
            if (isValid) {
                status =  constants.HTTP_STATUS_OK;
                let user: IUserDto;
                user = {
                    email: responseJSON[0].EMAIL,
                    type: responseJSON[0].TYPE,
                    id: responseJSON[0].ID
                };
                debug('Login Sucessful user %j', user);
                jwt.sign(user, secretKey, { algorithm: 'HS512' }, (err, token) =>{
                    if( err ) {
                        debug('Login error %j', err);
                        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                        res.status(status).send({ status, error: err});
                    } else {
                        debug('Login send token');
                        res.json({
                            token
                        });
                    }
                });
            } else {
                status =  constants.HTTP_STATUS_NOT_FOUND;
                res.status(status).send({ person:'Invalid Password' });
            }
        }
    } catch (error) {
        debug('Login failed. Error: %j', error);
        const status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});

UserController.post('/users/:id', multer.single('photo'), verifyToken, async (req: Request, res: Response) => {
    debug('Users UpdateById');
    const id = +req.params.id;
    const updatedUserData = req.body as IPersonalDataDto;
    try {
        // verificando si la actualizacion tiene foto
        if(req.file) {
            updatedUserData.PHOTOPATH = req.file.path;
        }
        debug('Users Update user: %j, ID:', updatedUserData, id);
        const response = await PersonService.updatePerson(id, updatedUserData);
        debug('User UpdateById response db: %j', response);
        let status;
        if(response) {        
            status =  constants.HTTP_STATUS_OK;
            res.status(status).send(response);
        } else {
            status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
            res.status(status).send('Error');
        }
    } catch (error) {
        debug('Patient symptoms saving failed');
        const status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});

UserController.post('/users/:id/symptomsFormPatient', multer.single('video'), verifyToken, async (req: Request, res: Response) => {
    debug('Patients form by Id');
    const id = +req.params.id;
    debug('Patients Symptoms body: %j, ID: %s',req.body, id);
    const symptomsFormData = req.body as ISymptomsFormDto;
    let status;
    if(req.file && req.file.path ){
        symptomsFormData.pathvideo = req.file.path;
        debug('Patients Symptoms json: %j', symptomsFormData);
    }
    try {
        const response = await PersonService.saveSymptomsForm(id, symptomsFormData);
        debug('Patient symptoms save result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send('OK');
    } catch (error) {
        debug('Patient symptoms saving failed. Error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error};
        res.status(status).send(responseError);
    }
});

UserController.put('/users/:id/symptomsFormPatient', multer.single('video'), verifyToken, async (req: Request, res: Response) => {
    debug('Patients form update by Id');
    const id = +req.params.id;
    debug('Patients update Symptoms body: %j, ID: %s',req.body, id);
    const symptomsFormData = req.body as ISymptomsFormDto;
    let status;
    if(req.file && req.file.path ){
        symptomsFormData.pathvideo = req.file.path;
        debug('Patients update Symptoms json: %j', symptomsFormData);
    }
    try {
        const response = await PersonService.updateSymptomsForm(id, symptomsFormData);
        debug('Patient update symptoms save result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send('OK');
    } catch (error) {
        debug('Patient update symptoms failed. Error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error};
        res.status(status).send(responseError);
    }
});

UserController.delete('/users/:id/symptomsFormPatient', verifyToken, async (req: Request, res: Response) => {
    const id = +req.params.id;
    const date = req.query.Date as string;
    debug('Delete  sypmtoms formpatient Id: %s', id);
    // se obtiene la autenticación para saber si el usuario está con la sesión iniciada
    const bearerHeader = req.headers.authorization;
    let status;
        debug('Delete symptoms form patient data: %j', date);
        if ( id && date) {
            try {
                // se llama al servicio encargado de eliminar una persona por el id
                const response = await PersonService.deleteSymptomsForm(id, date);
                debug('Deletion sypmtoms formpatient response db: %j', response);
                if(response) {
                    status =  constants.HTTP_STATUS_OK;
                    // se devuelve una respuesta afirmativa indicando que el usuario ha
                    // sido eliminado
                    res.status(status).send('Eliminado');
                } else {
                    // si no hay respuesta por parte del servicio, se devuelve una respuesta
                    // indicando error en el servidor
                    status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                    res.status(status).send('Error');
                }
            } catch (error) {
                debug('Deletion  sypmtoms formpatient Catch Error: %s, %j', error.stack, error);
                status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                // si ocurre algún error y no se puede ejecutar la operación, se devuelve una respuesta
                // indicando error en el servidor
                res.status(status).send('Error');
            }
        } else {
            status =  constants.HTTP_STATUS_BAD_REQUEST;
            // si el usuario con la sesión iniciada no es un administrador, se indica que no está
            // autorizado para la operación
            res.status(status).send('Bad request');
        }
});

UserController.get('/patient/relationRequest', verifyToken, async (req: Request, res: Response) => {
    debug('Getting requests of a patient');
    const bearerHeader = req.headers.authorization as string;
    let status;
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){
            try {
                const requests = await PersonService.getRelationRequest(id);
                debug('Getting requests result %j', requests);
                status = constants.HTTP_STATUS_OK;
                res.status(status).send(requests);
            } catch (error) {
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error};
                res.status(status).send(responseError);
            }
        }
});

UserController.get('/patients/:id/symptomsFormPatient', verifyToken, async (req: Request, res: Response) => {
    debug('Getting symptoms form');
    const bearerHeader = req.headers.authorization as string;
    const id = +req.params.id;
    debug('Patients form by Id, id: %s', id);
    let status;
    const idSender = getIdFromToken(bearerHeader);
    if( !isNaN(idSender) ){
        try {
            const requests = await PersonService.getSymptomsForm(id);
            debug('Getting symptoms form result %j', requests);
            status = constants.HTTP_STATUS_OK;
            res.status(status).send(requests);
        } catch (error) {
            debug('Get symptoms form failed. Error: %j', error);
            status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
            const responseError = { status, error};
            res.status(status).send(responseError);
        }
    }
});

UserController.get('/users/me', verifyToken, async (req: Request, res: Response) => {
    debug('Getting info about user');
    const bearerHeader = req.headers.authorization as string;
    let status;
        const idSender = getIdFromToken(bearerHeader);
        const type = getTypeFromToken(bearerHeader);
        debug('Getting info about user by Id, id: %s', idSender);
        if( !isNaN(idSender) ){
            try {
                let responseDB;
                if(type === 'Doctor') {
                    responseDB = await DoctorService.getDoctorById(idSender);
                } else if(type === 'Paciente') {
                    responseDB = await PatientService.getPatientById(idSender);
                } else if(type === 'Cuidador') {
                    responseDB = await CarerService.getCarerById(idSender);
                } else {
                    status = constants.HTTP_STATUS_BAD_REQUEST;
                    responseDB = 'Error, Token inválido';
                }
                debug('Getting info about user result %j', responseDB);
                if(!status) {
                    status = constants.HTTP_STATUS_OK;
                }
                res.status(status).send(responseDB);
            } catch (error) {
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error};
                res.status(status).send(responseError);
            }
        }
});


UserController.get('/users/:id', verifyToken, async (req: Request, res: Response) => {
    debug('Users GetByID');
    const id = +req.params.id;
    debug('Users GetById id: ', id);
    let status;
    try {
        const response = await PersonService.getPersonById(id);
        debug('User get by id response db: %j', response);       
        if(response) {
            status =  constants.HTTP_STATUS_OK;
            res.status(status).send(response);
        } else {
            status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
            res.status(status).send('Error');
        }
    } catch (error) {
        debug('Get user by Id failed. Error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});


UserController.get('/download', verifyToken, async (req: Request, res: Response) => {
    debug('Download file %j', req.query.path);
    const bearerHeader = req.headers.authorization as string;
    let status;
    try {
        const idSender = getIdFromToken(bearerHeader);
        const path = req.query.path as string;
        debug('Download file, id: %s, file path: %s', idSender, path);
        if( !isNaN(idSender) ){
            if(path) {
                res.download(path);
            } else {
                res.send('bad');
            }            
        }
    } catch (error) {
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error};
        res.status(status).send(responseError);
    }
});


UserController.get('/users/toolbox/items', verifyToken, async (req: Request, res: Response) => {
    debug('getting toolbox items');
    let status;
    try {
        const response = await PersonService.getToolboxItems();
        debug('Patient getting toolbox items. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting medicine Alarms failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});


UserController.post('/user/forgotPassword', async (req: Request, res: Response) => {
    debug('Forgot password user entry: %j', req.body.email);
    const email = req.body.Email;
    try {
        const responseDB = await PersonService.getPersonByEmail(email);
        const responseJSON = JSON.parse(JSON.stringify(responseDB));
        debug('Forgotten password. User get response db: %j', responseDB);
        let status;
        if (responseJSON.length === 0 ) {
            status =  constants.HTTP_STATUS_NOT_FOUND;
            res.status(status).send({ message:'Invalid Email' });
        } else {
            debug(' Reset password email: %s', email);
            const otp = await OTPUtilities.generateOTP();
            const subject = 'Peticion de cambio de contraseña';
            const text = `Para poder cambiar su contraseña el codigo de verificación es: ${otp}`;
            const responseSendEmail = await EmailUtilities.sendEmail(email, subject, text);
            if(responseSendEmail) {
                status =  constants.HTTP_STATUS_OK;
                const responseOK = { status, message: 'Email sent'};
                res.status(status).send(responseOK);
            }
        }
    } catch (error) {
        debug('Forgotten password failed. Error: %j', error);
        const status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});

UserController.post('/user/resetPassword', async (req: Request, res: Response) => {
    debug('Reset password user entry: %j', req.body.email);
    const credentials = req.body as IPersonResetDto;
    try {
        debug('Reset password data: %j', credentials);
        const verified = await OTPUtilities.verifyOtp(credentials.OTP);
        if(verified){
            const responseDB = await PersonService.resetPassword(credentials);
            debug('Resetten password. User get response db: %j', responseDB);
            let status;
            if (responseDB) {
                status =  constants.HTTP_STATUS_OK;
                res.status(status).send({ message:'Password Reset' });
            } else {
                debug('Reset password failed response db.');
                status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error: 'An error has ocurred'};
                res.status(status).send(responseError);
            }
        } else {
            const status =  constants.HTTP_STATUS_UNAUTHORIZED;
            const responseError = { status, error: 'Unauthorized'};
            res.status(status).send(responseError);
        }
    } catch (error) {
        debug('Reset password failed. Error: %j', error);
        const status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
function getIdFromToken(token: string) {
        const dataInToken = token.split('.')[1];
        debug('getIdFromToken data encoded: %s', dataInToken);
        const decodedData = Buffer.from(dataInToken, 'base64').toString();
        debug('getIdFromToken data decoded: %s',decodedData);
        const dataInJSON = JSON.parse(decodedData);
        debug('getIdFromToken data in JSON: %j',dataInJSON);
        return +dataInJSON.id;
}

function getTypeFromToken(token: string) {
    const dataInToken = token.split('.')[1];
    debug('getTypeFromToken data encoded: %s', dataInToken);
    const decodedData = Buffer.from(dataInToken, 'base64').toString();
    debug('getTypeFromToken data decoded: %s',decodedData);
    const dataInJSON = JSON.parse(decodedData);
    debug('getTypeFromToken data in JSON: %j',dataInJSON);
    return dataInJSON.type;
}
export default UserController;
