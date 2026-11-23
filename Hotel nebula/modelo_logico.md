# Hotel Nebula — Modelo Lógico (Completo)

> Este modelo representa a estrutura final e completa do banco de dados do **Hotel Nebula**, contendo todas as tabelas, colunas, tipos de dados e relacionamentos definidos.

---

## Tabelas

### hospedes
| Coluna           | Tipo           | Restrições         |
|------------------|----------------|--------------------|
| id_hospede       | INT            | PK, AUTO_INCREMENT |
| nome             | VARCHAR(100)   | NOT NULL           |
| email            | VARCHAR(100)   | UNIQUE, NOT NULL   |
| cpf              | VARCHAR(14)    | UNIQUE             |
| telefone         | VARCHAR(20)    |                    |
| data_nascimento  | DATE           |                    |
| cidade           | VARCHAR(80)    |                    |

---

### quartos
| Coluna       | Tipo           | Restrições          |
|--------------|----------------|---------------------|
| id_quarto    | INT            | PK, AUTO_INCREMENT  |
| numero       | VARCHAR(10)    | UNIQUE, NOT NULL    |
| tipo         | VARCHAR(50)    | NOT NULL            |
| capacidade   | INT            |                     |
| preco_diaria | DECIMAL(10,2)  | NOT NULL            |
| status       | VARCHAR(20)    | DEFAULT 'Disponível'|

---

### funcionarios
| Coluna          | Tipo         | Restrições         |
|-----------------|--------------|--------------------|
| id_funcionario  | INT          | PK, AUTO_INCREMENT |
| nome            | VARCHAR(100) | NOT NULL           |
| cargo           | VARCHAR(50)  |                    |
| telefone        | VARCHAR(20)  |                    |

---

### reservas
| Coluna         | Tipo          | Restrições          |
|----------------|---------------|---------------------|
| id_reserva     | INT           | PK, AUTO_INCREMENT  |
| id_hospede     | INT           | FK → hospedes       |
| id_quarto      | INT           | FK → quartos        |
| data_checkin   | DATE          | NOT NULL            |
| data_checkout  | DATE          | NOT NULL            |
| status         | VARCHAR(20)   | DEFAULT 'Confirmada'|

---

### hospedagens
| Coluna            | Tipo      | Restrições            |
|-------------------|-----------|-----------------------|
| id_hospedagem     | INT       | PK, AUTO_INCREMENT    |
| id_reserva        | INT       | UNIQUE, FK → reservas |
| id_funcionario    | INT       | FK → funcionarios     |
| checkin_real      | DATETIME  |                       |
| checkout_real     | DATETIME  |                       |

---

### pagamentos
| Coluna         | Tipo          | Restrições           |
|----------------|---------------|----------------------|
| id_pagamento   | INT           | PK, AUTO_INCREMENT   |
| id_hospedagem  | INT           | FK → hospedagens     |
| valor          | DECIMAL(10,2) | NOT NULL             |
| metodo         | VARCHAR(30)   |                      |
| data_pagamento | DATE          |                      |

---

### servicos
| Coluna     | Tipo          | Restrições         |
|------------|---------------|--------------------|
| id_servico | INT           | PK, AUTO_INCREMENT |
| nome       | VARCHAR(100)  | NOT NULL           |
| descricao  | VARCHAR(255)  |                    |
| preco      | DECIMAL(10,2) | NOT NULL           |

---

### hospedagem_servicos (Tabela Associativa N:N)
| Coluna                | Tipo | Restrições          |
|-----------------------|------|---------------------|
| id_hospedagem_servico | INT  | PK, AUTO_INCREMENT  |
| id_hospedagem         | INT  | FK → hospedagens    |
| id_servico            | INT  | FK → servicos       |
| quantidade            | INT  | NOT NULL, DEFAULT 1 |
| data_consumo          | DATE |                     |

---

### feedbacks
| Coluna         | Tipo         | Restrições               |
|----------------|--------------|--------------------------|
| id_feedback    | INT          | PK, AUTO_INCREMENT       |
| id_hospedagem  | INT          | UNIQUE, FK → hospedagens |
| nota           | INT          | NOT NULL, CHECK (1-5)    |
| comentario     | VARCHAR(255) |                          |
| data_avaliacao | DATE         |                          |

---

## Relacionamentos Implementados

```text
hospedes            ||--o{ reservas              : "faz"
quartos             ||--o{ reservas              : "recebe"
reservas            ||--|| hospedagens           : "gera"
funcionarios        ||--o{ hospedagens           : "atende"
hospedagens         ||--o{ pagamentos            : "gera"
hospedagens         ||--o{ hospedagem_servicos   : "associa"
servicos            ||--o{ hospedagem_servicos   : "compõe"
hospedagens         ||--o| feedbacks             : "recebe"