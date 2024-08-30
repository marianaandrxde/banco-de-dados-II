    
    /* FUNÇÃO PARA VALIDAR CPF DE USUÁRIO*/
    
    CREATE OR REPLACE FUNCTION VALIDAR_CPF(CPF VARCHAR(11)) 
    RETURNS VOID AS 
    $$

    DECLARE
        CPF_ARRAY INT[] := STRING_TO_ARRAY(CPF, NULL);
        SOMA_DIGITO_1 INT := 0;
        SOMA_DIGITO_2 INT := 0;

    BEGIN
        IF LENGTH(CPF) != 11 THEN
            RAISE EXCEPTION 'CPF INVÁLIDO!';
        END IF;
        
        FOR INDICE IN 1..9 LOOP
            SOMA_DIGITO_1 := SOMA_DIGITO_1 + CPF_ARRAY[INDICE] * (11 - INDICE);
        END LOOP;
        
        SOMA_DIGITO_1 := 11 - (SOMA_DIGITO_1 % 11);
        
        IF SOMA_DIGITO_1 > 9 THEN
            SOMA_DIGITO_1 := 0;
        END IF;
            
        FOR INDICE IN 1..10 LOOP
            SOMA_DIGITO_2 := SOMA_DIGITO_2 + CPF_ARRAY[INDICE] * (12 - INDICE);
        END LOOP;
        
        SOMA_DIGITO_2 := 11 - (SOMA_DIGITO_2 % 11);
        
        IF SOMA_DIGITO_2 > 9 THEN
            SOMA_DIGITO_2 = 0;
        END IF;
        
        IF SOMA_DIGITO_1 != CPF_ARRAY[10] OR SOMA_DIGITO_2 != CPF_ARRAY[11] THEN
            RAISE EXCEPTION 'CPF INVÁLIDO. DÍGITOS VERIFICADORES INVÁLIDOS!';
        END IF;
        
        RAISE LOG 'CPF VÁLIDO!';
        
    END;

    $$ LANGUAGE 'plpgsql';


    /* FUNÇÃO PARA VALIDAR TELEFONE DE USUÁRIO */

    CREATE OR REPLACE FUNCTION VALIDAR_TELEFONE(_TELEFONE VARCHAR(11))
    RETURNS VOID
    AS $$
    BEGIN
        IF LENGTH(_TELEFONE) != 11 THEN
            RAISE EXCEPTION 'INVALID PHONE';
        END IF;
    END;
    $$
    LANGUAGE 'plpgsql';


    /* FUNÇÃO PARA VALIDAR EMAIL DE USUÁRIO */

    CREATE OR REPLACE FUNCTION VALIDAR_EMAIL(_EMAIL VARCHAR(100))
    RETURNS VOID
    AS $$
    BEGIN
        IF NOT _EMAIL ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' THEN
            RAISE EXCEPTION 'EMAIL INVALIDO. %', _EMAIL;
        END IF;
    END;
    $$ LANGUAGE 'plpgsql';


    /* FUNÇÃO PARA VALIDAR INTERVALO DE DATAS */

    CREATE OR REPLACE FUNCTION PRIVATE_VALIDAR_DATAS(_DATA_INICIAL DATE, _DATA_FINAL DATE) 
    RETURNS VOID AS $$
        BEGIN

            IF(_DATA_INICIAL IS NULL OR _DATA_FINAL IS NULL) THEN
                RAISE EXCEPTION 'AS DATAS NÃO PODEM SER VAZIAS';
            END IF;
            IF(_DATA_INICIAL < CURRENT_DATE OR _DATA_FINAL < CURRENT_DATE) THEN
                RAISE EXCEPTION 'AS DATAS NÃO PODEM SER INFERIORES A %', CURRENT_DATE;
            END IF;

            IF _DATA_FINAL < _DATA_INICIAL THEN
                RAISE EXCEPTION 'DATA FINAL NÃO PODE SER MENOR QUE A DATA INICIAL';
            END IF;
        END;

    $$ LANGUAGE 'plpgsql';
    

    /* FUNÇÃO PARA CADASTRAR USUÁRIO*/

    CREATE OR REPLACE FUNCTION CADASTRAR_USUARIO(
    _NOME VARCHAR(50), 
    _CPF VARCHAR(11), 
    _DT_NASC DATE, 
    _EMAIL VARCHAR(50), 
    _ENDERECO VARCHAR(100), 
    _TELEFONE VARCHAR(11)
    ) 
    RETURNS VOID AS $$
    BEGIN
        IF EXISTS (SELECT 1 FROM USUARIO WHERE CPF = _CPF) THEN
            RAISE EXCEPTION 'CPF % já cadastrado.', _CPF;
        END IF;

        IF EXISTS (SELECT 1 FROM USUARIO WHERE EMAIL = _EMAIL) THEN
            RAISE EXCEPTION 'E-mail % já cadastrado.', _EMAIL;
        END IF;

        INSERT INTO USUARIO (NOME, CPF, DT_NASC, EMAIL, ENDERECO, TELEFONE) 
        VALUES (_NOME, _CPF, _DT_NASC, _EMAIL, _ENDERECO, _TELEFONE);

        RAISE NOTICE 'Usuário % cadastrado com sucesso!', _NOME;
    END;
    $$ LANGUAGE plpgsql;

    /* FUNÇÃO PARA VERIFICAR EXISTÊNCIA DE UMA RESERVA */

    CREATE OR REPLACE FUNCTION PRIVATE_VERIFICAR_EXISTENCIA_RESERVA(_ID_RESERVA INT) RETURNS VOID AS $$
	BEGIN
		IF NOT EXISTS (SELECT * FROM RESERVA WHERE ID_RESERVA = _ID_RESERVA) THEN
			RAISE EXCEPTION 'RESERVA NÚMERO % NÃO EXISTE', _ID_RESERVA;
		END IF;
	END;
    $$ LANGUAGE 'plpgsql';


    /* FUNÇÃO PARA CADASTRAR FUNCIONÁRIO */

    CREATE OR REPLACE FUNCTION CADASTRAR_FUNCIONARIO(
        _NOME VARCHAR(50),
		_ID_CARGO INT,
        _DATA_FIM_CONTRATO DATE,
        _USERNAME TEXT,
        _SENHA TEXT
    )
    BEGIN
    SELECT LOWER(NOME_CARGO) INTO VAR_CARGO FROM CARGO WHERE ID_CARGO = _ID_CARGO;

		EXECUTE format('CREATE USER "%I" WITH LOGIN PASSWORD %L VALID UNTIL %L', _USERNAME, _SENHA, _DATA_FIM_CONTRATO);
    	EXECUTE format('ALTER GROUP "%I" ADD USER "%I"', VAR_CARGO, _USERNAME);

		INSERT INTO FUNCIONARIO VALUES 
		(DEFAULT, _NOME, _CPF, _ENDERECO, _ID_CARGO, _DATA_FIM_CONTRATO, LOWER(_USERNAME));
		RAISE NOTICE 'FUNCIONÁRIO CADASTRADO COM SUCESSO!';

	END;
    $$ LANGUAGE 'plpgsql';

    /* FUNÇÃO PARA CRIAR RESERVA */
    
    CREATE OR REPLACE FUNCTION PRIVATE_CRIAR_RESERVA( 
        _ID_USUARIO INT,
		_ID_FUNCIONARIO INT,
		_ID_METODO_DE_PAGAMENTO INT
	) RETURNS INT AS $$
	DECLARE VAR_ID_RESERVA INT;
	BEGIN
		INSERT INTO RESERVA(
			ID_USUARIO, ID_FUNCIONARIO
		) VALUES (
			_ID_USUARIO, _ID_FUNCIONARIO
		) RETURNING ID_RESERVA INTO VAR_ID_RESERVA;
		RAISE NOTICE 'RESERVA % CRIADA COM SUCESSO', VAR_ID_RESERVA;
		RETURN VAR_ID_RESERVA;
	END
    $$ LANGUAGE 'plpgsql';

    /* FUNÇÃO PARA VERIFICAR ASSENTOS DISPONÍVEIS EM UM VOO */ 

    CREATE OR REPLACE FUNCTION VERIFICAR_ASSENTOS_DISPONIVEIS(
        _ID_VOO INT
    ) RETURNS TABLE (ID_ASSENTO INT, NOME_CLASSE VARCHAR) AS $$
    BEGIN
        RETURN QUERY
        SELECT a.ID_ASSENTO, c.NOME AS NOME_CLASSE
        FROM AVIAO_ASSENTO_CLASSE_VOO a
        JOIN CLASSE c ON a.ID_CLASSE = c.ID_CLASSE
        WHERE a.ID_VOO = _ID_VOO AND a.STATUS = FALSE;
    END
    $$ LANGUAGE plpgsql;

    /* 
    FUNÇÃO PARA CALCULAR VALOR DO TRAJETO 
    Essa função se baseia em verificar em qual intervalo de km a distância do trajeto está enquadrada e multiplicar
    essa distância pelo valor cobrado por km de acordo com a tabelo CUSTO_KM 
    */

    /*
    FUNÇÃO PARA CALCULAR O VALOR DA RESERVA
    O valor da reserva é a soma do custo total da distância e valor fixo cobrado pela classe.
    */

    /*
    FUNÇÃO PARA CANCELAR RESERVA*/
    CREATE OR REPLACE FUNCTION CANCELAR_RESERVA(_ID_RESERVA INT) RETURNS VOID AS $$
        BEGIN
            PERFORM PRIVATE_VERIFICAR_EXISTENCIA_RESERVA(_ID_RESERVA);

            DELETE FROM ITEM_RESERVA WHERE ID_RESERVA = _ID_RESERVA;
            DELETE FROM RESERVA WHERE ID_RESERVA = _ID_RESERVA;
            RAISE NOTICE 'RESERVA CANCELADA COM SUCESSO!';
        END;
    $$ LANGUAGE 'plpgsql';
    
    /*
    FUNÇÃO PARA CANCELAR VOO -> Função deve ser genérica, ou seja, deverá funcionar para o cancelamento de um voo, como também de uma reserva.
    Essa função deve excluir a linha correspondente ao id passado como parâmetro da tabela VOO e todas as linhas da tabela AVIAO_ASSENTO_CLASSE_VOO
    que fazem referência a esse id, se existir.
    */

    

    