

import * as jwt from 'jsonwebtoken';
import debugLib from 'debug';
import { Request, Response } from 'express';
import { constants } from "http2";
import config from '../config';
import * as bcrypt from 'bcryptjs';

const debug = debugLib('AppKinson:AuthUtilities');
const secretKey = config.secretKey;
export function verifyToken(req: Request, res: Response, next: any) {
    const bearerHeader = req.headers['authorization'];
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

export function getIdFromToken(token: string) {
    const dataInToken = token.split('.')[1];
    debug('getIdFromToken data encoded: %s', dataInToken);
    const decodedData = Buffer.from(dataInToken, 'base64').toString();
    debug('getIdFromToken data decoded: %s',decodedData);
    const dataInJSON = JSON.parse(decodedData);
    debug('getIdFromToken data in JSON: %j',dataInJSON);
    return +dataInJSON.id;
}

export function getTypeFromToken(token: string) {
    const dataInToken = token.split('.')[1];
    debug('getTypeFromToken data encoded: %s', dataInToken);
    const decodedData = Buffer.from(dataInToken, 'base64').toString();
    debug('getTypeFromToken data decoded: %s',decodedData);
    const dataInJSON = JSON.parse(decodedData);
    debug('getTypeFromToken data in JSON: %j',dataInJSON);
    return dataInJSON.type;
}

export async function compare(password: string, passwordInDB: string) {
    const isMatch = await bcrypt.compare(password, passwordInDB);
    return isMatch;
}