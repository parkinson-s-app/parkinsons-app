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

describe('AdminController delete toolbox item',() => {
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

    it('delete toolbox item should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'delete': 'deleted'}]];
        sqlMock.onFirstCall().returns(responseJSON1);
        const berarerPatient = 'as.eyJ0eXBlIjoiQWRtaW4iLCJpZCI6NH0=.as';
        const id = 13;
        chai.request(app)
            .delete(`/api/admin/toolbox/item/${id}`)
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

    it('delete toolbox item should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'delete': 'deleted'}]];
        sqlMock.onFirstCall().throws(new Error());
        const berarerPatient = 'as.eyJ0eXBlIjoiQWRtaW4iLCJpZCI6NH0=.as';
        const id = 13;
        chai.request(app)
            .delete(`/api/admin/toolbox/item/${id}`)
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

    it('delete toolbox item should fail bc query return null', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[null]];
        sqlMock.onFirstCall().returns(null);
        const berarerPatient = 'as.eyJ0eXBlIjoiQWRtaW4iLCJpZCI6NH0=.as';
        const id = 13;
        chai.request(app)
            .delete(`/api/admin/toolbox/item/${id}`)
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

    it('delete toolbox item should fail bc user is not admin', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{resp: 'deleted'}]];
        sqlMock.onFirstCall().returns(responseJSON1);
        const berarerPatient = 'as.eyJ0eXBlIjoiQ3VpZGFkb3IiLCJpZCI6NH0=.as';
        const id = 13;
        chai.request(app)
            .delete(`/api/admin/toolbox/item/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_UNAUTHORIZED);
                done();
            });
    });
});


describe('AdminController delete user',() => {
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

    it('delete user should have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'delete': 'deleted'}]];
        sqlMock.onFirstCall().returns(responseJSON1);
        const berarerPatient = 'as.eyJ0eXBlIjoiQWRtaW4iLCJpZCI6NH0=.as';
        const id = 13;
        chai.request(app)
            .delete(`/api/admin/user/${id}`)
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


    it('delete user should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'delete': 'deleted'}]];
        sqlMock.onFirstCall().throws(new Error());
        const berarerPatient = 'as.eyJ0eXBlIjoiQWRtaW4iLCJpZCI6NH0=.as';
        const id = 13;
        chai.request(app)
            .delete(`/api/admin/user/${id}`)
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

    it('delete user should fail bc query return null', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[null]];
        sqlMock.onFirstCall().returns(null);
        const berarerPatient = 'as.eyJ0eXBlIjoiQWRtaW4iLCJpZCI6NH0=.as';
        const id = 13;
        chai.request(app)
            .delete(`/api/admin/user/${id}`)
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

    it('delete user should fail bc user is not admin', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{resp: 'deleted'}]];
        sqlMock.onFirstCall().returns(responseJSON1);
        const berarerPatient = 'as.eyJ0eXBlIjoiQ3VpZGFkb3IiLCJpZCI6NH0=.as';
        const id = 13;
        chai.request(app)
            .delete(`/api/admin/user/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_UNAUTHORIZED);
                done();
            });
    });
});

describe('AdminController add toolbox item',() => {
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

    it('add toolbox item have been success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'add': 'added'}]];
        sqlMock.onFirstCall().returns(responseJSON1);
        const berarerPatient = 'as.eyJ0eXBlIjoiQWRtaW4iLCJpZCI6NH0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/admin/toolbox/item`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Title: "",
                Description: "",
                URL:"",
                Type:""
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });


    it('add toolbox item should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON1 = [[{'add': 'added'}]];
        sqlMock.onFirstCall().throws(new Error());
        const berarerPatient = 'as.eyJ0eXBlIjoiQWRtaW4iLCJpZCI6NH0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/admin/toolbox/item`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Title: "",
                Description: "",
                URL:"",
                Type:""
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});
