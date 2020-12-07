import express, { Request, Response } from 'express';
import logger from 'morgan';
// import path from 'path';
import config from './config';
import UserController from './controllers/UserController';
import DefaultResponseDto from './models/DefaultResponseDto';

const app = express();
const apiPath = config.apiPath;
const fullApiPath = `${apiPath}/api`;
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({extended: false}));
// app.use(express.static(path.join(__dirname, '../static')));
// Configurar cabeceras y cors
app.use((_, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', '*');
    res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
    res.header('Allow', 'GET, POST, OPTIONS, PUT, DELETE');
    next();
});
// add the controllers you need here
app.use(fullApiPath, UserController);

app.use((error: any, req: Request,res: Response, next: any) => {
    const msgRsErrorDto = DefaultResponseDto.getErrorFromMessage(JSON.stringify(error.message), error.statusCode);
    res.status(Number(msgRsErrorDto.status)).send(msgRsErrorDto);
});

export default app;
