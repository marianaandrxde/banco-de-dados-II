/*
 ========================================
 ||                                    ||
 ||   Função para Cancelar Reserva     ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION CANCELAR_RESERVA(_ID_RESERVA INT) 
RETURNS VOID AS $$
    BEGIN 
    PERFORM PRIVATE_VERIFICAR_EXISTENCIA_RESERVA(_ID_RESERVA);
    DELETE FROM ITEM_RESERVA WHERE ID_RESERVA = _ID_RESERVA;
    DELETE FROM RESERVA WHERE ID_RESERVA = _ID_RESERVA;
    RAISE NOTICE 'RESERVA CANCELADA COM SUCESSO!';
END;
$$ LANGUAGE 'plpgsql';

/*
========================================
||                                    ||
||       Função para Remover          ||
||          Item da Reserva           ||
========================================
*/

CREATE OR REPLACE FUNCTION REMOVER_ITEM(_ID_RESERVA INT, _ID_ITEM_RESERVA INT) 
RETURNS VOID AS $$
	BEGIN
		PERFORM PRIVATE_VERIFICAR_RESERVA(_ID_RESERVA);

		IF NOT EXISTS (SELECT * FROM ITEM_RESERVA WHERE ID_RESERVA = _ID_RESERVA AND ID_ITEM_RESERVA = _ID_ITEM_RESERVA) THEN
			RAISE EXCEPTION 'PASSAGEM NÃO ENCONTRADA NA RESERVA %', _ID_ITEM_RESERVA;
		END IF;

		DELETE FROM ITEM_RESERVA WHERE ID_RESERVA = _ID_RESERVA AND ID_ITEM_RESERVA = _ID_ITEM_RESERVA;
		RAISE NOTICE 'PASSAGEM Nº % REMOVIDA DA RESERVA Nº %', _ID_ITEM_RESERVA, _ID_RESERVA;
	END;
$$ LANGUAGE 'plpgsql';

/*
 ========================================
 ||                                    ||
 ||     Função para Cancelar Voo       ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION CANCELAR_VOO(_ID_VOO INT) 
RETURNS VOID AS $$
    BEGIN PERFORM PRIVATE_VERIFICAR_VOO(_ID_VOO);
    DELETE FROM ITEM_RESERVA WHERE ID_VOO = _ID_VOO;
    DELETE FROM AVIAO_ASSENTO_CLASSE_VOO WHERE ID_VOO = _ID_VOO;
    DELETE FROM VOO WHERE ID_VOO = _ID_VOO;
    RAISE NOTICE 'VOO CANCELADO COM SUCESSO!';
END;
$$ LANGUAGE 'plpgsql';

/*
 ========================================
 ||                                    ||
 ||  Função para Cancelar Trajeto      ||
 ||                                    ||
 ========================================
 */

CREATE OR REPLACE FUNCTION CANCELAR_TRAJETO(_ID_TRAJETO) 
RETURNS VOID AS $$
BEGIN
    PERFORM PRIVATE_VERIFICAR_TRAJETO(_ID_TRAJETO);
    IF EXISTS (SELECT 1 FROM VOO WHERE ID_TRAJETO = _ID_TRAJETO) THEN
        RAISE EXCEPTION 'NÃO É POSSÍVEL CANCELAR O TRAJETO POIS EXISTEM VOOS ASSOCIADOS';
    END IF;

    DELETE FROM TRAJETO WHERE ID_TRAJETO = _ID_TRAJETO;
    RAISE NOTICE 'VOO CANCELADO COM SUCESSO!';
END;
$$ LANGUAGE 'plpgsql';
