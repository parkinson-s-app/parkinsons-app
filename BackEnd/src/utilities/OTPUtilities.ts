import * as speakeasy from 'speakeasy';
import config from "../config";
import debugLib from 'debug';

const debug = debugLib('AppKinson:PersonService');
export default class OTPUtilities {
    public static async generateOTP() {
        debug('Generting otp')
        const token = speakeasy.totp({
            secret: config.otpKey as string,
            encoding: 'base32',
            digits:6,
            step: 300
        });
        return token;
    }

    public static async verifyOtp(token: any){
        let expiry =  speakeasy.totp.verifyDelta({
            secret: config.otpKey as string,
            encoding: 'base32',
            token: token,
            step: 60,
            window:10
        });
        console.log(expiry)
    }
}