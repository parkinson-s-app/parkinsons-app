export default {
    apiPath: process.env.API_PATH || '',
    host: process.env.HOST_DB || 'appkinson-db.cgmd1uulv47n.us-east-2.rds.amazonaws.com',
    user: process.env.USER_DB || 'admin',
    password: process.env.PASSWORD_DB || 'appkinson6',
    database: process.env.NAME_DB || 'AppKinsonDB',
    connectionLimit: process.env.CON_LIMIT || 10,
    port: process.env.PORT || '9000',
    portDB: process.env.PORTDB || 3306,
    secretKey: process.env.SECRET_KEY || 'supersecretkey',
    userEmail: process.env.USER_EMAIL || 'userFake',
    passwordEmail: process.env.PASSWORD_EMAIL || 'passFake',
    hostEmail: process.env.HOST_EMAIL || 'smtp.mailtrap.io',
    portEmail: process.env.PORT_EMAIL || 2525
};