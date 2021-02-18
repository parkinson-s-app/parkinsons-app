import debug from 'debug';
import e from 'express';
import express, { Request, Response } from 'express';
import logger from 'morgan';
// import path from 'path';
import config from './config';
import UserController from './controllers/UserController';
import DoctorController from './controllers/DoctorController';
import DefaultResponseDto from './models/DefaultResponseDto';
import CarerController from './controllers/CarerController';
import PatientController from './controllers/PatientController';
import AdminController from './controllers/AdminController';
import path from 'path';

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
app.use(fullApiPath, DoctorController);
app.use(fullApiPath, CarerController);
app.use(fullApiPath, PatientController);
app.use(fullApiPath, AdminController);

app.use((error: any, req: Request,res: Response, next: any) => {
    if(error.message && error.statusCode){
    const msgRsErrorDto = DefaultResponseDto.getErrorFromMessage(JSON.stringify(error.message), error.statusCode);
    res.status(Number(msgRsErrorDto.status)).send(msgRsErrorDto);
    } else{
        console.log(error);
        res.status(500).send(error);
    }
});
// storage
app.use('/uploads', express.static(path.resolve('uploads')));

export default app;
