import { createPool } from "mysql2/promise";
import config from "./config";
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