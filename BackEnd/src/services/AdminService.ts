import { connect } from "../database";
import debugLib from 'debug';

const debug = debugLib('AppKinson:PersonService');

export default class AdminService {

    public static async deletePerson(id: number) {
        debug('deletePerson person: %d', id);
        try {
            const conn = await connect();
            const res = await conn.query('DELETE FROM users WHERE ID = ?',[id]);
            debug('deletePerson saved and returned: %j', res);
            if( res && res[0] ) {
                const deleted = res[0] as any;
                debug('Registro success id inserted: %s', deleted);
                return deleted;
            }
            return res;
        } catch (e) {
            debug('deletePerson Catch Error: %s, %j', e.stack, e);
            throw Error(e);
        }
    }
}