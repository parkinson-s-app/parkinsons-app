import { connect } from "../database";
import debugLib from 'debug';
import { Pool } from "mysql2/promise";
import IToolboxItemDto from "../models/IToolboxItemDto";
import * as nodemailer from 'nodemailer';
import config from "../config";

const debug = debugLib('AppKinson:AdminService');

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

    public static async deleteToolboxItemById(id: number) {
        debug('delete Toolbox item, id: %d', id);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const res = await conn.query('DELETE FROM users WHERE ID = ?',[id]);
            debug('delete Toolbox item response: %j', res);
            conn.end();
            if( res && res[0] ) {
                const deleted = res[0] as any;
                debug(' Toolbox item success id deleted: %s', deleted);
                return deleted;
            }
            return res;
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('delete Toolbox item Catch Error: %s, %j', e.stack, e);
            throw Error(e);
        }
    }

    public static async saveToolboxItem(toolboxItem: IToolboxItemDto) {
        debug('save toolbox item: %j', toolboxItem);
        let conn: Pool | undefined;
        try {
            conn = await connect();
            const queryData = {  
                Title: toolboxItem.Title,
                Description: toolboxItem.Description,
                URL: toolboxItem.URL,
                Type: toolboxItem.Type
            };
            const res = await conn.query('INSERT INTO toolboxitems SET ?',[queryData]);
            conn.end();
            return res;
        } catch (e) {
            if(conn) {
                conn.end();
            }
            debug('save toolbox item Error: %s', e);
            throw e;
        }
    }

    public static async sendEmail(email: string) {
        debug(' Reset password email: %s', email);
        const transport = nodemailer.createTransport({
            // host: config.hostEmail,
            // port: config.portEmail as number,
            service: 'gmail',
            auth: {
               user: config.userEmail,
               pass: config.passwordEmail
            }
        });
        const message = {
            from: config.userEmail, //'elonmusk@tesla.com', // Sender address
            to: email,         // List of recipients
            subject: 'Design Your Model S | Tesla', // Subject line
            text: 'Have the most fun you can in a car. Get your Tesla today!' // Plain text body
        };
        try {
            const result = await transport.sendMail(message);
            debug('Confirmation sent. Email: %s', email);
            return result;
        } catch (error) {
            debug('Error sending email: %s, error: %j', email, error);
            throw error;            
        }
    }
}