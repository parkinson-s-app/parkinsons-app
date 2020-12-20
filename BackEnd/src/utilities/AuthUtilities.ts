

import * as jwt from 'jsonwebtoken';
import debugLib from 'debug';
import { Request, Response } from 'express';
import { constants } from "http2";
import config from '../config';

const debug = debugLib('AppKinson:AuthUtilities');
const secretKey = config.secretKey;
export function verifyToken(req: Request, res: Response, next: any) {
    const bearerHeader = req.headers['authorization'];
    debug('token: %s',bearerHeader );
    let status;
    if( bearerHeader !== undefined ) {
        const bearerToken = bearerHeader.split(' ')[1];
        const token = bearerToken;
        jwt.verify(token, secretKey, { algorithms: ['HS512'] }, (error, authData) => {
            if (error) {
                debug('Verifytoken error: %j', error);
                status = constants.HTTP_STATUS_UNAUTHORIZED;
                res.status(status).send({error});
            } else {
                debug('Verifytoken successful');
                next();
            }
        });
    } else {
        debug('Verifytoken unauthorized');
        status = constants.HTTP_STATUS_UNAUTHORIZED;
        res.status(status).send({ error: 'Not Authorized'});
    }
}