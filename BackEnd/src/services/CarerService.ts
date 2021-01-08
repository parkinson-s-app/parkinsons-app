import { connect } from "../database";
import debugLib from 'debug';

const debug = debugLib('AppKinson:CarerService');

export default class CarerService {
    /**
     * relatePatientToCarer
     */
    public static async relatePatientToCarer(idCarer: number, idPatient: number, answer: string) {
        debug('relate Patient id patient: %s, id carer: %s', idPatient, idCarer);
        const conn = await connect();
        try {
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
            return resDeletion;
        } catch (e) {
            debug('relate Patient to Carer Error: %s', e);
        }
    }

    /**
     * requestRelatePatientToCarer
     */
    public static async requestRelatePatientToCarer(idCarer: number, idPatient: number) {
        debug('request relate Patient id patient: %s, id carer: ', idPatient, idCarer);
        const conn = await connect();
        try {
            const queryData = { ID_CARER: idCarer, ID_PATIENT: idPatient};
            const res = await conn.query('INSERT INTO requestlinkcarertopatient SET ?',[queryData]);
            return res;
        } catch (e) {
            debug('request relate Patient to Carer Error: %s', e);
        }
    }

    /**
     * getPatients
     * 
     */
    public static async getPatientsUnrelated(id: number) {
        debug('Unrelated Patients, id carer: ', id);
        const conn = await connect();
        try {
            const query = `SELECT *
            FROM patients 
            WHERE ID_USER NOT IN 
            ( SELECT ID_PATIENT
                FROM patientxcarer 
                WHERE ID_CARER = ? )`;
            const res = await conn.query(query,[id]);
            debug('Unrelated Patients response query %s', res);
            if(res) {
                return res[0];
            } else {
                return null;
            }
        } catch (error) {
            debug('Unrelated Patients error making query. Error: %s', error);
            return null;
        }
    }

    /**
     * getPatients
     * 
     */
    public static async getPatientsRelated(id: number) {
        debug('Related Patients, id carer: ', id);
        const conn = await connect();
        try {
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
            if(res) {
                return res[0];
            } else {
                return null;
            }
        } catch (error) {
            debug('Unrelated Patients error making query. Error: %s', error);
            return null;
        }
    }
}