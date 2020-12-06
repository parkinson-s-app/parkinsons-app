import { createPool } from "mysql2/promise";
import config from "./config";

export async function connect () {
    const connection = createPool({
        host: config.host,
        user: config.user,
        password: config.password,
        database: config.database,
        connectionLimit: +config.connectionLimit
    });
    return connection;
}