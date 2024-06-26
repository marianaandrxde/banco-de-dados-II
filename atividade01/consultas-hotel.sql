-- CRIAÇÃO DAS TABELAS

	CREATE TABLE CATEGORIA (
		COD_CAT INT NOT NULL,
		NOME VARCHAR(50) NOT NULL,
		VALOR_DIA FLOAT NOT NULL,
		CONSTRAINT PRI_CAT PRIMARY KEY(COD_CAT)
	);

	CREATE TABLE APARTAMENTO (
		NUM INT NOT NULL PRIMARY KEY,
		STATUS CHAR(1) NOT NULL,
		COD_CAT INT NOT NULL,
		CONSTRAINT EST_APTO FOREIGN KEY(COD_CAT) REFERENCES CATEGORIA(COD_CAT)
	);
	
	CREATE TABLE HOSPEDE (
		COD_HOSP INT NOT NULL,
		NOME VARCHAR(50) NOT NULL,
		DT_NASC DATE NOT NULL,
		CONSTRAINT PRI_HOSP PRIMARY KEY(COD_HOSP)
	);
	
	CREATE TABLE HOSPEDAGEM (
		COD_HOSPEDA INT NOT NULL,
		COD_HOSP INT NOT NULL,
		NUM INT NOT NULL,
		DT_ENT DATE NOT NULL,
		DT_SAI DATE,
		CONSTRAINT PRI_HOSPEDA PRIMARY KEY(COD_HOSPEDA),
		CONSTRAINT EST_HOSP FOREIGN KEY(COD_HOSP) REFERENCES HOSPEDE(COD_HOSP),
		CONSTRAINT EST_APTO FOREIGN KEY(NUM) REFERENCES APARTAMENTO(NUM)
	);
	
    	CREATE TABLE RESERVA (
		COD_RESERVA INT NOT NULL,
		COD_HOSP INT NOT NULL,
		NUM INT NOT NULL,
		DT_PREV_ENT DATE NOT NULL,
		DT_PREV_SAI DATE,
		CONSTRAINT PRI_RESERVA PRIMARY KEY(COD_RESERVA),
		CONSTRAINT EST_HOSP FOREIGN KEY(COD_HOSP) REFERENCES HOSPEDE(COD_HOSP),
		CONSTRAINT EST_APTO FOREIGN KEY(NUM) REFERENCES APARTAMENTO(NUM)
	);
    
	CREATE TABLE SERVICO (
		COD_SERV INT NOT NULL,
		NOME VARCHAR(50) NOT NULL,
		VALOR FLOAT NOT NULL,
		CONSTRAINT PRI_SERV PRIMARY KEY(COD_SERV)
	);
	
	CREATE TABLE SOLICITACAO (
		COD_SOL INT NOT NULL,
		COD_HOSPEDA INT NOT NULL,
		COD_SERV INT NOT NULL,
		DT_SOL DATE NOT NULL,
		QUANT INT NOT NULL,
		CONSTRAINT PRI_SOLIC PRIMARY KEY(COD_SOL),
		CONSTRAINT EST_HOSPEDA FOREIGN KEY(COD_HOSPEDA) REFERENCES HOSPEDAGEM(COD_HOSPEDA),
		CONSTRAINT EST_SERV FOREIGN KEY(COD_SERV) REFERENCES SERVICO(COD_SERV)
	);

-- INSERÇÃO DE DADOS
 
	INSERT INTO CATEGORIA (COD_CAT, NOME, VALOR_DIA) 
	VALUES 
		(1, 'Econômica', 100.00), 
		(2, 'Luxo', 300.00), 
		(3, 'Premium', 500.00),
   		(4, 'Standart', 450.00);
		
	INSERT INTO APARTAMENTO (NUM, STATUS, COD_CAT) 
	VALUES 
		(101, 'L', 1), 
		(102, 'L', 1), 
		(103, 'O', 2),
   		(104, 'L', 3),
   		(201, 'L', 4);
		
	INSERT INTO HOSPEDE (COD_HOSP, NOME, DT_NASC) 
	VALUES 
		(1, 'João Silva', '1985-05-01'), 
		(2, 'Maria Santos', '1990-09-15'), 
		(3, 'Pedro Souza', '1978-02-22'),
        (99, 'Mariana Andrade', '2005-04-13');
		
	INSERT INTO HOSPEDAGEM (COD_HOSPEDA, COD_HOSP, NUM, DT_ENT, DT_SAI) 
	VALUES 
		(1, 1, 101, '2022-02-28', '2022-03-03'), 
		(2, 2, 103, '2022-03-10', NULL), 
		(3, 3, 102, '2022-03-15', '2022-03-20'),
        (4, 3, 102, '2022-03-28', '2022-04-01'),
        (5, 1, 201, '2022-03-28', '2022-04-01'),
  		(8, 99, 103, '2021-04-13','2022-04-15'); 
        
   	INSERT INTO RESERVA (COD_RESERVA, COD_HOSP, NUM, DT_PREV_ENT, DT_PREV_SAI) 
	VALUES 
		(1, 1, 101, '2022-02-28', '2022-03-03'), 
		(2, 2, 102, '2022-03-10', NULL), 
		(3, 3, 102, '2022-03-15', '2022-03-20'),
       	(4, 3, 102, '2022-03-28', '2022-04-01'),
        (8, 99, 103, '2022-03-28', '2022-04-01');
		
	INSERT INTO SERVICO (COD_SERV, NOME, VALOR) 
	VALUES 
		(1, 'Café da manhã', 15.00), 
		(2, 'Lavanderia', 50.00), 
		(3, 'Internet sem fio', 20.00);
		
	INSERT INTO SOLICITACAO (COD_SOL, COD_HOSPEDA, COD_SERV, DT_SOL, QUANT) 
	VALUES 
		(1, 1, 1, '2022-03-01', 2), 
		(2, 2, 3, '2022-03-11', 1), 
		(3, 3, 2, '2022-03-17', 3);
        
	
   -- CONSULTAS - PARTE I
   
   -- 1 - Categorias que possuam preços entre R$ 100,00 e R$ 200,00
   		SELECT NOME FROM CATEGORIA WHERE VALOR_DIA BETWEEN 100 AND 200;
   
   -- 2 - Categorias cujos nomes possuam a palavra ‘Luxo’.
   		SELECT NOME FROM CATEGORIA WHERE NOME ILIKE '%LUXO%';
        
   -- 3 - Nomes de categorias de apartamentos que foram ocupados há mais de 5 anos.
   		SELECT NOME FROM CATEGORIA NATURAL JOIN APARTAMENTO NATURAL JOIN HOSPEDAGEM WHERE DATE_PART('YEAR', AGE(CURRENT_DATE, DT_SAI))>5;
   
   -- 4 - Apartamentos que estão ocupados, ou seja, a data de saída está vazia.
   		SELECT NUM FROM APARTAMENTO WHERE NUM IN (SELECT NUM FROM HOSPEDAGEM WHERE DT_SAI IS NULL);
        
   -- 5 - Apartamentos cuja categoria tenha código 1, 2, 3, 11, 34, 54, 24, 12.
   		SELECT AP.NUM FROM APARTAMENTO AP JOIN CATEGORIA C ON AP.COD_CAT = C.COD_CAT AND AP.COD_CAT IN (1,2,3,11,34,54,24,12);
     
   -- 6 - Apartamentos cujas categorias iniciam com a palavra ‘Luxo’.
   		SELECT NUM FROM APARTAMENTO NATURAL JOIN CATEGORIA WHERE NOME ILIKE 'LUXO%';
   
   -- 7 - Quantidade de apartamentos cadastrados no sistema.
   		SELECT COUNT(NUM) FROM APARTAMENTO;
   
   -- 8 - Somatório dos preços das categorias.
   		SELECT SUM(VALOR_DIA) FROM CATEGORIA;
        
   -- 9 - Média de preços das categorias.
   		SELECT AVG(VALOR_DIA) FROM CATEGORIA;
        
   -- 10 - Maior preço de categoria.
      	SELECT MAX(VALOR_DIA) FROM CATEGORIA;
        
   -- 11 - 11. Menor preço de categoria.
   		SELECT MIN(VALOR_DIA) FROM CATEGORIA;
        
   -- 12 O preço média das diárias dos apartamentos ocupados por cada hóspede.
   		SELECT H.NOME, AVG(VALOR_DIA) FROM CATEGORIA NATURAL JOIN APARTAMENTO AP NATURAL JOIN HOSPEDAGEM HG JOIN HOSPEDE H ON HG.COD_HOSP=H.COD_HOSP GROUP BY H.NOME;
   
   -- 13 - Quantidade de apartamentos para cada categoria.
   		SELECT C.NOME, COUNT(NUM) FROM APARTAMENTO AP JOIN CATEGORIA C ON AP.COD_CAT=C.COD_CAT GROUP BY C.NOME;
        
   -- 14 - Categorias que possuem pelo menos 2 apartamentos.
   		SELECT C.NOME, COUNT(NUM) FROM APARTAMENTO AP JOIN CATEGORIA C ON AP.COD_CAT = C.COD_CAT GROUP BY C.NOME HAVING COUNT(NUM) > 1;
        
   -- 15 - Nome dos hóspedes que nasceram após 1° de janeiro de 1970.
   		SELECT NOME FROM HOSPEDE WHERE DT_NASC > '1970-01-01';
   
   -- 16 - Quantidade de hóspedes.
   		SELECT COUNT(COD_HOSP) FROM HOSPEDE;
        
   -- 17 - Apartamentos que foram ocupados pelo menos 2 vezes.
   		SELECT NUM, COUNT(NUM) FROM HOSPEDAGEM GROUP BY NUM HAVING COUNT(NUM) > 1;
        
   -- 18 - Altere a tabela Hóspede, acrescentando o campo "Nacionalidade".
   		ALTER TABLE HOSPEDE ADD COLUMN NACIONALIDADE VARCHAR(20) NOT NULL DEFAULT 'NÃO INFORMADO';
   
   -- 19 - Quantidade de hóspedes para cada nacionalidade.
   		SELECT NACIONALIDADE, COUNT(COD_HOSP) FROM HOSPEDE GROUP BY NACIONALIDADE;
   
   -- 20 - A data de nascimento do hóspede mais velho.
   		SELECT MIN(DT_NASC) FROM HOSPEDE;
   
   -- 21 - A data de nascimento do hóspede mais novo.
   		SELECT MAX(DT_NASC) FROM HOSPEDE;
        
   -- 22 - Reajuste em 10% o valor das diárias das categorias.
   		UPDATE CATEGORIA SET VALOR_DIA = VALOR_DIA * 1.1;
        
   -- 23 - O nome das categorias que não possuem apartamentos.
		SELECT NOME FROM CATEGORIA C LEFT JOIN APARTAMENTO A ON C.COD_CAT = A.COD_CAT WHERE A.COD_CAT IS NULL;
   
   -- 24. O número dos apartamentos que nunca foram ocupados.
   		SELECT AP.NUM FROM APARTAMENTO AP LEFT JOIN HOSPEDAGEM HG ON AP.NUM = HG.NUM WHERE HG.NUM IS NULL;
   
   -- 25 - O número do apartamento mais caro ocupado pelo João.
   		SELECT AP.NUM FROM APARTAMENTO AP JOIN CATEGORIA C ON AP.COD_CAT = C.COD_CAT JOIN HOSPEDAGEM HG ON HG.NUM = AP.NUM JOIN HOSPEDE H ON H.COD_HOSP = HG.COD_HOSP 
     	WHERE H.NOME ILIKE 'JOÃO%' ORDER BY C.VALOR_DIA DESC LIMIT 1;
        
   --26 - O nome dos hóspedes que nunca se hospedaram no apartamento 201.
   		SELECT NOME FROM HOSPEDE WHERE COD_HOSP NOT IN (SELECT COD_HOSP FROM HOSPEDAGEM WHERE NUM = 201);
        
   -- 27 - O nome dos hóspedes que nunca se hospedaram em apartamentos da categoria LUXO.
   		SELECT NOME FROM HOSPEDE WHERE COD_HOSP NOT IN (SELECT COD_HOSP FROM HOSPEDAGEM NATURAL JOIN APARTAMENTO NATURAL JOIN CATEGORIA WHERE NOME ILIKE '%LUXO%');
   
        
   -- 28 - O nome dos hóspedes que se hospedaram ou reservaram apartamento do tipo LUXO.
		SELECT NOME FROM HOSPEDE WHERE COD_HOSP IN (SELECT COD_HOSP FROM HOSPEDAGEM NATURAL JOIN APARTAMENTO NATURAL JOIN CATEGORIA WHERE NOME ILIKE '%LUXO%' 
        UNION 
    	SELECT COD_HOSP FROM RESERVA NATURAL JOIN APARTAMENTO NATURAL JOIN CATEGORIA WHERE NOME ILIKE '%LUXO%');

   --29 - O nome dos hóspedes que se hospedaram mas nunca reservaram apartamentos do tipo LUXO.
   		SELECT NOME FROM HOSPEDE WHERE COD_HOSP IN (SELECT COD_HOSP FROM HOSPEDAGEM NATURAL JOIN APARTAMENTO NATURAL JOIN CATEGORIA WHERE NOME ILIKE '%LUXO%') 
        AND COD_HOSP NOT IN (SELECT COD_HOSP FROM RESERVA NATURAL JOIN APARTAMENTO NATURAL JOIN CATEGORIA WHERE NOME ILIKE '%LUXO%');
        
   -- 30 - O nome dos hóspedes que se hospedaram e reservaram apartamento do tipo LUXO.
   		SELECT H.NOME FROM HOSPEDE H NATURAL JOIN HOSPEDAGEM NATURAL JOIN APARTAMENTO AP JOIN CATEGORIA C ON C.COD_CAT = AP.COD_CAT WHERE C.NOME ILIKE '%LUXO%'
        INTERSECT 
   		SELECT H.NOME FROM HOSPEDE H NATURAL JOIN RESERVA NATURAL JOIN APARTAMENTO AP JOIN CATEGORIA C ON C.COD_CAT = AP.COD_CAT WHERE C.NOME ILIKE '%LUXO%';
