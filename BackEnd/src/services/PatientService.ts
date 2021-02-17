import { connect } from "../database";
import debugLib from 'debug';
import IAnswerRequestDto from "../models/IAnswerRequestDto";
import { PersonType } from "../utilities/GenericTypes";
import CarerService from "./CarerService";
import DoctorService from "./DoctorService";

const debug = debugLib('AppKinson:PatientService');

export default class PatientService {

    public static async getDoctorRequests(id: number) {
        debug('Getting requests doctor of id patient: %s', id);
        const conn = await connect();
        const requests = await conn.query('SELECT * FROM requestlinkdoctortopatient WHERE ID_PATIENT = ?',[id]);
        return requests[0];
    }

    public static async getCarerRequests(id: number) {
        debug('Getting requests carer of id patient: %s', id);
        const conn = await connect();
        const requests = await conn.query('SELECT * FROM requestlinkcarertopatient WHERE ID_PATIENT = ?',[id]);
        return requests[0];
    }

    public static async answerRequest(idPatient: number, answer: IAnswerRequestDto) {
        debug('Answer request id patient: %s, info answer: %j ', idPatient, answer);
        try {
            if( answer.RequesterType === PersonType.CARER ) {
                const idCarer = Number(answer.RequesterId);
                if(!Number.isNaN(idCarer)) {
                    return await CarerService.relatePatientToCarer(idCarer, idPatient, answer.Answer);
                } else {
                    return 'Error parsing Id Carer';
                }
            } else if(answer.RequesterType === PersonType.DOCTOR) {
                const idDoctor = Number(answer.RequesterId);
                if(!Number.isNaN(idDoctor)) {
                    return await DoctorService.relatePatientToDoctor(idDoctor, idPatient, answer.Answer)
                } else {
                    return 'Error parsing Id Doctor';
                }
            }
        } catch (error) {
            debug('Answering request Patient to Carer Error: %j', error);
            throw error;
        }
    }
    
    /**
     * getPatientByEmail
     */
    public static async getIdPatientByEmail(email: string) {
        debug('getPatientByEmail email: %s', email);
        const conn = await connect();
        const person =  await conn.query(
            `SELECT ID 
            FROM patients
            LEFT JOIN users
            ON users.ID = patients.ID_USER
            WHERE users.EMAIL = ? `,[email]);
        debug('result search patient by email: %j', person[0]);
        return person[0];
    }
    /**
     * getPatientById
     */
    public static async getPatientById(id : number) {
        debug('getPatientById id: %s', id);
        const conn = await connect();
        const person =  await conn.query(
            `SELECT EMAIL, NAME, PHOTOPATH 
            FROM patients
            LEFT JOIN users
            ON users.ID = patients.ID_USER
            WHERE users.ID = ? `,[id]);
        debug('result search patient by id: %j', person[0]);
        return person[0];
    }
}