import { connect } from "../database";
import debugLib from 'debug';
import IPersonDto from "../models/IPersonDto";
import * as bcrypt from "bcryptjs";
import ISymptomsFormDto from "../models/ISymptomsFormDto";
import { Pool } from "mysql2/promise";
import * as speakeasy from 'speakeasy';
import config from "../config";

const debug = debugLib('AppKinson:PersonService');

export default class PersonService {
    
    public static async savePerson(person: IPersonDto) {
        debug('savePerson person: %j', person);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const cript = await bcrypt.hash(person.password,10);
            const userSave = {
                EMAIL: person.email,
                PASSWORD: cript,
                TYPE: person.type
            }
            debug('savePerson person to save: %j', userSave);
            const res = await conn.query('INSERT INTO users SET ?',[userSave]);
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
                    await conn.query('INSERT INTO patients SET ?', [idPerson]);
                } else if( userSave.TYPE === 'Doctor' ) {
                    await conn.query('INSERT INTO doctors SET ?', [idPerson]);
                } else if( userSave.TYPE === 'Cuidador' ) {
                    await conn.query('INSERT INTO carers SET ?', [idPerson]);
                }
                conn.end();
            }
            return res;
        } catch (e) {
            debug('savePerson Catch Error: %s, %j', e.stack, e);
            if(conn) {
                conn.end();
            }
            throw e;
        }
    }

    /**
     * getPeople
     */
    public static async getPeople() {
        debug('getPeople start');
        let conn: Pool | undefined;
        try {
            conn = await connect();
            debug('getPeople bd connected');
            const people = await conn.query('SELECT * FROM users');
            debug('getPeople response db: %j', people[0]);
            conn.end();
            return people[0];
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug("getPeople failed. Error: %j", error);
            throw error;
        }
    }

    /**
     * getPersonByEmail
     */
    public static async getPersonByEmail(email: string) {
        debug('getPersonByEmail email: %s', email);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const person =  await conn.query('SELECT * FROM users WHERE EMAIL = ?',[email]);
            conn.end();
            return person[0];
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug("getPersonByEmail failed. Error: %j", error);
            throw error;
        }
    }
    /**
     * getPersonById
     */
    public static async getPersonById(id: number) {
        debug('getPersonById id: %s', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const person =  await conn.query('SELECT * FROM users WHERE ID = ?',[id]);
            conn.end();
            return person[0];
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug("getPersonById failed. Error: %j", error);
            throw error;
        }
    }

    /**
     * updatePerson
     */
    public static async updatePerson(id: number, userUpdated: any) {
        debug('updatePerson id: %s', id);
        let conn: Pool | undefined;
        try {
            const user = await this.getPersonById(id) as any;
            debug('updatePerson person to update: %j to %j', user, userUpdated);
            conn = await connect();
            if( user && user[0] ) {
                const type = user[0].TYPE;
                debug('updatePerson person type: %s', type);
                let person;
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
                    conn.end();
                debug('updatePerson returning person %j', person);
                return person;
            } else  {
                conn.end();
                return null;
            }
        } catch (error) {
            if(conn) {
                conn.end();
            }
            debug('updatePerson failed. Error: %j', error);
            throw error;
        }
    }
    
    public static async getRelationRequest(id: number) {
        debug('Related Patients, id doctor: ', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
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
            return null;
        }
    }

    public static async saveSymptomsForm(id: number, symptomsFormData: ISymptomsFormDto) {
        symptomsFormData.id_patient=id;
        debug('saveSymptoms to person: %j, id: %s', symptomsFormData, id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const res = await conn.query('INSERT INTO symptomsformpatient SET ?',[symptomsFormData]);
            debug('savePerson saved and returned: %j', res);
            conn.end();
            return res;
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('saveSymptoms Catch Error: %s, %j', e.stack, e);
            throw e;
        }
    }

    public static async updateSymptomsForm(id: number, symptomsFormData: ISymptomsFormDto) {
        symptomsFormData.id_patient=id;
        debug('updateSymptoms to person: %j, id: %s', symptomsFormData, id);
        let conn: Pool | undefined;
        try {
            conn = await connect(); // UPDATE patients SET ? WHERE ID_USER = ?
            const res = await conn.query('UPDATE symptomsformpatient SET ? WHERE ID_PATIENT = ? AND formdate = ?',[symptomsFormData, symptomsFormData.id_patient, symptomsFormData.formdate]);
            debug('updatePerson updated and returned: %j', res);
            conn.end();
            return res;
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('updateSymptoms Catch Error: %s, %j', e.stack, e);
            throw e;
        }
    }

    public static async deleteSymptomsForm(id: number, date: string) {
        debug('deleteSymptomsForm SymptomsForm: %d', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const res = await conn.query('DELETE FROM symptomsformpatient WHERE ID_PATIENT = ? AND formdate = ?',[id, date]);
            debug('deleteSymptomsForm deleted. response: %j', res);
            conn.end();
            return res;
        } catch (e) {
            if(conn) {
                conn.end();
            }
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
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const res = await conn.query('SELECT * FROM symptomsformpatient WHERE ID_PATIENT = ?',[id]);
            debug('Symptoms found: %j', res[0]);
            conn.end();
            return res[0];
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('Getting Symptoms Catch Error: %s, %j', e.stack, e);
            throw e;
        }
    }


    public static async getToolboxItems() {
        debug('getting toolbox items ');
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const query = 
                `SELECT
                    ID,
                    Title,
                    Description,
                    URL,
                    Type
                FROM toolboxitems;`;
            const res = await conn.query(query);
            debug('getting toolbox items response query %s', res[0]);
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
            debug('getting toolbox items error making query. Error: %s', error);
            throw error;
        }
    }

    public static async generateOTP() {
        const token = speakeasy.totp({
            secret: config.otpKey as string,
            encoding: 'base32',
            digits:6,
            step: 300
        });

        
    }
}