# Hotel Nebula - Projeto de Banco de Dados

Projeto de banco de dados para organizar e analisar as informações operacionais e gerenciais do **Hotel Nebula**: hóspedes, quartos, reservas, hospedagens, pagamentos, funcionários, serviços e avaliações.

## Arquivos

- `README.md`: documentação completa do projeto (Modelo Lógico, Regras e Consultas)
- `01_criacao_banco.sql`: criação do banco `hotel_nebula`, tabelas, chaves e restrições
- `02_insercao_dados.sql`: inserção da massa de dados fictícios para testes
- `03_consultas.sql`: consultas SQL analíticas e gerenciais

Para executar (MySQL 8.0.16 ou superior), rode os scripts na seguinte ordem: `01`, `02` e `03`.

---

### Entidades

| Entidade | O que representa |
|---|---|
| `hospedes` | Clientes cadastrados no hotel (dados pessoais e cidade) |
| `quartos` | Acomodações disponíveis, com número, tipo, capacidade, diária e status |
| `reservas` | Agendamentos de quartos feitos por hóspedes, com datas previstas e status |
| `hospedagens` | Estadias reais efetivadas no momento do check-in |
| `pagamentos` | Registros financeiros vinculados a cada hospedagem |
| `funcionarios` | Equipe do hotel (recepcionistas, gerentes) responsável pelos atendimentos |
| `servicos` | Serviços extras oferecidos (café da manhã, spa, lavanderia, transfer, etc.) |
| `hospedagem_servicos` | Tabela associativa que registra os serviços consumidos em cada estadia |
| `feedbacks` | Avaliações (nota de 1 a 5 e comentários) registradas após a hospedagem |

### Relacionamentos

| Relacionamento | Tipo | Como ficou no banco |
|---|---|---|
| Hóspede faz reservas | 1:N | `reservas.id_hospede` |
| Quarto recebe reservas | 1:N | `reservas.id_quarto` |
| Reserva gera hospedagem | 1:1 | `hospedagens.id_reserva` |
| Funcionário atende hospedagens | 1:N | `hospedagens.id_funcionario` |
| Hospedagem gera pagamentos | 1:N | `pagamentos.id_hospedagem` |
| Hospedagem consome serviços | N:N | tabela `hospedagem_servicos` |
| Hospedagem recebe feedback | 1:1 | `feedbacks.id_hospedagem` |

O feedback é vinculado diretamente à hospedagem porque, através da cadeia (`hospedagem → reserva → hóspede e quarto`), é possível rastrear quem avaliou e qual quarto foi utilizado sem duplicar dados, garantindo que apenas estadias reais sejam avaliadas.

### Regras de Negócio

1. Toda reserva pertence a um hóspede e a um quarto, exigindo que a data de check-out seja posterior à de check-in.
2. Um quarto não pode possuir duas reservas ativas (não canceladas) com datas sobrepostas.
3. Quartos com status `Manutenção` ficam bloqueados para novas reservas.
4. Uma reserva gera no máximo uma hospedagem (efetivada no check-in).
5. Uma hospedagem pode acumular múltiplos pagamentos e diversos consumos de serviços extras.
6. Cada hospedagem é vinculada a um funcionário responsável e pode receber no máximo uma avaliação (nota de 1 a 5).
7. Enquanto o campo `checkout_real` estiver `NULL`, considera-se que o hóspede ainda está hospedado no hotel.

---

## Parte 1 - Implementação e Dados

Estrutura implementada no script `01_criacao_banco.sql` e populada em `02_insercao_dados.sql`:

- **Tabelas completas:** 9 tabelas estruturadas, incluindo a tabela associativa `hospedagem_servicos` para resolver o relacionamento N:N entre estadias e serviços.
- **Integridade e Restrições:** Uso de `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE` (e-mail, CPF, número do quarto), `NOT NULL`, `DEFAULT` (`Disponível`, `Confirmada`, quantidade `1`) e validações `CHECK` (`data_checkout > data_checkin` e `nota BETWEEN 1 AND 5`).
- **Tipos de Dados:** `DECIMAL(10,2)` para valores monetários, `DATE` para datas de reserva/pagamento e `DATETIME` para registros exatos de check-in e check-out.
- **Massa de Dados (`02_insercao_dados.sql`):** Contém 5 hóspedes (de diferentes capitais), 5 quartos (Standard, Luxo, Suíte e Suíte Presidencial), 3 funcionários, 5 tipos de serviços, 9 reservas (incluindo concluídas, ativas, futuras e canceladas), 6 hospedagens, 8 registros de consumo de serviços, 6 pagamentos e 5 feedbacks.

---

## Parte 2 - Consultas Gerenciais (`03_consultas.sql`)

O arquivo de consultas foi estruturado para responder às seguintes perguntas de negócio do Hotel Nebula:

| # | Pergunta / Análise |
|---|---|
| 1 | Faturamento total gerado por cada tipo de quarto |
| 2 | Tempo médio de estadia (em dias) das reservas concluídas |
| 3 | Hóspedes que mais gastaram com serviços extras |
| 4 | Quartos que nunca tiveram reservas registradas |
| 5 | Métodos de pagamento mais utilizados e valor total arrecadado por cada um |
| 6 | Média das avaliações (notas) recebidas por cada funcionário no atendimento |
| 7 | Detalhamento completo das hospedagens ativas no momento (hóspede, quarto e atendente) |