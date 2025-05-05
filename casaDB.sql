CREATE TABLE ambienti -- ambienti 1:n dispositivi // ambienti 1:n permessi
(
    id_ambienti VARCHAR(5) NOT NULL AUTO_INCREMENT,
    interno BOOLEAN,
    nome VARCHAR(15),
    superficie FLOAT,
    altezza FLOAT,
    immagine VARCHAR(255),
    PRIMARY KEY (id_ambienti)
);

CREATE TABLE tipologia --tipologia n:m dispositivi
(
    id_tipologia VARCHAR(5) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(15),
    attuatore BOOLEAN,
    PRIMARY KEY (id_tipologia)
);

CREATE TABLE dispositivi --dispositivi 1:n accessi // dispositivi 1:n letture // dispositivi n:1 ambienti
(
    id_dispositivi VARCHAR(5) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(25),
    descrizione TEXT,
    data_installazione DATE,
    data_ultima_manutenzione DATE,
    timestamp_ultima_lettura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_ambiente VARCHAR(5),
    PRIMARY KEY (id_dispositivi),
    FOREIGN KEY (id_ambiente) REFERENCES ambiente (id_ambiente)
);


CREATE TABLE tipologia_dispositivi --tipologia n:m dispositivi
(
    id VARCHAR(5) NOT NULL AUTO_INCREMENT,
    id_tipologia VARCHAR(5),
    id_dispositivi VARCHAR(5),
    id_tipologia VARCHAR(5),
    PRIMARY KEY (id),
    FOREIGN KEY (id_dispositivi) REFERENCES dispositivi (id_dispositivi),
    FOREIGN KEY (id_tipologia) REFERENCES tipologia (id_tipologia)
);

CREATE TABLE letture --letture n:1 dispositivi
(
    id_letture VARCHAR(5) NOT NULL AUTO_INCREMENT,
    id_dispositivi VARCHAR(5),
    valore_numerico FLOAT(24),
    valore_test FLOAT(24),
    valore_booleano BOOLEAN(24),

    PRIMARY KEY (id_letture),
    FOREIGN KEY (id_dispositivi) REFERENCES dispositivi (id_dispositivi)
);

CREATE TABLE permessi --permessi n:m utente // permessi n:1 ambienti
(
    id_permessi VARCHAR(5) NOT NULL AUTO_INCREMENT,
    nome VARCHAR(25),
    descrizione TEXT,
    PRIMARY KEY (id_permessi)
);

CREATE TABLE utenti --utente n:m permessi // utente n:1 ambienti
(
    id_utenti VARCHAR(5) NOT NULL AUTO_INCREMENT,
    nome varchar(25),
    cognome varchar(25),
    impronta_biometrica VARCHAR(255), --da capire che tipo di variabile usare
    user_password VARCHAR(30),
    data_nascita DATE,
    id_ambiente VARCHAR(5),
    id_permessi VARCHAR(5),
    PRIMARY KEY (id_utenti),
    FOREIGN KEY (id_ambiente) REFERENCES ambiente (id_ambiente)
);

CREATE TABLE utente_permessi --utente n:m permessi
(
    id VARCHAR(5) NOT NULL AUTO_INCREMENT,
    id_utenti VARCHAR(5),
    id_permessi VARCHAR(5),
    PRIMARY KEY (id),
    FOREIGN KEY (id_utenti) REFERENCES utenti (id_utenti),
    FOREIGN KEY (id_permessi) REFERENCES permessi (id_permessi)
);


CREATE TABLE accessi --accessi n:1 dispositivi // accessi n:1 utente
(
    id_accessi VARCHAR(5) NOT NULL AUTO_INCREMENT,
    timestamp_accesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_accessi),
    FOREIGN KEY (id_utenti) REFERENCES utenti (id_utenti),
    FOREIGN KEY (id_dispositivi) REFERENCES dispositivi (id_dispositivi)
);