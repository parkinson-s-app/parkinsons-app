export default {
    apiPath: process.env.API_PATH || '',
    host: process.env.HOST_DB || 'localhost',
    user: process.env.USER_DB || 'root',
    password: process.env.PASSWORD_DB || '',
    database: process.env.NAME_DB || 'AppKinsonDB',
    connectionLimit: process.env.CON_LIMIT || 10,
    port: process.env.PORT || '8000',
    secretKey: process.env.SECRET_KEY || 'supersecretkey'
};