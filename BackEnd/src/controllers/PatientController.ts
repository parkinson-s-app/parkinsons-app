import debugLib from 'debug';
import { Request, Response, Router } from 'express';
import { constants } from 'http2';
import IAnswerRequestDto from '../models/IAnswerRequestDto';
import IEmotionalFormDto from '../models/IEmotionalFormDto';
import IMedicineAlarm from '../models/IMedicineAlarm';
import IGameScore from '../models/IGameScore';
import CarerService from '../services/CarerService';
import PatientService from '../services/PatientService';
import { getIdFromToken, verifyToken } from '../utilities/AuthUtilities';
import IStepRecord from '../models/IStepRecord';
import INoMotorFormDto from '../models/INoMotorFormDto';

const debug = debugLib('AppKinson:PatientController');
const PatientController = Router();


PatientController.post('/patient/answerRequest', verifyToken, async (req: Request, res: Response) => {
    debug('Request to link response patients');
    const bearerHeader = req.headers['authorization'];
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){
            try {
                const answer = req.body as IAnswerRequestDto;
                const patients = await PatientService.answerRequest(id, answer);
                debug('Request to link result %j', patients);
                if(patients) {
                    status = constants.HTTP_STATUS_OK;
                    const message = { status, message: "Success"};
                    res.status(status).send(message);
                } else {
                    status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                    const responseError = { status, error: "An error has ocurred"};
                    res.status(status).send(responseError);
                }
            } catch (error) {
                debug('Answering request error: %j', error);
                
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error: "An error has ocurred"};
                res.status(status).send(responseError);
            }
        }
    } else {
        debug('Request Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});

PatientController.get('/patient/request/doctor', verifyToken, async (req: Request, res: Response) => {
    debug('Getting request relation from doctors');
    const bearerHeader = req.headers['authorization'];
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){
            try {
                const requests = await PatientService.getDoctorRequests(id);
                debug('Getting requests result %j', requests);
                status = constants.HTTP_STATUS_OK;
                res.status(status).send(requests);
            } catch (error) {
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error};
                res.status(status).send(responseError);
            }
        }
    } else {
        debug('Request relation Patients to Doctor Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});

PatientController.get('/patient/request/carer', verifyToken, async (req: Request, res: Response) => {
    debug('Getting request relation from carers');
    const bearerHeader = req.headers['authorization'];
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){
            try {
                const requests = await PatientService.getCarerRequests(id);
                debug('Getting requests result %j', requests);
                status = constants.HTTP_STATUS_OK;
                res.status(status).send(requests);
            } catch (error) {
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error};
                res.status(status).send(responseError);
            }
        }
    } else {
        debug('Request relation Patients to Carer Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});


PatientController.post('/carer/relate/:idPatient', verifyToken, async (req: Request, res: Response) => {
    const bearerHeader = req.headers['authorization'];
    const idPatient = +req.params.idPatient;
    let status;
    if( bearerHeader !== undefined ) {
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ){    
            try {
                const response = await CarerService.requestRelatePatientToCarer(id, idPatient);
                if(response) {
                    status = constants.HTTP_STATUS_OK;
                    res.status(status).send('Success');
                } else {
                    status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                    res.status(status).send('An Error had ocurred');
                }
            } catch (error) {
                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error};
                res.status(status).send(responseError);
            }
        } else {
            debug('Relate Error getting id from token')
            status = constants.HTTP_STATUS_BAD_REQUEST;
            res.status(status).send('Bad request');
        }
    } else {
        debug('Relate Error getting authorization header');
        status = constants.HTTP_STATUS_BAD_REQUEST;
        res.status(status).send('Bad request');
    }
});

PatientController.post('/patient/:id/emotionalFormPatient', verifyToken, async (req: Request, res: Response) => {
    debug('Patients emotional form by Id');
    const id = +req.params.id;
    debug('Patients emotional body: %j, ID: %s',req.body, id);
    const emotionalFormData: IEmotionalFormDto = req.body;
    let status;
    debug('Patients emotional json: %j', emotionalFormData);
    try {
        const response = await PatientService.saveEmotionalForm(id, emotionalFormData);
        debug('Patient emotional save result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send('OK');
    } catch (error) {
        debug('Patient emotional form saving failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.get('/patient/:id/emotionalFormPatient', verifyToken, async (req: Request, res: Response) => {
    const id = +req.params.id;
    debug('Patients getting emotional form by Id: %s', id);
    let status;
    try {
        const initialDate: string = (req.query.start) ? req.query.start as string : '';
        const endDate = (req.query.end) ? req.query.end as string : '';
        const response = await PatientService.getEmotionalFormsById(id, initialDate, endDate);
        debug('Patient getting emotional result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting emotional form failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.post('/patient/:id/noMotorSymptomsFormPatient', verifyToken, async (req: Request, res: Response) => {
    debug('Patients noMotorSymptomsFormPatient by Id');
    const id = +req.params.id;
    debug('Patients noMotorSymptomsFormPatient body: %j, ID: %s',req.body, id);
    const noMotorFormData: INoMotorFormDto = req.body;
    let status;
    debug('Patients noMotorSymptomsFormPatient json: %j', noMotorFormData);
    try {
        const response = await PatientService.saveNoMotorForm(id, noMotorFormData);
        debug('Patient noMotorSymptomsFormPatient save result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send('OK');
    } catch (error) {
        debug('Patient noMotorSymptomsFormPatient saving failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.get('/patient/:id/noMotorSymptomsFormPatient', verifyToken, async (req: Request, res: Response) => {
    const id = +req.params.id;
    debug('Patients getting no motor form by Id: %s', id);
    let status;
    try {
        const initialDate: string = (req.query.start) ? req.query.start as string : '';
        const endDate = (req.query.end) ? req.query.end as string : '';
        const response = await PatientService.getNoMotorFormsById(id, initialDate, endDate);
        debug('Patient getting no motor result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting no motor form failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.post('/patient/:id/medicineAlarm', verifyToken, async (req: Request, res: Response) => {
    debug('Patients save Medicine alarms by Id');
    const id = +req.params.id;
    debug('Patients save Medicine alarms body: %j, ID: %s',req.body, id);
    const medicineAlarms: IMedicineAlarm = req.body;
    let status;
    if(req.body.isPending === 'true') {
        medicineAlarms.isPending = true;
    } else {
        medicineAlarms.isPending = false;
    }
    debug('Patients save Medicine alarms json: %j', medicineAlarms);
    try {
        const response = await PatientService.saveMedicineAlarms(id, medicineAlarms);
        debug('Patients save Medicine alarms result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send('OK');
    } catch (error) {
        debug('Patients Medicine alarms saving failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.get('/patient/:id/medicineAlarm', verifyToken, async (req: Request, res: Response) => {
    const id = +req.params.id;
    debug('Patients getting medicine Alarms by Id: %s', id);
    let status;
    try {
        const response = await PatientService.getMedicineAlarmsById(id);
        debug('Patient getting medicine Alarms result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting medicine Alarms failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.post('/patient/:idPatient/medicineAlarm/delete/:id', verifyToken, async (req: Request, res: Response) => {
    debug('Patients delete Medicine alarms by Id');
    const id = req.params.id;
    const idPatient = +req.params.idPatient;
    debug('Patients delete Medicine alarms patient: %s, ID: %s',idPatient, id);
    let status;
    try {
        const response = await PatientService.deleteMedicineAlarms(id, idPatient);
        debug('Patients delete Medicine alarms result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send('OK');
    } catch (error) {
        debug('Patients Medicine alarms deleting failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.get('/patient/:id/symptoms/report', verifyToken, async (req: Request, res: Response) => {
    debug('getting symptoms report');
    let status;
    const idPatient = +req.params.id;
    const initDate = req.query.start as string;
    const endDate = req.query.end as string;
    const montly = req.query.montly as string;
    debug('Start get report Dates: %s to %s', initDate, endDate);

    try {
        let response;
        if(montly != 'true'){
            response = await PatientService.getReportSymptomsTwoDates(idPatient, initDate, endDate);

        } else if (montly && montly == 'true') {
            response = await montlyReport(idPatient, initDate, endDate, 'SYMPTOMS');
        }
        debug('Patient getting symptoms report. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting symptoms report failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.post('/patient/:id/newGameScore', verifyToken, async (req: Request, res: Response) => {
    debug('Patients save Game Score by Id');
    const id = +req.params.id;
    debug('Patients save Game Score body: %j, ID: %s',req.body, id);
    let gameScore: IGameScore = req.body;
    gameScore.ID_PATIENT = id;
    let status;
    debug('Patients save Game Score json: %j', gameScore);
    try {
        const response = await PatientService.saveGameScore(gameScore);
        debug('Patients save Game Score result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send('Saved');
    } catch (error) {
        debug('Patients Game Score saving failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.post('/patient/:id/newStepRecord', verifyToken, async (req: Request, res: Response) => {
    debug('Patients save Step Record by Id');
    const id = +req.params.id;
    debug('Patients save Step Record body: %j, ID: %s',req.body, id);
    let stepRecord: IStepRecord = req.body;
    stepRecord.ID_PATIENT = id;
    let status;
    debug('Patients save Step Record json: %j', stepRecord);
    try {
        const response = await PatientService.saveStepRecord(stepRecord);
        debug('Patients save Step Record result %j, succesful', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send('Saved');
    } catch (error) {
        debug('Patients Step Record saving failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});


PatientController.get('/patient/:id/game/report', verifyToken, async (req: Request, res: Response) => {
    debug('getting game report');
    let status;
    const idPatient = +req.params.id;
    const initDate = req.query.start as string;
    const endDate = req.query.end as string;
    const montly = req.query.montly as string;
    debug('Start get game report Dates: %s to %s', initDate, endDate);

    try {
        let response;
        if(montly != 'true'){
            response = await PatientService.getReportSymptomsTwoDates(idPatient, initDate, endDate);
        } else if (montly && montly == 'true') {
            response = await montlyReport(idPatient, initDate, endDate, 'GAME');
        }
        debug('Patient getting game report. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting game report failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.get('/patient/:id/emotionalsymptoms/report', verifyToken, async (req: Request, res: Response) => {
    debug('getting emotionalsymptoms report');
    let status;
    const idPatient = +req.params.id;
    const initDate = req.query.start as string;
    const endDate = req.query.end as string;
    const montly = req.query.montly as string;
    debug('Start get emotionalsymptoms report Dates: %s to %s', initDate, endDate);

    try {
        let response;
        if(montly != 'true'){
            response = await PatientService.getReportEmotionalSymptomsTwoDates(idPatient, initDate, endDate);
        } else if (montly && montly == 'true') {
            response = await montlyReport(idPatient, initDate, endDate, 'EMOTIONAL');
        }
        debug('Patient getting emotionalsymptoms report. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting emotionalsymptoms report failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.get('/patient/:id/dyskinecia/report', verifyToken, async (req: Request, res: Response) => {
    debug('getting dyskinecia report');
    let status;
    const idPatient = +req.params.id;
    const initDate = req.query.start as string;
    const endDate = req.query.end as string;
    const montly = req.query.montly as string;
    debug('Start get dyskinecia report Dates: %s to %s', initDate, endDate);

    try {
        let response;
        if(montly != 'true'){
            response = await PatientService.getReportDiskineciaTwoDates(idPatient, initDate, endDate);
        } else if (montly && montly == 'true') {
            response = await montlyReport(idPatient, initDate, endDate, 'DYSKINECIA');
        }
        debug('Patient getting dyskinecia report. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting dyskinecia report failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});

PatientController.get('/patient/:id/discrepancy/report', verifyToken, async (req: Request, res: Response) => {
    debug('getting discrepancy report');
    let status;
    const idPatient = +req.params.id;
    const initDate = req.query.start as string;
    const endDate = req.query.end as string;
    const montly = req.query.montly as string;
    debug('Start get discrepancy report Dates: %s to %s', initDate, endDate);

    try {
        let response;
        if(montly != 'true'){
            response = await PatientService.getReportDiscrepancyTwoDates(idPatient, initDate, endDate);
        } else if (montly && montly == 'true') {
            response = await montlyReport(idPatient, initDate, endDate, 'DISCREPANCY');
        }
        debug('Patient getting discrepancy report. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting discrepancy report failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: "An error has ocurred"};
        res.status(status).send(responseError);
    }
});


async function montlyReport(idPatient: number, initDate: string, endDate: string, reportType: string) {
    var before = new Date(initDate);
    var last = new Date(endDate);
    let resp = [];
    while(before.getTime() < last.getTime()) {
        let report: any;
        const nDate = new Date(before.getFullYear(), before.getMonth()+1, 0 );
        if(nDate.getTime() < last.getTime()){
            initDate = (before.toJSON()).toString();
            endDate = (nDate.toJSON()).toString();
        } else {
            initDate = (before.toJSON()).toString();
            endDate = (last.toJSON()).toString();
        }
        if(reportType === 'SYMPTOMS') {
            report = await PatientService.getReportSymptomsTwoDates(idPatient, initDate, endDate);
        } else if(reportType === 'GAME') {
            report = await PatientService.getReportGameTwoDates(idPatient, initDate, endDate);
        } else if(reportType === 'EMOTIONAL') {
            report = await PatientService.getReportEmotionalSymptomsTwoDates(idPatient, initDate, endDate);
        } else if(reportType === 'DYSKINECIA') {
            report = await PatientService.getReportDiskineciaTwoDates(idPatient, initDate, endDate);
        } else if(reportType === 'DISCREPANCY') {
            report = await PatientService.getReportDiscrepancyTwoDates(idPatient, initDate, endDate);
        }
        report.mes = before.getMonth().toString();
        report.Mes = before.getMonth().toString();
        before = new Date(before.getFullYear(), before.getMonth() +1, 1 );
        resp.push(report);
    }
    return resp;
}

export default PatientController;