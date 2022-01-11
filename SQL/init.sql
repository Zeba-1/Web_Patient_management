-- FICHIER D'INITIALISATION DES TABLES ET DES CONTRAINTE --


CREATE TABLE medecinT (
    nPro char(9) PRIMARY KEY,
    nom varchar(20) NOT NULL,
    prenom varchar(20) NOT NULL,
    adresse varchar(100)

);

CREATE TABLE patients (
    numSecu char(15) PRIMARY KEY,
    nomU varchar(20) NOT NULL,
    nom varchar(20),
    prenom varchar(20) NOT NULL,
    adresse varchar(100),
    medecinT char(9) REFERENCES medecinT(nPro) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE allergies (
    code varchar(5) PRIMARY KEY,
    niv int CHECK (niv BETWEEN 1 AND 10)
);

CREATE TABLE services (
    idS serial PRIMARY KEY,
    nom varchar(30) NOT NULL,
    loc char(2) NOT NULL
);

CREATE TABLE medecinH (
    idM serial PRIMARY KEY,
    nom varchar(20) NOT NULL,
    prenom varchar(20) NOT NULL,
    adresse varchar(100),
    mdp varchar(32) NOT NULL -- 32 car nombre de caractère de MD5
);

CREATE TABLE acteMed (
    idA serial PRIMARY KEY,
    nom varchar(50) NOT NULL,
    dateH timestamp NOT NULL,
    resum text NOT NULL,
    patient char(15) NOT NULL REFERENCES patients(numSecu) ON DELETE CASCADE ON UPDATE CASCADE,
    medecin int NOT NULL REFERENCES medecinH(idM) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE fichier (
    nom varchar(30) PRIMARY KEY,
    lien varchar(200),
    descr text NOT NULL,
    acteMed int NOT NULL REFERENCES acteMed(idA) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE dateEntre (
    dateE date PRIMARY KEY
);

CREATE TABLE possede (
    patient char(15) NOT NULL REFERENCES patients(numSecu) ON DELETE CASCADE ON UPDATE CASCADE,
    allergie varchar(5) NOT NULL REFERENCES allergies(code) ON DELETE CASCADE ON UPDATE CASCADE,
    dateD date NOT NULL,
    dateF date,

    PRIMARY KEY (patient, allergie)
);

CREATE TABLE passePar (
    patient char(15) NOT NULL REFERENCES patients(numSecu) ON DELETE CASCADE ON UPDATE CASCADE,
    services int NOT NULL REFERENCES services(idS) ON DELETE CASCADE ON UPDATE CASCADE,
    dateE date NOT NULL REFERENCES dateEntre(dateE) ON DELETE CASCADE ON UPDATE CASCADE,
    dateS date,

    PRIMARY KEY (patient, services, dateE)
);

CREATE TABLE travaille (
    medecin int NOT NULL REFERENCES medecinH(idM) ON DELETE CASCADE ON UPDATE CASCADE,
    services int NOT NULL REFERENCES services(idS) ON DELETE CASCADE ON UPDATE CASCADE,
    fonction varchar(20),
    anciennete date,

    PRIMARY KEY (medecin, services)
); 

-- Vue pour le rendu 2 --

--IL FAUT TESTER LES VUE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
CREATE VIEW nbIntervention AS (
    SELECT DATE(dateH), count(idA)
    FROM acteMed
    GROUP BY DATE(dateH)
);

CREATE VIEW NbTypeIntervention AS (
    SELECT nom, count(nom)
    FROM acteMed
    GROUP BY nom
);
 
CREATE VIEW TempsPassageService AS (
    SELECT services, avg(dateS - dateE) AS tempsPasser
    FROM passePar
    GROUP BY services
); 
