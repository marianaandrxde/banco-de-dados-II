CREATE TABLE USUARIO (
	ID_USUARIO SERIAL PRIMARY KEY NOT NULL,
	CPF VARCHAR(11) NOT NULL,
	NOME TEXT NOT NULL,
	DT_NASC DATE NOT NULL,
	EMAIL TEXT NOT NULL,
	ENDERECO TEXT NOT NULL,
	TELEFONE VARCHAR(11) NOT NULL,
	CONSTRAINT UNIQUE_CPF UNIQUE (CPF),
	CONSTRAINT UNIQUE_EMAIL UNIQUE (EMAIL)
);

CREATE TABLE CLASSE (
	ID_CLASSE SERIAL PRIMARY KEY NOT NULL,
	NOME VARCHAR(50) NOT NULL,
	DESCRICAO TEXT NOT NULL,
	VALOR NUMERIC(10, 2) DEFAULT 0.00 NOT NULL
);

CREATE TABLE AVIAO (
	ID_AVIAO SERIAL PRIMARY KEY NOT NULL,
	NOME VARCHAR(50) NOT NULL,
	CAPACIDADE INT NOT NULL,
	DESCRICAO TEXT NOT NULL
);

CREATE TABLE ASSENTO (
	ID_ASSENTO INT NOT NULL PRIMARY KEY NOT NULL,
	NUM_POLTRONA INT NOT NULL
);

CREATE TABLE CIDADE (
	ID_CIDADE SERIAL PRIMARY KEY NOT NULL,
	NOME VARCHAR(30),
	LOCALIZACAO VARCHAR(50)
);

CREATE TABLE TRAJETO (
	ID_TRAJETO SERIAL PRIMARY KEY,
	ID_ORIGEM INT NOT NULL,
	ID_DESTINO INT NOT NULL,
	DISTANCIA_KM INT NOT NULL,
	VALOR_TRAJETO NUMERIC(10, 2) DEFAULT 0.00 NOT NULL,
	ATIVO BOOLEAN DEFAULT TRUE;
	CONSTRAINT FK_ORIGEM FOREIGN KEY(ID_ORIGEM) REFERENCES CIDADE(ID_CIDADE),
	CONSTRAINT FK_DESTINO FOREIGN KEY(ID_DESTINO) REFERENCES CIDADE(ID_CIDADE)
);

CREATE TABLE CUSTO_KM (
	ID_CUSTO_KM SERIAL PRIMARY KEY,
	KM INT NOT NULL,
	VALOR NUMERIC(10, 2) DEFAULT 0.00 NOT NULL
);

CREATE TABLE VOO (
	ID_VOO SERIAL PRIMARY KEY,
	ID_AVIAO INT NOT NULL,
	ID_TRAJETO INT NOT NULL,
	DATA_VOO DATE NOT NULL,
	HORARIO_SAIDA TIME,
	HORARIO_PREV_CHEGADA TIME,
	CONSTRAINT FK_AVIAO FOREIGN KEY(ID_AVIAO) REFERENCES AVIAO(ID_AVIAO),
	CONSTRAINT FK_TRAJETO FOREIGN KEY(ID_TRAJETO) REFERENCES TRAJETO(ID_TRAJETO)
);

CREATE TABLE AVIAO_ASSENTO_CLASSE_VOO (
	ID_AVIAO_ASSENTO_CLASSE_VOO SERIAL PRIMARY KEY NOT NULL,
	ID_AVIAO INT NOT NULL,
	ID_ASSENTO INT NOT NULL,
	ID_CLASSE INT NOT NULL,
	ID_VOO INT NOT NULL,
	LOCALIZACAO VARCHAR(20) NOT NULL,
	STATUS BOOLEAN NOT NULL DEFAULT FALSE,
	CONSTRAINT FK_AVIAO FOREIGN KEY(ID_AVIAO) REFERENCES AVIAO(ID_AVIAO),
	CONSTRAINT FK_ASSENTO FOREIGN KEY(ID_ASSENTO) REFERENCES ASSENTO(ID_ASSENTO),
	CONSTRAINT FK_CLASSE FOREIGN KEY(ID_CLASSE) REFERENCES CLASSE(ID_CLASSE)
);

CREATE TABLE RESERVA (
	ID_RESERVA SERIAL PRIMARY KEY NOT NULL,
	ID_USUARIO INT NOT NULL,
	DATA_RESERVA TIMESTAMP DEFAULT NOW(),
	VALOR_TOTAL_RESERVA NUMERIC(10, 2) DEFAULT 0.00 NOT NULL,
	CONSTRAINT FK_METODO_DE_PAGAMENTO FOREIGN KEY(ID_METODO_DE_PAGAMENTO) REFERENCES METODO_DE_PAGAMENTO(ID_METODO_DE_PAGAMENTO)
);

CREATE TABLE ITEM_RESERVA (
	ID_ITEM_RESERVA SERIAL PRIMARY KEY NOT NULL,
	ID_RESERVA INT NOT NULL,
	ID_VOO INT NOT NULL,
	ID_AVIAO_ASSENTO_CLASSE_VOO INT NOT NULL,
	NOME_PASSAGEIRO TEXT NOT NULL,
	CPF_PASSAGEIRO VARCHAR(11) NOT NULL,
	VALOR NUMERIC(10, 2) DEFAULT 0.00 NOT NULL,
	CONSTRAINT FK_VOO FOREIGN KEY(ID_VOO) REFERENCES VOO(ID_VOO),
	CONSTRAINT FK_RESERVA FOREIGN KEY(ID_RESERVA) REFERENCES RESERVA(ID_RESERVA),
	CONSTRAINT FK_AAC FOREIGN KEY(ID_AVIAO_ASSENTO_CLASSE_VOO) REFERENCES AVIAO_ASSENTO_CLASSE_VOO(ID_AVIAO_ASSENTO_CLASSE_VOO)
);

CREATE TABLE CARGO(
	ID_CARGO SERIAL PRIMARY KEY NOT NULL,
	NOME_CARGO VARCHAR(20) NOT NULL,
	SALARIO_FIXO NUMERIC(10, 2) NOT NULL
);

CREATE TABLE FUNCIONARIO(
	ID_FUNCIONARIO SERIAL PRIMARY KEY NOT NULL,
	NOME TEXT NOT NULL,
	CPF_FUNCIONARIO VARCHAR(11) NOT NULL,
	ID_CARGO INT NOT NULL,
	DATA_FIM_CONTRATO TIMESTAMP,
	USERNAME TEXT,
	DATA_CONTRATACAO TIMESTAMP NOT NULL DEFAULT NOW(),
	CONSTRAINT UNIQUE_CPF_FUNCIONARIO UNIQUE (CPF_FUNCIONARIO),
	CONSTRAINT UNIQUE_USERNAME UNIQUE (USERNAME)
);