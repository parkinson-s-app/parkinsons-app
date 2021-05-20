
import config from '../config';
import debugLib from 'debug';
import * as nodemailer from 'nodemailer';

const debug = debugLib('AppKinson:OTPUtilities');
export default class EmailUtilities {
    public static async sendEmail(email: string, subject: string, text: string) {
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
            from: config.userEmail, // 'elonmusk@tesla.com', // Sender address
            to: email,         // List of recipients
            subject, // Subject line
            text // Plain text body
        };
        try {
            const result = await this.sendEmailFinal(transport, message);
            debug('Confirmation sent. Email: %s', email);
            return result;
        } catch (error) {
            debug('Error sending email: %s, error: %j', email, error);
            throw error;
        }
    }

    public static async sendEmailFinal(transport: any, message: any) {
        return await transport.sendMail(message);
    }
}
