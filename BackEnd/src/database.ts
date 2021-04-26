import { createPool, Pool } from 'mysql2/promise';
import config from './config';
import debugLib from 'debug';

const debug = debugLib('AppKinson:DatabaseConnection');
/**
 * Funcion para crear una conexion con la base de datos
 */
export async function connect () {
    try {
        const connection = createPool({
            host: config.host,
            user: config.user,
            password: config.password,
            database: config.database,
            connectionLimit: +config.connectionLimit
        });
        return connection;
    } catch (error) {
        debug('Error connecting to db, error: %j', error);
        throw error;
    }
}

export async function executeSQL(sqlQuery: string, values?: any) {
    let conn: Pool | undefined;
    try {
        debug(`[DB NEW CONNECTION]`);
        conn = await connect();
        debug('response connection: %j', conn);
        const result = (values) ? await conn.query(sqlQuery, values) : await conn.query(sqlQuery);
        debug('Query executed.');
        conn.end();
        return result;
    } catch (error) {
        if(conn) {
            conn.end();
        }
        debug('[ERROR-DB]: %s', error);
        throw error;
    }
}