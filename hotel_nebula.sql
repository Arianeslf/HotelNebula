CREATE DATABASE IF NOT EXISTS hotel_nebula;
USE hotel_nebula;


CREATE TABLE hospede (
    cpf VARCHAR(11) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    telefone VARCHAR(20)
);

CREATE TABLE quarto (
    id_quarto INT AUTO_INCREMENT PRIMARY KEY,
    numero INT NOT NULL,
    tipo VARCHAR(50) NOT NULL
);

CREATE TABLE reserva (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(11) NOT NULL,
    id_quarto INT NOT NULL,
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    FOREIGN KEY (cpf) REFERENCES hospede(cpf),
    FOREIGN KEY (id_quarto) REFERENCES quarto(id_quarto)
);

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pagamento DATE NOT NULL,
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva)
);

CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    salario DECIMAL(10,2)
);

CREATE TABLE hospedagem (
    id_hospedagem INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_checkin_real DATE,
    data_checkout_real DATE,
    status VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva),
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE avaliacao (
    id_avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(11) NOT NULL,
    id_hospedagem INT NOT NULL,
    nota INT NOT NULL,
    comentario VARCHAR(255),
    data_avaliacao DATE NOT NULL,
    FOREIGN KEY (cpf) REFERENCES hospede(cpf),
    FOREIGN KEY (id_hospedagem) REFERENCES hospedagem(id_hospedagem),
    CHECK (nota >= 1 AND nota <= 5)
);


CREATE TABLE servico_extra (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    nome_servico VARCHAR(100) NOT NULL,
    valor DECIMAL(10,2) NOT NULL
);

CREATE TABLE consumo_servico (
    id_consumo INT AUTO_INCREMENT PRIMARY KEY,
    id_hospedagem INT NOT NULL,
    id_servico INT NOT NULL,
    quantidade INT NOT NULL,
    data_consumo DATE NOT NULL,
    FOREIGN KEY (id_hospedagem) REFERENCES hospedagem(id_hospedagem),
    FOREIGN KEY (id_servico) REFERENCES servico_extra(id_servico)
);


-- INSERÇÃO DE DADOS


INSERT INTO hospede (cpf, nome, email, telefone) VALUES
('11111111111', 'Mariana Souza', 'mariana@email.com', '11999991111'),
('22222222222', 'Carlos Lima', 'carlos@email.com', '11999992222'),
('33333333333', 'Ana Beatriz', 'ana@email.com', '11999993333'),
('44444444444', 'Joao Pedro', 'joao@email.com', '11999994444'),
('55555555555', 'Luiza Fernandes', 'luiza@email.com', '11999995555');

INSERT INTO quarto (numero, tipo) VALUES
(101, 'Solteiro'),
(102, 'Casal'),
(201, 'Luxo'),
(202, 'Familia'),
(301, 'Suite Master');

INSERT INTO funcionario (nome_funcionario, cargo, salario) VALUES
('Fernanda Alves', 'Recepcionista', 2500.00),
('Roberto Silva', 'Gerente', 5000.00),
('Camila Rocha', 'Atendente', 2300.00),
('Lucas Martins', 'Recepcionista', 2400.00);

INSERT INTO reserva (cpf, id_quarto, data_checkin, data_checkout) VALUES
('11111111111', 1, '2026-06-01', '2026-06-05'),
('22222222222', 2, '2026-06-10', '2026-06-12'),
('33333333333', 3, '2026-06-15', '2026-06-20'),
('44444444444', 4, '2026-07-01', '2026-07-04'),
('11111111111', 5, '2026-07-10', '2026-07-15'),
('55555555555', 2, '2026-07-20', '2026-07-25');

INSERT INTO pagamento (id_reserva, valor, data_pagamento) VALUES
(1, 720.00, '2026-06-05'),
(2, 500.00, '2026-06-10'),
(3, 2100.00, '2026-06-15'),
(4, 1050.00, '2026-07-01'),
(5, 3000.00, '2026-07-10');

INSERT INTO hospedagem (id_reserva, id_funcionario, data_checkin_real, data_checkout_real, status) VALUES
(1, 1, '2026-06-01', '2026-06-05', 'finalizada'),
(2, 3, '2026-06-10', '2026-06-12', 'finalizada'),
(3, 1, NULL, NULL, 'cancelada'),
(4, 4, '2026-07-01', '2026-07-04', 'finalizada'),
(5, 2, '2026-07-10', NULL, 'em andamento');

INSERT INTO avaliacao (cpf, id_hospedagem, nota, comentario, data_avaliacao) VALUES
('11111111111', 1, 5, 'Otima hospedagem e atendimento excelente.', '2026-06-05'),
('22222222222', 2, 4, 'Quarto confortavel e boa recepcao.', '2026-06-12'),
('44444444444', 4, 5, 'Gostei bastante do quarto e da limpeza.', '2026-07-04');

INSERT INTO servico_extra (nome_servico, valor) VALUES
('Cafe da manha', 35.00),
('Lavanderia', 50.00),
('Estacionamento', 40.00),
('Servico de quarto', 60.00),
('Spa', 120.00);

INSERT INTO consumo_servico (id_hospedagem, id_servico, quantidade, data_consumo) VALUES
(1, 1, 4, '2026-06-02'),
(1, 3, 4, '2026-06-02'),
(2, 1, 2, '2026-06-11'),
(2, 4, 1, '2026-06-11'),
(4, 5, 1, '2026-07-02'),
(5, 1, 3, '2026-07-11');


-- CONSULTAS SQL

SELECT q.id_quarto, q.numero, q.tipo
FROM quarto q
WHERE q.id_quarto NOT IN (
    SELECT r.id_quarto
    FROM reserva r
    JOIN hospedagem h ON r.id_reserva = h.id_reserva
    WHERE h.status <> 'cancelada'
    AND '2026-06-10' < r.data_checkout
    AND '2026-06-12' > r.data_checkin
);


SELECT 
    h.nome,
    COUNT(r.id_reserva) AS total_reservas
FROM hospede h
JOIN reserva r ON h.cpf = r.cpf
GROUP BY h.cpf, h.nome
ORDER BY total_reservas DESC;


SELECT
    YEAR(data_pagamento) AS ano,
    MONTH(data_pagamento) AS mes,
    SUM(valor) AS faturamento_total
FROM pagamento
GROUP BY YEAR(data_pagamento), MONTH(data_pagamento)
ORDER BY ano, mes;


SELECT
    s.nome_servico,
    SUM(c.quantidade) AS total_consumido
FROM servico_extra s
JOIN consumo_servico c ON s.id_servico = c.id_servico
GROUP BY s.id_servico, s.nome_servico
ORDER BY total_consumido DESC;


SELECT
    q.numero AS numero_quarto,
    q.tipo,
    AVG(a.nota) AS media_avaliacao
FROM avaliacao a
JOIN hospedagem h ON a.id_hospedagem = h.id_hospedagem
JOIN reserva r ON h.id_reserva = r.id_reserva
JOIN quarto q ON r.id_quarto = q.id_quarto
GROUP BY q.id_quarto, q.numero, q.tipo
ORDER BY media_avaliacao DESC;


SELECT
    r.id_reserva,
    hp.nome AS hospede,
    q.numero AS quarto,
    h.status
FROM hospedagem h
JOIN reserva r ON h.id_reserva = r.id_reserva
JOIN hospede hp ON r.cpf = hp.cpf
JOIN quarto q ON r.id_quarto = q.id_quarto
WHERE h.status = 'cancelada';


SELECT
    f.nome_funcionario,
    f.cargo,
    COUNT(h.id_hospedagem) AS total_hospedagens
FROM funcionario f
LEFT JOIN hospedagem h ON f.id_funcionario = h.id_funcionario
GROUP BY f.id_funcionario, f.nome_funcionario, f.cargo
ORDER BY total_hospedagens DESC;


SELECT
    r.id_reserva,
    h.nome AS hospede,
    q.numero AS quarto,
    q.tipo,
    r.data_checkin,
    r.data_checkout
FROM reserva r
JOIN hospede h ON r.cpf = h.cpf
JOIN quarto q ON r.id_quarto = q.id_quarto
ORDER BY r.data_checkin;


SELECT
    hs.id_hospedagem,
    hp.nome AS hospede,
    SUM(cs.quantidade * se.valor) AS total_servicos
FROM hospedagem hs
JOIN reserva r ON hs.id_reserva = r.id_reserva
JOIN hospede hp ON r.cpf = hp.cpf
JOIN consumo_servico cs ON hs.id_hospedagem = cs.id_hospedagem
JOIN servico_extra se ON cs.id_servico = se.id_servico
GROUP BY hs.id_hospedagem, hp.nome
ORDER BY total_servicos DESC;
