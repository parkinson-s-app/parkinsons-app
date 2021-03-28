import { connect } from "../database";
import debugLib from 'debug';
import { Pool } from "mysql2/promise";
import IMedicine from "../models/IMedicine";

const debug = debugLib('AppKinson:DoctorService');

export default class DoctorService {
    
    
    /**
     * relatePatientToDoctor
     */
    public static async relatePatientToDoctor(idDoctor: number, idPatient: number, answer: string) {
        debug('relate Patient id patient: %s, id doctor: ', idPatient, idDoctor);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const queryData = { ID_DOCTOR: idDoctor, ID_PATIENT: idPatient};
            let res;
            if(answer === 'ACCEPT') {
                res = await conn.query('INSERT INTO patientxdoctor SET ?',[queryData]);
                debug('result adding row in patientxdoctor: %j', res);
            } else {
                debug('answer was REJECTED ');
            }
            const resDeletion = await conn.query(
                'DELETE FROM requestlinkdoctortopatient WHERE ID_DOCTOR = ? AND ID_PATIENT = ?',
                [queryData.ID_DOCTOR, queryData.ID_PATIENT]);
            if(resDeletion) {
                debug('Deletion from request table success, Response: %j', resDeletion);
            }
            conn.end();
            return resDeletion;
        
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('relate Patient Error: %j', e);
            throw e;
        }
    }

    /**
     * requestRelatePatientToCarer
     */
    public static async requestRelatePatientToDoctor(idDoctor: number, idPatient: number) {
        debug('request relate Patient id patient: %s, id doctor: ', idPatient, idDoctor);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const queryData = { ID_DOCTOR: idDoctor, ID_PATIENT: idPatient};
            const res = await conn.query('INSERT INTO requestlinkdoctortopatient SET ?',[queryData]);
            conn.end();
            return res;
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('request relate Patient to Carer Error: %s', e);
            throw e;
        }
    }

    /**
     * 
     */
    public static async getPatientsUnrelated(id: number) {
        debug('Unrelated Patients, id doctor: ', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const query = `SELECT 
            p.ID_USER as IdUser,
            p.NAME as Name,
            u.EMAIL as Email
            FROM patients as p
            INNER JOIN users as u
            ON u.ID = p.ID_USER
            WHERE p.ID_USER NOT IN 
            ( SELECT ID_PATIENT
                FROM patientxdoctor 
                WHERE ID_DOCTOR = ? )`;
            const res = await conn.query(query,[id]);
            debug('Unrelated Patients response query %s', res);
            conn.end();
            if(res) {
                return res[0];
            } else {
                return null;
            }
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug('Getting unrelated Patients failed. Error: %s', error);
            throw error;
        }
    }

    /**
     * getPatients
     * SELECT ID_USER, ID_DOCTOR, NAME, EMAIL FROM patients LEFT JOIN patientxdoctor ON patients.ID_USER=patientxdoctor.ID_PATIENT LEFT JOIN users ON users.ID=patients.ID_USER WHERE ID_DOCTOR <> 2 OR ID_DOCTOR IS NULL
     */
    public static async getPatientsRelated(id: number) {
        debug('Related Patients, id doctor: ', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const query = `
            SELECT ID_USER, NAME, EMAIL
            FROM patients
            LEFT JOIN patientxdoctor 
            ON patients.ID_USER=patientxdoctor.ID_PATIENT
            LEFT JOIN users 
            ON users.ID=patients.ID_USER
            WHERE ID_DOCTOR = ?`;
            const res = await conn.query(query,[id]);
            debug('Related Patients response query %s', res);
            conn.end();
            if(res) {
                return res[0];
            } else {
                return null;
            }
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug('Related Patients failed. Error: %s', error);
            throw error;
        }
    }

    /**
     * getDoctorById
     */
    public static async getDoctorById(id : number) {
        debug('getDoctorById id: %s', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const person =  await conn.query(
                `SELECT EMAIL, NAME, PHOTOPATH  
                FROM doctors
                LEFT JOIN users
                ON users.ID = doctors.ID_USER
                WHERE users.ID = ? `,[id]);
            debug('result search dctor by id: %j', person[0]);
            conn.end();
            return person[0];
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug('Getting doctor by id failed. Error: %s', error);
            throw error;
        }
    }
    /**
     * 
     */
    public static async getMedicines() {
        debug('Get medicines');
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const medicines =  await conn.query(
                `SELECT ID, NAME  
                FROM medicine`);
            debug('result get medicines: %j', medicines[0]);
            conn.end();
            return medicines[0];
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug('Getting doctor by id failed. Error: %s', error);
            throw error;
        }
    }

    public static async setMedicineToPatient(medicine: IMedicine) {
        debug('set medicine to Patient. Id patient: %s', medicine.ID_PATIENT);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const queryData = { 
                ID_PATIENT: medicine.ID_PATIENT,
                periodicityQuantity: medicine.periodicityQuantity,
                title: medicine.title,
                alarmTime: medicine.alarmTime,
                idMedicine: medicine.idMedicine,
                dose: medicine.dose,
                periodicityType: medicine.periodicityType,
                quantity: medicine.quantity
            }; 
            const res = await conn.query('INSERT INTO alarmandmedicinepatient SET ?',[queryData]);
            conn.end();
            return res;
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('request relate Patient to Carer Error: %s', e);
            throw e;
        }
    }


    public static async unrelatePatient(idCarer: number, idPatient: number) {
        debug('Unrelate patient Doctor: %d, patient: %d', idCarer, idPatient);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const res = await conn.query('DELETE FROM patientxdoctor WHERE ID_CARER = ? AND ID_PATIENT = ?',[idCarer, idPatient]);
            debug('unrelated patient Doctor. response: %j', res);
            conn.end();
            return res;
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('unrelated patient Doctor Catch Error: %s, %j', e.stack, e);
            throw Error(e);
        }
    }
}