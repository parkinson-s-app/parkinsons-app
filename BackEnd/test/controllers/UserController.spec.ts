import chai from 'chai';
import chaiHttp from 'chai-http';
import sinon from 'sinon';
import app from '../../src/app';
import * as database from '../../src/database';
const mysql = require('mysql2/promise');
import path from 'path';
import fs from 'fs';

chai.use(chaiHttp);
chai.should();
const expect = chai.expect;
// resources
const saveUserResponse  = require('../resources/savePersonResponse.json');

describe('UserController',() => {
    let sqlMock: any = null;
    beforeEach(() => {
        sqlMock = sinon.stub(database, 'executeSQL');
    });
    afterEach(() => {
        sinon.restore();
    });
    it('registro should save the new user', (done) => {
        const poolStub = {
            getConnection: sinon.stub().returnsThis(),
            query: sinon.stub().returnsThis(),
            release: sinon.stub(),
        };
        const createPoolStub = sinon.stub(mysql, 'createPool').returns(poolStub);
        sqlMock.returns((): Promise<any> => {
            return Promise.resolve(saveUserResponse);
        });
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
        // savePersonResponseDuplicate.json
        const responseFile = path.join(__dirname, '../resources/savePersonResponseDuplicate.json');
        const response = fs.readFileSync(responseFile, 'utf8').toString();
        sqlMock.returns(response);
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
                // expect(response.body.status).to.equals(500);
                // expect(response.body.error).to.equals("An error has ocurred");
                expect(response.status).to.equals(400);
                done();
            });
    });

});