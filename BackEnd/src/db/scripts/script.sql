/*DROP DATABASE AppKinsonDB;*/

CREATE DATABASE AppKinsonDB;


USE AppKinsonDB;

CREATE TABLE users(
    ID INT NOT NULL AUTO_INCREMENT,
    EMAIL VARCHAR(50) NOT NULL UNIQUE,
    PASSWORD VARCHAR(60) NOT NULL,
    TYPE VARCHAR(60) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE doctors(
    ID_USER INT NOT NULL,
    NAME VARCHAR(50),
    PHOTOPATH VARCHAR(255),
    FOREIGN KEY (ID_USER) REFERENCES users(ID) ON DELETE CASCADE 
);

CREATE TABLE patients(
    ID_USER INT NOT NULL,
    NAME VARCHAR(50),
    PHOTOPATH VARCHAR(255),
    FOREIGN KEY (ID_USER) REFERENCES users(ID) ON DELETE CASCADE 
);

CREATE TABLE carers(
    ID_USER INT NOT NULL,
    NAME VARCHAR(50),
    PHOTOPATH VARCHAR(255),
    FOREIGN KEY (ID_USER) REFERENCES users(ID) ON DELETE CASCADE 
);

CREATE TABLE requestlinkdoctortopatient(
    ID_DOCTOR INT NOT NULL,
    ID_PATIENT INT NOT NULL,
    FOREIGN KEY (ID_DOCTOR) REFERENCES doctors(ID_USER) ON DELETE CASCADE ,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE ,
    PRIMARY KEY (ID_DOCTOR,ID_PATIENT)
);

CREATE TABLE patientxdoctor(
    ID_DOCTOR INT NOT NULL,
    ID_PATIENT INT NOT NULL,
    FOREIGN KEY (ID_DOCTOR) REFERENCES doctors(ID_USER) ON DELETE CASCADE,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (ID_DOCTOR,ID_PATIENT)
);

CREATE TABLE patientxcarer(
    ID_CARER INT NOT NULL,
    ID_PATIENT INT NOT NULL,
    FOREIGN KEY (ID_CARER) REFERENCES carers(ID_USER) ON DELETE CASCADE,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (ID_CARER,ID_PATIENT)
);


CREATE TABLE requestlinkcarertopatient(
    ID_CARER INT NOT NULL,
    ID_PATIENT INT NOT NULL,
    FOREIGN KEY (ID_CARER) REFERENCES carers(ID_USER) ON DELETE CASCADE,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (ID_CARER,ID_PATIENT)
);

CREATE TABLE symptomsformpatient (
    ID_PATIENT INT NOT NULL,
    Q1 VARCHAR(50) NOT NULL,
    Q2 VARCHAR(50) NOT NULL,
    formdate DATETIME NOT NULL,
    pathvideo VARCHAR(50),
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (ID_PATIENT,formdate)
);
CREATE TABLE patientxsymptomsform(
    ID_PATIENT INT NOT NULL,
    DATE_FORM DATETIME,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (DATE_FORM,ID_PATIENT)
);

CREATE TABLE emotionalformpatient (
    ID_PATIENT INT NOT NULL,
    Q1 INT NOT NULL,
    Q2 INT NOT NULL,
    Q3 INT NOT NULL,
    Q4 INT NOT NULL,
    Q5 INT NOT NULL,
    Q6 INT NOT NULL,
    Q7 INT NOT NULL,
    Q8 INT NOT NULL,
    Q9 INT NOT NULL,
    Q10 INT NOT NULL,
    Q11 INT NOT NULL,
    Q12 INT NOT NULL,
    Q13 INT NOT NULL,
    Q14 INT NOT NULL,
    Q15 INT NOT NULL,
    Q16 INT NOT NULL,
    Q17 INT NOT NULL,
    Q18 INT NOT NULL,
    Q19 INT NOT NULL,
    Q20 INT NOT NULL,
    Q21 INT NOT NULL,
    Q22 INT NOT NULL,
    Q23 INT NOT NULL,
    Q24 INT NOT NULL,
    Q25 INT NOT NULL,
    Q26 INT NOT NULL,
    Q27 INT NOT NULL,
    Q28 INT NOT NULL,
    Q29 INT NOT NULL,
    Q30 INT NOT NULL,
    date DATETIME NOT NULL,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (ID_PATIENT,date)
);

CREATE TABLE medicinealarmpatient (
    ID_PATIENT INT NOT NULL,
    id VARCHAR(50) NOT NULL,
    title VARCHAR(50),
    alarmDateTime DATETIME,
    alarmTime TIME NOT NULL,
    isPending BOOLEAN,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (ID_PATIENT,id)
);

CREATE TABLE medicine (
    ID INT NOT NULL AUTO_INCREMENT,
    NAME VARCHAR(50),
    PRIMARY KEY (ID)
);

insert into medicine(NAME) values('levodopa'), ('medicina2'),('medicina3');


CREATE TABLE alarmandmedicinepatient (
    ID_PATIENT INT NOT NULL,
    periodicityQuantity INT NOT NULL,
    title VARCHAR(50),
    alarmTime TIME NOT NULL,
    idMedicine INT NOT NULL,
    dose VARCHAR(50),
    periodicityType VARCHAR(50),
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    FOREIGN KEY (idMedicine) REFERENCES medicine(ID) ON DELETE CASCADE,
    PRIMARY KEY (ID_PATIENT,idMedicine)
);