Essas consultas devem ser realizadas utilizando INNER JOIN, JOIN, LEFT JOIN e
RIGHT JOIN para mostrar diferentes tipos de relacionamentos entre tabelas em uma
pizzaria.

-- ex1

SELECT 
    pedido.id_pedido,
    contatos.nome AS nome_cliente,
    contatos.email AS email_cliente,
    contatos.cel AS celular_cliente,
    pedido.data_pedido
FROM 
    pedido
INNER JOIN 
    contatos ON pedido.id_contato = contatos.id_contato;

-- ex2

SELECT 
    pedido.id_pedido,
    pizzas.nome AS nome_pizza,
    pizzas.preco AS preco_pizza,
    pizzas.ingredientes
FROM 
    pedido
INNER JOIN 
    pizzas ON pedido.id_pizza = pizzas.id_pizza;

-- ex3

SELECT 
    funcionarios.id_funcionario,
    funcionarios.nome AS nome_funcionario,
    atribuicoes AS atribuicao,
    areas_trabalho AS area_trabalho
FROM 
    funcionarios


--ex4

SELECT 
    pedido.id_pedido,
    pedido.data_pedido,
    status_pizzas.status_producao,
    status_pizzas.status_entrega
FROM 
    pedido
JOIN 
    status_pizzas ON pedido.id_pedido = status_pizzas.id_pedido;


--ex5

SELECT 
    contatos.nome AS nome_cliente,
    pedido.id_pedido,
    pedido.data_pedido
FROM 
    contatos
INNER JOIN 
    pedido ON contatos.id_contato = pedido.id_contato;


--ex6

SELECT 
    nome,
    ingredientes
FROM 
    pizzas;

--ex7

SELECT 
    pedido.id_pedido,
    pedido.data_pedido,
    entregas.nome AS nome_entrega,
    entregas.email AS email_entrega,
    entregas.cel AS celular_entrega,
    entregas.pizza AS pizza_entrega,
    entregas.cadastro AS data_entrega,
    entregas.situacao AS situacao_entrega
FROM 
    pedido
JOIN 
    entregas ON pedido.id_entrega = entregas.id_entrega;

--ex8

SELECT 
    f1.nome AS funcionario,
    f2.nome AS supervisor
FROM 
    funcionarios AS f1
LEFT JOIN 
    funcionarios AS f2 ON f1.id_supervisor = f2.id_funcionario;


--ex9

SELECT 
    pedido.id_pedido,
    pedido.id_entrega,
    pedido.id_contato,
    pedido.id_pizza,
    pedido.data_pedido,
    pizzas.nome AS nome_pizza,
    pizzas.preco AS preco_pizza
FROM 
    pedido
JOIN
    pizzas ON pedido.id_pizza = pizzas.id_pizza;


--ex10

SELECT p.nome AS pizza, 
       p.preco AS preco_pizza, 
       pr.nome_promocao AS promocao, 
       pr.descricao AS descricao_promocao, 
       pr.desconto AS desconto_promocao, 
       pr.data_inicio AS inicio_promocao, 
       pr.data_fim AS fim_promocao
FROM pizzas p
LEFT JOIN promocoes pr ON p.id_pizza = pr.id_pizza;



Segunda Parte (Consultas com comandos SQL básicos)

--ex1

SELECT DISTINCT c.nome, c.email, c.cel
FROM contatos c
JOIN pedido p ON c.id_contato = p.id_contato;

--ex2

SELECT *
FROM pedido
WHERE data_pedido BETWEEN '2024-04-24' AND '2024-05-24';

--ex3

SELECT p.nome AS item_pedido, p.preco
FROM pedido pd
JOIN pizzas p ON pd.id_pizza = p.id_pizza
WHERE pd.id_pedido = 3;

--ex4

SELECT c.nome AS cliente, SUM(p.preco) AS total_gasto
FROM contatos c
JOIN pedido pd ON c.id_contato = pd.id_contato
JOIN pizzas p ON pd.id_pizza = p.id_pizza
GROUP BY c.nome;

--ex5

SELECT p.nome AS sabor_pizza, COUNT(*) AS total_pedidos
FROM pedido pd
JOIN pizzas p ON pd.id_pizza = p.id_pizza
GROUP BY p.nome
ORDER BY COUNT(*) DESC;

--ex6

SELECT *
FROM pizzas
WHERE nome = 'Marguerita';

--ex7

SELECT *
FROM funcionarios;

--ex8

SELECT *
FROM horario_funcionamento;

--ex9

SELECT *
FROM entregas
WHERE situacao = 'Em Andamento';

--ex10

SELECT AVG(EXTRACT(EPOCH FROM CURRENT_TIMESTAMP - data_pedido) / 60) AS tempo_medio_espera_minutos
FROM pedido;
