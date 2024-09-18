-- Funções de Validação
/*
 ========================================
 ||                                    ||
 ||    Função para Validar Reserva     ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION PRIVATE_VERIFICAR_RESERVA(_ID_RESERVA INT) RETURNS VOID AS $$
	BEGIN
		IF NOT EXISTS (SELECT * FROM RESERVA WHERE ID_RESERVA = _ID_RESERVA) THEN
			RAISE EXCEPTION 'RESERVA NÚMERO % NÃO EXISTE', _ID_RESERVA;
		END IF;
	END;
$$ LANGUAGE 'plpgsql';

/*
 ========================================
 ||                                    ||
 ||      Função para Validar Voo       ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION PRIVATE_VERIFICAR_VOO(_ID_VOO INT) RETURNS VOID AS $$
	BEGIN
		IF NOT EXISTS (SELECT * FROM VOO WHERE ID_VOO = _ID_VOO) THEN
			RAISE EXCEPTION 'VOO NÚMERO % NÃO EXISTE', _ID_VOO;
		END IF;
	END;
$$ LANGUAGE 'plpgsql';

/*
 ========================================
 ||                                    ||
 ||    Função para Validar Usuario     ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION PRIVATE_VERIFICAR_USUARIO(_ID_USUARIO INT) RETURNS VOID AS $$
	BEGIN
		IF NOT EXISTS (SELECT * FROM USUARIO WHERE ID_USUARIO = _ID_USUARIO) THEN
			RAISE EXCEPTION 'USUARIO NÚMERO % NÃO EXISTE', _ID_USUARIO;
		END IF;
	END;
$$ LANGUAGE 'plpgsql';

/*
 ========================================
 ||                                    ||
 ||    Função para Validar Aviao       ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION PRIVATE_VERIFICAR_AVIAO(_ID_AVIAO INT) RETURNS VOID AS $$
	BEGIN
		IF NOT EXISTS (SELECT * FROM AVIAO WHERE ID_AVIAO = _ID_AVIAO) THEN
			RAISE EXCEPTION 'AVIAO NÚMERO % NÃO EXISTE', _ID_AVIAO;
		END IF;
	END;
$$ LANGUAGE 'plpgsql';

/*
 ========================================
 ||                                    ||
 ||     Função para Validar Classe     ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION PRIVATE_VERIFICAR_CLASSE(_ID_CLASSE INT) RETURNS VOID AS $$
	BEGIN
		IF NOT EXISTS (SELECT * FROM CLASSE WHERE ID_CLASSE = _ID_CLASSE) THEN
			RAISE EXCEPTION 'CLASSE NÚMERO % NÃO EXISTE', _ID_CLASSE;
		END IF;
	END;
$$ LANGUAGE 'plpgsql';

/*
 ========================================
 ||                                    ||
 ||    Função para Validar Assento     ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION PRIVATE_VERIFICAR_ASSENTO(_ID_ASSENTO INT) RETURNS VOID AS $$
	BEGIN
		IF NOT EXISTS (SELECT * FROM ASSENTO WHERE ID_ASSENTO = _ID_ASSENTO) THEN
			RAISE EXCEPTION 'ASSENTO NÚMERO % NÃO EXISTE', _ID_ASSENTO;
		END IF;
	END;
$$ LANGUAGE 'plpgsql';

/*
 ========================================
 ||                                    ||
 ||     Função para Validar Cidade     ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION PRIVATE_VERIFICAR_CIDADE(_ID_CIDADE INT) RETURNS VOID AS $$
	BEGIN
		IF NOT EXISTS (SELECT * FROM CIDADE WHERE ID_CIDADE = _ID_CIDADE) THEN
			RAISE EXCEPTION 'CIDADE NÚMERO % NÃO EXISTE', _ID_CIDADE;
		END IF;
	END;
$$ LANGUAGE 'plpgsql';

/*
 ========================================
 ||                                    ||
 ||    Função para Validar Trajeto     ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION PRIVATE_VERIFICAR_TRAJETO(_ID_TRAJETO INT) RETURNS VOID AS $$
	BEGIN
		IF NOT EXISTS (SELECT * FROM TRAJETO WHERE ID_TRAJETO = _ID_TRAJETO) THEN
			RAISE EXCEPTION 'TRAJETO NÚMERO % NÃO EXISTE', _ID_TRAJETO;
		END IF;
	END;
$$ LANGUAGE 'plpgsql';

-- Funções
/*
 ========================================
 ||                                    ||
 ||      Função para Validar CPF       ||
 ||                                    ||
 ========================================
 */
CREATE
OR REPLACE FUNCTION VALIDAR_CPF(CPF VARCHAR(11)) RETURNS VOID AS $ $ DECLARE CPF_ARRAY INT [] := STRING_TO_ARRAY(CPF, NULL);

SOMA_DIGITO_1 INT := 0;

SOMA_DIGITO_2 INT := 0;

BEGIN IF LENGTH(CPF) != 11 THEN RAISE EXCEPTION 'CPF INVÁLIDO!';

END IF;

FOR INDICE IN 1..9 LOOP SOMA_DIGITO_1 := SOMA_DIGITO_1 + CPF_ARRAY [INDICE] * (11 - INDICE);

END LOOP;

SOMA_DIGITO_1 := 11 - (SOMA_DIGITO_1 % 11);

IF SOMA_DIGITO_1 > 9 THEN SOMA_DIGITO_1 := 0;

END IF;

FOR INDICE IN 1..10 LOOP SOMA_DIGITO_2 := SOMA_DIGITO_2 + CPF_ARRAY [INDICE] * (12 - INDICE);

END LOOP;

SOMA_DIGITO_2 := 11 - (SOMA_DIGITO_2 % 11);

IF SOMA_DIGITO_2 > 9 THEN SOMA_DIGITO_2 = 0;

END IF;

IF SOMA_DIGITO_1 != CPF_ARRAY [10]
OR SOMA_DIGITO_2 != CPF_ARRAY [11] THEN RAISE EXCEPTION 'CPF INVÁLIDO. DÍGITOS VERIFICADORES INVÁLIDOS!';

END IF;

RAISE LOG 'CPF VÁLIDO!';

END;

$ $ LANGUAGE 'plpgsql';

/*
 ============================================
 ||                                    	  ||
 ||      Função para Validar TELEFONE      ||
 ||                                        ||
 ============================================
 */

CREATE OR REPLACE FUNCTION VALIDAR_TELEFONE(_TELEFONE VARCHAR(11)) 
RETURNS VOID AS $$
BEGIN
    IF LENGTH(_TELEFONE) != 11 THEN RAISE EXCEPTION 'NUMERO DE TELEFONE INVÁLIDO';
END IF;
END;

$ $ LANGUAGE 'plpgsql';

/*
 =========================================
 ||                                     ||
 ||      Função para Validar EMAIL      ||
 ||                                     ||
 =========================================
 */
CREATE OR REPLACE FUNCTION VALIDAR_EMAIL(_EMAIL VARCHAR(100)) 
RETURNS VOID AS $$
BEGIN 
    IF NOT _EMAIL ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$' THEN RAISE EXCEPTION 'EMAIL INVALIDO. %',
_EMAIL;

END IF;
END;
$$ LANGUAGE 'plpgsql';
