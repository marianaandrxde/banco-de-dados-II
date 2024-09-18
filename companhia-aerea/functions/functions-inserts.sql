/*
 ========================================
 ||                                    ||
 ||       Função para CADASTRAR        ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION CADASTRAR(
    TABELA TEXT,
    P1 TEXT DEFAULT NULL,
    P2 TEXT DEFAULT NULL,
    P3 TEXT DEFAULT NULL,
    P4 TEXT DEFAULT NULL,
    P5 TEXT DEFAULT NULL,
    P6 TEXT DEFAULT NULL,
    P7 TEXT DEFAULT NULL
) RETURNS VOID AS $ $ BEGIN IF TABELA ILIKE 'USUARIO' THEN EXECUTE FORMAT(
    'SELECT CADASTRAR_USUARIO(%L, %L, %L, %L, %L, %L)',P1, P2, CAST(P3 AS DATE), P4, P5, P6
);

ELSEIF TABELA ILIKE 'CLASSE' THEN EXECUTE FORMAT (
    'SELECT CADASTRAR_CLASSE(%L, %L, %L)', P1, P2, CAST(P3 AS NUMERIC)
);

ELSEIF TABELA ILIKE 'AVIAO' THEN EXECUTE FORMAT (
    'SELECT CADASTRAR_AVIAO(%L, %L, %L)',P1, CAST(P2 AS INT), P3
);

ELSEIF TABELA ILIKE 'ASSENTO' THEN EXECUTE FORMAT ('SELECT CADASTRAR_ASSENTO(%L)', CAST(P1 AS INT));

ELSEIF TABELA ILIKE 'CIDADE' THEN EXECUTE FORMAT ('SELECT CADASTRAR_CIDADE(%L, %L)', P1, P2);

ELSEIF TABELA ILIKE 'TRAJETO' THEN EXECUTE FORMAT ('SELECT CADASTRAR_TRAJETO(%L, %L, %L, %L)',    CAST(PI AS INT), CAST (P2 AS INT), CAST (P3 AS INT), CAST (P4 AS NUMERIC));

ELSEIF TABELA ILIKE 'FUNCIONARIO' THEN EXECUTE FORMAT ('SELECT CADASTRAR_FUNCIONARIO(%L, %L, %L, %L, %L)', P1, CAST (P2 AS INT), CAST (P3 AS DATE), P4, CAST(P5 AS DATE));

ELSEIF TABELA ILIKE 'CUSTO' THEN EXECUTE FORMAT ('SELECT CADASTRAR_CUSTO(%L, %L)', CAST (P1 AS INT), CAST(P2 AS DECIMAL));

ELSEIF TABELA ILIKE 'VOO' THEN EXECUTE FORMAT ('SELECT CADASTRAR_VOO(%L, %L, %L, %L, %L)', CAST (P1 AS INT), CAST(P2 AS INT), CAST (P3 AS DATE), CAST(P3 AS DATE), CAST (P4 AS TIME), CAST (P5 AS TIME));

ELSEIF TABELA ILIKE 'AVIAO_ASSENTO_CLASSE_VOO' THEN EXECUTE FORMAT ('SELECT CADASTRAR_AACV(%L, %L, %L, %L, %L, %L)', CAST (P1 AS INT), CAST(P2 AS INT), CAST (P3 AS INT), CAST(P4 AS INT), P5, CAST (P6 AS BOOLEAN));

ELSE RAISE EXCEPTION 'TABELA NÃO ENCONTRADA';

END IF;
END;
$$ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR Usuario     ||
 ||                                    ||
 ========================================
 */

CREATE
OR REPLACE FUNCTION CADASTRAR_USUARIO(
    _NOME VARCHAR(50),
    _CPF VARCHAR(11),
    _DT_NASC DATE,
    _EMAIL VARCHAR(50),
    _ENDERECO VARCHAR(100),
    _TELEFONE VARCHAR(11)
) RETURNS VOID AS $$
BEGIN 
INSERT INTO
    USUARIO (NOME, CPF, DT_NASC, EMAIL, ENDERECO, TELEFONE)
VALUES
    (
        _NOME,
        _CPF,
        _DT_NASC,
        _EMAIL,
        _ENDERECO,
        _TELEFONE
    );

RAISE NOTICE 'Usuário % cadastrado com sucesso!',
_NOME;

END;

$$ LANGUAGE plpgsql;

/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR CLASSE      ||
 ||                                    ||
 ========================================
 */

CREATE
OR REPLACE FUNCTION CADASTRAR_CLASSE(NOME TEXT, DESCRICAO TEXT, VALOR NUMERIC) 
RETURNS VOID AS $$
BEGIN
    INSERT INTO CLASSE VALUES (DEFAULT, NOME, DESCRICAO, VALOR);
    RAISE NOTICE 'Classe % cadastrado com sucesso!', NOME;
    END;
$ $ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR AVIAO       ||
 ||                                    ||
 ========================================
 */

CREATE
OR REPLACE FUNCTION CADASTRAR_AVIAO(NOME TEXT, CAPACIDADE INT, DESCRICAO TEXT) 
RETURNS VOID AS $$
BEGIN
    INSERT INTO AVIAO VALUES (DEFAULT, NOME, CAPACIDADE, DESCRICAO);
    RAISE NOTICE 'AVIAO % cadastrado com sucesso!', NOME;
    END;
$$ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR ASSENTO     ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION CADASTRAR_ASSENTO(NUM_POLTRONA INT) RETURNS VOID AS $ $ BEGIN
INSERT INTO ASSENTO VALUES (DEFAULT, num_poltrona); 
RAISE NOTICE 'ASSENTO % cadastrado com sucesso!', NUM_POLTRONA;
END;
$ $ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR CIDADE      ||
 ||                                    ||
 ========================================
 */

CREATE
OR REPLACE FUNCTION CADASTRAR_CIDADE(NOME TEXT, LOCALIZACAO TEXT) RETURNS VOID AS $ $ BEGIN
INSERT INTO
    CIDADE VALUES (DEFAULT, NOME, LOCALIZACAO);
    RAISE NOTICE 'CIDADE % cadastrado com sucesso!', NOME;
END;
$$ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 ||  Função para CADASTRAR TRAJETO     ||
 ||                                    ||
 ========================================
 */

CREATE
OR REPLACE FUNCTION CADASTRAR_TRAJETO(
    ID_ORIGEM INT,
    ID_DESTINO INT,
    DISTANCIA INT,
    VALOR_TRAJETO NUMERIC
) RETURNS VOID AS $ $ BEGIN
INSERT INTO TRAJETO VALUES(DEFAULT, ID_ORIGEM, ID_DESTINO, DISTANCIA,VALOR_TRAJETO);
RAISE NOTICE 'TRAJETO cadastrado com sucesso!';
END;
$$ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 || Função para CADASTRAR FUNCTIONARIO ||
 ||                                    ||
 ========================================
 */

CREATE
OR REPLACE FUNCTION CADASTRAR_FUNCIONARIO(
    NOME TEXT,
    CPF_FUNCIONARIO VARCHAR,
    ID_CARGO INT,
    DATA_FIM_CONTRATO DATE,
    USERNAME TEXT,
    DATA_CONTRATACAO DATE
) RETURNS VOID AS $ $ BEGIN
INSERT INTO FUNCIONARIO VALUES(DEFAULT, NOME, CPF_FUNCIONARIO, ID_CARGO, DATA_FIM_CONTRATO, USERNAME,DATA_CONTRATACAO);
RAISE NOTICE 'FUNCIONARIO % cadastrado com sucesso!', NOME;
END;
$$ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 ||     Função para CADASTRAR CUSTO    ||
 ||                                    ||
 ========================================
 */

CREATE
OR REPLACE FUNCTION CADASTRAR_CUSTO_KM(KM INT, VALOR DECIMAL) RETURNS VOID AS $ $ BEGIN
INSERT INTO CUSTO_KM VALUES (DEFAULT, KM, VALOR);
RAISE NOTICE 'CUSTO cadastrado com sucesso!';
END;
$$ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 || Função para CADASTRAR VOO          ||
 ||                                    ||
 ========================================
 */

CREATE
OR REPLACE FUNCTION CADASTRAR_VOO(
    ID_AVIAO INT,
    ID_TRAJETO INT,
    DATA_VOO DATE,
    HORARIO_SAIDA TIME,
    HORARIO_PRE_CHEGADA TIME
) RETURNS VOID AS $ $ BEGIN
INSERT INTO VOO VALUES(DEFAULT, ID_AVIAO, ID_TRAJETO, DATA_VOO, HORARIO_SAIDA, HORARIO_PREV_CHEGADA);
RAISE NOTICE 'VOO cadastrado com sucesso!';
END;
$ $ LANGUAGE PLPGSQL;

/*
 ========================================
 ||                                    ||
 || Função para CADASTRAR AAVV         ||
 ||                                    ||
 ========================================
 */

CREATE
OR REPLACE FUNCTION CADASTRAR_AVIAO_ASSENTO_CLASSE_VOO(
    ID_AVIAO INT,
    ID_ASSENTO INT,
    ID_CLASSE INT,
    ID_VOO INT,
    LOCALIZACAO TEXT,
    STATUS BOOLEAN
) RETURNS VOID AS $ $ BEGIN
INSERT INTO
    AVIAO_ASSENTO_CLASSE_VOO
VALUES
    (DEFAULT, ID_AVIAO, ID_ASSENTO, ID_CLASSE, ID_VOO, LOCALIZACAO, STATUS);
    RAISE NOTICE 'Cadastrado com sucesso!',
_NOME;
END;
$$ LANGUAGE PLPGSQL;