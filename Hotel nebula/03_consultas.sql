-- Hotel Nebula - Consultas Complementares
USE hotel_nebula;

-- 1) Faturamento total gerado por cada tipo de quarto
SELECT q.tipo, SUM(p.valor) AS faturamento_total
FROM pagamentos p
JOIN hospedagens hg ON hg.id_hospedagem = p.id_hospedagem
JOIN reservas r     ON r.id_reserva = hg.id_reserva
JOIN quartos q      ON q.id_quarto = r.id_quarto
GROUP BY q.tipo
ORDER BY faturamento_total DESC;

-- 2) Tempo médio de estadia (em dias) das reservas concluídas
SELECT ROUND(AVG(DATEDIFF(r.data_checkout, r.data_checkin)), 1) AS media_dias_estadia
FROM reservas r
WHERE r.status = 'Concluída';

-- 3) Hóspedes que mais gastaram com serviços extras
SELECT h.nome, SUM(s.preco * hs.quantidade) AS total_gasto_servicos
FROM hospedes h
JOIN reservas r       ON r.id_hospede = h.id_hospede
JOIN hospedagens hg   ON hg.id_reserva = r.id_reserva
JOIN hospedagem_servicos hs ON hs.id_hospedagem = hg.id_hospedagem
JOIN servicos s       ON s.id_servico = hs.id_servico
GROUP BY h.id_hospede, h.nome
ORDER BY total_gasto_servicos DESC;

-- 4) Quartos que nunca tiveram reservas (ou que nunca foram reservados)
SELECT q.numero, q.tipo, q.preco_diaria
FROM quartos q
WHERE q.id_quarto NOT IN (
    SELECT DISTINCT id_quarto FROM reservas
);

-- 5) Métodos de pagamento mais utilizados e valor total arrecadado por cada um
SELECT metodo, COUNT(*) AS quantidade_usos, SUM(valor) AS valor_total
FROM pagamentos
GROUP BY metodo
ORDER BY valor_total DESC;

-- 6) Média das avaliações (notas) recebidas por cada funcionário no atendimento
SELECT f.nome AS funcionario, f.cargo, ROUND(AVG(fb.nota), 2) AS media_notas
FROM funcionarios f
JOIN hospedagens hg ON hg.id_funcionario = f.id_funcionario
JOIN feedbacks fb   ON fb.id_hospedagem = hg.id_hospedagem
GROUP BY f.id_funcionario, f.nome, f.cargo
ORDER BY media_notas DESC;

-- 7) Detalhamento completo das hospedagens ativas no momento (com hóspede, quarto e funcionário)
SELECT hg.id_hospedagem, h.nome AS hospede, q.numero AS quarto, 
       f.nome AS atendente, hg.checkin_real
FROM hospedagens hg
JOIN reservas r     ON r.id_reserva = hg.id_reserva
JOIN hospedes h     ON h.id_hospede = r.id_hospede
JOIN quartos q      ON q.id_quarto = r.id_quarto
JOIN funcionarios f ON f.id_funcionario = hg.id_funcionario
WHERE hg.checkout_real IS NULL;