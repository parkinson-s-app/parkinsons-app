import debugLib from 'debug';
import { Request, Response, Router } from 'express';
import { constants } from 'http2';
import IPersonCredencialsDto from '../models/IPersonCredencialsDto';
import IPersonDto from '../models/IPersonDto';
import PersonService from '../services/PersonService';

const debug = debugLib('AppKinson:UserController');
const UserController = Router();

UserController.post('/registro', async (req: Request, res: Response) => {
    debug('Registro Body: %j', req.body);
    const person = req.body as IPersonDto;
    const response = PersonService.savePerson(person);
    debug('Registro response db: %j', response);
    if(response) {
        const status =  constants.HTTP_STATUS_OK;
        res.status(status).send(response);
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

UserController.post('/login', async (req: Request, res: Response) => {
    debug('Login Body: %j', req.body);
    const credentials = req.body as IPersonCredencialsDto;
    const responseDB = await PersonService.getPersonByEmail(credentials.email);
    const responseJSON = JSON.parse(JSON.stringify(responseDB));
    debug('Login: responseDB ', responseJSON.length);
    let status;
    if (responseJSON.length === 0 ) {
        status =  constants.HTTP_STATUS_NOT_FOUND;
        res.status(status).send({ message:'Invalid Email' });
    }
    const isValid = compare(credentials.password, responseJSON[0].PASSWORD);
    if (isValid) {
        status =  constants.HTTP_STATUS_OK;
        res.status(status).send(responseJSON);
    } else {
        status =  constants.HTTP_STATUS_NOT_FOUND;
        res.status(status).send({ message:'Invalid Password' });
    }
});

function compare(password: string, passwordInDB: string) {
    return password === passwordInDB;
}
export default UserController;