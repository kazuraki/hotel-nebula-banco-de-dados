-- Hotel Nebula - Novos Dados de Teste
USE hotel_nebula;

INSERT INTO hospedes (nome, email, cpf, telefone, data_nascimento, cidade) VALUES
('Marcos Vinicius', 'marcos@email.com', '123.456.789-01', '(31) 98888-1111', '1988-05-10', 'Belo Horizonte'),
('Juliana Paes',    'juliana@email.com', '234.567.890-12', '(11) 97777-2222', '1993-12-14', 'São Paulo'),
('Roberto Carlos',  'roberto@email.com', '345.678.901-23', '(21) 96666-3333', '1975-04-20', 'Rio de Janeiro'),
('Camila Pitanga',  'camila@email.com',  '456.789.012-34', '(41) 95555-4444', '1991-08-30', 'Curitiba'),
('Lucas Silveira',  'lucas@email.com',   '567.890.123-45', '(51) 94444-5555', '1996-02-18', 'Porto Alegre');

INSERT INTO quartos (numero, tipo, capacidade, preco_diaria, status) VALUES
('103', 'Standard', 2, 180.00, 'Disponível'),
('202', 'Luxo',     3, 320.00, 'Disponível'),
('203', 'Luxo',     3, 320.00, 'Ocupado'),
('303', 'Suíte',    4, 550.00, 'Disponível'),
('304', 'Suíte Presidencial', 4, 900.00, 'Manutenção');

INSERT INTO funcionarios (nome, cargo, telefone) VALUES
('Fernanda Lima', 'Recepcionista', '(11) 91112-0001'),
('Gustavo Lima',  'Recepcionista', '(11) 92223-0002'),
('Mariana Rios',  'Gerente',       '(11) 93334-0003');

INSERT INTO servicos (nome, descricao, preco) VALUES
('Café da manhã',      'Buffet completo',            45.00),
('Lavanderia',         'Lavagem de roupas',          60.00),
('Massagem',           'Massagem relaxante no spa', 220.00),
('Transfer aeroporto', 'Traslado de ida ou volta',  150.00),
('Room service',       'Refeição no quarto',         85.00);

INSERT INTO reservas (id_hospede, id_quarto, data_checkin, data_checkout, status) VALUES
(1, 1, '2026-07-01', '2026-07-04', 'Concluída'),   -- 1
(2, 3, '2026-07-10', '2026-07-15', 'Concluída'),   -- 2
(3, 4, '2026-08-01', '2026-08-03', 'Concluída'),   -- 3
(1, 2, '2026-09-05', '2026-09-08', 'Concluída'),   -- 4
(4, 1, '2026-09-15', '2026-09-17', 'Cancelada'),   -- 5
(1, 3, '2026-10-10', '2026-10-13', 'Concluída'),   -- 6
(5, 4, '2026-11-12', '2026-11-18', 'Confirmada'),  -- 7 (hospedado agora)
(2, 2, '2026-12-10', '2026-12-15', 'Confirmada'),  -- 8 (futura)
(3, 1, '2026-10-01', '2026-10-03', 'Cancelada');   -- 9

INSERT INTO hospedagens (id_reserva, id_funcionario, checkin_real, checkout_real) VALUES
(1, 1, '2026-07-01 14:00:00', '2026-07-04 11:00:00'),
(2, 2, '2026-07-10 15:00:00', '2026-07-15 10:30:00'),
(3, 1, '2026-08-01 14:30:00', '2026-08-03 11:00:00'),
(4, 2, '2026-09-05 16:00:00', '2026-09-08 10:45:00'),
(6, 1, '2026-10-10 14:00:00', '2026-10-13 11:30:00'),
(7, 1, '2026-11-12 15:00:00', NULL);

INSERT INTO hospedagem_servicos (id_hospedagem, id_servico, quantidade, data_consumo) VALUES
(1, 1, 2, '2026-07-02'),
(2, 3, 1, '2026-07-12'),
(2, 1, 4, '2026-07-11'),
(3, 5, 1, '2026-08-02'),
(4, 2, 2, '2026-09-06'),
(5, 4, 1, '2026-09-16'),
(5, 1, 2, '2026-09-15'),
(6, 1, 3, '2026-10-11');

INSERT INTO pagamentos (id_hospedagem, valor, metodo, data_pagamento) VALUES
(1,  630.00, 'Pix',               '2026-07-04'),
(2, 1820.00, 'Cartão de Crédito', '2026-07-15'),
(3, 1190.00, 'Cartão de Crédito', '2026-08-03'),
(4, 1020.00, 'Dinheiro',          '2026-09-08'),
(5, 1740.00, 'Pix',               '2026-10-13'),
(6,  975.00, 'Pix',               '2026-11-12');

INSERT INTO feedbacks (id_hospedagem, nota, comentario, data_avaliacao) VALUES
(1, 5, 'Funcionários muito educados.',     '2026-07-05'),
(2, 5, 'Experiência fantástica no spa.',   '2026-07-16'),
(3, 4, 'Quarto confortável e limpo.',      '2026-08-04'),
(4, 3, 'Internet um pouco instável.',      '2026-09-09'),
(5, 5, 'Tudo perfeito, recomendo muito!',  '2026-10-14');