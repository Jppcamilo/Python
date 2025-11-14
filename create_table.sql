------------------------------------------------------------
-- DROPS (executar sem medo caso as tabelas já existam)
------------------------------------------------------------
BEGIN EXECUTE IMMEDIATE 'DROP TABLE progress CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE challenges CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE users CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE plans CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE progress_seq'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE challenges_seq'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE users_seq'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE plans_seq'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

------------------------------------------------------------
-- PLANS (Tabela de planos)
------------------------------------------------------------
CREATE TABLE plans (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    description VARCHAR2(200)
);

CREATE SEQUENCE plans_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER plans_bi
BEFORE INSERT ON plans
FOR EACH ROW
BEGIN
    :new.id := plans_seq.nextval;
END;
/

INSERT INTO plans (name, description) VALUES ('Bronze', 'Acesso básico sem funcionalidades extras');
INSERT INTO plans (name, description) VALUES ('Prata',  'Acesso ao chat de IA para dúvidas');
INSERT INTO plans (name, description) VALUES ('Ouro',   'Chat IA + chat com especialista');

------------------------------------------------------------
-- USERS
------------------------------------------------------------
CREATE TABLE users (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    cpf VARCHAR2(20) UNIQUE NOT NULL,
    password_hash VARCHAR2(100) NOT NULL,
    role VARCHAR2(20) DEFAULT 'user',
    plan_id NUMBER DEFAULT 1,
    CONSTRAINT fk_user_plan FOREIGN KEY (plan_id) REFERENCES plans(id)
);

CREATE SEQUENCE users_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER users_bi
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    :new.id := users_seq.nextval;
END;
/

------------------------------------------------------------
-- CHALLENGES
------------------------------------------------------------
CREATE TABLE challenges (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    description VARCHAR2(200)
);

CREATE SEQUENCE challenges_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER challenges_bi
BEFORE INSERT ON challenges
FOR EACH ROW
BEGIN
    :new.id := challenges_seq.nextval;
END;
/

------------------------------------------------------------
-- PROGRESS
------------------------------------------------------------
CREATE TABLE progress (
    id NUMBER PRIMARY KEY,
    user_id NUMBER NOT NULL,
    challenge_id NUMBER NOT NULL,
    score NUMBER DEFAULT 0,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_progress_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_progress_challenge FOREIGN KEY (challenge_id) REFERENCES challenges(id)
);

CREATE SEQUENCE progress_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER progress_bi
BEFORE INSERT ON progress
FOR EACH ROW
BEGIN
    :new.id := progress_seq.nextval;
END;
/

------------------------------------------------------------
-- CHALLENGES BASE (opcional)
------------------------------------------------------------
INSERT INTO challenges (name, description) VALUES ('Desafio Matemática', 'Resolver cálculos');
INSERT INTO challenges (name, description) VALUES ('Desafio Lógica', 'Quebra-cabeças de lógica');
INSERT INTO challenges (name, description) VALUES ('Desafio Palavras', 'Montar palavras');
