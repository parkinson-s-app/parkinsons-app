import chai from 'chai';
import chaiHttp from 'chai-http';
import sinon, { assert } from 'sinon';
import app from '../../src/app';
import * as database from '../../src/database';
import * as nodemailer from 'nodemailer';
import * as speakeasy from 'speakeasy';

const mysql = require('mysql2/promise');
import path from 'path';
import fs from 'fs';
import { constants } from 'http2';
import PersonService from '../../src/services/PersonService';
import Mail from 'nodemailer/lib/mailer';
import EmailUtilities from '../../src/utilities/EmailUtilities';
import OTPUtilities from '../../src/utilities/OTPUtilities';
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

chai.use(chaiHttp);
chai.should();
const expect = chai.expect;
const sandbox = sinon.createSandbox();
// resources
const saveUserResponse  = require('../resources/savePersonResponse.json');

describe('databaseService execute sql',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    //let nodeMailerMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
        //nodeMailerMock = sinon.stub(EmailUtilities, 'sendEmailFinal');
    });
    afterEach(() => {
        sinon.restore();
    });

    // it('delete toolbox item should have been success', async (done) => {
    //     const poolStub = {
    //         getConnection: sinon.stub().returnsThis(),
    //         release: sinon.stub(),
    //         query: sinon.stub().returnsThis(),
    //     };
    //     //const createPoolStub = sinon.stub( mysql, 'createPool' ).returns(poolStub);
    //     const connStub = { query: sinon.stub().resolves({ rowCount: 1 }), release: sinon.stub() };
    //     //const poolStub = { getConnection: sinon.stub().resolves(connStub) } ;
    //     sinon.stub(database, "connect").returns(poolStub);
    //     await database.executeSQL('sql');
    //     assert.calledOnce(createPoolStub);
    //     done();
    // });
});