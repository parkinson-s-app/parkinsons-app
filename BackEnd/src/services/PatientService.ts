import { connect, executeSQL } from '../database';
import debugLib from 'debug';
import IAnswerRequestDto from '../models/IAnswerRequestDto';
import { PersonType } from '../utilities/GenericTypes';
import CarerService from './CarerService';
import DoctorService from './DoctorService';
import IEmotionalFormDto from '../models/IEmotionalFormDto';
import { Pool } from 'mysql2/promise';
import IMedicineAlarm from '../models/IMedicineAlarm';
import IGameScore from '../models/IGameScore';
import IStepRecord from '../models/IStepRecord';
import INoMotorFormDto from '../models/INoMotorFormDto';

const debug = debugLib('AppKinson:PatientService');

export default class PatientService {

    public static async getDoctorRequests(id: number) {
        debug('Getting requests doctor of id patient: %s', id);
        try {
            const requests = await executeSQL('SELECT * FROM requestlinkdoctortopatient WHERE ID_PATIENT = ?',[id]);
            return requests[0];
        } catch (error) {
            debug('Get doctor request failed. Error: %j', error);
            throw error;
        }
    }

    public static async getCarerRequests(id: number) {
        debug('Getting requests carer of id patient: %s', id);
        try {
            const requests = await executeSQL('SELECT * FROM requestlinkcarertopatient WHERE ID_PATIENT = ?',[id]);
            return requests[0];
        } catch (error) {
            debug('get carer request failed. Error: %j', error);
            throw error;
        }
    }

    public static async answerRequest(idPatient: number, answer: IAnswerRequestDto) {
        debug('Answer request id patient: %s, info answer: %j ', idPatient, answer);
        try {
            if( answer.RequesterType === PersonType.CARER ) {
                const idCarer = Number(answer.RequesterId);

                if(!Number.isNaN(idCarer)) {
                    return await CarerService.relatePatientToCarer(idCarer, idPatient, answer.Answer);
                } else {
                    debug('Error parsing Id Carer. Id: %s', answer.RequesterId);
                    return null;
                }
            } else if(answer.RequesterType === PersonType.DOCTOR) {
                const idDoctor = Number(answer.RequesterId);
                if(!Number.isNaN(idDoctor)) {
                    return await DoctorService.relatePatientToDoctor(idDoctor, idPatient, answer.Answer);
                } else {
                    debug('Error parsing Id Doctor. Id: %s', answer.RequesterId);
                    return null;
                }
            } else {
                debug('Error requester type not valid. Type: %s', answer.RequesterType);
                return null;
            }
        } catch (error) {
            debug('answer request failed. Error: %j', error);
            throw error;
        }
    }

    /**
     * getPatientByEmail
     */
    public static async getIdPatientByEmail(email: string) {
        debug('getPatientByEmail email: %s', email);
        try {
            const person =  await executeSQL(
                `SELECT ID
                FROM patients
                LEFT JOIN users
                ON users.ID = patients.ID_USER
                WHERE users.EMAIL = ? `,[email]);
            debug('result search patient by email: %j', person[0]);
            return person[0];
        } catch (error) {
            debug('getPatientByEmail failed. Error: %j', error);
            throw error;
        }
    }
    /**
     * getPatientById
     */
    public static async getPatientById(id : number) {
        debug('getPatientById id: %s', id);
        try {
            const person =  await executeSQL(
                `SELECT EMAIL, NAME, PHOTOPATH
                FROM patients
                LEFT JOIN users
                ON users.ID = patients.ID_USER
                WHERE users.ID = ? `,[id]);
            debug('result search patient by id: %j', person[0]);
            return person[0];
        } catch (error) {
            debug('get patient by Id failed. Error: %j', error);
            throw error;
        }
    }
    /**
     *
     * @param id
     * @param emotionalFormData
     */
    public static async saveEmotionalForm(id: number, emotionalFormData: IEmotionalFormDto) {
        try {
            emotionalFormData.id_patient=id;
            debug('saveEmotionalForm to person: %j, id: %s', emotionalFormData, id);
            const res = await executeSQL('INSERT INTO emotionalformxpatient SET ?',[emotionalFormData]);
            debug('saveEmotionalForm saved');
            return res;
        }  catch (error) {
            debug('saveEmotionalForm Error: %j', error);
            throw error;
        }
    }

    public static async saveNoMotorForm(id: number, noMotorFormData: INoMotorFormDto) {
        try {
            noMotorFormData.id_patient=id;
            debug('saveEmotionalForm to person: %j, id: %s', noMotorFormData, id);
            const res = await executeSQL('INSERT INTO nomotorsymptomsformpatient SET ?',[noMotorFormData]);
            debug('saveEmotionalForm saved');
            return res;
        }  catch (error) {
            debug('saveEmotionalForm Error: %j', error);
            throw error;
        }
    }
    /**
     *
     * @param id
     */
    public static async getEmotionalFormsById(id: number, start: string, end: string) {
        try {
            const dateStart = new Date(start);
            const dateEnd = new Date(end);
            const query = 'SELECT * FROM emotionalformxpatient WHERE ID_PATIENT=? and ( date BETWEEN ? AND ?)';
            debug('getEmotionalForms to patient id: %s', id);
            const res = await executeSQL(query,[id, dateStart, dateEnd]);
            debug('getEmotionalForms saved');
            return res[0];
        }  catch (error) {
            debug('getEmotionalForms Error: %j', error);
            throw error;
        }
    }

    /**
     *
     * @param id
     */
    public static async getNoMotorFormsById(id: number, start: string, end: string) {
        try {
            const dateStart = new Date(start);
            const dateEnd = new Date(end);
            const query = 'SELECT * FROM nomotorsymptomsformpatient WHERE ID_PATIENT=? and ( date BETWEEN ? AND ?)';
            debug('getNoMotorForms to patient id: %s', id);
            const res = await executeSQL(query,[id, dateStart, dateEnd]);
            debug('getNoMotorForms saved');
            return res[0];
        }  catch (error) {
            debug('getNoMotorForms Error: %j', error);
            throw error;
        }
    }

    public static async getMedicineAlarmsById(id: number) {
        try {
            const query = `
            SELECT
                am.title as Title,
                m.NAME as Medicine,
                m.ID as IdMedicine,
                am.dose as Dose,
                am.periodicityQuantity as PeriodicityQuantity,
                am.periodicityType as PeriodicityType,
                am.alarmTime as AlarmTime,
                am.ID_PATIENT as IdPatient,
                am.quantity as Quantity
            FROM
                alarmandmedicinepatient am
                INNER JOIN
                medicine m
                ON m.ID = am.idMedicine
            WHERE ID_PATIENT= ?`;
            debug('getMedicineAlarmsById to patient id: %s', id);
            const res = await executeSQL(query,[id]);
            debug('getMedicineAlarmsById executed');
            return res[0];
        }  catch (error) {
            debug('getMedicineAlarmsById Error: %j', error);
            throw error;
        }
    }

    public static async saveMedicineAlarms(id: number, medicineAlarms: IMedicineAlarm) {
        try {
            debug('saveMedicineAlarms get into');
            medicineAlarms.ID_PATIENT = id;
            debug('saveMedicineAlarms medicine alarms to save: %j', medicineAlarms);
            const res = await executeSQL('INSERT INTO medicinealarmpatient SET ?',[medicineAlarms]);
            debug('saveMedicineAlarms saved');
            return res;
        }  catch (error) {
            debug('saveMedicineAlarms Error: %j', error);
            throw error;
        }
    }


    public static async deleteMedicineAlarms(id: string, idPatient: number) {
        try {
            debug('deleteMedicineAlarms get into');
            debug('deleteMedicineAlarms medicine alarm id: %s, id patient: %s', id, idPatient);
            const resDeletion = await executeSQL(
                'DELETE FROM alarmandmedicinepatient WHERE ID_PATIENT  = ? AND idMedicine = ?',
                [idPatient, id]);
            debug('deleteMedicineAlarms saved');
            return resDeletion;
        }  catch (error) {
            debug('deleteMedicineAlarms Error: %j', error);
            throw error;
        }
    }

    public static async  getReportSymptomsTwoDates(idPatient: number, initDate: string, endDate: string) {
        try {
            debug('getting report by two dates First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT
                Q1
            FROM
                symptomsformpatient
            WHERE ID_PATIENT= ?
            AND formdate BETWEEN ? AND ?`;
            debug('getReportSymptomsTwoDates to patient id: %s', idPatient);
            const res = await executeSQL(query,[idPatient, initDate, endDate]);
            debug('getReportSymptomsTwoDates executed');
            debug('query reslt response :%j', res[0]);
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query response as a list :%j', res[0]);
            let on = 0;
            let onG = 0;
            let off = 0;
            let offB = 0;
            const size = listJSON.length;
            debug('size :%s', size);
            for (let index = 0; index < size; index++) {

                if(listJSON[index].Q1 === 'on') {
                    on++;
                } else if (listJSON[index].Q1 === 'on bueno') {
                    onG++;
                } else if (listJSON[index].Q1 === 'off malo') {
                    offB++;
                } else if (listJSON[index].Q1 === 'off') {
                    off++;
                }
            }
            if (size !== 0) {
                on = Number(((100/size)*on).toFixed(1));
                off = Number(((100/size)*off).toFixed(1));
                offB = Number(((100/size)*offB).toFixed(1));
                onG = Number(((100/size)*onG).toFixed(1));
            }
            const finalResponse = {
                on,
                off,
                offB,
                onG,
                mes: 'null'
            };
            debug('response final :%j', finalResponse);
            return finalResponse;
        }  catch (error) {
            debug('getReportSymptomsTwoDates Error: %j', error);
            throw error;
        }
    }

    public static async saveGameScore(gameScore: IGameScore) {
        try {
            debug('saveGameScore get into');
            debug('saveGameScore to save: %j', gameScore);
            const res = await executeSQL('INSERT INTO touchgamexpatient SET ?',[gameScore]);
            debug('saveGameScore saved');
            return res;
        }  catch (error) {
            debug('saveGameScore Error: %j', error);
            throw error;
        }
    }

    public static async saveStepRecord(stepRecord: IStepRecord) {
        try {
            debug('saveStepRecord get into');
            debug('saveStepRecord to save: %j', stepRecord);
            const res = await executeSQL('INSERT INTO stepsxpatient SET ?',[stepRecord]);
            debug('saveStepRecord saved');
            return res;
        }  catch (error) {
            debug('saveGameScore Error: %j', error);
            throw error;
        }
    }

    public static async getReportGameTwoDates(idPatient: number, initDate: string, endDate: string) {
        try {
            debug('getting game report by two dates First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT
                score
            FROM
                touchgamexpatient
            WHERE ID_PATIENT= ?
            AND gameDate BETWEEN ? AND ?`;
            debug('getReportGameTwoDates to patient id: %s', idPatient);
            const res = await executeSQL(query,[idPatient, initDate, endDate]);
            debug('getReportGameTwoDates executed');
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query game response as a list with size:%j', listJSON.length);
            const on = 0;
            let acum = 0;
            let average = 0;
            let max = 0;
            let min = 9999;
            const size = listJSON.length;
            debug('size :%s', size);
            for (let index = 0; index < size; index++) {
                acum += listJSON[index].score;
                if(listJSON[index].score < min) {
                    min = listJSON[index].score;
                }
                if(listJSON[index].score > max) {
                    max = listJSON[index].score;
                }
            }
            if (size !== 0) {
                average = Number((acum/size).toFixed(1));
            }
            const finalResponse = {
                Mes: 'null',
                Promedio: average,
                Cantidad: size,
                Max: max,
                Min: min
            };
            debug('response final :%j', finalResponse);
            return finalResponse;
        }  catch (error) {
            debug('getReportGameTwoDates Error: %j', error);
            throw error;
        }
    }


    public static async getReportEmotionalSymptomsTwoDates(idPatient: number, initDate: string, endDate: string): Promise<any> {
        try {
            debug('getting emotional symptoms report by two dates First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT
                Q1,
                Q2
            FROM
                emotionalformxpatient
            WHERE ID_PATIENT= ?
            AND date BETWEEN ? AND ?`;
            debug('getReportEmotionalSymptomsTwoDates to patient id: %s', idPatient);
            const res = await executeSQL(query,[idPatient, initDate, endDate]);
            debug('getReportEmotionalSymptomsTwoDates executed');
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query emotional symptoms response as a list with size:%j', listJSON.length);
            const on = 0;
            let acum = 0;
            let average = 0;
            const size = listJSON.length;
            let elementsInvalid = 0;
            debug('size :%s', size);
            for (let index = 0; index < size; index++) {
                if(listJSON[index].Q1 !== -1 && listJSON[index].Q2 !== -1) {
                    acum += Number(((listJSON[index].Q1 + listJSON[index].Q2)).toFixed(1));
                } else {
                    elementsInvalid++;
                }
            }
            if (size !== 0) {
                average = Number((acum/(size-elementsInvalid)).toFixed(1));
            }
            const finalResponse = {
                Mes: 'null',
                Promedio:  average,
                Cantidad: (size-elementsInvalid)
            };
            debug('response emotional symptoms report final :%j', finalResponse);
            return finalResponse;
        }  catch (error) {
            debug('getReportGameTwoDates Error: %j', error);
            throw error;
        }
    }

    public static async getReportDiskineciaTwoDates(idPatient: number, initDate: string, endDate: string): Promise<any> {
        try {
            debug('getting dyskinecia report by two dates First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT
                Q2
            FROM
                symptomsformpatient
            WHERE ID_PATIENT= ?
            AND formdate BETWEEN ? AND ?`;
            debug('getReportDiskineciaTwoDates to patient id: %s', idPatient);
            const res = await executeSQL(query,[idPatient, initDate, endDate]);
            debug('getReportDiskineciaTwoDates executed');
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query dyskinecia response as a list with size:%j', listJSON.length);
            let acum = 0;
            let average = 0;
            const size = listJSON.length;
            for (let index = 0; index < size; index++) {
                if(listJSON[index].Q2 !==''){
                    acum += 1;
                }
            }
            if (size !== 0) {
                average = Number((acum/(size)).toFixed(1));
            }
            const finalResponse = {
                Mes: 'null',
                Promedio:  average,
                Cantidad: size
            };
            debug('response dyskinecia report final :%j', finalResponse);
            return finalResponse;
        }  catch (error) {
            debug('getReportDiskineciaTwoDates Error: %j', error);
            throw error;
        }
    }

    public static async getReportDiscrepancyTwoDates(idPatient: number, initDate: string, endDate: string): Promise<any> {
        try {
            debug('getting discrepancy report by two dates First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT
                discrepancy
            FROM
                symptomsformpatient
            WHERE ID_PATIENT= ?
            AND formdate BETWEEN ? AND ?`;
            debug('getReportDiscrepancyTwoDates to patient id: %s', idPatient);
            const res = await executeSQL(query,[idPatient, initDate, endDate]);
            debug('getReportDiscrepancyTwoDates executed ');
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query discrepancy response as a list with size:%j', listJSON.length);
            let acum = 0;
            let cant = 0;
            let average = 0;
            const size = listJSON.length;
            for (let index = 0; index < size; index++) {
                if(listJSON[index].discrepancy !== 0){
                    acum += listJSON[index].discrepancy;
                    cant += 1;
                }
            }
            if (size !== 0) {
                average = Number((acum/(cant)).toFixed(1));
            }
            const finalResponse = {
                Mes: 'null',
                Promedio: average,
                Cantidad: cant
            };
            debug('response discrepancy report final :%j', finalResponse);
            return finalResponse;
        }  catch (error) {
            debug('getReportDiscrepancyTwoDates Error: %j', error);
            throw error;
        }
    }

    public static async getReportNoMotorTwoDates(idPatient: number, initDate: string, endDate: string): Promise<any> {
        try {
            debug('getting no motor report by two dates First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT
                *
            FROM
                nomotorsymptomsformpatient
            WHERE ID_PATIENT= ?
            AND date BETWEEN ? AND ?`;
            debug('getReportNoMotorTwoDates to patient id: %s', idPatient);
            const res = await executeSQL(query,[idPatient, initDate, endDate]);
            debug('getReportNoMotorTwoDates executed ');
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query getReportNoMotorTwoDates response as a list with size:%j', listJSON.length);
            let acum = 0;
            let average = 0;
            let questions = [];
            const size = listJSON.length;
            for (let index = 0; size && (index < 1); index++) {
                if(listJSON[index].Q1){
                    acum += listJSON[index].Q1 - 1;
                    if(listJSON[index].Q1 === 2){
                        questions.push('Q1');
                    }
                }
                if(listJSON[index].Q2){
                    acum += listJSON[index].Q2 - 1;
                    if(listJSON[index].Q2 === 2){
                        questions.push('Q2');
                    }
                }
                if(listJSON[index].Q3){
                    acum += listJSON[index].Q3 - 1;
                    if(listJSON[index].Q3 === 2){
                        questions.push('Q3');
                    }
                }
                if(listJSON[index].Q4){
                    acum += listJSON[index].Q4 - 1;
                    if(listJSON[index].Q4 === 2){
                        questions.push('Q4');
                    }
                }
                if(listJSON[index].Q5){
                    acum += listJSON[index].Q5 - 1;
                    if(listJSON[index].Q5 === 2){
                        questions.push('Q5');
                    }
                }
                if(listJSON[index].Q6){
                    acum += listJSON[index].Q6 - 1;
                    if(listJSON[index].Q6 === 2){
                        questions.push('Q6');
                    }
                }
                if(listJSON[index].Q7){
                    acum += listJSON[index].Q7 - 1;
                    if(listJSON[index].Q7 === 2){
                        questions.push('Q7');
                    }
                }
                if(listJSON[index].Q8){
                    acum += listJSON[index].Q8 - 1;
                    if(listJSON[index].Q8 === 2){
                        questions.push('Q8');
                    }
                }
                if(listJSON[index].Q9){
                    acum += listJSON[index].Q9 - 1;
                    if(listJSON[index].Q9 === 2){
                        questions.push('Q9');
                    }
                }
                if(listJSON[index].Q10){
                    acum += listJSON[index].Q10 - 1;
                    if(listJSON[index].Q10 === 2){
                        questions.push('Q10');
                    }
                }
                if(listJSON[index].Q11){
                    acum += listJSON[index].Q11 - 1;
                    if(listJSON[index].Q11 === 2){
                        questions.push('Q11');
                    }
                }
                if(listJSON[index].Q12){
                    acum += listJSON[index].Q12 - 1;
                    if(listJSON[index].Q12 === 2){
                        questions.push('Q12');
                    }
                }
                if(listJSON[index].Q13){
                    acum += listJSON[index].Q13 - 1;
                    if(listJSON[index].Q13 === 2){
                        questions.push('Q13');
                    }
                }
                if(listJSON[index].Q14){
                    acum += listJSON[index].Q14 - 1;
                    if(listJSON[index].Q14 === 2){
                        questions.push('Q14');
                    }
                }
                if(listJSON[index].Q15){
                    acum += listJSON[index].Q15 - 1;
                    if(listJSON[index].Q15 === 2){
                        questions.push('Q15');
                    }
                }
                if(listJSON[index].Q16){
                    acum += listJSON[index].Q16 - 1;
                    if(listJSON[index].Q16 === 2){
                        questions.push('Q16');
                    }
                }
                if(listJSON[index].Q17){
                    acum += listJSON[index].Q17 - 1;
                    if(listJSON[index].Q17 === 2){
                        questions.push('Q17');
                    }
                }
                if(listJSON[index].Q18){
                    acum += listJSON[index].Q18 - 1;
                    if(listJSON[index].Q18 === 2){
                        questions.push('Q18');
                    }
                }
                if(listJSON[index].Q19){
                    acum += listJSON[index].Q19 - 1;
                    if(listJSON[index].Q19 === 2){
                        questions.push('Q19');
                    }
                }
                if(listJSON[index].Q20){
                    acum += listJSON[index].Q20 - 1;
                    if(listJSON[index].Q20 === 2){
                        questions.push('Q20');
                    }
                }
                if(listJSON[index].Q21){
                    acum += listJSON[index].Q21 - 1;
                    if(listJSON[index].Q21 === 2){
                        questions.push('Q21');
                    }
                }
                if(listJSON[index].Q22){
                    acum += listJSON[index].Q22 - 1;
                    if(listJSON[index].Q22 === 2){
                        questions.push('Q22');
                    }
                }
                if(listJSON[index].Q23){
                    acum += listJSON[index].Q23 - 1;
                    if(listJSON[index].Q23 === 2){
                        questions.push('Q23');
                    }
                }
                if(listJSON[index].Q24){
                    acum += listJSON[index].Q24 - 1;
                    if(listJSON[index].Q24 === 2){
                        questions.push('Q24');
                    }
                }
                if(listJSON[index].Q25){
                    acum += listJSON[index].Q25 - 1;
                    if(listJSON[index].Q25 === 2){
                        questions.push('Q25');
                    }
                }
                if(listJSON[index].Q26){
                    acum += listJSON[index].Q26 - 1;
                    if(listJSON[index].Q26 === 2){
                        questions.push('Q26');
                    }
                }
                if(listJSON[index].Q27){
                    acum += listJSON[index].Q27 - 1;
                    if(listJSON[index].Q27 === 2){
                        questions.push('Q27');
                    }
                }
                if(listJSON[index].Q28){
                    acum += listJSON[index].Q28 - 1;
                    if(listJSON[index].Q28 === 2){
                        questions.push('Q28');
                    }
                }
                if(listJSON[index].Q29){
                    acum += listJSON[index].Q29 - 1;
                    if(listJSON[index].Q29 === 2){
                        questions.push('Q29');
                    }
                }
                if(listJSON[index].Q30){
                    acum += listJSON[index].Q30 - 1;
                    if(listJSON[index].Q30 === 2){
                        questions.push('Q30');
                    }
                }
            }

            if (size !== 0) {
                average = Number((acum/(size)).toFixed(1));
            }
            const finalResponse = {
                Promedio: average,
                Cantidad: size,
                Fecha: (size !== 0) ? listJSON[0].date: '0000-00-00T00:00:00.000Z',
                Preguntas: questions
            };
            debug('response no motor report final :%j', finalResponse);
            return finalResponse;
        }  catch (error) {
            debug('getReportNoMotorTwoDates Error: %j', error);
            throw error;
        }
    }

    public static async getAlarmsTodayById(id: number): Promise<any> {
        try {
            debug('getting alarms today for patient: %s', id);
            const query = `
            SELECT
                NAME as Name,
                alarmTime as AlarmTime,
                periodicityQuantity as PeriodicityQuantity,
                periodicityType as PeriodicityType
            FROM
                medicine
                INNER JOIN
                alarmandmedicinepatient
                ON medicine.ID =alarmandmedicinepatient.idMedicine
            WHERE ID_PATIENT= ?`;
            debug('getReportDiscrepancyTwoDates to patient id: %s', id);
            const res = await executeSQL(query,[id]);
            debug('getReportDiscrepancyTwoDates executed ');
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query discrepancy response as a list with size:%j', listJSON.length);
            const size = listJSON.length;
            let response = [];
            for (let index = 0; index < size; index++) {
                if(listJSON[index].Name === 'levodopa' || listJSON[index].Name === 'Levodopa' || listJSON[index].Name === 'LEVODOPA' ){
                    const today = new Date();
                    const hour = listJSON[index].AlarmTime;
                    let initialHour = new Date(`${today.getFullYear()}-${today.getMonth()+1}-${today.getDate()} ${hour}:00.000Z`);
                    const limit = new Date(`${initialHour.getFullYear()}-${initialHour.getMonth()+1}-${initialHour.getDate()} 21:00:00.000Z`);
                    const periodicity = listJSON[index].PeriodicityQuantity;
                    const periodicityType = listJSON[index].PeriodicityType;
                    if(periodicityType === 'Hora(s)') {
                        while(initialHour.getTime() < limit.getTime()) {
                            response.push(`${initialHour.getHours()}:${initialHour.getMinutes()}:00`);
                            initialHour.setHours(initialHour.getHours() + periodicity);
                        }
                    } else {
                        response.push(hour);
                    }
                }
            }
            debug('response alarms today response:%j', response);
            return response;
        }  catch (error) {
            debug('getReportDiscrepancyTwoDates Error: %j', error);
            throw error;
        }
    }

    public static async  getReportSymptomsDaily(idPatient: number, initDate: string, endDate: string) {
        try {
            debug('getting report daily First: %s Second: %s', initDate, endDate);
            const query = `
            SELECT
                Q1,
                formdate
            FROM
                symptomsformpatient
            WHERE ID_PATIENT= ?
            AND formdate BETWEEN ? AND ? ORDER BY formdate ASC`;
            debug('getReportSymptomsDaily to patient id: %s', idPatient);
            const res = await executeSQL(query,[idPatient, initDate, endDate]);
            debug('getReportSymptomsDaily executed');
            debug('query reslt response :%j', res[0]);
            const listJSON = JSON.parse(JSON.stringify(res[0]));
            debug('query daily response as a list :%j', res[0]);
            const size = listJSON.length;
            const init = new Date(initDate);
            const end = new Date(endDate);

            let before = new Date(init);
            let after = new Date(init);

            while(before.getTime() < end.getTime()) {
                after.setHours(after.getHours()+1);
                before.setHours(before.getHours() + 1);
            }

            let result: any = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
            for (let index = 0; index < size; index++) {
                const hour = new Date(listJSON[index].formdate); 
                if(listJSON[index].Q1 === 'on') {
                    result[hour.getHours()] = 3;
                } else if (listJSON[index].Q1 === 'on bueno') {
                    result[hour.getHours()] = 4;
                } else if (listJSON[index].Q1 === 'off malo') {
                    result[hour.getHours()] = 1;
                } else if (listJSON[index].Q1 === 'off') {
                    result[hour.getHours()] = 2;
                }
            }
            let resp = [];
            for (let index = 0; index < 24; index++) {
                const item = {
                    Hora: index,
                    Estado: result[index]
                }
                resp.push(item);
            }
            debug('response daily final :%j', resp);
            return resp;
        }  catch (error) {
            debug('getReportSymptomsDaily Error: %j', error);
            throw error;
        }
    }
}