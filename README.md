# Hotel Nebula

Projeto de banco de dados desenvolvido para organizar os dados da rede de hotéis Hotel Nebula.

## Sobre o projeto

O Hotel Nebula está expandindo suas operações e precisa organizar digitalmente seus dados para melhorar o controle de reservas, hospedagens, pagamentos, quartos, funcionários, avaliações e serviços extras.

O banco de dados foi criado com base no diagrama ER do projeto e também nas regras solicitadas pelo professor.

## Objetivo geral

Desenvolver um projeto de banco de dados passando pelas etapas de compreensão do problema, modelagem dos dados, implementação do banco, inserção de dados para testes e extração de informações com consultas SQL.

## Entidades principais

- Hóspede
- Quarto
- Reserva
- Pagamento
- Hospedagem
- Funcionário
- Avaliação
- Serviço Extra
- Consumo de Serviço

## Relacionamentos

Um hóspede pode realizar várias reservas.

Uma reserva pertence a um hóspede e a um quarto.

Uma reserva pode gerar pagamento.

Uma reserva pode gerar hospedagem.

Uma hospedagem é atendida por um funcionário.

Uma hospedagem pode receber avaliação.

Uma hospedagem pode consumir serviços extras.

## Estrutura do repositório

```txt
README.md
hotel_nebula.sql
```

## Arquivo SQL

O arquivo `hotel_nebula.sql` contém:

- criação do banco de dados;
- criação das tabelas;
- definição de chaves primárias e estrangeiras;
- inserção de dados iniciais;
- consultas SQL para análise dos dados.

## Consultas criadas

- quartos disponíveis em determinado período;
- hóspedes que mais realizaram reservas;
- faturamento por mês;
- serviços extras mais consumidos;
- quartos com melhores avaliações;
- reservas canceladas;
- quantidade de hospedagens atendidas por funcionário.

## Tecnologias utilizadas

- SQL
- MySQL
- GitHub
- Draw.io
