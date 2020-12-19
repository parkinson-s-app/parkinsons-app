import debugLib from 'debug';
import { Request, Response, Router } from 'express';
import { constants } from 'http2';
import IPersonCredencialsDto from '../models/IPersonCredencialsDto';
import IPersonDto from '../models/IPersonDto';
import PersonService from '../services/PersonService';
import * as bcrypt from "bcryptjs";

const debug = debugLib('AppKinson:UserController');
const UserController = Router();

UserController.post('/registro', async (req: Request, res: Response) => {
    debug('Registro Body: %j', req.body);
    const person = req.body as IPersonDto;
    const response = PersonService.savePerson(person);
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

UserController.post('/login', async (req: Request, res: Response) => {
    debug('Login Body: %j', req.body);
    const credentials = req.body as IPersonCredencialsDto;
    const responseDB = await PersonService.getPersonByEmail(credentials.email);
    debug('Login Body: %j', req.body);
    const responseJSON = JSON.parse(JSON.stringify(responseDB));
    debug('Login: responseDB ', responseJSON.length);
    debug('User get response db: %j', responseDB);
    let status;
    if (responseJSON.length === 0 ) {
        status =  constants.HTTP_STATUS_NOT_FOUND;
        res.status(status).send({ message:'Invalid Email' });
    }
    const isValid = await compare(credentials.password, responseJSON[0].PASSWORD);
    if (isValid) {
        status =  constants.HTTP_STATUS_OK;
        res.status(status).send(responseJSON[0]);
    } else {
        status =  constants.HTTP_STATUS_NOT_FOUND;
        res.status(status).send({ message:'Invalid Password' });
    }
});
async function compare(password: string, passwordInDB: string) {
    const isMatch = await bcrypt.compare(password, passwordInDB);
    return isMatch;
}
export default UserController;