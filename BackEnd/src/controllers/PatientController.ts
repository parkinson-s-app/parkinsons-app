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

/**
 * recurso que permite responder la solicitud ya se de un médico o un cuidador
 * para se su encargado, el paciente debe tener la sesion iniciada
 */
PatientController.post('/patient/answerRequest', verifyToken, async (req: Request, res: Response) => {
    debug('Request to link response patients');
    const bearerHeader = req.headers.authorization as string;
    let status;
        const id = getIdFromToken(bearerHeader);
        if( !isNaN(id) ) {
            try {
                const answer = req.body as IAnswerRequestDto;
                const patients = await PatientService.answerRequest(id, answer);
                debug('Request to link result %j', patients);
                if(patients) {
                    status = constants.HTTP_STATUS_OK;
                    const message = { status, message: 'Success'};
                    res.status(status).send(message);
                } else {
                    status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                    const responseError = { status, error: 'An error has ocurred'};
                    res.status(status).send(responseError);
                }
            } catch (error) {
                debug('Answering request error: %j', error);

                status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
                const responseError = { status, error: 'An error has ocurred'};
                res.status(status).send(responseError);
            }
        }
});
/**
 * recurso que permite obtener todas las solicitudes de los medicos hacia el paciente
 * el paciente es quien hace el consumo del recurso
 */
PatientController.get('/patient/request/doctor', verifyToken, async (req: Request, res: Response) => {
    debug('Getting request relation from doctors');
    const bearerHeader = req.headers.authorization as string;
    let status;
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
});
/**
 * recurso que permite obtener todas las solicitudes de los cuidadores hacia el paciente
 * el paciente es quien hace el consumo del recurso
 */
PatientController.get('/patient/request/carer', verifyToken, async (req: Request, res: Response) => {
    debug('Getting request relation from carers');
    const bearerHeader = req.headers.authorization as string;
    let status;
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
});
/**
 * recurso que permite agregar un nuevo registro de formualario emocional por id del paciente
 */
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
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite obtener los registros de formualarios emocionales de un paciente por su id
 */
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
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite agregar un nuevo registro de formualario no motor a un paciente por su id
 */
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
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite obtener los registros de formualarios no motores de un paciente por su id
 */
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
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite agregar las medicinas que debe tomar un paciente por su id y son alarmas
 */
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
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite obtener las medicinas que debe tomar un paciente por su id y son alarmas
 */
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
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite eliminar las medicinas que debe tomar un paciente por su id y son alarmas
 */
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
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite obtener los reportes del formulario de sintomas de un paciente por su id
 */
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
        if(montly !== 'true'){
            response = await PatientService.getReportSymptomsTwoDates(idPatient, initDate, endDate);
        } else if (montly && montly === 'true') {
            response = await montlyReport(idPatient, initDate, endDate, 'SYMPTOMS');
        }
        debug('Patient getting symptoms report. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting symptoms report failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite agregar una nueva entrada de un score nuevo del juego de un paciente por su id
 */
PatientController.post('/patient/:id/newGameScore', verifyToken, async (req: Request, res: Response) => {
    debug('Patients save Game Score by Id');
    const id = +req.params.id;
    debug('Patients save Game Score body: %j, ID: %s',req.body, id);
    const gameScore: IGameScore = req.body;
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
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite obtener los reportes de los puntajes en el juego de un paciente por su id
 */
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
        if(montly !== 'true'){
            response = await PatientService.getReportGameTwoDates(idPatient, initDate, endDate);
        } else if (montly && montly === 'true') {
            response = await montlyReport(idPatient, initDate, endDate, 'GAME');
        }
        debug('Patient getting game report. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting game report failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite obtener los reportes los sintomas emocionales de un paciente por su id
 * start: fecha inicial del reporte
 * end: fecha final del reporte
 * montly: indica si el reporte se quiere por meses
 */
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
        if(montly !== 'true'){
            response = await PatientService.getReportEmotionalSymptomsTwoDates(idPatient, initDate, endDate);
        } else if (montly && montly === 'true') {
            response = await montlyReport(idPatient, initDate, endDate, 'EMOTIONAL');
        }
        debug('Patient getting emotionalsymptoms report. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting emotionalsymptoms report failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite obtener los reportes las disquinecias de un paciente por su id
 * start: fecha inicial del reporte
 * end: fecha final del reporte
 * montly: indica si el reporte se quiere por meses
 */
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
        if(montly !== 'true'){
            response = await PatientService.getReportDiskineciaTwoDates(idPatient, initDate, endDate);
        } else if (montly && montly === 'true') {
            response = await montlyReport(idPatient, initDate, endDate, 'DYSKINECIA');
        }
        debug('Patient getting dyskinecia report. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting dyskinecia report failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite obtener los reportes de las discrepancias en la toma de medicamento
 * de un paciente por su id
 * start: fecha inicial del reporte
 * end: fecha final del reporte
 * montly: indica si el reporte se quiere por meses
 */
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
        if(montly !== 'true'){
            response = await PatientService.getReportDiscrepancyTwoDates(idPatient, initDate, endDate);
        } else if (montly && montly === 'true') {
            response = await montlyReport(idPatient, initDate, endDate, 'DISCREPANCY');
        }
        debug('Patient getting discrepancy report. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting discrepancy report failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});
/**
 * recurso que permite obtener los reportes los sintomas no motores de un paciente por su id
 * start: fecha inicial del reporte
 * end: fecha final del reporte
 * montly: indica si el reporte se quiere por meses
 */
PatientController.get('/patient/:id/noMotorSymptoms/report', verifyToken, async (req: Request, res: Response) => {
    debug('getting discrepancy report');
    let status;
    const idPatient = +req.params.id;
    const initDate = req.query.start as string;
    const endDate = req.query.end as string;
    debug('Start get discrepancy report Dates: %s to %s', initDate, endDate);

    try {
        let response;
        response = await twoWeeklyReport(idPatient, initDate, endDate, 'NOMOTOR');
        debug('Patient getting discrepancy report. Items: %j', response);
        status = constants.HTTP_STATUS_OK;
        res.status(status).send(response);
    } catch (error) {
        debug('Patient getting discrepancy report failed, error: %j', error);
        status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
        const responseError = { status, error: 'An error has ocurred'};
        res.status(status).send(responseError);
    }
});

/**
 * metodo que define los meses que hacen parte del reporte cuando este debe ser mensual
 */
async function montlyReport(idPatient: number, initDate: string, endDate: string, reportType: string) {
    let before = new Date(initDate);
    const last = new Date(endDate);
    const resp = [];
    try {
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
            report.mes = (before.getMonth()+1);
            report.Mes = (before.getMonth()+1);
            before = new Date(before.getFullYear(), before.getMonth() +1, 1 );
            resp.push(report);
        }
        return resp;
    } catch (error) {
        throw error;
    }

}
/**
 * metodo que define las fechas de dos semanas que hacen parte del reporte cuando este
 * debe ser cada dos semanas
 */
async function twoWeeklyReport(idPatient: number, initDate: string, endDate: string, reportType: string) {
    const before = new Date(initDate);
    const last = new Date(endDate);
    const resp = [];
    resp.push({
        Week: 0,
        Promedio: 0,
        Cantidad: 0,
        Fecha: initDate,
        Preguntas: []
    });
    let week = 1;
    while(before.getTime() < last.getTime()) {
        let report: any;
        const nDate = new Date(before.getTime() );
        nDate.setDate(nDate.getDate() +7);
        if(nDate.getTime() < last.getTime()){
            initDate = (before.toJSON()).toString();
            endDate = (nDate.toJSON()).toString();
        } else {
            initDate = (before.toJSON()).toString();
            endDate = (last.toJSON()).toString();
        }
        if(reportType === 'NOMOTOR') {
            report = await PatientService.getReportNoMotorTwoDates(idPatient, initDate, endDate);
        }
        report.Week = week;
        week++;
        before.setDate(before.getDate() + 7);
        resp.push(report);
    }
    return resp;
}
/**
 * recurso que permite obtener cuales son las alarmas que sonarán en el dia
 */
PatientController.get('/patient/alarms/today', verifyToken, async (req: Request, res: Response) => {
    debug('getting alarms today');
    let status;
    const bearerHeader = req.headers.authorization as string;
        const id = getIdFromToken(bearerHeader);
        try {
            let response;
            response = 'ok';
            debug('Patient getting alarms by id: %s', id);
            response = await PatientService.getAlarmsTodayById(id);
            status = constants.HTTP_STATUS_OK;
            res.status(status).send(response);
        } catch (error) {
            debug('Patient getting alarms failed, error: %j', error);
            status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
            const responseError = { status, error: 'An error has ocurred'};
            res.status(status).send(responseError);
        }
});
/**
 * recurso que permite obtener los reportes los estados on y off de un paciente por su id,
 * de forma diaria
 * start: fecha inicial del reporte
 * end: fecha final del reporte
 */
PatientController.get('/patient/:id/report/daily', verifyToken, async (req: Request, res: Response) => {
    debug('getting daily report');
    let status;
    const bearerHeader = req.headers.authorization as string;
        const id = getIdFromToken(bearerHeader);
        try {
            let response;
            const idPatient = +req.params.id;
            const initDate = req.query.start as string;
            const endDate = req.query.end as string;
            response = 'ok';
            debug('Patient getting daily report by id: %s start: %s end: %s', id, initDate, endDate);
            response = await PatientService.getReportSymptomsDaily(idPatient, initDate, endDate);
            status = constants.HTTP_STATUS_OK;
            debug('Response repost daily %j', response);
            res.status(status).send(response);
        } catch (error) {
            debug('Patientdaily report report failed, error: %j', error);
            status = constants.HTTP_STATUS_INTERNAL_SERVER_ERROR;
            const responseError = { status, error: 'An error has ocurred'};
            res.status(status).send(responseError);
        }
});

export default PatientController;