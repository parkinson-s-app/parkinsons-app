import { connect } from "../database";
import debugLib from 'debug';
import IPersonDto from "../models/IPersonDto";
import * as bcrypt from "bcryptjs";
import ISymptomsFormDto from "../models/ISymptomsFormDto";

const debug = debugLib('AppKinson:PersonService');

export default class PersonService {
    
    public static async savePerson(person: IPersonDto) {
        debug('savePerson person: %j', person);
        const conn = await connect();
        const cript = await bcrypt.hash(person.password,10);
        const userSave = {
            EMAIL: person.email,
            PASSWORD: cript,
            TYPE: person.type
        }
        debug('savePerson person to save: %j', userSave);
        try {
            const res = await conn.query('INSERT INTO users SET ?',[userSave]);
            debug('savePerson saved and returned: %j', res);
            if( res && res[0] ) {
                const inserted = res[0] as any;
                const idInserted = inserted.insertId
                debug('Registro success id inserted: %s:%s', idInserted);
                const idPerson = {ID_USER: idInserted};
                debug('Registro data to insert in type tables %j', idPerson);
                if( userSave.TYPE === 'Paciente' ) {
                    await conn.query('INSERT INTO patients SET ?', [idPerson]);
                } else if( userSave.TYPE === 'Doctor' ) {
                    await conn.query('INSERT INTO doctors SET ?', [idPerson]);
                } else if( userSave.TYPE === 'Cuidador' ) {
                    await conn.query('INSERT INTO carers SET ?', [idPerson]);
                }
            }
            return res;
        } catch (e) {
            debug('savePerson Catch Error: %s, %j', e.stack, e);
            // throw Error
        }
    }

    /**
     * getPeople
     */
    public static async getPeople() {
        debug('getPeople start');
        const conn = await connect();
        debug('getPeople bd connected');
        const people = await conn.query('SELECT * FROM users');
        debug('getPeople response db: %j', people[0]);
        return people[0];
    }

    /**
     * getPersonByEmail
     */
    public static async getPersonByEmail(email: string) {
        debug('getPersonByEmail email: %s', email);
        const conn = await connect();
        const person =  await conn.query('SELECT * FROM users WHERE EMAIL = ?',[email]);
        return person[0];
    }
    /**
     * getPersonById
     */
    public static async getPersonById(id: number) {
        debug('getPersonById id: %s', id);
        const conn = await connect();
        const person =  await conn.query('SELECT * FROM users WHERE ID = ?',[id]);
        return person[0];
    }

    /**
     * updatePerson
     */
    public static async updatePerson(id: number, userUpdated: any) {
        debug('updatePerson id: %s', id);
        const conn = await connect();
        const user = await this.getPersonById(id) as any;
        debug('updatePerson person to update: %j to %j', user, userUpdated);
        if( user && user[0] ) {
            const type = user[0].TYPE;
            debug('updatePerson person type: %s', type);
            let person;
            try {
                if( type === 'Doctor') {
                    debug('updatePerson person to update is a doctor');
                    person =  await conn.query('UPDATE doctors SET ? WHERE ID_USER = ?',[userUpdated, id]);
                } else if( type === 'Paciente') {
                    debug('updatePerson person to update is a patient');
                    person =  await conn.query('UPDATE patients SET ? WHERE ID_USER = ?',[userUpdated, id]);
                } else if ( type === 'Cuidador') {
                    debug('updatePerson person to update is a carer');
                    person =  await conn.query('UPDATE carers SET ? WHERE ID_USER = ?',[userUpdated, id]);
                }
            } catch(e) {
                debug('updatePerson Error Updating %s', e);
            }
            debug('updatePerson returning person %j', person);
            return person;
        } else  {
            return null;
        }
    }

    /**
     * relatePatientToDoctor
     */
    public static async relatePatientToDoctor(idDoctor: number, idPatient: number) {
        debug('relate Patient id patient: %s, id doctor: ', idPatient, idDoctor);
        const conn = await connect();
        try {
            const queryData = { ID_DOCTOR: idDoctor, ID_PATIENT: idPatient};
            const res = await conn.query('INSERT INTO patientxdoctor SET ?',[queryData]);
            return res;
        } catch (e) {
            debug('relate Patient Error: %s', e);
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
            FROM patients LEFT JOIN users ON users.ID=patients.ID_USER
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
    
    public static async getRelationRequest(id: number) {
        debug('Related Patients, id doctor: ', id);
        const conn = await connect();
        try {
            const query = `
            SELECT EMAIL, TYPE, ID, NAME FROM 
            (                
             (SELECT EMAIL, TYPE, ID, ID_PATIENT, NAME
            FROM (requestlinkdoctortopatient 
                  LEFT JOIN users 
                  ON users.ID = requestlinkdoctortopatient.ID_DOCTOR
                  LEFT JOIN doctors
                  ON users.ID = doctors.ID_USER
                 ) 
            UNION ( 
                SELECT EMAIL, TYPE, ID, ID_PATIENT, NAME 
                FROM requestlinkcarertopatient 
                LEFT JOIN users 
                ON users.ID = requestlinkcarertopatient.ID_CARER
                LEFT JOIN carers
                ON users.ID = carers.ID_USER
                )
            )
           ) as result
           WHERE result.ID_PATIENT = ?`;
            const res = await conn.query(query,[id]);
            debug('Requests response query %s', res);
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

    public static async saveSymptomsForm(id: number, symptomsFormData: ISymptomsFormDto) {
        const conn = await connect();
        symptomsFormData.id_patient=id;
        debug('saveSymptoms to person: %j, id: %s', symptomsFormData, id);
        try {
            const res = await conn.query('INSERT INTO symptomsformpatient SET ?',[symptomsFormData]);
            debug('savePerson saved and returned: %j', res);
            return res;
        } catch (e) {
            debug('saveSymptoms Catch Error: %s, %j', e.stack, e);
            // throw Error
        }
    }
    /**
     * obtener los formularios de un paciente con el id
     * @param id 
     */
    public static async getSymptomsForm(id: number) {
        const conn = await connect();
        debug('Symptoms of person: id: %s', id);
        try {
            const res = await conn.query('SELECT * FROM symptomsformpatient WHERE ID_PATIENT = ?',[id]);
            debug('Symptoms found: %j', res);
            return res[0];
        } catch (e) {
            debug('Getting Symptoms Catch Error: %s, %j', e.stack, e);
            // throw Error
        }
    }

}