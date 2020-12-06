import { connect } from "../database";
import debugLib from 'debug';
import IPersonDto from "../models/IPersonDto";

const debug = debugLib('AppKinson:PersonService');

export default class PersonService {

    public static async savePerson(person: IPersonDto) {
        debug('savePerson person: %j', person);
        const conn = await connect();
        const aux = {
            EMAIL: person.email,
            PASSWORD: person.password
        }
        debug('savePerson person to save: %j', aux);
        const res = await conn.query('INSERT INTO users SET ?',[aux]);
        conn.end();
        return res;
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
        conn.end();
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
}