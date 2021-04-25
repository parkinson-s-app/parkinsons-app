import debugLib from 'debug';
import { Request, Response, Router } from 'express';
import { constants } from 'http2';
import CarerService from '../services/CarerService';
import PatientService from '../services/PatientService';
import { getIdFromToken, verifyToken } from '../utilities/AuthUtilities';

const debug = debugLib('AppKinson:CarerController');
const CarerController = Router();
const headerAuth = 'authorization';

/**
 * recurso que permite obtener los pacientes que aún no están relacionados al cuidador que hace la
 * petición
 */
CarerController.get('/carer/patients/unrelated', verifyToken, async (req: Request, res: Response) => {
    debug('Getting unrelated patients');
    const bearerHeader = req.headers[headerAuth];
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){
            try {
                const patients = await CarerService.getPatientsUnrelated(id);
                debug('Getting unrelated result %j', patients);
                status = constants.HTTP_STATUS_OK;
                res.status(status).send(patients);
            } catch (error) {
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error};
                res.status(status).send(responseError);
            }
        }
    } else {
        debug('Unrelated Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});
/**
 * recurso que permite obtener todos los pacientes que un cuidador tiene a su cargo
 */
CarerController.get('/carer/patients/related', verifyToken, async (req: Request, res: Response) => {
    debug('Getting related patients');
    const bearerHeader = req.headers[headerAuth];
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){
            try {
                const patients = await CarerService.getPatientsRelated(id);
                debug('Getting related result %j', patients);
                status = constants.HTTP_STATUS_OK;
                res.status(status).send(patients);
            } catch (error) {
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error};
                res.status(status).send(responseError);
            }
        }
    } else {
        debug('Related Patients to Carer Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});

/**
 * recurso que permite lanzar la petición de un cuidador a un paciente con el id, para ser su encargado
 */
CarerController.post('/carer/relate/:idPatient', verifyToken, async (req: Request, res: Response) => {
    const bearerHeader = req.headers[headerAuth];
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
            debug('Relate Error getting id from token');
            status = constants.HTTP_STATUS_BAD_REQUEST;
            res.status(status).send('Bad request');
        }
    } else {
        debug('Relate Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});
/**
 * recurso que permite lanzar la petición de un cuidador a un paciente con el correo de este,
 * para ser su encargado
 */
CarerController.post('/carer/relate', verifyToken, async (req: Request, res: Response) => {
    const bearerHeader = req.headers[headerAuth];
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        const emailPatient = req.body.Email;
        debug('Relate patient by email. Email: %s, id carer: %s, body: %j', emailPatient, id, req.body);
        if( !isNaN(id) && emailPatient ){
            try {
                const searchIdByEmail = await PatientService.getIdPatientByEmail(emailPatient);
                const responseSearchJSON = JSON.parse(JSON.stringify(searchIdByEmail));
                debug('result search patient Id by email: %j', responseSearchJSON);
                if( responseSearchJSON.length !== 0 ){
                    const idPatient = Number(responseSearchJSON[0].ID);
                    if( !Number.isNaN(idPatient)) {
                        debug('patient to relate is: %s', idPatient);
                        const response = await CarerService.requestRelatePatientToCarer(id, idPatient);
                        if(response) {
                            debug('request relate patient to carer was successful');
                            status = constants.HTTP_STATUS_OK;
                            res.status(status).send('Success');
                        } else {
                            debug('error response request relate patient to carer is null');
                            status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                            res.status(status).send('An Error had ocurred');
                        }
                    } else {
                        debug('Error converting idPatient %j', responseSearchJSON[0]);
                        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                        res.status(status).send('An Error had ocurred');
                    }
                } else {
                    debug('Error length responseSearchJSON is 0');
                    status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                    res.status(status).send('An Error had ocurred');
                }
            } catch (error) {
                debug('Relate patient to carer failed. Error: %j', error);
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error};
                res.status(status).send(responseError);
            }
        } else {
            debug('Relate Error getting id from token');
            status = constants.HTTP_STATUS_BAD_REQUEST;
            res.status(status).send('Bad request');
        }
    } else {
        debug('Relate Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});

CarerController.delete('/carer/patients/:idPatient', verifyToken, async (req: Request, res: Response) => {
    const idPatient = +req.params.idPatient;
    debug('Delete Id: %s', idPatient);
    // se obtiene la autenticación para saber si el usuario está con la sesión iniciada
    const bearerHeader = req.headers[headerAuth];
    let status;
    if( bearerHeader !== undefined ) {
        // se verifica el tipo de persona con la sesión iniciada
        const idCarer = getIdFromToken(bearerHeader);
        if ( idCarer ) {
            try {
                // se llama al servicio encargado de eliminar una persona por el id
                const response = await CarerService.unrelatePatient(idCarer, idPatient);
                debug('Deletion response db: %j', response);
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
                debug('Deletion Catch Error: %s, %j', error.stack, error);
                status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                // si ocurre algún error y no se puede ejecutar la operación, se devuelve una respuesta
                // indicando error en el servidor
                res.status(status).send('Error');
            }
        } else {
            status =  constants.HTTP_STATUS_UNAUTHORIZED;
            // si el usuario con la sesión iniciada no es un administrador, se indica que no está
            // autorizado para la operación
            res.status(status).send('Unauthorized');
        }
    } else {
        status =  constants.HTTP_STATUS_UNAUTHORIZED;
        // si la petición no tiene la autenticación, se indica que no está
        // autorizado para la operación
        res.status(status).send('Unauthorized');
    }
});

export default CarerController;