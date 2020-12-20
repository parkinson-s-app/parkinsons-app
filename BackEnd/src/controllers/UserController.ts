import debugLib from 'debug';
import { Request, Response, Router } from 'express';
import { constants } from 'http2';
import IPersonCredencialsDto from '../models/IPersonCredencialsDto';
import IPersonDto from '../models/IPersonDto';
import PersonService from '../services/PersonService';
import * as bcrypt from 'bcryptjs';
import * as jwt from 'jsonwebtoken';
import IUserDto from '../models/IUserDto';
import config from '../config';
import { verifyToken } from '../utilities/AuthUtilities';

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
    const credentials = req.body as IPersonCredencialsDto;
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
                    })
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

UserController.put('/users/:id', verifyToken, async (req: Request, res: Response) => {
    debug('Users UpdateById');
    const id = +req.params.id;
    const updatedUserData = req.body;
    debug('Users Update user: %j, ID:', updatedUserData, id);
    // const response = await PersonService.updatePerson(id, updatedUserData);
    // debug('User UpdateById response db: %j', response);
    // if(response) {
    //     const status =  constants.HTTP_STATUS_OK;
    //     res.status(status).send(response);
    // } else {
    //     const status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
    //     res.status(status).send('Error');
    // }
    res.status(200).send('Actualizado');
});
export default UserController;