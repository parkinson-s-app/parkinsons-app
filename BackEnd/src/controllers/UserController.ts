import debugLib from 'debug';
import { Request, Response, Router } from 'express';
import { constants } from 'http2';
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

export default UserController;