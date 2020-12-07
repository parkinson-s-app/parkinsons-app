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
        const aux = {
            EMAIL: person.email,
            PASSWORD: cript
        }
        debug('savePerson person to save: %j', aux);
        try {
            const res = await conn.query('INSERT INTO users SET ?',[aux]);
            return res;
        } catch (e) {
            debug('savePerson Catch Error: %s, %j', e.stack, e);
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
}