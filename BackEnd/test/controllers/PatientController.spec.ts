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

describe('PatientController post answer request',() => {
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

    it('answer request to carer should accept the request', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'deleted'}]];
        const responseJSON2 = [[{'some': 'added'}]];
        sqlMock.onFirstCall().returns(responseJSON1).onSecondCall().returns(responseJSON2);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post('/api/patient/answerRequest')
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Answer: "ACCEPT",
                RequesterType: "Cuidador",
                RequesterId: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('answer request to carer should fail bc requester id is wrong', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'deleted'}]];
        const responseJSON2 = [[{'some': 'added'}]];
        sqlMock.onFirstCall().returns(responseJSON1).onSecondCall().returns(responseJSON2);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post('/api/patient/answerRequest')
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Answer: "ACCEPT",
                RequesterType: "Cuidador",
                RequesterId: "n2"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });

    it('answer request to doctor should accept the request', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'deleted'}]];
        const responseJSON2 = [[{'some': 'added'}]];
        sqlMock.onFirstCall().returns(responseJSON1).onSecondCall().returns(responseJSON2);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post('/api/patient/answerRequest')
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Answer: "ACCEPT",
                RequesterType: "Doctor",
                RequesterId: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('answer request to doctor should fail bc requester id is wrong', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'deleted'}]];
        const responseJSON2 = [[{'some': 'added'}]];
        sqlMock.onFirstCall().returns(responseJSON1).onSecondCall().returns(responseJSON2);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post('/api/patient/answerRequest')
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Answer: "ACCEPT",
                RequesterType: "Doctor",
                RequesterId: "n2"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });

    it('answer request should fail bc requester type is wrong', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'deleted'}]];
        const responseJSON2 = [[{'some': 'added'}]];
        sqlMock.onFirstCall().returns(responseJSON1).onSecondCall().returns(responseJSON2);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post('/api/patient/answerRequest')
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Answer: "ACCEPT",
                RequesterType: "requester",
                RequesterId: "2"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });

    it('answer request should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'deleted'}]];
        const responseJSON2 = [[{'some': 'added'}]];
        sqlMock.onFirstCall().throws(new Error()).onSecondCall().returns(responseJSON2);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post('/api/patient/answerRequest')
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Answer: "ACCEPT",
                RequesterType: "Doctor",
                RequesterId: "2"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });

});

describe('PatientController get patient request from doctors',() => {
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

    it('get patient request from doctors should accept the request', (done) => {
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
            .get('/api/patient/request/doctor')
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Answer: "ACCEPT",
                RequesterType: "Cuidador",
                RequesterId: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get patient request from doctors should fail bc fail query', (done) => {
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
            .get('/api/patient/request/doctor')
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Answer: "ACCEPT",
                RequesterType: "Cuidador",
                RequesterId: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController get patient request from carers',() => {
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

    it('get patient request from carers should accept the request', (done) => {
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
            .get('/api/patient/request/carer')
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Answer: "ACCEPT",
                RequesterType: "Cuidador",
                RequesterId: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get patient request from carers should fail bc fail query', (done) => {
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
            .get('/api/patient/request/carer')
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

describe('PatientController add emotional form to patient',() => {
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

    it('add emotional form to patient should have been success', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/emotionalFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                q1: "",
                q2: "",
                date: new Date()
            })
            .end((err, response) => {
                //console.log(response);
                
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('add emotional form to patient should fail bc fail query', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/emotionalFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                q1: "",
                q2: "",
                date: new Date()
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController get emotional form to patient',() => {
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

    it('get emotional form to patient should have been success', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/emotionalFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                //console.log(response);
                
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get emotional form to patient should have been success with start and end date', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/emotionalFormPatient`)
            .query({
                start: "date start",
                end: "date end"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                //console.log(response);
                
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get emotional form to patient should fail bc fail query', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/emotionalFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController add no motor symptoms report to patient',() => {
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

    it('add no motor symptoms report to patient should have been success', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/noMotorSymptomsFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                q1: "", q2: "", q3: "", q4: "", q5: "", q6: "", q7: "", q8: "", q9: "", q10: "",
                q11: "", q12: "", q13: "", q14: "", q15: "", q16: "", q17: "", q18: "", q19: "", q20: "",
                q21: "", q22: "", q23: "", q24: "", q25: "", q26: "", q27: "", q28: "", q29: "", q30: "",
                date: new Date()
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('add no motor symptoms report to patient should fail bc fail query', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/noMotorSymptomsFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                q1: "", q2: "", q3: "", q4: "", q5: "", q6: "", q7: "", q8: "", q9: "", q10: "",
                q11: "", q12: "", q13: "", q14: "", q15: "", q16: "", q17: "", q18: "", q19: "", q20: "",
                q21: "", q22: "", q23: "", q24: "", q25: "", q26: "", q27: "", q28: "", q29: "", q30: "",
                date: new Date()
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController get no motor symptoms form from patient',() => {
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

    it('get no motor symptoms form from patient should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'report'}]];
        sqlMock.onFirstCall().returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/noMotorSymptomsFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get no motor symptoms form from patient should have been success with start and end date', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'report'}]];
        sqlMock.onFirstCall().returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/noMotorSymptomsFormPatient`)
            .query({
                start: "date start",
                end: "date end"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                //console.log(response);
                
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get no motor symptoms form from patient should fail bc fail query', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'report'}]];
        sqlMock.onFirstCall().throws(new Error());
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/noMotorSymptomsFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController add medicine alarm to patient',() => {
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

    it('add medicine alarm should have been success', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/medicineAlarm`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                title: "",
                alarmDateTime: "",
                alarmTime: "",
                isPending: "true"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('add medicine alarm should have been success is pending false', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/medicineAlarm`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                title: "",
                alarmDateTime: "",
                alarmTime: "",
                isPending: false
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('add medicine alarm should fail bc query fail', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/medicineAlarm`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                title: "",
                alarmDateTime: "",
                alarmTime: "",
                isPending: false
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController get medicine alarm from patient',() => {
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

    it('get medicine alarm should have been success', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/medicineAlarm`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get medicine alarm should fail bc query fail', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/medicineAlarm`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController delete medicine alarm to patient',() => {
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

    it('delete medicine alarm should have been success', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/medicineAlarm/delete/4`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                title: "",
                alarmDateTime: "",
                alarmTime: "",
                isPending: "true"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('delete medicine alarm should fail bc query fail', (done) => {
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
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/medicineAlarm/delete/4`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                title: "",
                alarmDateTime: "",
                alarmTime: "",
                isPending: "true"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController get symptoms report from patient',() => {
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

    it('get symptoms report should have been success monthly', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{Q1: 'on'},{Q1: 'on bueno'},{Q1: 'off malo'},{Q1: 'off'}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/symptoms/report`)
            .query({
                start:"2021-04-16T23:59:59.000Z",
                end: "2021-08-21T23:59:59.000Z",
                montly: 'true'
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get symptoms report should have been success no monthly', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{Q1: 'on'},{Q1: 'on bueno'},{Q1: 'off malo'},{Q1: 'off'}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/symptoms/report`)
            .query({
                start:"2021-04-16T23:59:59.000Z",
                end: "2021-07-16T23:59:59.000Z",
                montly: "false"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get symptoms report should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{Q1: 'on'},{Q1: 'on bueno'},{Q1: 'off malo'},{Q1: 'off'}]];
        sqlMock.throws(new Error());
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/symptoms/report`)
            .query({
                start:"2021-04-16T23:59:59.000Z",
                end: "2021-05-16T23:59:59.000Z",
                montly: "false"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController add game score to patient',() => {
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

    it('add game score should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/newGameScore`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                gameDate: "",
                score: 5
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('add game score should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.throws(new Error());
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/newGameScore`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                gameDate: "",
                score: 5
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController add step record to patient',() => {
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

    it('add step record should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/newStepRecord`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                stepDate: "",
                quantitySteps: 5
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('add step record should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'some': 'requests'}]];
        sqlMock.throws(new Error());
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/patient/${id}/newStepRecord`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send({
                stepDate: "",
                quantitySteps: 5
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});


describe('PatientController get game report from patient',() => {
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

    it('get game report should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{score: 10},{score: 13}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/game/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-05T00:00:00.000Z",
                montly: "true"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get game report should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{score: 10},{score: 13}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/game/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-05T00:00:00.000Z",
                montly: "false"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get game report should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[1,2]];
        sqlMock.throws(new Error());
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/game/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-16T00:00:00.000Z",
                montly: "true"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});


describe('PatientController get emotional symptoms report from patient',() => {
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

    it('get emotional symptoms report should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{Q1:-1, Q2:-1}, {Q1: 1, Q2:3}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/emotionalsymptoms/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-05T00:00:00.000Z",
                montly: "true"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get emotional symptoms report should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{Q1:-1, Q2:-1}, {Q1: 1, Q2:3}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/emotionalsymptoms/report`)
            .query({
                start:"2021-04-16T00:00:00.000Z",
                end: "2021-08-21T00:00:00.000Z",
                montly: "false"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get emotional symptoms report should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[1,2]];
        sqlMock.throws(new Error());
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/emotionalsymptoms/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-16T00:00:00.000Z",
                montly: "true"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController get discrepancy report from patient',() => {
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

    it('get discrepancy report should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[1,2]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/discrepancy/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-05T00:00:00.000Z",
                montly: "true"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get discrepancy report should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[1,2]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/discrepancy/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-05T00:00:00.000Z",
                montly: "false"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get discrepancy report should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[1,2]];
        sqlMock.throws(new Error());
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/discrepancy/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-05T00:00:00.000Z",
                montly: "true"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController get dyskinecia report from patient',() => {
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

    it('get dyskinecia report should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[1,2]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/dyskinecia/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-05T00:00:00.000Z",
                montly: "true"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get dyskinecia report should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[1,2]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/dyskinecia/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-05T00:00:00.000Z",
                montly: "false"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get dyskinecia report should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[1,2]];
        sqlMock.throws(new Error());
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/dyskinecia/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-16T00:00:00.000Z",
                montly: "true"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('PatientController no motor symptoms report from patient',() => {
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

    it('get no motor report should have been success 1', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[
            {Q1:2, Q2: 2, Q3: 2, Q4: 2, Q5: 2, Q6: 2, Q7: 2, Q8: 2, Q9: 2, Q10: 2,
                Q11:2, Q12: 2, Q13: 2, Q14: 2, Q15: 2, Q16: 2, Q17: 2, Q18: 2, Q19: 2,
                Q20: 2,Q21: 2,Q22: 2,Q23: 2,Q24: 2,Q25: 2, Q26: 2,Q27: 2,Q28: 21,Q29: 21,Q30: 21},
            {Q1:1}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/noMotorSymptoms/report`)
            .query({
                start:"2021-04-16T00:00:00.000Z",
                end: "2021-08-16T00:00:00.000Z",
                montly: "true"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get no motor report should have been success 2', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[
            {Q1:2, Q2: 2, Q3: 2, Q4: 2, Q5: 2, Q6: 2, Q7: 2, Q8: 2, Q9: 2, Q10: 2,
                Q11:2, Q12: 2, Q13: 2, Q14: 2, Q15: 2, Q16: 2, Q17: 2, Q18: 2, Q19: 2,
                Q20: 2,Q21: 2,Q22: 2,Q23: 2,Q24: 2,Q25: 2, Q26: 2,Q27: 2,Q28: 2,Q29: 2,Q30: 2},
            {Q1:1}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/noMotorSymptoms/report`)
            .query({
                start:"2021-04-16T00:00:00.000Z",
                end: "2021-05-16T00:00:00.000Z",
                montly: "false"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get no motor report should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[1,2]];
        sqlMock.throws(new Error());
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/noMotorSymptoms/report`)
            .query({
                start: "2021-04-16T00:00:00.000Z",
                end: "2021-07-16T00:00:00.000Z",
                montly: "true"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});


describe('PatientController get alarms for the day from patient',() => {
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

    it('get alarms should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{Name:'levodopa', AlarmTime:'12:03', PeriodicityQuantity:3, PeriodicityType:'Hora(s)'},
        {Name:'otra', AlarmTime:'12:03', PeriodicityQuantity:3, PeriodicityType:'Hora(s)'},
        {Name:'Levodopa', AlarmTime:'12:03', PeriodicityQuantity:3, PeriodicityType:'Dia(s)'}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/alarms/today`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get alarms should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{Name:'levodopa', AlarmTime:'12:03', PeriodicityQuantity:3, PeriodicityType:'Hora(s)'}]];
        sqlMock.throws(new Error());
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/alarms/today`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});


describe('PatientController get report daily from patient',() => {
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

    it('get report daily should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{Q1:'on', formdate:'2021-04-16T01:00:00.000Z'},
        {Q1:'on bueno', formdate:'2021-04-16T04:00:00.000Z'},
        {Q1:'off malo', formdate:'2021-04-16T02:00:00.000Z'},
        {Q1:'off', formdate:'2021-04-16T03:00:00.000Z'}]];
        sqlMock.returns(responseJSON1);
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/report/daily`)
            .query({
                start:"2021-04-16T00:00:00.000Z",
                end:"2021-04-16T23:59:00.000Z"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get report daily should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{Q1:'on', formdate:'2021-04-16T01:00:00.000Z'},
        {Q1:'on bueno', formdate:'2021-04-16T04:00:00.000Z'},
        {Q1:'off malo', formdate:'2021-04-16T02:00:00.000Z'},
        {Q1:'off', formdate:'2021-04-16T03:00:00.000Z'}]];
        sqlMock.throws(new Error());
        const berarer = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/patient/${id}/report/daily`)
            .query({
                start:"2021-04-16T00:00:00.000Z",
                end:"2021-04-16T23:59:00.000Z"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});
