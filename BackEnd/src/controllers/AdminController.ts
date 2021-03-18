import debugLib from 'debug';
import { Request, Response, Router } from 'express';
import { constants } from 'http2';
import { getTypeFromToken, verifyToken } from '../utilities/AuthUtilities';
import AdminService from '../services/AdminService';
import IToolboxItemDto from '../models/IToolboxItemDto';

const debug = debugLib('AppKinson:AdminController');
const AdminController = Router();
/**
 * recurso que permite la eliminación de un usuario indicando el id, por parte de un administrador
 * con sesion iniciada
 */
AdminController.delete('/admin/user/:id', verifyToken, async (req: Request, res: Response) => {
    const id = +req.params.id;
    debug('Delete Id: %s', id);
    // se obtiene la autenticación para saber si el usuario está con la sesión iniciada
    const bearerHeader = req.headers['authorization'];
    let status;
    if( bearerHeader !== undefined ) {
        // se verifica el tipo de persona con la sesión iniciada
        const type = getTypeFromToken(bearerHeader);
        if ( type === 'Admin') {
            try {
                // se llama al servicio encargado de eliminar una persona por el id
                const response = await AdminService.deletePerson(id);
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
                debug('Deletion Catch Error: %s, %j', error.stack, error)
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


AdminController.post('/admin/toolbox/item', verifyToken, async (req: Request, res: Response) => {
    debug('Add toolbox item');
    debug('Body: %j, ID: %s',req.body);
    let toolboxItem = req.body as IToolboxItemDto;
    let status;
    try {
        const response = await AdminService.saveToolboxItem(toolboxItem);
        debug('save toolbox item result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send({ message:'Saved' });
    } catch (error) {
        debug('Patient symptoms saving failed. Error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error};
        res.status(status).send(responseError);
    }
});

export default AdminController;
