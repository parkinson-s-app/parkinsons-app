import debugLib from 'debug';
import { Request, Response, Router } from 'express';
import { constants } from 'http2';
import IPersonDto from '../models/IPersonDto';
import PersonService from '../services/PersonService';
import PatientService from '../services/PatientService';
import * as bcrypt from 'bcryptjs';
import * as jwt from 'jsonwebtoken';
import IUserDto from '../models/IUserDto';
import config from '../config';
import { verifyToken } from '../utilities/AuthUtilities';
import IPersonalDataDto from '../models/IPersonalDataDto';
import multer from '../utilities/multer';
import ISymptomsFormDto from '../models/ISymptomsFormDto';
import DoctorService from '../services/DoctorService';
import CarerService from '../services/CarerService';

const debug = debugLib('AppKinson:UserController');
const UserController = Router();
const secretKey = config.secretKey;

UserController.post('/registro', async (req: Request, res: Response) => {
    debug('Registro Body: %j', req.body);
    const person = req.body as IPersonDto;
    const response = await PersonService.savePerson(person);
    debug('Registro response db: %j', response);
    if(response) {
        const status =  constants.HTTP_STATUS_OK;
        res.status(status).send('Guardado');
    } else {
        const status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        res.status(status).send('Error');
    }
});

UserController.get('/users', async (req: Request, res: Response) => {
    debug('Users Get');
    const response = await PersonService.getPeople();
    debug('User get response db: %j', response);
    if(response) {
        const status =  constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } else {
        const status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        res.status(status).send('Error');
    }
});

UserController.get('/users/:id', verifyToken, async (req: Request, res: Response) => {
    debug('Users GetByID');
    const id = +req.params.id;
    debug('Users GetById id: ', id);
    const response = await PersonService.getPersonById(id);
    debug('User get by id response db: %j', response);
    if(response) {
        const status =  constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } else {
        const status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        res.status(status).send('Error');
    }
});

UserController.post('/login', async (req: Request, res: Response) => {
    debug('Login Body entry: %j', req.body);
    const credentials = req.body as IPersonDto;
    const responseDB = await PersonService.getPersonByEmail(credentials.email);
    debug('Login Credentials: %j', credentials);
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

            // res.status(status).send(user);
        } else {
            status =  constants.HTTP_STATUS_NOT_FOUND;
            res.status(status).send({ person:'Invalid Password' });
        }
    }
});

async function compare(password: string, passwordInDB: string) {
    const isMatch = await bcrypt.compare(password, passwordInDB);
    return isMatch;
}

UserController.post('/users/:id', multer.single('photo'), verifyToken, async (req: Request, res: Response) => {
    debug('Users UpdateById');
    const id = +req.params.id;
    let updatedUserData = req.body as IPersonalDataDto;
    updatedUserData.PHOTOPATH = req.file.path;
    debug('Users Update user: %j, ID:', updatedUserData, id);
    const response = await PersonService.updatePerson(id, updatedUserData);
    debug('User UpdateById response db: %j', response);
    if(response) {
        const status =  constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } else {
        const status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        res.status(status).send('Error');
    }
});

UserController.post('/users/:id/symptomsForm', multer.single('video'), verifyToken, async (req: Request, res: Response) => {
    debug('Users UpdateById');
    const id = +req.params.id;
    debug('Users Symptoms body: %j, ID: %s, file path: %s',req.body, id, req.file.path);
    let symptomsFormData = req.body as ISymptomsFormDto;
    if (req.file) {
        debug('Users Symptoms body: %j, ID: %s, file path: %s',req.body, id, req.file.path);
    } else {
        debug('Users Symptoms body: %j, ID: %s, without file',req.body, id);
    }
    // let updatedUserData = req.body as IPersonalDataDto;
    // updatedUserData.PHOTOPATH = req.file.path;
    // debug('Users Update user: %j, ID:', updatedUserData, id);
    // const response = await PersonService.updatePerson(id, updatedUserData);
    // debug('User UpdateById response db: %j', response);
    // if(response) {
    //     const status =  constants.HTTP_STATUS_OK;
    //     res.status(status).send(response);
    // } else {
    //     const status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
    //     res.status(status).send('Error');
    // }
    res.status(200).send('ok perro');
});

UserController.post('/users/:id/symptomsFormPatient', multer.single('video'), verifyToken, async (req: Request, res: Response) => {
    debug('Patients form by Id');
    const id = +req.params.id;
    debug('Patients Symptoms body: %j, ID: %s, file path: %s',req.body, id, req.file.path);
    let symptomsFormData = req.body as ISymptomsFormDto;
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
        debug('Patient symptoms saving failed');
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error};
        res.status(status).send(responseError);
    }
});

UserController.get('/patient/relationRequest', verifyToken, async (req: Request, res: Response) => {
    debug('Getting requests of a patient');
    const bearerHeader = req.headers['authorization'];
    let status;
    if( bearerHeader !== undefined ) {
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
    } else {
        debug('Related Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});

UserController.get('/patients/relationRequest', verifyToken, async (req: Request, res: Response) => {
    debug('Mock Getting requests of a patient');
    const bearerHeader = req.headers['authorization'];
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){
            // try {
                const requests = 'OK';
                status = constants.HTTP_STATUS_OK;
                res.status(status).send(requests);
            // } catch (error) {
            //     status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
            //     const responseError = { status, error};
            //     res.status(status).send(responseError);
            // }
        }
    } else {
        debug('Mock Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});

UserController.get('/patients/:id/symptomsFormPatient', verifyToken, async (req: Request, res: Response) => {
    debug('Getting symptoms form');
    const bearerHeader = req.headers['authorization'];
    const id = +req.params.id;
    debug('Patients form by Id, id: %s', id);
    let status;
    if( bearerHeader !== undefined ) {
        const idSender = getIdFromToken(bearerHeader);
        if( !isNaN(idSender) ){
            
            try {
                const requests = await PersonService.getSymptomsForm(id);
                debug('Getting symptoms form result %j', requests);
                status = constants.HTTP_STATUS_OK;
                res.status(status).send(requests);
            } catch (error) {
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error};
                res.status(status).send(responseError);
            }
        }
    } else {
        debug('Mock Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});

UserController.get('/me', verifyToken, async (req: Request, res: Response) => {
    debug('Getting info about user');
    const bearerHeader = req.headers['authorization'];
    let status;
    if( bearerHeader !== undefined ) {
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
    } else {
        debug('Getting info about use Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
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
