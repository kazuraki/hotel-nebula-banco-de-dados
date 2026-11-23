-- Hotel Nebula - Criação do banco
DROP DATABASE IF EXISTS hotel_nebula;
CREATE DATABASE hotel_nebula;
USE hotel_nebula;

CREATE TABLE hospedes (
    id_hospede      INT AUTO_INCREMENT PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    email           VARCHAR(100) UNIQUE NOT NULL,
    cpf             VARCHAR(14) UNIQUE,
    telefone        VARCHAR(20),
    data_nascimento DATE,
    cidade          VARCHAR(80)
);

CREATE TABLE quartos (
    id_quarto    INT AUTO_INCREMENT PRIMARY KEY,
    numero       VARCHAR(10) UNIQUE NOT NULL,
    tipo         VARCHAR(50) NOT NULL,
    capacidade   INT,
    preco_diaria DECIMAL(10,2) NOT NULL,
    status       VARCHAR(20) DEFAULT 'Disponível'
);

CREATE TABLE funcionarios (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    cargo          VARCHAR(50),
    telefone       VARCHAR(20)
);

CREATE TABLE reservas (
    id_reserva    INT AUTO_INCREMENT PRIMARY KEY,
    id_hospede    INT NOT NULL,
    id_quarto     INT NOT NULL,
    data_checkin  DATE NOT NULL,
    data_checkout DATE NOT NULL,
    status        VARCHAR(20) DEFAULT 'Confirmada',  -- Confirmada, Concluída, Cancelada
    FOREIGN KEY (id_hospede) REFERENCES hospedes(id_hospede),
    FOREIGN KEY (id_quarto)  REFERENCES quartos(id_quarto),
    CHECK (data_checkout > data_checkin)
);

CREATE TABLE hospedagens (
    id_hospedagem  INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva     INT UNIQUE NOT NULL,
    id_funcionario INT NOT NULL,       -- quem atendeu o hóspede
    checkin_real   DATETIME,
    checkout_real  DATETIME,           -- NULL = ainda hospedado
    FOREIGN KEY (id_reserva)     REFERENCES reservas(id_reserva),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

CREATE TABLE pagamentos (
    id_pagamento   INT AUTO_INCREMENT PRIMARY KEY,
    id_hospedagem  INT NOT NULL,
    valor          DECIMAL(10,2) NOT NULL,
    metodo         VARCHAR(30),
    data_pagamento DATE,
    FOREIGN KEY (id_hospedagem) REFERENCES hospedagens(id_hospedagem)
);

CREATE TABLE servicos (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome       VARCHAR(100) NOT NULL,
    descricao  VARCHAR(255),
    preco      DECIMAL(10,2) NOT NULL
);

-- Tabela de associação: uma hospedagem pode ter vários serviços
-- e um serviço pode estar em várias hospedagens (N:N)
CREATE TABLE hospedagem_servicos (
    id_hospedagem_servico INT AUTO_INCREMENT PRIMARY KEY,
    id_hospedagem         INT NOT NULL,
    id_servico            INT NOT NULL,
    quantidade            INT NOT NULL DEFAULT 1,
    data_consumo          DATE,
    FOREIGN KEY (id_hospedagem) REFERENCES hospedagens(id_hospedagem),
    FOREIGN KEY (id_servico)    REFERENCES servicos(id_servico)
);

-- Cada hospedagem pode ter uma avaliação.
-- O hóspede e o quarto são descobertos pela hospedagem -> reserva.
CREATE TABLE feedbacks (
    id_feedback    INT AUTO_INCREMENT PRIMARY KEY,
    id_hospedagem  INT UNIQUE NOT NULL,
    nota           INT NOT NULL,
    comentario     VARCHAR(255),
    data_avaliacao DATE,
    FOREIGN KEY (id_hospedagem) REFERENCES hospedagens(id_hospedagem),
    CHECK (nota BETWEEN 1 AND 5)
);