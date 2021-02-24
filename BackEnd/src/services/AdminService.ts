import { connect } from "../database";
import debugLib from 'debug';
import { Pool } from "mysql2/promise";

const debug = debugLib('AppKinson:PersonService');

export default class AdminService {

    public static async deletePerson(id: number) {
        debug('deletePerson person: %d', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const res = await conn.query('DELETE FROM users WHERE ID = ?',[id]);
            debug('deletePerson saved and returned: %j', res);
            conn.end();
            if( res && res[0] ) {
                const deleted = res[0] as any;
                debug('Registro success id inserted: %s', deleted);
                return deleted;
            }
            return res;
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('deletePerson Catch Error: %s, %j', e.stack, e);
            throw Error(e);
        }
    }
}