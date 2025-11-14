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
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE plans_seq'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

------------------------------------------------------------
-- PLANS (Tabela de planos)
------------------------------------------------------------
CREATE TABLE plans (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    description VARCHAR2(200),
    has_ai_chat NUMBER(1) DEFAULT 0,
    has_specialist_chat NUMBER(1) DEFAULT 0
);

CREATE SEQUENCE plans_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER plans_bi
BEFORE INSERT ON plans
FOR EACH ROW
BEGIN
    :new.id := plans_seq.nextval;
END;
/

INSERT INTO plans (name, description, has_ai_chat, has_specialist_chat)
VALUES ('Bronze', 'Acesso básico', 0, 0);

INSERT INTO plans (name, description, has_ai_chat, has_specialist_chat)
VALUES ('Prata', 'Acesso ao chat IA', 1, 0);

INSERT INTO plans (name, description, has_ai_chat, has_specialist_chat)
VALUES ('Ouro', 'Acesso total: IA + especialistas', 1, 1);

------------------------------------------------------------
-- CHALLENGES
------------------------------------------------------------
CREATE TABLE challenges (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR2(100) NOT NULL,
    description VARCHAR2(200)
);

------------------------------------------------------------
-- USERS
------------------------------------------------------------
CREATE TABLE users (
    id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) NOT NULL UNIQUE,
    cpf VARCHAR2(20) UNIQUE NOT NULL,
    password_hash VARCHAR2(200) NOT NULL,
    role VARCHAR2(20) DEFAULT 'user',
    plan_id NUMBER REFERENCES plans(id),
    selected_challenge_id NUMBER REFERENCES challenges(id)
);

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
-- DESAFIOS BASE
------------------------------------------------------------
INSERT INTO challenges (title, description) VALUES ('Desafio Matemática', 'Resolver cálculos');
INSERT INTO challenges (title, description) VALUES ('Desafio Lógica', 'Quebra-cabeças de lógica');
INSERT INTO challenges (title, description) VALUES ('Desafio Palavras', 'Montar palavras');
