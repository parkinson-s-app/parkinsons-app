export default {
    apiPath: process.env.API_PATH || '',
    host: process.env.HOST_DB || '192.168.0.16',
    user: process.env.USER_DB || 'root',
    password: process.env.PASSWORD_DB || '',
    database: process.env.NAME_DB || 'AppKinsonDB',
    connectionLimit: process.env.CON_LIMIT || 10,
    port: process.env.PORT || '8095',
};