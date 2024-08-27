INSERT INTO USUARIO (CPF, NOME, DT_NASC, EMAIL, ENDERECO, TELEFONE) VALUES
('12345678901', 'Ana Silva', '1985-06-15', 'ana.silva@example.com', 'Rua A, 123', '11987654321'),
('23456789012', 'Bruno Santos', '1990-12-22', 'bruno.santos@example.com', 'Rua B, 456', '11987654322'),
('34567890123', 'Carlos Pereira', '1982-04-05', 'carlos.pereira@example.com', 'Rua C, 789', '11987654323'),
('45678901234', 'Daniela Costa', '1995-08-16', 'daniela.costa@example.com', 'Rua D, 101', '11987654324'),
('56789012345', 'Eduardo Almeida', '1988-01-25', 'eduardo.almeida@example.com', 'Rua E, 202', '11987654325'),
('67890123456', 'Fernanda Oliveira', '1992-09-10', 'fernanda.oliveira@example.com', 'Rua F, 303', '11987654326'),
('78901234567', 'Gabriel Rodrigues', '1986-11-12', 'gabriel.rodrigues@example.com', 'Rua G, 404', '11987654327'),
('89012345678', 'Helena Martins', '1993-03-20', 'helena.martins@example.com', 'Rua H, 505', '11987654328'),
('90123456789', 'Igor Fernandes', '1991-07-07', 'igor.fernandes@example.com', 'Rua I, 606', '11987654329'),
('01234567890', 'Juliana Lima', '1989-10-30', 'juliana.lima@example.com', 'Rua J, 707', '11987654330');

INSERT INTO CLASSE (NOME, DESCRICAO, VALOR) VALUES
('Econômica', 'Classe econômica padrão', 500.00),
('Executiva', 'Classe executiva com mais conforto', 1200.00),
('Primeira Classe', 'Classe premium com todos os luxos', 3000.00);

INSERT INTO AVIAO (NOME, DESCRICAO) VALUES
('Boeing 737', 'Avião de médio porte, ideal para voos regionais'),
('Airbus A320', 'Avião de médio porte, popular em voos curtos'),
('Boeing 777', 'Avião de longo alcance, ideal para voos internacionais'),
('Airbus A380', 'Avião de grande porte, conhecido por seu conforto'),
('Boeing 787', 'Avião moderno, com tecnologia avançada para longas distâncias'),
('Embraer E190', 'Avião regional de pequeno porte'),
('Boeing 747', 'Avião de grande porte, conhecido como Jumbo Jet'),
('Airbus A330', 'Avião de médio a longo alcance'),
('Bombardier CRJ900', 'Avião regional eficiente para curtas distâncias'),
('Airbus A321', 'Avião de médio porte, ideal para voos mais longos');

INSERT INTO ASSENTO (ID_ASSENTO) VALUES
(1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

INSERT INTO CIDADE (NOME, LOCALIZACAO) VALUES
('São Paulo', 'Sudeste do Brasil'),
('Rio de Janeiro', 'Sudeste do Brasil'),
('Belo Horizonte', 'Sudeste do Brasil'),
('Brasília', 'Centro-Oeste do Brasil'),
('Salvador', 'Nordeste do Brasil'),
('Fortaleza', 'Nordeste do Brasil'),
('Curitiba', 'Sul do Brasil'),
('Porto Alegre', 'Sul do Brasil'),
('Recife', 'Nordeste do Brasil'),
('Manaus', 'Norte do Brasil');

INSERT INTO TRAJETO (ID_ORIGEM, ID_DESTINO, DISTANCIA_KM, VALOR_TRAJETO) VALUES
(1, 2, 430, 1500),
(2, 3, 440, 1550),
(3, 4, 715, 2500),
(4, 5, 1200, 4500),
(5, 6, 850, 3200),
(6, 7, 1670, 6000),
(7, 8, 740, 2800),
(8, 9, 1150, 4300),
(9, 10, 2800, 10000),
(10, 1, 2200, 8000);

INSERT INTO CUSTO_KM (KM_MINIMO, KM_MAXIMO, VALOR) VALUES
(0, 500, 3.00),
(501, 1000, 2.50),
(1001, 1500, 2.00),
(1501, 2000, 1.75),
(2001, 2500, 1.50),
(2501, 3000, 1.25),
(3001, 3500, 1.00),
(3501, 4000, 0.90),
(4001, 4500, 0.85),
(4501, 5000, 0.80);

INSERT INTO VOO (ID_AVIAO, ID_TRAJETO, DATA_VOO, HORARIO_SAIDA, HORARIO_PREV_CHEGADA) VALUES
(1, 1, '2024-09-01', '08:00:00', '10:00:00'),
(2, 2, '2024-09-02', '09:00:00', '11:00:00'),
(3, 3, '2024-09-03', '10:00:00', '13:00:00'),
(4, 4, '2024-09-04', '11:00:00', '15:00:00'),
(5, 5, '2024-09-05', '12:00:00', '17:00:00'),
(6, 6, '2024-09-06', '13:00:00', '18:00:00'),
(7, 7, '2024-09-07', '14:00:00', '19:00:00'),
(8, 8, '2024-09-08', '15:00:00', '20:00:00'),
(9, 9, '2024-09-09', '16:00:00', '21:00:00'),
(10, 10, '2024-09-10', '17:00:00', '22:00:00');

INSERT INTO METODO_DE_PAGAMENTO (NOME_METODO_DE_PAGAMENTO) VALUES
('Cartão de Crédito'),
('Débito'),
('Boleto Bancário'),
('Transferência Bancária'),
('Pix');

INSERT INTO AVIAO_ASSENTO_CLASSE_VOO (ID_AVIAO, ID_ASSENTO, ID_CLASSE, ID_VOO, LOCALIZACAO, STATUS) VALUES
(1, 1, 1, 1, 'Janela', FALSE),
(1, 2, 1, 1, 'Central', FALSE),
(1, 3, 2, 1, 'Corredor', FALSE),
(2, 4, 2, 2, 'Janela', FALSE),
(2, 5, 1, 2, 'Central', FALSE),
(2, 6, 2, 2, 'Corredor', FALSE),
