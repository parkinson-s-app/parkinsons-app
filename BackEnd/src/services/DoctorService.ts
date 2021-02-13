import { connect } from "../database";
import debugLib from 'debug';

const debug = debugLib('AppKinson:DoctorService');

export default class DoctorService {

    /**
     * relatePatientToDoctor
     */
    public static async relatePatientToDoctor(idDoctor: number, idPatient: number, answer: string) {
        debug('relate Patient id patient: %s, id doctor: ', idPatient, idDoctor);
        const conn = await connect();
        try {
            const queryData = { ID_DOCTOR: idDoctor, ID_PATIENT: idPatient};
            const resDeletion = await conn.query(
                'DELETE FROM requestlinkdoctortopatient WHERE ID_DOCTOR = ? AND ID_PATIENT = ?',
                [queryData.ID_DOCTOR, queryData.ID_PATIENT]);
            if(answer === 'ACCEPT') {
                const res = await conn.query('INSERT INTO patientxdoctor SET ?',[queryData]);
                debug('result adding row in patientxdoctor: %j', res);
                return res;
            }
            debug('answer was REJECTED result deleting row from requestlinkdoctortopatient: %j', resDeletion);
            return resDeletion;
        } catch (e) {
            debug('relate Patient Error: %j', e);
            throw e;
        }
    }

    /**
     * requestRelatePatientToCarer
     */
    public static async requestRelatePatientToDoctor(idDoctor: number, idPatient: number) {
        debug('request relate Patient id patient: %s, id doctor: ', idPatient, idDoctor);
        const conn = await connect();
        try {
            const queryData = { ID_DOCTOR: idDoctor, ID_PATIENT: idPatient};
            const res = await conn.query('INSERT INTO requestlinkdoctortopatient SET ?',[queryData]);
            return res;
        } catch (e) {
            debug('request relate Patient to Carer Error: %s', e);
        }
    }

    /**
     * getPatients
     * SELECT ID_USER, ID_DOCTOR, NAME, EMAIL FROM patients LEFT JOIN patientxdoctor ON patients.ID_USER=patientxdoctor.ID_PATIENT LEFT JOIN users ON users.ID=patients.ID_USER WHERE ID_DOCTOR <> 2 OR ID_DOCTOR IS NULL
     */
    public static async getPatientsUnrelated(id: number) {
        debug('Unrelated Patients, id doctor: ', id);
        const conn = await connect();
        try {
            const query = `SELECT *
            FROM patients 
            WHERE ID_USER NOT IN 
            ( SELECT ID_PATIENT
                FROM patientxdoctor 
                WHERE ID_DOCTOR = ? )`;
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
     * SELECT ID_USER, ID_DOCTOR, NAME, EMAIL FROM patients LEFT JOIN patientxdoctor ON patients.ID_USER=patientxdoctor.ID_PATIENT LEFT JOIN users ON users.ID=patients.ID_USER WHERE ID_DOCTOR <> 2 OR ID_DOCTOR IS NULL
     */
    public static async getPatientsRelated(id: number) {
        debug('Related Patients, id doctor: ', id);
        const conn = await connect();
        try {
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