-- DROP DATABASE AppKinsonDB;

CREATE DATABASE AppKinsonDB;


USE AppKinsonDB;

CREATE TABLE users(
    ID INT(11) NOT NULL AUTO_INCREMENT,
    EMAIL VARCHAR(50) NOT NULL UNIQUE,
    PASSWORD VARCHAR(60) NOT NULL,
    TYPE VARCHAR(60) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE doctors(
    ID_USER INT(11) NOT NULL,
    NAME VARCHAR(50),
    PHOTOPATH VARCHAR(255),
    FOREIGN KEY (ID_USER) REFERENCES users(ID) ON DELETE CASCADE 
);

CREATE TABLE patients(
    ID_USER INT(11) NOT NULL,
    NAME VARCHAR(50),
    PHOTOPATH VARCHAR(255),
    FOREIGN KEY (ID_USER) REFERENCES users(ID) ON DELETE CASCADE 
);

CREATE TABLE carers(
    ID_USER INT(11) NOT NULL,
    NAME VARCHAR(50),
    PHOTOPATH VARCHAR(255),
    FOREIGN KEY (ID_USER) REFERENCES users(ID) ON DELETE CASCADE 
);

CREATE TABLE requestlinkdoctortopatient(
    ID_DOCTOR INT(11) NOT NULL,
    ID_PATIENT INT(11) NOT NULL,
    FOREIGN KEY (ID_DOCTOR) REFERENCES doctors(ID_USER) ON DELETE CASCADE ,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE ,
    PRIMARY KEY (ID_DOCTOR,ID_PATIENT)
);

CREATE TABLE patientxdoctor(
    ID_DOCTOR INT(11) NOT NULL,
    ID_PATIENT INT(11) NOT NULL,
    FOREIGN KEY (ID_DOCTOR) REFERENCES doctors(ID_USER) ON DELETE CASCADE,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (ID_DOCTOR,ID_PATIENT)
);

CREATE TABLE requestlinkdoctortopatient(
    ID_DOCTOR INT(11) NOT NULL,
    ID_PATIENT INT(11) NOT NULL,
    FOREIGN KEY (ID_DOCTOR) REFERENCES doctors(ID_USER) ON DELETE CASCADE ,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE ,
    PRIMARY KEY (ID_DOCTOR,ID_PATIENT)

);

CREATE TABLE patientxcarer(
    ID_CARER INT(11) NOT NULL,
    ID_PATIENT INT(11) NOT NULL,
    FOREIGN KEY (ID_CARER) REFERENCES carers(ID_USER) ON DELETE CASCADE,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (ID_CARER,ID_PATIENT)
);

CREATE TABLE requestlinkcarertopatient(
    ID_CARER INT(11) NOT NULL,
    ID_PATIENT INT(11) NOT NULL,
    FOREIGN KEY (ID_CARER) REFERENCES carers(ID_USER) ON DELETE CASCADE,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (ID_CARER,ID_PATIENT)
);

CREATE TABLE symptomsformpatient (
    ID_PATIENT INT(11) NOT NULL,
    Q1 VARCHAR(50) NOT NULL,
    Q2 VARCHAR(50) NOT NULL,
    Q3 VARCHAR(50) NOT NULL,
    Q4 VARCHAR(50) NOT NULL,
    Q5 VARCHAR(50) NOT NULL,
    formdate DATETIME NOT NULL,
    pathvideo VARCHAR(50),
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (ID_PATIENT,formdate)

);
CREATE TABLE patientxsymptomsform(
    ID_PATIENT INT(11) NOT NULL,
    DATE_FORM DATETIME,
    FOREIGN KEY (ID_PATIENT) REFERENCES patients(ID_USER) ON DELETE CASCADE,
    PRIMARY KEY (DATE_FORM,ID_PATIENT)
);
