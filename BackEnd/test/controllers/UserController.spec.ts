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

describe('UserController post registro',() => {
    let sqlMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('registro should save the new user patient', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        sqlMock.returns(saveUserResponse);
        chai.request(app)
            .post('/api/registro')
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                email: "veraele2@javeriana.edu.co",
                password: "hola1234",
                type: "Paciente",
                name: "nombre"
            })
            .end((err, response) => {

                console.log(response.text);
                expect(response.text).to.equals("Guardado");
                expect(response.status).to.equals(200);
                done();
            });
    });

    it('registro should save the new user carer', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        sqlMock.returns(saveUserResponse);
        chai.request(app)
            .post('/api/registro')
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                email: "veraele2@javeriana.edu.co",
                password: "hola1234",
                type: "Cuidador",
                name: "nombre"
            })
            .end((err, response) => {

                console.log(response.text);
                expect(response.text).to.equals("Guardado");
                expect(response.status).to.equals(200);
                done();
            });
    });

    it('registro should save the new user doctor', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        sqlMock.returns(saveUserResponse);
        chai.request(app)
            .post('/api/registro')
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                email: "veraele2@javeriana.edu.co",
                password: "hola1234",
                type: "Doctor"
            })
            .end((err, response) => {

                console.log(response.text);
                expect(response.text).to.equals("Guardado");
                expect(response.status).to.equals(200);
                done();
            });
    });

    it('registro should fail to save the new user, null executeSQL', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        sqlMock.returns(null);
        chai.request(app)
            .post('/api/registro')
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                email: "veraele2@javeriana.edu.co",
                password: "hola1234",
                type: "Paciente"
            })
            .end((err, response) => {

                console.log(response.text);
                expect(response.text).to.equals("Error");
                expect(response.status).to.equals(500);
                done();
            });
    });

    it('registro should fail to save the new user, null executeSQL', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        sqlMock.returns(
            Promise.reject()
        );
        chai.request(app)
            .post('/api/registro')
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                email: "veraele2@javeriana.edu.co",
                password: "hola1234",
                type: "Paciente"
            })
            .end((err, response) => {

                console.log(response.body);
                expect(response.body.status).to.equals(500);
                expect(response.body.error).to.equals("An error has ocurred");
                expect(response.status).to.equals(500);
                done();
            });
    });

    it('registro should fail to save the new user, user duplicate', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/savePersonResponseDuplicate.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        sqlMock.throws(new Error(response));
        chai.request(app)
            .post('/api/registro')
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                email: "veraele2@javeriana.edu.co",
                password: "hola1234",
                type: "Paciente"
            })
            .end((err, response) => {
                console.log(response.text);
                expect(response.text).to.equals("Existe");
                expect(response.status).to.equals(400);
                done();
            });
    });

});

describe('UserController get users',() => {
    let sqlMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('get people should return all users', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getUsersResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        //sqlMock.throws(new Error(response));
        sqlMock.returns(response);
        chai.request(app)
            .get('/api/users')
            .set({
                'Content-Type': 'application/json'
            })
            .send()
            .end((err, response) => {
                console.log(response.body);
                //expect(response.text).to.equals("Existe");
                expect(response.status).to.equals(200);
                done();
            });
    });

    it('get people should return error bc response is null', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        //sqlMock.throws(new Error(response));
        sqlMock.returns([null,null]);
        chai.request(app)
            .get('/api/users')
            .set({
                'Content-Type': 'application/json'
            })
            .send()
            .end((err, response) => {
                console.log(response.text);
                expect(response.text).to.equals("Error");
                expect(response.status).to.equals(500);
                done();
            });
    });

    it('get people should return error bc fail execute sql', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        //sqlMock.throws(new Error(response));
        sqlMock.throws(new Error());
        chai.request(app)
            .get('/api/users')
            .set({
                'Content-Type': 'application/json'
            })
            .send()
            .end((err, response) => {
                console.log(response.body);
                expect(response.body.error).to.equals("An error has ocurred");
                expect(response.status).to.equals(500);
                done();
            });
    });

});


describe('UserController post login',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        // jwtMock = sinon.stub(jwt, 'sign');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('login should return credentials', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        //sqlMock.throws(new Error(response));
        sqlMock.returns(response);
        bcryptMock.returns(Promise.resolve(true));
        //const token = "token";
        // jwtMock.callsFake((err: any, tk: any) => {
        //     tk=token;
        //     return tk;
        // });
        chai.request(app)
            .post('/api/login')
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                email: "veraele1@javeriana.edu.co",
                password: "hola1234"
            })
            .end((err, response) => {
                console.log(response.body);
                //expect(response.text).to.equals("Existe");
                expect(response.status).to.equals(200);
                done();
            });
    });


    it('login should return error password incorrect', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        //sqlMock.throws(new Error(response));
        sqlMock.returns(response);
        bcryptMock.returns(Promise.resolve(false));
        // jwtMock.returns(Promise.resolve(true));
        chai.request(app)
            .post('/api/login')
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                email: "veraele1@javeriana.edu.co",
                password: "hola1234"
            })
            .end((err, response) => {
                console.log(response.body);
                expect(response.body.person).to.equals("Invalid Password");
                expect(response.status).to.equals(constants.HTTP_STATUS_NOT_FOUND);
                done();
            });
    });

    it('login should return error invalid email', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        //sqlMock.throws(new Error(response));
        sqlMock.returns([[]]);
        bcryptMock.returns(Promise.resolve(false));
        // jwtMock.returns(Promise.resolve(true));
        chai.request(app)
            .post('/api/login')
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                email: "veraele1@javeriana.edu.co",
                password: "hola1234"
            })
            .end((err, response) => {
                console.log(response.body);
                expect(response.body.message).to.equals("Invalid Email");
                expect(response.status).to.equals(constants.HTTP_STATUS_NOT_FOUND);
                done();
            });
    });


    it('login should return error bc fail access to db', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByIdFailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        //sqlMock.throws(new Error(response));
        sqlMock.throws(new Error());
        chai.request(app)
            .post('/api/login')
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                email: "veraele1@javeriana.edu.co",
                password: "hola1234"
            })
            .end((err, response) => {
                console.log(response.body);
                expect(response.body.error).to.equals('An error has ocurred');
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });

    // it('login should return error bc fail jwt', (done) => {
    //     const poolStub = {
    //         getConnection: sinon.stub().returnsThis(),
    //         query: sinon.stub().returnsThis(),
    //         release: sinon.stub(),
    //     };
    //     const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
    //     const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
    //     const response = fs.readFileSync(responseFile, 'utf8').toString();
    //     //sqlMock.throws(new Error(response));
    //     sqlMock.returns(response);
    //     bcryptMock.returns(Promise.resolve(true));
    //     // jwtMock.returns(Promise.reject(Error('Algorith is invalid')));
    //     chai.request(app)
    //         .post('/api/login')
    //         .set({
    //             'Content-Type': 'application/json'
    //         })
    //         .send({
    //             email: "veraele1@javeriana.edu.co",
    //             password: "hola1234"
    //         })
    //         .end((err, response) => {
    //             console.log(response.body);
    //             expect(response.body.error).to.equals('An error has ocurred');
    //             expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
    //             done();
    //         });
    // });
});


describe('UserController update user by id',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let personServiceMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
        //personServiceMock = sinon.stub(PersonService, 'getPersonById');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('update should return success update for patient', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().returns(responseById).onSecondCall().returns("success");
        //personServiceMock.returns(responseById);
        const id = 13;
        chai.request(app)
            .post(`/api/users/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                NAME: "nuevo nombre"
            })
            .end((err, response) => {
                expect(response.status).to.equals(200);
                done();
            });
    });

    it('update should return success update for doctor', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Doctor'}]];
        sqlMock.onFirstCall().returns(responseById).onSecondCall().returns("success");
        //personServiceMock.returns(responseById);
        const id = 13;
        chai.request(app)
            .post(`/api/users/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                NAME: "nuevo nombre"
            })
            .end((err, response) => {
                expect(response.status).to.equals(200);
                done();
            });
    });

    it('update should return success update for carer', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Cuidador'}]];
        sqlMock.onFirstCall().returns(responseById).onSecondCall().returns("success");
        //personServiceMock.returns(responseById);
        const id = 13;
        chai.request(app)
            .post(`/api/users/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                NAME: "nuevo nombre"
            })
            .end((err, response) => {
                expect(response.status).to.equals(200);
                done();
            });
    });

    it('update should return error updating user bc first query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().throws(new Error());
        //personServiceMock.returns(responseById);
        const id = 13;
        chai.request(app)
            .post(`/api/users/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                NAME: "nuevo nombre"
            })
            .end((err, response) => {
                expect(response.status).to.equals(500);
                done();
            });
    });

    it('update should return error updating user bc second query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().returns(responseById).onSecondCall().returns(null);
        const id = 13;
        chai.request(app)
            .post(`/api/users/${id}`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                NAME: "nuevo nombre"
            })
            .end((err, response) => {
                expect(response.status).to.equals(500);
                done();
            });
    });
});

describe('UserController add symptoms form patient by id',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let personServiceMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
        //personServiceMock = sinon.stub(PersonService, 'getPersonById');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('add symptoms form should return success addition for patient', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().returns("success");
        const id = 13;
        chai.request(app)
            .post(`/api/users/${id}/symptomsFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(200);
                done();
            });
    });


    it('add symptoms form should fail addition for patient bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().throws(new Error());
        const id = 13;
        chai.request(app)
            .post(`/api/users/${id}/symptomsFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(500);
                done();
            });
    });
});

describe('UserController update symptoms form patient by id',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let personServiceMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('update symptoms form should return success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().returns("success");
        const id = 13;
        chai.request(app)
            .put(`/api/users/${id}/symptomsFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(200);
                done();
            });
    });

    it('update symptoms form should fail addition for patient bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().throws(new Error());
        const id = 13;
        chai.request(app)
            .put(`/api/users/${id}/symptomsFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(500);
                done();
            });
    });
});

describe('UserController delete symptoms form patient by id',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let personServiceMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('delete symptoms form should return success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().returns("success");
        const id = 13;
        chai.request(app)
            .delete(`/api/users/${id}/symptomsFormPatient`)
            .query({
                Date: "date test"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(200);
                done();
            });
    });

    it('delete symptoms form should fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().throws(new Error());
        const id = 13;
        chai.request(app)
            .delete(`/api/users/${id}/symptomsFormPatient`)
            .query({
                Date: "date test"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(500);
                done();
            });
    });

    it('delete symptoms form should fail bc query return null', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().returns(null);
        const id = 13;
        chai.request(app)
            .delete(`/api/users/${id}/symptomsFormPatient`)
            .query({
                Date: "date test"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(500);
                done();
            });
    });

    it('delete symptoms form should fail bc data incomplete', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().returns("success");
        const id = 13;
        chai.request(app)
            .delete(`/api/users/${id}/symptomsFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer bearer'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_BAD_REQUEST);
                done();
            });
    });

    it('delete symptoms form should fail bc not authorized', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().returns("success");
        const id = 13;
        chai.request(app)
            .delete(`/api/users/${id}/symptomsFormPatient`)
            .query({
                Date: "date test"
            })
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_UNAUTHORIZED);
                done();
            });
    });
});

describe('UserController relation request',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let personServiceMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('get relations request should return success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().returns("success");
        chai.request(app)
            .get(`/api/patient/relationRequest`)
            .query({
                Date: "date test"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer as.eyJpZCI6MX0=.as'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(200);
                done();
            });
    });

    it('get relations request should return success but query return null', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().returns(null);
        chai.request(app)
            .get(`/api/patient/relationRequest`)
            .query({
                Date: "date test"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer as.eyJpZCI6MX0=.as'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get relations request should return fail bc query return error', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseById = [[{'TYPE': 'Paciente'}]];
        sqlMock.onFirstCall().throws(new Error());
        chai.request(app)
            .get(`/api/patient/relationRequest`)
            .query({
                Date: "date test"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer as.eyJpZCI6MX0=.as'
            })
            .send({
                q1: "lorem",
                q2: "lorem",
                formdate: new Date(),
                discrepancy: 2
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});


describe('UserController get symptoms form patient request',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let personServiceMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('get relations request should return success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'Symtoms': 'sintomas'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const id = 13;
        chai.request(app)
            .get(`/api/patients/${id}/symptomsFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer as.eyJpZCI6MX0=.as'
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(200);
                done();
            });
    });

    it('get relations request should return fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'Symtoms': 'sintomas'}]];
        sqlMock.onFirstCall().throws(new Error());
        const id = 13;
        chai.request(app)
            .get(`/api/patients/${id}/symptomsFormPatient`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': 'Bearer as.eyJpZCI6MX0=.as'
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});

describe('UserController get profile request',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let personServiceMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('get profile request should return success for patient', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/users/me`)
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

    it('get profile request should return success for doctor', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerDoctor = 'as.eyJ0eXBlIjoiRG9jdG9yIiwiaWQiOjF9.as';
        const id = 13;
        
        chai.request(app)
            .get(`/api/users/me`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerDoctor}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get profile request should return success for carer', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerCarer = 'as.eyJ0eXBlIjoiQ3VpZGFkb3IiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/users/me`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerCarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('get profile request should return fail bc wrong type', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerWrong = 'as.eyJ0eXBlIjoiV3JvbmciLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/users/me`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerWrong}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_BAD_REQUEST);
                done();
            });
    });

    it('get profile request should return fail bc fail query', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().throws(new Error());
        const berarerCarer = 'as.eyJ0eXBlIjoiQ3VpZGFkb3IiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/users/me`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerCarer}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });
});


describe('UserController get user by id request',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let personServiceMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('get user by id request should return success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/users/${id}`)
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

    it('get user by id request should return fail bc query empty', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [null];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/users/${id}`)
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

    it('get user by id request should return fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [null];
        sqlMock.onFirstCall().throws(new Error());
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/users/${id}`)
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


describe('UserController download request',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let personServiceMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('download from path should return success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/download`)
            .query({
                path: "/uploads/test.txt"
            })
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send()
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_NOT_FOUND);
                done();
            });
    });

    it('download from path should return fail bc not path provided', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/download`)
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

    // it('download from path should return fail bc failed get id from token', (done) => {
    //     const poolStub = {
    //         getConnection: sinon.stub().returnsThis(),
    //         query: sinon.stub().returnsThis(),
    //         release: sinon.stub(),
    //     };
    //     const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
    //     const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
    //     const response = fs.readFileSync(responseFile, 'utf8').toString();
    //     bcryptMock.returns(Promise.resolve(true));
    //     jwtMock.returns({success: 'Token is valid'});
    //     const responseJSON = [[{'person': 'person test'}]];
    //     sqlMock.onFirstCall().returns(responseJSON);
    //     const berarerPatient = 'as.eyJ0eXBlIjoiV3JvbmciLCJpZCI6ImRzYSJ9.as';
    //     const id = 13;
    //     chai.request(app)
    //         .get(`/api/download`)
    //         .set({
    //             'Content-Type': 'application/json',
    //             'Authorization': `Bearer ${berarerPatient}`
    //         })
    //         .send()
    //         .end((err, response) => {
    //             expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
    //             done();
    //         });
    // });
});

describe('UserController get toolbox items request',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let personServiceMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('get toolbox items should return success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'item': 'item test'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/users/toolbox/items`)
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

    it('get toolbox items should return succesc with response null', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'item': 'item test'}]];
        sqlMock.onFirstCall().returns(null);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/users/toolbox/items`)
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

    it('get toolbox items should return fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        const responseJSON = [[{'item': 'item test'}]];
        sqlMock.onFirstCall().throws(new Error());
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .get(`/api/users/toolbox/items`)
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


describe('UserController forgot password request',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let nodeMailerMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
        nodeMailerMock = sinon.stub(EmailUtilities, 'sendEmailFinal');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('forgot password should return success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const transport = {
                sendMail: (data:any, callback:any) => {
                    Promise.resolve(true)
                }
            } as Mail;
        sinon.stub(nodemailer, 'createTransport').returns(transport);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        nodeMailerMock.returns(Promise.resolve(true));
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/user/forgotPassword`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Email: "emailtest"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('forgot password should return fail sending email', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const transport = {
                sendMail: (data:any, callback:any) => {
                    Promise.resolve(true)
                }
            } as Mail;
        sinon.stub(nodemailer, 'createTransport').returns(transport);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        nodeMailerMock.returns(Promise.reject());
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/user/forgotPassword`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Email: "emailtest"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });

    it('forgot password should return not found', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const transport = {
                sendMail: (data:any, callback:any) => {
                    Promise.resolve(true)
                }
            } as Mail;
        sinon.stub(nodemailer, 'createTransport').returns(transport);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        nodeMailerMock.returns(Promise.resolve(true));
        const responseJSON = [[]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/user/forgotPassword`)
            .set({
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${berarerPatient}`
            })
            .send({
                Email: "emailtest"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_NOT_FOUND);
                done();
            });
    });
});


describe('UserController reset password request',() => {
    let sqlMock: any = null;
    let bcryptMock: any = null;
    let jwtMock: any = null;
    let otpMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
        otpMock = sinon.stub(OTPUtilities, 'verifyOtp');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('reset password should return success', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        otpMock.returns(Promise.resolve(true));
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/user/resetPassword`)
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                Email: "emailtest",
                Password: "newPass",
                OTP: "otp"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_OK);
                done();
            });
    });

    it('reset password should return fail bc query fail', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        otpMock.returns(Promise.resolve(true));
        const responseJSON = [[{'person': 'person test'}]];
        sqlMock.onFirstCall().throws(new Error());
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/user/resetPassword`)
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                Email: "emailtest",
                Password: "newPass",
                OTP: "otp"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });

    it('reset password should return fail bc query return field null', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        otpMock.returns(Promise.resolve(true));
        const responseJSON = [null];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/user/resetPassword`)
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                Email: "emailtest",
                Password: "newPass",
                OTP: "otp"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_INTERNAL_SERVER_ERROR);
                done();
            });
    });

    it('reset password should return fail bc otp unauthorized', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        const responseFile = path.join(__dirname, '../resources/getPersonByEmailResponse.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        bcryptMock.returns(Promise.resolve(true));
        jwtMock.returns({success: 'Token is valid'});
        otpMock.returns(Promise.resolve(false));
        const responseJSON = [null];
        sqlMock.onFirstCall().returns(responseJSON);
        const berarerPatient = 'as.eyJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6MX0=.as';
        const id = 13;
        chai.request(app)
            .post(`/api/user/resetPassword`)
            .set({
                'Content-Type': 'application/json'
            })
            .send({
                Email: "emailtest",
                Password: "newPass",
                OTP: "otp"
            })
            .end((err, response) => {
                expect(response.status).to.equals(constants.HTTP_STATUS_UNAUTHORIZED);
                done();
            });
    });
});
