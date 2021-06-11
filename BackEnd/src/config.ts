export default {
    apiPath: process.env.API_PATH || '',
    host: process.env.HOST_DB || 'hostfake',
    user: process.env.USER_DB || 'userfake',
    password: process.env.PASSWORD_DB || 'passwordfake',
    database: process.env.NAME_DB || 'namefake',
    connectionLimit: process.env.CON_LIMIT || 10,
    port: process.env.PORT || '9000',
    portDB: process.env.PORTDB || 3306,
    secretKey: process.env.SECRET_KEY || 'supersecretkey',
    userEmail: process.env.USER_EMAIL || 'userFake',
    passwordEmail: process.env.PASSWORD_EMAIL || 'passFake',
    hostEmail: process.env.HOST_EMAIL || 'smtp.mailtrap.io',
    portEmail: process.env.PORT_EMAIL || 2525,
    otpKey: process.env.OTP_KEY || 'fake_key',
    otpStep: process.env.OTP_STEP || 300
};