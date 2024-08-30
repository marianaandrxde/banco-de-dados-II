-- Inserções adicionais na tabela USUARIO
INSERT INTO USUARIO (CPF, NOME, DT_NASC, EMAIL, ENDERECO, TELEFONE) VALUES
('45678901234', 'Laura Costa', '1985-07-10', 'laura.costa@example.com', 'Rua D, 101', '11987654324'),
('56789012345', 'Roberto Almeida', '1972-12-25', 'roberto.almeida@example.com', 'Rua E, 202', '11987654325'),
('67890123456', 'Fernanda Lima', '1995-04-20', 'fernanda.lima@example.com', 'Rua F, 303', '11987654326'),
('78901234567', 'Lucas Pereira', '1988-09-15', 'lucas.pereira@example.com', 'Rua G, 404', '11987654327'),
('89012345678', 'Juliana Santos', '1992-01-30', 'juliana.santos@example.com', 'Rua H, 505', '11987654328');

-- Inserções na tabela CLASSE
INSERT INTO CLASSE (NOME, DESCRICAO, VALOR) VALUES
('Econômica', 'Classe econômica padrão', 500.00),
('Executiva', 'Classe com mais conforto e benefícios', 1500.00),
('Primeira Classe', 'Classe premium com todas as comodidades', 3000.00);

-- Inserções na tabela AVIAO
INSERT INTO AVIAO (NOME, CAPACIDADE, DESCRICAO) VALUES
('Boeing 737', 180, 'Avião de médio porte com capacidade para 180 passageiros'),
('Airbus A320', 150, 'Avião de médio porte com capacidade para 150 passageiros'),
('Boeing 787', 250, 'Avião de longo alcance com capacidade para 250 passageiros');

-- Inserções na tabela ASSENTO
INSERT INTO ASSENTO (ID_ASSENTO) VALUES
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15);

-- Inserções na tabela CIDADE
INSERT INTO CIDADE (NOME, LOCALIZACAO) VALUES
('São Paulo', 'SP - Brasil'),
('Rio de Janeiro', 'RJ - Brasil'),
('Brasília', 'DF - Brasil');

-- Inserções na tabela TRAJETO
INSERT INTO TRAJETO (ID_ORIGEM, ID_DESTINO, DISTANCIA_KM, VALOR_TRAJETO) VALUES
(1, 2, 350, 500.00),
(2, 3, 1000, 1500.00),
(1, 3, 870, 1200.00);

-- Inserções na tabela CUSTO_KM
INSERT INTO CUSTO_KM (KM_MINIMO, KM_MAXIMO, VALOR) VALUES
(0, 500, 1.50),
(501, 1000, 1.20),
(1001, 2000, 1.00);

-- Inserções na tabela VOO
INSERT INTO VOO (ID_AVIAO, ID_TRAJETO, DATA_VOO, HORARIO_SAIDA, HORARIO_PREV_CHEGADA) VALUES
(1, 1, '2024-09-10', '10:00:00', '11:30:00'),
(2, 2, '2024-09-11', '15:00:00', '17:00:00'),
(3, 3, '2024-09-12', '20:00:00', '23:00:00');

-- Inserções na tabela METODO_DE_PAGAMENTO
INSERT INTO METODO_DE_PAGAMENTO (NOME_METODO_DE_PAGAMENTO) VALUES
('Cartão de Crédito'),
('Boleto Bancário'),
('Débito'),
('Pix'),
('Transferência Bancária');

-- Inserções na tabela AVIAO_ASSENTO_CLASSE_VOO
INSERT INTO AVIAO_ASSENTO_CLASSE_VOO (ID_AVIAO, ID_ASSENTO, ID_CLASSE, ID_VOO, LOCALIZACAO, STATUS) VALUES
(1, 1, 1, 1, 'Central', FALSE),
(1, 2, 1, 1, 'Janela', TRUE),
(2, 3, 2, 2, 'Central', FALSE),
(2, 4, 2, 2, 'Janela', TRUE),
(3, 5, 3, 3, 'Central', FALSE);

-- Inserções na tabela RESERVA
INSERT INTO RESERVA (ID_USUARIO, ID_METODO_DE_PAGAMENTO, VALOR_TOTAL_RESERVA) VALUES
(1, 1, 500.00),
(2, 2, 1500.00),
(3, 3, 1200.00);

-- Inserções na tabela ITEM_RESERVA
INSERT INTO ITEM_RESERVA (ID_RESERVA, ID_VOO, ID_AVIAO_ASSENTO_CLASSE_VOO, NOME_PASSAGEIRO, CPF_PASSAGEIRO, VALOR) VALUES
(1, 1, 1, 'João da Silva', '12345678901', 500.00),
(2, 2, 3, 'Maria Oliveira', '23456789012', 1500.00),
(3, 3, 5, 'Pedro Santos', '34567890123', 1200.00);

-- Inserções na tabela CARGO 
INSERT INTO CARGO (NOME_CARGO, SALARIO_FIXO) VALUES
('Atendente', 5000.00),
('Gerente', 15000.00),
('Supervisor', 10000.00);

-- Inserções na tabela FUNCIONARIO
INSERT INTO FUNCIONARIO (NOME, CPF_FUNCIONARIO, ID_CARGO, DATA_FIM_CONTRATO, USERNAME) VALUES
('Carlos Silva', '11223344556', 1, NULL, 'carlos.silva'),
('Ana Pereira', '22334455667', 2, NULL, 'ana.pereira'),
('José Oliveira', '33445566778', 3, '2025-08-30', 'jose.oliveira');
