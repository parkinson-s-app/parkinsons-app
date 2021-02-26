import { connect } from "../database";
import debugLib from 'debug';
import IAnswerRequestDto from "../models/IAnswerRequestDto";
import { PersonType } from "../utilities/GenericTypes";
import CarerService from "./CarerService";
import DoctorService from "./DoctorService";
import IEmotionalFormDto from "../models/IEmotionalFormDto";
import { Pool } from "mysql2/promise";
import IMedicineAlarm from "../models/IMedicineAlarm";

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
            const res = await conn.query('INSERT INTO emotionalformpatient SET ?',[emotionalFormData]);
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
            const query = 'SELECT * FROM emotionalformpatient WHERE ID_PATIENT=? and ( date BETWEEN ? AND ?)';
            debug('getEmotionalForms to patient id: %s', id);
            const res = await conn.query(query,[id, dateStart, dateEnd]);
            debug('getEmotionalForms saved and returned: %j', res);
            conn.end();
            return res[0];
        }  catch (error) {
            if(conn) {
                conn.end();
            }
            debug('saveEmotionalForm Error: %j', error);
            throw error;
        }
    }

    public static async getMedicineAlarmsById(id: number) {
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const query = 'SELECT * FROM medicinealarmpatient WHERE ID_PATIENT=?';
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
}