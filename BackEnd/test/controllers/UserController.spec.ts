import chai from 'chai';
import chaiHttp from 'chai-http';
import sinon from 'sinon';
import app from '../../src/app';
import * as database from '../../src/database';
const mysql = require('mysql2/promise');
import path from 'path';
import fs from 'fs';
import { constants } from 'http2';
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

chai.use(chaiHttp);
chai.should();
const expect = chai.expect;
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
        const token = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InZlcmFlbGUxQGphdmVyaWFuYS5lZHUuY28iLCJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6NDgsImlhdCI6MTYxOTM5Mjk4OH0.DeG53aT5UYT7vsHQBY49Ibx0Nv14XnBYrmDOpn2qPkXVbdsjZhk8T9cwOIVSuLLtAYjrpbS7xm7sbEw9tx_QxQ";
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
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
        bcryptMock = sinon.stub(bcrypt, 'compare');
        jwtMock = sinon.stub(jwt, 'verify');
    });
    afterEach(() => {
        sinon.restore();
    });

    it('update should return success update', (done) => {
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
        const token = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InZlcmFlbGUxQGphdmVyaWFuYS5lZHUuY28iLCJ0eXBlIjoiUGFjaWVudGUiLCJpZCI6NDgsImlhdCI6MTYxOTM5Mjk4OH0.DeG53aT5UYT7vsHQBY49Ibx0Nv14XnBYrmDOpn2qPkXVbdsjZhk8T9cwOIVSuLLtAYjrpbS7xm7sbEw9tx_QxQ";
        jwtMock.returns({success: 'Token is valid'});
        //     tk=token;
        //     return tk;
        // });
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
                console.log(response.body);
                //expect(response.text).to.equals("Existe");
                expect(response.status).to.equals(200);
                done();
            });
    });
});