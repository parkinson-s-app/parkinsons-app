import { connect } from "../database";
import debugLib from 'debug';
import IPersonDto from "../models/IPersonDto";
import * as bcrypt from "bcryptjs";

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
}