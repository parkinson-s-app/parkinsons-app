import { connect } from "../database";
import debugLib from 'debug';
import { Pool } from "mysql2/promise";

const debug = debugLib('AppKinson:CarerService');

export default class CarerService {
    /**
     * relatePatientToCarer
     */
    public static async relatePatientToCarer(idCarer: number, idPatient: number, answer: string) {
        debug('relate Patient id patient: %s, id carer: %s', idPatient, idCarer);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const queryData = { ID_CARER: idCarer, ID_PATIENT: idPatient};
            const resDeletion = await conn.query(
                'DELETE FROM requestlinkcarertopatient WHERE ID_CARER  = ? AND ID_PATIENT = ?',
                [queryData.ID_CARER, queryData.ID_PATIENT]);
            debug(' Result deletion request %j', resDeletion);
            if(answer === 'ACCEPT') {
                const res = await conn.query('INSERT INTO patientxcarer SET ?',[queryData]);
                debug('result adding row in patientxcarer: %j', res);
                return res;
            }
            debug('answer was REJECTED result deleting row from requestlinkcarertopatient: %j', resDeletion);
            conn.end();
            return resDeletion;
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('relate Patient to Carer Error: %s', e);
            throw e;
        }
    }

    /**
     * requestRelatePatientToCarer
     */
    public static async requestRelatePatientToCarer(idCarer: number, idPatient: number) {
        debug('request relate Patient id patient: %s, id carer: ', idPatient, idCarer);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const queryData = { ID_CARER: idCarer, ID_PATIENT: idPatient};
            const res = await conn.query('INSERT INTO requestlinkcarertopatient SET ?',[queryData]);
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
     * getPatients
     * 
     */
    public static async getPatientsUnrelated(id: number) {
        debug('Unrelated Patients, id carer: ', id);
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
                FROM patientxcarer 
                WHERE ID_CARER = ? )`;
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
            debug('Unrelated Patients error making query. Error: %s', error);
            throw error;
        }
    }

    /**
     * getPatients
     * 
     */
    public static async getPatientsRelated(id: number) {
        debug('Related Patients, id carer: ', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const query = `
            SELECT ID_USER, NAME, EMAIL
            FROM patients
            LEFT JOIN patientxcarer 
            ON patients.ID_USER=patientxcarer.ID_PATIENT
            LEFT JOIN users 
            ON users.ID=patients.ID_USER
            WHERE ID_CARER = ?`;
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
            debug('Unrelated Patients error making query. Error: %s', error);
            throw error;
        }
    }

    /**
     * getCarerById
     */
    public static async getCarerById(id : number) {
        debug('getCarerById id: %s', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const person =  await conn.query(
                `SELECT EMAIL, NAME, PHOTOPATH  
                FROM doctors
                LEFT JOIN users
                ON users.ID = doctors.ID_USER
                WHERE users.ID = ? `,[id]);
            conn.end();
            debug('result search carer by id: %j', person[0]);
            return person[0];
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug('GetCarerByID failed. Error: %s', error);
            throw error;
        }
    }
    
    public static async unrelatePatient(idCarer: number, idPatient: number) {
        debug('Unrelate patient Carer: %d, patient: %d', idCarer, idPatient);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const res = await conn.query('DELETE FROM patientxcarer WHERE ID_CARER = ? AND ID_PATIENT = ?',[idCarer, idPatient]);
            debug('unrelated patient. response: %j', res);
            conn.end();
            return res;
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('unrelated patient carer Catch Error: %s, %j', e.stack, e);
            throw Error(e);
        }
    }
}