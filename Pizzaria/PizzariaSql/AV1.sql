Create Database pizzaria;

CREATE TABLE IF NOT EXISTS contatos (
    id_contato INT NOT NULL PRIMARY KEY,
    nome VARCHAR(225) NOT NULL,
    email VARCHAR(225) NOT NULL,
    cell VARCHAR(225) NOT NULL,
    pizza VARCHAR(225) NOT NULL,
    cadastro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ENTREGAS (
    ID_ENTREGAS INT NOT NULL PRIMARY KEY,
    NOME VARCHAR(255) NOT NULL,
    EMAIL VARCHAR(255) NOT NULL,
    CEL VARCHAR(255) NOT NULL,
    PIZZA VARCHAR(255) NOT NULL,
    CADASTRO DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ENTREGA VARCHAR(255) NOT NULL CHECK (ENTREGA IN ('Em Andamento', 'Finalizada')) 
);


CREATE TABLE IF NOT EXISTS status_pizzas (
    id_status INT NOT NULL PRIMARY KEY,
    id_contato INT NOT NULL,
    status_producao VARCHAR(100) NOT NULL,
    status_entrega VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_contato) REFERENCES contatos(id_contato)
);

CREATE TABLE IF NOT EXISTS funcionarios (
    id_funcionarios INT NOT NULL PRIMARY KEY,
    atribuicoes VARCHAR(255) NOT NULL,
    areas_trabalho VARCHAR(255) NOT NULL
);


CREATE TABLE IF NOT EXISTS pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_entregas INT NOT NULL,
    id_contato INT NOT NULL,
    id_pizza INT NOT NULL,
    data_pedido DATE NOT NULL,
    CONSTRAINT fk_id_entregas FOREIGN KEY (id_entregas) REFERENCES entregas (id_entregas),
    CONSTRAINT fk_id_contato FOREIGN KEY (id_contato) REFERENCES contatos (id_contato),
    CONSTRAINT fk_id_pizza FOREIGN KEY (id_pizza) REFERENCES pizzas (id_pizza)
);

CREATE TABLE IF NOT EXISTS pizzas (
    id_pizza SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    tamanho VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    ingredientes TEXT NOT NULL
);

DROP TABLE IF EXISTS contatos;

INSERT INTO contatos (id_contato, nome, email, cell, pizza, cadastro) VALUES

SELECT * from contatos

SELECT * FROM contatos ORDER BY id_contato OFFSET :offset 1 :1

SELECT COUNT(*) FROM contatos

alter TABLE contatos
COLUMN id_contato rename to id

SELECT * FROM contatos WHERE id_contato = ?



--1. Listar todos os pedidos com detalhes do cliente. Consulta para obter informações sobre os pedidos e os clientes que os fizeram.
SELECT 
    pedido.id_pedido,
    pedido.data_pedido,
    contatos.nome AS nome_cliente,
    contatos.email AS email_cliente,
    contatos.cell AS telefone_cliente
    FROM 
    pedido
INNER JOIN 
    contatos ON pedido.id_contato = contatos.id_contato
 --2. Listar todos os itens de pedidos com detalhes da pizza. Consulta para mostrar os itens de pedidos e os detalhes das pizzas associadas a eles.
SELECT 
 pizzas.nome AS nome_pizza,
    pizzas.tamanho AS tamanho_pizza,
    pizzas.preco AS preco_pizza,
    pizzas.ingredientes AS ingredientes_pizza,
   INNER JOIN 
    pizzas ON pedido.id_pizza = pizzas.id_pizza;
--3. Listar todos os funcionários com suas respectivas atribuições. Consulta para mostrar os funcionários e as áreas em que estão trabalhando.
SELECT 
    id_funcionarios AS id_funcionario,
    atribuicoes AS atribuicao,
    areas_trabalho AS area_trabalho
FROM 
    funcionarios;
--4. Listar todos os pedidos com status e funcionários responsáveis. Consulta para mostrar os pedidos, seus status e os funcionários responsáveis pelo atendimento.

  