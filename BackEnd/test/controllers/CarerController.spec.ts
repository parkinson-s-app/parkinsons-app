import chai from 'chai';
import chaiHttp from 'chai-http';
import sinon from 'sinon';
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

describe('CarerController relate patient to carer',() => {
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

    it('relate patient to carer should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.onFirstCall().returns(responseJSON1);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/carer/relate/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                //console.log(response);
                
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });
});


describe('CarerController get patients unrelated',() => {
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

    it('get patients unrelated should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.onFirstCall().returns(responseJSON1);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/carer/patients/unrelated`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });


    it('get patients unrelated should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.onFirstCall().throws(new Error());
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/carer/patients/unrelated`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('CarerController get patients related',() => {
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

    it('get patients related should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.onFirstCall().returns(responseJSON1);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/carer/patients/related`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });


    it('get patients related should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.onFirstCall().throws(new Error());
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/carer/patients/related`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});


describe('CarerController relate patients',() => {
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

    it('relate patients should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.onFirstCall().returns(responseJSON1);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/carer/relate/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('relate patients should fails bc query return null', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.onFirstCall().returns(null);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/carer/relate/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });

    it('relate patients should fails bc query fails', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.onFirstCall().throws(new Error());
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/carer/relate/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });

    it('relate patients should fails bc id token wrong', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.onFirstCall().throws(new Error());
        const berarerPatient = 'as.eyJ0eXBlIjoiQ3VpZGFkb3IiLCJpZCI6InNmYSJ9.as';
        const id = 13;
        chai.request(app)
            .post(`/api/carer/relate/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_BAD_REQUEST);
                done();
            });
    });
});


describe('CarerController send request relate patients',() => {
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

    it('send request relate patients should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{ID: 4}]];
        sqlMock.onFirstCall().returns(responseJSON1).onSecondCall().returns([[{'response':'requested'}]]);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/carer/relate`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Email:"email"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });
    it('send request relate patients should fails bc fail second query', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{ID: 4}]];
        sqlMock.onFirstCall().returns(responseJSON1).onSecondCall().throws(new Error());
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/carer/relate`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Email:"email"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
    it('send request relate patients should fails bc is null second query', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{ID: 4}]];
        sqlMock.onFirstCall().returns(responseJSON1).onSecondCall().returns(null);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/carer/relate`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Email:"email"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
    it('send request relate patients should fails bc id not number', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{ID: "dsa"}]];
        sqlMock.onFirstCall().returns(responseJSON1).onSecondCall().returns(null);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/carer/relate`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Email:"email"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
    it('send request relate patients should fails bc email not found', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[]];
        sqlMock.onFirstCall().returns(responseJSON1).onSecondCall().returns(null);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/carer/relate`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Email:"email"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });

    it('send request relate patients should fails bc email not provided', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[]];
        sqlMock.onFirstCall().returns(responseJSON1).onSecondCall().returns(null);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/carer/relate`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_BAD_REQUEST);
                done();
            });
    });
});
