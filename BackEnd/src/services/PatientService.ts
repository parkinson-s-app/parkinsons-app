import { connect } from "../database";
import debugLib from 'debug';
import IAnswerRequestDto from "../models/IAnswerRequestDto";
import { PersonType } from "../utilities/GenericTypes";
import CarerService from "./CarerService";
import DoctorService from "./DoctorService";
import IEmotionalFormDto from "../models/IEmotionalFormDto";
import { Pool } from "mysql2/promise";
import IMedicineAlarm from "../models/IMedicineAlarm";
import IGameScore from "../models/IGameScore";
import IStepRecord from "../models/IStepRecord";
import INoMotorFormDto from "../models/INoMotorFormDto";

const debug = debugLib('AppKinson:PatientService');

export default class PatientService {

    public static async getDoctorRequests(id: number) {
        debug('Getting requests doctor of id patient: %s', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const requests = await conn.query('SELECT * FROM requestlinkdoctortopatient WHERE ID_PATIENT = ?',[id]);
            conn.end();
            return requests[0];
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug('Get doctor request failed. Error: %j', error);
            throw error;
        }
    }

    public static async getCarerRequests(id: number) {
        debug('Getting requests carer of id patient: %s', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const requests = await conn.query('SELECT * FROM requestlinkcarertopatient WHERE ID_PATIENT = ?',[id]);
            conn.end();
            return requests[0];
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug('get carer request failed. Error: %j', error);
            throw error;
        }
    }

    public static async answerRequest(idPatient: number, answer: IAnswerRequestDto) {
        debug('Answer request id patient: %s, info answer: %j ', idPatient, answer);
        try {
            if( answer.RequesterType === PersonType.CARER ) {
                const idCarer = Number(answer.RequesterId);

                if(!Number.isNaN(idCarer)) {
                    return await CarerService.relatePatientToCarer(idCarer, idPatient, answer.Answer);
                } else {
                    debug('Error parsing Id Carer. Id: %s', answer.RequesterId);
                    return null;
                }
            } else if(answer.RequesterType === PersonType.DOCTOR) {
                const idDoctor = Number(answer.RequesterId);
                if(!Number.isNaN(idDoctor)) {
                    return await DoctorService.relatePatientToDoctor(idDoctor, idPatient, answer.Answer)
                } else {
                    debug('Error parsing Id Doctor. Id: %s', answer.RequesterId);
                    return null;
                }
            } else {
                debug('Error requester type not valid. Type: %s', answer.RequesterType);
                return null;
            }
        } catch (error) {
            debug('answer request failed. Error: %j', error);
            throw error;
        }
    }
    
    /**
     * getPatientByEmail
     */
    public static async getIdPatientByEmail(email: string) {
        debug('getPatientByEmail email: %s', email);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const person =  await conn.query(
                `SELECT ID 
                FROM patients
                LEFT JOIN users
                ON users.ID = patients.ID_USER
                WHERE users.EMAIL = ? `,[email]);
            debug('result search patient by email: %j', person[0]);
            conn.end();
            return person[0];
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug('getPatientByEmail failed. Error: %j', error);
            throw error;
        }
    }
    /**
     * getPatientById
     */
    public static async getPatientById(id : number) {
        debug('getPatientById id: %s', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const person =  await conn.query(
                `SELECT EMAIL, NAME, PHOTOPATH 
                FROM patients
                LEFT JOIN users
                ON users.ID = patients.ID_USER
                WHERE users.ID = ? `,[id]);
            debug('result search patient by id: %j', person[0]);
            conn.end();
            return person[0];
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug('get patient by Id failed. Error: %j', error);
            throw error;   
        }
    }
    /**
     * 
     * @param id 
     * @param emotionalFormData 
     */
    public static async saveEmotionalForm(id: number, emotionalFormData: IEmotionalFormDto) {
        let conn: Pool | undefined;
        try {
            conn = await connect();
            emotionalFormData.id_patient=id;
            debug('saveEmotionalForm to person: %j, id: %s', emotionalFormData, id);
            const res = await conn.query('INSERT INTO emotionalformxpatient SET ?',[emotionalFormData]);
            debug('saveEmotionalForm saved and returned: %j', res);
            conn.end();
            return res;
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('saveEmotionalForm Error: %j', error);
            throw error;
        }
    }

    public static async saveNoMotorForm(id: number, noMotorFormData: INoMotorFormDto) {
        let conn: Pool | undefined;
        try {
            conn = await connect();
            noMotorFormData.id_patient=id;
            debug('saveEmotionalForm to person: %j, id: %s', noMotorFormData, id);
            const res = await conn.query('INSERT INTO nomotorsymptomsformpatient SET ?',[noMotorFormData]);
            debug('saveEmotionalForm saved and returned: %j', res);
            conn.end();
            return res;
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('saveEmotionalForm Error: %j', error);
            throw error;
        }
    }
    /**
     * 
     * @param id 
     */
    public static async getEmotionalFormsById(id: number, start: string, end: string) {
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const dateStart = new Date(start);
            const dateEnd = new Date(end);
            const query = 'SELECT * FROM emotionalformxpatient WHERE ID_PATIENT=? and ( date BETWEEN ? AND ?)';
            debug('getEmotionalForms to patient id: %s', id);
            const res = await conn.query(query,[id, dateStart, dateEnd]);
            debug('getEmotionalForms saved and returned: %j', res);
            conn.end();
            return res[0];
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('getEmotionalForms Error: %j', error);
            throw error;
        }
    }

    /**
     * 
     * @param id 
     */
    public static async getNoMotorFormsById(id: number, start: string, end: string) {
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const dateStart = new Date(start);
            const dateEnd = new Date(end);
            const query = 'SELECT * FROM nomotorsymptomsformpatient WHERE ID_PATIENT=? and ( date BETWEEN ? AND ?)';
            debug('getNoMotorForms to patient id: %s', id);
            const res = await conn.query(query,[id, dateStart, dateEnd]);
            debug('getNoMotorForms saved and returned: %j', res);
            conn.end();
            return res[0];
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('getNoMotorForms Error: %j', error);
            throw error;
        }
    }

    public static async getMedicineAlarmsById(id: number) {
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const query = `
            SELECT 
                am.title as Title,
                m.NAME as Medicine,
                m.ID as IdMedicine,
                am.dose as Dose,
                am.periodicityQuantity as PeriodicityQuantity,
                am.periodicityType as PeriodicityType,
                am.alarmTime as AlarmTime,
                am.ID_PATIENT as IdPatient,
                am.quantity as Quantity
            FROM 
                alarmandmedicinepatient am
                INNER JOIN
                medicine m
                ON m.ID = am.idMedicine
            WHERE ID_PATIENT= ?`;
            debug('getMedicineAlarmsById to patient id: %s', id);
            const res = await conn.query(query,[id]);
            debug('getMedicineAlarmsById executed and returned: %j', res[0]);
            conn.end();
            return res[0];
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('getMedicineAlarmsById Error: %j', error);
            throw error;
        }
    }

    public static async saveMedicineAlarms(id: number, medicineAlarms: IMedicineAlarm) {
        let conn: Pool | undefined;
        try {
            debug('saveMedicineAlarms get into');
            conn = await connect();
            medicineAlarms.ID_PATIENT = id;
            debug('saveMedicineAlarms medicine alarms to save: %j', medicineAlarms);
            const res = await conn.query('INSERT INTO medicinealarmpatient SET ?',[medicineAlarms]);
            debug('saveMedicineAlarms saved and returned: %j', res);
            conn.end();
            return res;
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('saveMedicineAlarms Error: %j', error);
            throw error;
        }
    }


    public static async deleteMedicineAlarms(id: string, idPatient: number) {
        let conn: Pool | undefined;
        try {
            debug('deleteMedicineAlarms get into');
            conn = await connect();
            debug('deleteMedicineAlarms medicine alarm id: %s, id patient: %s', id, idPatient);
            const resDeletion = await conn.query(
                'DELETE FROM medicinealarmpatient WHERE ID_PATIENT  = ? AND id = ?',
                [idPatient, id]);
            debug('deleteMedicineAlarms saved and returned: %j', resDeletion);
            conn.end();
            return resDeletion;
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('deleteMedicineAlarms Error: %j', error);
            throw error;
        }
    }

    public static async  getReportSymptomsTwoDates(idPatient: number, initDate: string, endDate: string) {
        let conn: Pool | undefined;
        try {
            conn = await connect();
            debug('getting report by two dates First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT 
                Q1
            FROM 
                symptomsformpatient
            WHERE ID_PATIENT= ? 
            AND formdate BETWEEN ? AND ?`;
            debug('getReportSymptomsTwoDates to patient id: %s', idPatient);
            const res = await conn.query(query,[idPatient, initDate, endDate]);
            debug('getReportSymptomsTwoDates executed and returned: %j', res[0]);
            conn.end();
            debug('query reslt response :%j', res[0]);
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query response as a list :%j', res[0]);
            let on = 0;
            let onG = 0;
            let off = 0;
            let offB = 0;
            const size = listJSON.length;
            debug('size :%s', size);
            for (let index = 0; index < size; index++) {
                
                if(listJSON[index].Q1 == 'on') {
                    on++;
                } else if (listJSON[index].Q1 == 'on bueno') {
                    onG++;
                } else if (listJSON[index].Q1 == 'off malo') {
                    offB++;
                } else if (listJSON[index].Q1 == 'off') {
                    off++;
                }
            }
            if (size != 0) {
                on = (100/size)*on;
                off = (100/size)*off;
                offB = (100/size)*offB;
                onG = (100/size)*onG;
            }
            const finalResponse = {
                on: Math.round((100/size)*on).toFixed(3),
                off: Math.round((100/size)*off).toFixed(3),
                offB: Math.round((100/size)*offB).toFixed(3),
                onG: Math.round((100/size)*onG).toFixed(3),
                mes: 'null'
            }
            debug('response final :%j', finalResponse);
            return finalResponse;
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('getReportSymptomsTwoDates Error: %j', error);
            throw error;
        }
    }

    public static async saveGameScore(gameScore: IGameScore) {
        let conn: Pool | undefined;
        try {
            debug('saveGameScore get into');
            conn = await connect();
            debug('saveGameScore to save: %j', gameScore);
            const res = await conn.query('INSERT INTO touchgamexpatient SET ?',[gameScore]);
            debug('saveGameScore saved and returned: %j', res);
            conn.end();
            return res;
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('saveGameScore Error: %j', error);
            throw error;
        }
    }

    public static async saveStepRecord(stepRecord: IStepRecord) {
        let conn: Pool | undefined;
        try {
            debug('saveStepRecord get into');
            conn = await connect();
            debug('saveStepRecord to save: %j', stepRecord);
            const res = await conn.query('INSERT INTO stepsxpatient SET ?',[stepRecord]);
            debug('saveStepRecord saved and returned: %j', res);
            conn.end();
            return res;
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('saveGameScore Error: %j', error);
            throw error;
        }
    }

    public static async getReportGameTwoDates(idPatient: number, initDate: string, endDate: string) {
        let conn: Pool | undefined;
        try {
            conn = await connect();
            debug('getting game report by two dates First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT 
                score
            FROM 
                touchgamexpatient
            WHERE ID_PATIENT= ? 
            AND gameDate BETWEEN ? AND ?`;
            debug('getReportGameTwoDates to patient id: %s', idPatient);
            const res = await conn.query(query,[idPatient, initDate, endDate]);
            debug('getReportGameTwoDates executed and returned: %j', res[0]);
            conn.end();
            debug('query game result response :%j', res[0]);
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query game response as a list :%j', res[0]);
            let on = 0;
            let acum = 0;
            let average = 0;
            const size = listJSON.length;
            debug('size :%s', size);
            for (let index = 0; index < size; index++) {
                acum += listJSON[index].score;
            }
            if (size != 0) {
                average = (acum/size);
            }
            const finalResponse = {
                Mes: 'null',
                Promedio:  Math.round(average).toFixed(3),
                Cantidad: size
            };
            debug('response final :%j', finalResponse);
            return finalResponse;
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('getReportGameTwoDates Error: %j', error);
            throw error;
        }
    }


    public static async getReportEmotionalSymptomsTwoDates(idPatient: number, initDate: string, endDate: string): Promise<any> {
        let conn: Pool | undefined;
        try {
            conn = await connect();
            debug('getting emotional symptoms report by two dates First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT 
                Q1,
                Q2
            FROM 
                emotionalformxpatient
            WHERE ID_PATIENT= ? 
            AND date BETWEEN ? AND ?`;
            debug('getReportEmotionalSymptomsTwoDates to patient id: %s', idPatient);
            const res = await conn.query(query,[idPatient, initDate, endDate]);
            debug('getReportEmotionalSymptomsTwoDates executed and returned: %j', res[0]);
            conn.end();
            debug('query emotional symptoms result response :%j', res[0]);
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query emotional symptoms response as a list :%j', res[0]);
            let on = 0;
            let acum = 0;
            let average = 0;
            const size = listJSON.length;
            debug('size :%s', size);
            for (let index = 0; index < size; index++) {
                acum += listJSON[index].Q1;
                acum += listJSON[index].Q2;
            }
            if (size != 0) {
                average = (acum/(size*2));
            }
            const finalResponse = {
                Mes: 'null',
                Promedio:  Math.round(average).toFixed(3),
                Cantidad: size
            };
            debug('response emotional symptoms report final :%j', finalResponse);
            return finalResponse;
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('getReportGameTwoDates Error: %j', error);
            throw error;
        }
    }

    public static async getReportDiskineciaTwoDates(idPatient: number, initDate: string, endDate: string): Promise<any> {
        let conn: Pool | undefined;
        try {
            conn = await connect();
            debug('getting dyskinecia report by two dates First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT
                Q2
            FROM 
                symptomsformpatient
            WHERE ID_PATIENT= ? 
            AND formdate BETWEEN ? AND ?`;
            debug('getReportDiskineciaTwoDates to patient id: %s', idPatient);
            const res = await conn.query(query,[idPatient, initDate, endDate]);
            debug('getReportDiskineciaTwoDates executed and returned: %j', res[0]);
            conn.end();
            debug('query dyskinecia result response :%j', res[0]);
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query dyskinecia response as a list :%j', res[0]);
            let acum = 0;
            let average = 0;
            const size = listJSON.length;
            for (let index = 0; index < size; index++) {
                if(listJSON[index].Q2 !==''){
                    acum += 1;
                }
            }
            if (size != 0) {
                average = (acum/(size));
            }
            const finalResponse = {
                Mes: 'null',
                Promedio:  Math.round(average).toFixed(3),
                Cantidad: size
            };
            debug('response dyskinecia report final :%j', finalResponse);
            return finalResponse;
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('getReportDiskineciaTwoDates Error: %j', error);
            throw error;
        }
    }

    public static async getReportDiscrepancyTwoDates(idPatient: number, initDate: string, endDate: string): Promise<any> {
        let conn: Pool | undefined;
        try {
            conn = await connect();
            debug('getting discrepancy report by two dates First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT
                discrepancy
            FROM 
                symptomsformpatient
            WHERE ID_PATIENT= ? 
            AND formdate BETWEEN ? AND ?`;
            debug('getReportDiscrepancyTwoDates to patient id: %s', idPatient);
            const res = await conn.query(query,[idPatient, initDate, endDate]);
            debug('getReportDiscrepancyTwoDates executed and returned: %j', res[0]);
            conn.end();
            debug('query discrepancy result response :%j', res[0]);
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query discrepancy response as a list :%j', res[0]);
            let acum = 0;
            let cant = 0;
            let average = 0;
            const size = listJSON.length;
            for (let index = 0; index < size; index++) {
                if(listJSON[index].discrepancy !== 0){
                    acum += listJSON[index].discrepancy;
                    cant += 1;
                }
            }
            if (size != 0) {
                average = (acum/(cant));
            }
            const finalResponse = {
                Mes: 'null',
                Promedio: Math.round(average).toFixed(3),
                Cantidad: cant
            };
            debug('response discrepancy report final :%j', finalResponse);
            return finalResponse;
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('getReportDiscrepancyTwoDates Error: %j', error);
            throw error;
        }
    }
}