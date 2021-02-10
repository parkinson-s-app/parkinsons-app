import debugLib from 'debug';
import { Request, Response, Router } from 'express';
import { constants } from 'http2';
import IAnswerRequestDto from '../models/IAnswerRequestDto';
import CarerService from '../services/CarerService';
import PatientService from '../services/PatientService';
import { getIdFromToken, verifyToken } from '../utilities/AuthUtilities';

const debug = debugLib('AppKinson:PatientController');
const PatientController = Router();


PatientController.post('/patient/answerRequest', verifyToken, async (req: Request, res: Response) => {
    debug('Request to link response patients');
    const bearerHeader = req.headers['authorization'];
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){
            try {
                const answer = req.body as IAnswerRequestDto;
                const patients = await PatientService.answerRequest(id, answer);
                debug('Request to link result %j', patients);
                if(patients) {
                    status = constants.HTTP_STATUS_OK;
                    const message = { status, message: "Success"};
                    res.status(status).send(message);
                } else {
                    status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                    const responseError = { status, error: "An error has ocurred"};
                    res.status(status).send(responseError);
                }
            } catch (error) {
                debug('Answering request error: %j', error);
                
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error: "An error has ocurred"};
                res.status(status).send(responseError);
            }
        }
    } else {
        debug('Request Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});

PatientController.get('/patient/request/doctor', verifyToken, async (req: Request, res: Response) => {
    debug('Getting request relation from doctors');
    const bearerHeader = req.headers['authorization'];
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){
            try {
                const requests = await PatientService.getDoctorRequests(id);
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
        debug('Request relation Patients to Doctor Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});

PatientController.get('/patient/request/carer', verifyToken, async (req: Request, res: Response) => {
    debug('Getting request relation from carers');
    const bearerHeader = req.headers['authorization'];
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){
            try {
                const requests = await PatientService.getCarerRequests(id);
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
        debug('Request relation Patients to Carer Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});


PatientController.post('/carer/relate/:idPatient', verifyToken, async (req: Request, res: Response) => {
    const bearerHeader = req.headers['authorization'];
    const idPatient = +req.params.idPatient;
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){     
            try {
                const response = await CarerService.requestRelatePatientToCarer(id, idPatient);
                if(response) {
                    status = constants.HTTP_STATUS_OK;
                    res.status(status).send('Success');
                } else {
                    status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                    res.status(status).send('An Error had ocurred');
                }
            } catch (error) {
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error};
                res.status(status).send(responseError);
            }
        } else {
            debug('Relate Error getting id from token')
            status = constants.HTTP_STATUS_BAD_REQUEST;
            res.status(status).send('Bad request');
        }
    } else {
        debug('Relate Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});

export default PatientController;