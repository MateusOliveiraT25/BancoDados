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
    NOME VARCHAR(255) NOT NULL,
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

INSERT INTO contatos (id_contato, nome, email, cell, pizza, cadastro) VALUES
(1, 'João Silva', 'joao@example.com', '(11) 91234-5678', 'Mussarela', '2024-05-25'),
(2, 'Maria Sousa', 'maria@example.com', '(21) 98765-4321', 'Calabresa', '2024-05-25'),
(3, 'Carlos Lima', 'carlos@example.com', '(31) 99876-5432', 'Portuguesa', '2024-05-25');

INSERT INTO entregas (id_entregas, nome, email, cel, pizza, cadastro, entrega) VALUES
(1, 'Ana Costa', 'ana@example.com', '(11) 99876-5432', 'Margherita', '2024-05-25', 'Em Andamento'),
(2, 'Pedro Santos', 'pedro@example.com', '(21) 98765-4321', 'Frango com Catupiry', '2024-05-25', 'Finalizada'),
(3, 'Luiza Oliveira', 'luiza@example.com', '(31) 91234-5678', 'Quatro Queijos', '2024-05-25', 'Em Andamento');

INSERT INTO status_pizzas (id_status, id_contato, status_producao, status_entrega) VALUES
(1, 1, 'Pronta', 'Em Andamento'),
(2, 2, 'Em Preparo', 'Finalizada'),
(3, 3, 'Pronta', 'Em Andamento');

INSERT INTO funcionarios (id_funcionarios, nome, atribuicoes, areas_trabalho) VALUES
(1, 'Marcos Silva', 'Pizzaiolo', 'Cozinha'),
(2, 'Ana Santos', 'Entregadora', 'Entrega'),
(3, 'Pedro Lima', 'Atendente', 'Atendimento');

INSERT INTO pizzas (id_pizza, nome, tamanho, preco, ingredientes) VALUES
(1, 'Mussarela', 'Grande', 30.00, 'Queijo, Molho de Tomate, Orégano'),
(2, 'Calabresa', 'Média', 25.00, 'Calabresa, Queijo, Molho de Tomate'),
(3, 'Portuguesa', 'Grande', 35.00, 'Presunto, Ovo, Cebola, Pimentão, Azeitona, Queijo, Molho de Tomate');

INSERT INTO pedido (id_pedido, id_entregas, id_contato, id_pizza, data_pedido) VALUES
(1, 1, 1, 1, '2024-05-25'),
(2, 2, 2, 2, '2024-05-25'),
(3, 3, 3, 3, '2024-05-25');


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
    pedido.id_pedido,
    pizzas.nome AS nome_pizza,
    pizzas.preco AS preco_pizza,
    pizzas.ingredientes
FROM 
    pedido
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
SELECT 
    pedido.id_pedido,
    status_pizzas.status_producao,
    status_pizzas.status_entrega,
    funcionarios.nome AS nome_funcionario
FROM 
    pedido
LEFT JOIN 
    status_pizzas ON pedido.id_status = status_pizzas.id_status
LEFT JOIN 
    funcionarios ON pedido.id_funcionario = funcionarios.id_funcionario;
--5. Listar todos os clientes com seus pedidos realizados. Consulta para exibir os clientes e todos os pedidos que eles fizeram.
SELECT 
    contatos.nome AS nome_cliente,
    pedido.id_pedido,
    pedido.data_pedido
FROM 
    contatos
INNER JOIN 
    pedido ON contatos.id_contato = pedido.id_contato;
--6. Listar todas as pizzas disponíveis com seus respectivos ingredientes. Consulta para mostrar todas as pizzas disponíveis e seus ingredientes.
SELECT 
    nome,
    ingredientes
FROM 
    pizzas;
--7. Listar todos os pedidos com detalhes de entrega. Consulta para mostrar os pedidos com detalhes de entrega.
SELECT 
    pedido.id_pedido,
    entregas.NOME AS nome_cliente,
    entregas.EMAIL AS email_cliente,
    entregas.CEL AS celular_cliente,
    entregas.PIZZA AS pizza,
    pedido.data_pedido,
    entregas.SITUACAO AS situacao_entrega
FROM 
    pedido
INNER JOIN 
    entregas ON pedido.id_entregas = entregas.ID_ENTREGAS;
--8. Listar todos os funcionários com seus respectivos supervisores. Consulta para exibir os funcionários e seus supervisores.
SELECT 
    f1.nome AS nome_funcionario,
    f2.nome AS nome_supervisor
FROM 
    funcionarios AS f1
LEFT JOIN 
    funcionarios AS f2 ON f1.id_supervisor = f2.id_funcionario;