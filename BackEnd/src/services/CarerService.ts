import { connect, executeSQL } from '../database';
import debugLib from 'debug';
import { Pool } from 'mysql2/promise';

const debug = debugLib('AppKinson:CarerService');

export default class CarerService {
    /**
     * relatePatientToCarer
     */
    public static async relatePatientToCarer(idCarer: number, idPatient: number, answer: string) {
        debug('relate Patient id patient: %s, id carer: %s', idPatient, idCarer);
        try {
            const queryData = { ID_CARER: idCarer, ID_PATIENT: idPatient};
            const resDeletion = await executeSQL(
                'DELETE FROM requestlinkcarertopatient WHERE ID_CARER  = ? AND ID_PATIENT = ?',
                [queryData.ID_CARER, queryData.ID_PATIENT]);
            debug(' Result deletion request %j', resDeletion);
            if(answer === 'ACCEPT') {
                const res = await executeSQL('INSERT INTO patientxcarer SET ?',[queryData]);
                debug('result adding row in patientxcarer: %j', res);
                return res;
            }
            debug('answer was REJECTED result deleting row from requestlinkcarertopatient: %j', resDeletion);
            return resDeletion;
        } catch (e) {
            debug('relate Patient to Carer Error: %s', e);
            throw e;
        }
    }

    /**
     * requestRelatePatientToCarer
     */
    public static async requestRelatePatientToCarer(idCarer: number, idPatient: number) {
        debug('request relate Patient id patient: %s, id carer: ', idPatient, idCarer);
        try {
            const queryData = { ID_CARER: idCarer, ID_PATIENT: idPatient};
            const res = await executeSQL('INSERT INTO requestlinkcarertopatient SET ?',[queryData]);
            return res;
        } catch (e) {
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
        try {
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
            const res = await executeSQL(query,[id]);
            debug('Unrelated Patients response query %s', res);
            if(res) {
                return res[0];
            } else {
                return null;
            }
        } catch (error) {
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
        try {
            const query = `
            SELECT ID_USER, NAME, EMAIL
            FROM patients
            LEFT JOIN patientxcarer
            ON patients.ID_USER=patientxcarer.ID_PATIENT
            LEFT JOIN users
            ON users.ID=patients.ID_USER
            WHERE ID_CARER = ?`;
            const res = await executeSQL(query,[id]);
            debug('Related Patients response query %s', res);
            if(res) {
                return res[0];
            } else {
                return null;
            }
        } catch (error) {
            debug('Unrelated Patients error making query. Error: %s', error);
            throw error;
        }
    }

    /**
     * getCarerById
     */
    public static async getCarerById(id : number) {
        debug('getCarerById id: %s', id);
        try {
            const person =  await executeSQL(
                `SELECT EMAIL, NAME, PHOTOPATH
                FROM doctors
                LEFT JOIN users
                ON users.ID = doctors.ID_USER
                WHERE users.ID = ? `,[id]);
            debug('result search carer by id: %j', person[0]);
            return person[0];
        } catch (error) {
            debug('GetCarerByID failed. Error: %s', error);
            throw error;
        }
    }

    public static async unrelatePatient(idCarer: number, idPatient: number) {
        debug('Unrelate patient Carer: %d, patient: %d', idCarer, idPatient);
        try {
            const res = await executeSQL('DELETE FROM patientxcarer WHERE ID_CARER = ? AND ID_PATIENT = ?',[idCarer, idPatient]);
            debug('unrelated patient. response: %j', res);
            return res;
        } catch (e) {
            debug('unrelated patient carer Catch Error: %s, %j', e.stack, e);
            throw Error(e);
        }
    }
}