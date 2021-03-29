import * as speakeasy from 'speakeasy';
import config from "../config";
import debugLib from 'debug';

const debug = debugLib('AppKinson:OTPUtilities');
export default class OTPUtilities {
    public static async generateOTP() {
        debug('Generting otp')
        const token = speakeasy.totp({
            secret: config.otpKey as string,
            encoding: 'base32',
            digits:6,
            step: config.otpStep as number
        });
        return token;
    }

    public static async verifyOtp(token: string){
        debug('Verifying token');
        let verified =  speakeasy.totp.verify({
            secret: config.otpKey as string,
            encoding: 'base32',
            token: token,
            step: config.otpStep as number
        });
        debug('result verify: %s', verified);
        return verified;
    }
}