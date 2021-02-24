import debugLib from 'debug';
import { Request, Response, Router } from 'express';
import { constants } from 'http2';
import { getTypeFromToken, verifyToken } from '../utilities/AuthUtilities';
import AdminService from '../services/AdminService';

const debug = debugLib('AppKinson:AdminController');
const AdminController = Router();

AdminController.delete('/admin/user/:id', verifyToken, async (req: Request, res: Response) => {
    const id = +req.params.id;
    debug('Delete Id: %s', id);
    const bearerHeader = req.headers['authorization'];
    let status;
    if( bearerHeader !== undefined ) {
        const type = getTypeFromToken(bearerHeader);
        if ( type === 'Admin') {
            try {
                const response = await AdminService.deletePerson(id);
                debug('Deletion response db: %j', response);
                if(response) {
                    status =  constants.HTTP_STATUS_OK;
                    res.status(status).send('Eliminado');
                } else {
                    status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                    res.status(status).send('Error');
                }
            } catch (error) {
                debug('Deletion Catch Error: %s, %j', error.stack, error)
                status =  constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                res.status(status).send('Error');
            }
        } else {
            status =  constants.HTTP_STATUS_UNAUTHORIZED;
            res.status(status).send('Unauthorized');
        }
    }
});

export default AdminController;
