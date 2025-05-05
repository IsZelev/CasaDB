CREATE TABLE ambiente
(
    id_ambiente INT NOT NULL AUTO_INCREMENT,
    interno BOOLEAN,
    nome VARCHAR(15),
    superficie FLOAT,
    altezza FLOAT,
    immagine VARCHAR(255),
    PRIMARY KEY (id_ambiente)
);

CREATE TABLE tipologia
(
    id_tipologia INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(15),
    attuatore BOOLEAN,
    PRIMARY KEY (id_tipologia)
);

CREATE TABLE dispositivo
(
    id_dispositivo INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(25),
    descrizione TEXT,
    data_installazione DATE,
    data_ultima_manutenzione DATE,
    timestamp_ultima_lettura TIMESTAMP,
    id_ambiente INT,
    PRIMARY KEY (id_dispositivo),
    FOREIGN KEY (id_ambiente) REFERENCES ambiente (id_ambiente)
);


CREATE TABLE tipologia_dispositivi
(
    id INT NOT NULL AUTO_INCREMENT,
    id_tipologia INT,
    id_dispositivo INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id_dispositivo) REFERENCES dispositivo (id_dispositivo),
    FOREIGN KEY (id_tipologia) REFERENCES tipologia (id_tipologia)
);

CREATE TABLE lettura
(
    id_lettura INT NOT NULL AUTO_INCREMENT,
    id_dispositivo INT,
    valore_numerico FLOAT(3,2),
    valore_test FLOAT(3,2),
    valore_booleano BOOLEAN,

    PRIMARY KEY (id_lettura),
    FOREIGN KEY (id_dispositivo) REFERENCES dispositivo (id_dispositivo)
);

CREATE TABLE permesso
(
    id_permesso INT NOT NULL AUTO_INCREMENT,
    id_ambiente INT,
    nome VARCHAR(25),
    descrizione TEXT,
    PRIMARY KEY (id_permesso),
    FOREIGN KEY (id_ambiente) REFERENCES ambiente (id_ambiente)
);

CREATE TABLE utente
(
    id_utente INT NOT NULL AUTO_INCREMENT,
    nome varchar(25),
    cognome varchar(25),
    impronta_biometrica VARCHAR(255),
    user_password VARCHAR(32),
    data_nascita DATE,
    id_permesso INT,
    PRIMARY KEY (id_utente),
    FOREIGN KEY (id_permesso) REFERENCES permesso (id_permesso)
);

CREATE TABLE utente_permesso
(
    id INT NOT NULL AUTO_INCREMENT,
    id_utente INT,
    id_permesso INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id_utente) REFERENCES utente (id_utente),
    FOREIGN KEY (id_permesso) REFERENCES permesso (id_permesso)
);


CREATE TABLE accesso
(
    id_accesso INT NOT NULL AUTO_INCREMENT,
    timestamp_accesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_utente INT,
    id_dispositivo INT,
    PRIMARY KEY (id_accesso),
    FOREIGN KEY (id_utente) REFERENCES utente (id_utente),
    FOREIGN KEY (id_dispositivo) REFERENCES dispositivo (id_dispositivo)
);