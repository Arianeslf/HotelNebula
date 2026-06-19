# Hotel Nébula

Este projeto apresenta a modelagem e implementação de um banco de dados para um sistema de gerenciamento hoteleiro.

O objetivo é organizar informações sobre hóspedes, quartos, reservas, hospedagens, pagamentos, funcionários e avaliações.

## 📌 Objetivo do Projeto

Desenvolver um banco de dados capaz de controlar as principais operações de um hotel, permitindo registrar reservas, acompanhar hospedagens, gerenciar pagamentos e armazenar avaliações feitas pelos clientes.

## 🧩 Entidades

### HÓSPEDE

Armazena as informações dos clientes do hotel.

- `cpf` **PK**
- `nome`
- `email`
- `telefone`

### QUARTO

Representa os quartos disponíveis no hotel.

- `id_quarto` **PK**
- `numero`
- `tipo`
- `status`
- `valor_diaria`

### RESERVA

Registra as reservas realizadas pelos hóspedes.

- `id_reserva` **PK**
- `cpf` **FK**
- `id_quarto` **FK**
- `data_reserva`
- `data_checkin`
- `data_checkout`
- `status`

### HOSPEDAGEM

Representa a estadia real do hóspede no hotel.

- `id_hospedagem` **PK**
- `id_reserva` **FK**
- `id_funcionario` **FK**
- `data_checkin_real`
- `data_checkout_real`
- `status`

### PAGAMENTO

Registra os pagamentos relacionados às reservas.

- `id_pagamento` **PK**
- `id_reserva` **FK**
- `valor`
- `forma_pagamento`
- `data_pagamento`
- `status_pagamento`

### FUNCIONÁRIO

Armazena os dados dos funcionários do hotel.

- `id_funcionario` **PK**
- `nome_funcionario`
- `cargo`
- `salario`

### AVALIAÇÃO

Armazena as avaliações feitas pelos hóspedes após a hospedagem.

- `id_avaliacao` **PK**
- `cpf` **FK**
- `id_hospedagem` **FK**
- `nota`
- `comentario`
- `data_avaliacao`

## 🔗 Relacionamentos

- Um hóspede pode realizar várias reservas.
- Uma reserva pertence a apenas um hóspede.
- Um quarto pode estar presente em várias reservas.
- Uma reserva está relacionada a apenas um quarto.
- Uma reserva pode gerar uma hospedagem.
- Uma hospedagem está associada a uma única reserva.
- Uma reserva pode ter um ou mais pagamentos.
- Um pagamento pertence a uma única reserva.
- Um funcionário pode atender várias hospedagens.
- Uma hospedagem é atendida por um único funcionário.
- Uma hospedagem pode receber uma avaliação.
- Uma avaliação pertence a uma única hospedagem.
- Um hóspede pode fazer várias avaliações.

## 🛠️ Tecnologias Utilizadas

- SQL
- MySQL
- Modelagem de Banco de Dados
- Modelo Entidade-Relacionamento
- Normalização de Dados

## 📂 Estrutura do Projeto

O projeto contém os arquivos principais para criação e teste do banco de dados:

- `script_hotel_nebula.sql`  
  Arquivo com a criação do banco, tabelas, chaves primárias, chaves estrangeiras e dados de exemplo.

- `README.md`  
  Documento explicando o objetivo do projeto, entidades e relacionamentos.

## ▶️ Como Executar

1. Abra o MySQL Workbench ou outro ambiente SQL.
2. Importe ou abra o arquivo `script_hotel_nebula.sql`.
3. Execute o script completo.
4. Verifique se as tabelas foram criadas corretamente.
5. Execute os comandos `SELECT` para visualizar os dados cadastrados.

## ✅ Consultas de Teste

Exemplo de consulta para listar reservas com nome do hóspede e quarto:

```sql
SELECT 
    r.id_reserva,
    h.nome AS hospede,
    q.numero AS quarto,
    r.data_checkin,
    r.data_checkout,
    r.status
FROM reserva r
JOIN hospede h ON r.cpf = h.cpf
JOIN quarto q ON r.id_quarto = q.id_quarto;
