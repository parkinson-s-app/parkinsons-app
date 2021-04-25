import { connect, executeSQL } from "../database";
import debugLib from 'debug';
import { Pool } from "mysql2/promise";
import IToolboxItemDto from "../models/IToolboxItemDto";
import * as nodemailer from 'nodemailer';
import config from "../config";

const debug = debugLib('AppKinson:AdminService');

export default class AdminService {

    public static async deletePerson(id: number) {
        debug('deletePerson person: %d', id);
        try {
            const res = await executeSQL('DELETE FROM users WHERE ID = ?',[id]);
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

    public static async deleteToolboxItemById(id: number) {
        debug('delete Toolbox item, id: %d', id);
        try {
            const res = await executeSQL('DELETE FROM toolboxitems WHERE ID = ?',[id]);
            debug('delete Toolbox item response: %j', res);
            if( res && res[0] ) {
                const deleted = res[0] as any;
                debug(' Toolbox item success id deleted: %s', deleted);
                return deleted;
            }
            return res;
        } catch (e) {
            debug('delete Toolbox item Catch Error: %s, %j', e.stack, e);
            throw Error(e);
        }
    }

    public static async saveToolboxItem(toolboxItem: IToolboxItemDto) {
        debug('save toolbox item: %j', toolboxItem);
        try {
            const queryData = {  
                Title: toolboxItem.Title,
                Description: toolboxItem.Description,
                URL: toolboxItem.URL,
                Type: toolboxItem.Type
            };
            const res = await executeSQL('INSERT INTO toolboxitems SET ?',[queryData]);
            return res;
        } catch (e) {
            debug('save toolbox item Error: %s', e);
            throw e;
        }
    }
}