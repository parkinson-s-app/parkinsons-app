import { executeSQL } from '../database';
import debugLib from 'debug';
import IPersonDto from '../models/IPersonDto';
import * as bcrypt from 'bcryptjs';
import ISymptomsFormDto from '../models/ISymptomsFormDto';
import { Pool } from 'mysql2/promise';
import IPersonResetDto from '../models/IPersonResetDto';

const debug = debugLib('AppKinson:PersonService');

export default class PersonService {

    public static async savePerson(person: IPersonDto) {
        debug('savePerson person: %j', person);
        try {
            const cript = await bcrypt.hash(person.password,10);
            const userSave = {
                EMAIL: person.email,
                PASSWORD: cript,
                TYPE: person.type
            };
            debug('savePerson person to save: %j', userSave);
            const res = await executeSQL('INSERT INTO users SET ?',[userSave]);
            debug('savePerson saved and returned: %j', res);
            if( res && res[0] ) {
                const inserted = res[0] as any;
                const idInserted = inserted.insertId;
                debug('Registro success id inserted: %s', idInserted);
                let idPerson;
                if(person.name) {
                    debug('Insert with name, name: %s', person.name);
                    idPerson = {ID_USER: idInserted, NAME: person.name};
                } else {
                    debug('Insert without name, name: %s', person.name);
                    idPerson = {ID_USER: idInserted};
                }
                debug('Registro data to insert in type tables %j', idPerson);
                if( userSave.TYPE === 'Paciente' ) {
                    await executeSQL('INSERT INTO patients SET ?', [idPerson]);
                } else if( userSave.TYPE === 'Doctor' ) {
                    await executeSQL('INSERT INTO doctors SET ?', [idPerson]);
                } else if( userSave.TYPE === 'Cuidador' ) {
                    await executeSQL('INSERT INTO carers SET ?', [idPerson]);
                }
            }
            return res;
        } catch (e) {
            debug('savePerson Catch Error: %s, %j', e.stack, e);
            throw e;
        }
    }

    /**
     * getPeople
     */
    public static async getPeople() {
        debug('getPeople start');
        try {
            debug('getPeople bd connected');
            const people = await executeSQL('SELECT ID as Id, EMAIL as Email, TYPE as Type FROM users');
            debug('getPeople response complete db: %j', people);
            debug('getPeople response db: %j', people[0]);
            return people[0];
        } catch (error) {
            debug('getPeople failed. Error: %j', error);
            throw error;
        }
    }

    /**
     * getPersonByEmail
     */
    public static async getPersonByEmail(email: string) {
        debug('getPersonByEmail email: %s', email);
        try {
            const person =  await executeSQL('SELECT * FROM users WHERE EMAIL = ?',[email]);
            debug('getPersonByEmail response complete: %j', person);
            return person[0];
        } catch (error) {
            debug('getPersonByEmail failed. Error: %j', error);
            throw error;
        }
    }
    /**
     * getPersonById
     */
    public static async getPersonById(id: number) {
        debug('getPersonById id: %s', id);
        try {
            const person =  await executeSQL('SELECT * FROM users WHERE ID = ?',[id]);
            return person[0];
        } catch (error) {
            debug('getPersonById failed. Error: %j', error);
            throw error;
        }
    }

    /**
     * updatePerson
     */
    public static async updatePerson(id: number, userUpdated: any) {
        debug('updatePerson id: %s', id);
        try {
            const user = await this.getPersonById(id) as any;
            debug('updatePerson person to update: %j to %j', user, userUpdated);
            if( user && user[0] ) {
                const type = user[0].TYPE;
                debug('updatePerson person type: %s', type);
                let person;
                    if( type === 'Doctor') {
                        debug('updatePerson person to update is a doctor');
                        person =  await executeSQL('UPDATE doctors SET ? WHERE ID_USER = ?',[userUpdated, id]);
                    } else if( type === 'Paciente') {
                        debug('updatePerson person to update is a patient');
                        person =  await executeSQL('UPDATE patients SET ? WHERE ID_USER = ?',[userUpdated, id]);
                    } else if ( type === 'Cuidador') {
                        debug('updatePerson person to update is a carer');
                        person =  await executeSQL('UPDATE carers SET ? WHERE ID_USER = ?',[userUpdated, id]);
                    }
                debug('updatePerson returning person %j', person);
                return person;
            } else  {
                return null;
            }
        } catch (error) {
            debug('updatePerson failed. Error: %j', error);
            throw error;
        }
    }

    public static async getRelationRequest(id: number) {
        debug('Related Patients, id doctor: ', id);
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
            const res = await executeSQL(query,[id]);
            debug('Requests response query %s', res);
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

    public static async saveSymptomsForm(id: number, symptomsFormData: ISymptomsFormDto) {
        symptomsFormData.id_patient=id;
        debug('saveSymptoms to person: %j, id: %s', symptomsFormData, id);
        try {
            const res = await executeSQL('INSERT INTO symptomsformpatient SET ?',[symptomsFormData]);
            debug('savePerson saved and returned: %j', res);
            return res;
        } catch (e) {
            debug('saveSymptoms Catch Error: %s, %j', e.stack, e);
            throw e;
        }
    }

    public static async updateSymptomsForm(id: number, symptomsFormData: ISymptomsFormDto) {
        symptomsFormData.id_patient=id;
        debug('updateSymptoms to person: %j, id: %s', symptomsFormData, id);
        try { // UPDATE patients SET ? WHERE ID_USER = ?
            const res = await executeSQL('UPDATE symptomsformpatient SET ? WHERE ID_PATIENT = ? AND formdate = ?',[symptomsFormData, symptomsFormData.id_patient, symptomsFormData.formdate]);
            debug('updatePerson updated and returned: %j', res);
            return res;
        } catch (e) {
            debug('updateSymptoms Catch Error: %s, %j', e.stack, e);
            throw e;
        }
    }

    public static async deleteSymptomsForm(id: number, date: string) {
        debug('deleteSymptomsForm SymptomsForm: %d', id);
        try {
            const res = await executeSQL('DELETE FROM symptomsformpatient WHERE ID_PATIENT = ? AND formdate = ?',[id, date]);
            debug('deleteSymptomsForm deleted. response: %j', res);
            return res;
        } catch (e) {
            debug('deleteSymptomsForm Catch Error: %s, %j', e.stack, e);
            throw Error(e);
        }
    }
    /**
     * obtener los formularios de un paciente con el id
     * @param id
     */
    public static async getSymptomsForm(id: number) {
        debug('Symptoms of person: id: %s', id);
        try {
            const res = await executeSQL('SELECT * FROM symptomsformpatient WHERE ID_PATIENT = ?',[id]);
            debug('Symptoms found: %j', res[0]);
            return res[0];
        } catch (e) {
            debug('Getting Symptoms Catch Error: %s, %j', e.stack, e);
            throw e;
        }
    }


    public static async getToolboxItems() {
        debug('getting toolbox items ');
        try {
            const query =
                `SELECT
                    ID,
                    Title,
                    Description,
                    URL,
                    Type
                FROM toolboxitems;`;
            const res = await executeSQL(query);
            if(res) {
                debug('getting toolbox items response query %s', res[0]);
                return res[0];
            } else {
                return null;
            }
        } catch (error) {
            debug('getting toolbox items error making query. Error: %s', error);
            throw error;
        }
    }

    public static async resetPassword(credentials: IPersonResetDto) {
        debug('Resetting Password: ');
        try {
            const cript = await bcrypt.hash(credentials.Password,10);
            const userSave = {
                EMAIL: credentials.Email,
                PASSWORD: cript
            };
            debug('Credentials to reset: %j', userSave);
            const res = await executeSQL('UPDATE users SET PASSWORD = ? WHERE EMAIL = ?',[userSave.PASSWORD, userSave.EMAIL]);
            debug('Reset credentials result: %j', res);
            return res[0];
        } catch (e) {
            debug('Reset credentials Catch Error: %s, %j', e.stack, e);
            throw e;
        }
    }

}