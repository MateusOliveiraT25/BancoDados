 CREATE DATABASE sa4_ex2_bd;


-- Criar tabela "Produtos" para armazenar informações sobre os produtos
CREATE TABLE IF NOT EXISTS Produtos (
    ID SERIAL PRIMARY KEY, -- Chave primária autoincrementada
    Nome VARCHAR(255),
    Descricao TEXT,
    Preco DECIMAL(10, 2)
);

-- Adicionar restrição para garantir que o preço do produto seja positivo
ALTER TABLE Produtos
ADD CONSTRAINT Preco_Positive CHECK (Preco > 0);

CREATE TABLE IF NOT EXISTS Pedidos (
    ID SERIAL PRIMARY KEY, -- Chave primária autoincrementada
    Data DATE,
    Valor DECIMAL(10, 2),
    Status VARCHAR(50)
);


-- Criar tabela "Pedidos_Produtos" para associar produtos a pedidos
CREATE TABLE IF NOT EXISTS Pedidos_Produtos (
    ID_Pedido INT,
    ID_Produto INT,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    PRIMARY KEY (ID_Pedido, ID_Produto) -- Definindo uma chave primária composta
);

-- Adicionar restrição para garantir que não haja pedidos duplicados
ALTER TABLE Pedidos_Produtos
ADD CONSTRAINT unique_pedido_produto UNIQUE (ID_Pedido, ID_Produto);

-- Criar índice na coluna "Nome" da tabela "Produtos" para otimizar consultas por nome do produto
CREATE INDEX idx_nome_produto ON Produtos (Nome);

-- Criar tabela "Categorias" para armazenar informações sobre as categorias de produtos
CREATE TABLE IF NOT EXISTS Categorias (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL
);

-- Criar tabela "Produtos_Categorias" para associar produtos a categorias
CREATE TABLE IF NOT EXISTS Produtos_Categorias (
    ID_Produto INT,
    ID_Categoria INT,
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID),
    PRIMARY KEY (ID_Produto, ID_Categoria) -- Definindo uma chave primária composta
);

-- Criar tabela "Funcionários" para armazenar informações sobre os funcionários
CREATE TABLE IF NOT EXISTS Funcionários (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    Sobrenome VARCHAR(255),
    Cargo VARCHAR(255)
);

-- Adicionar restrição para garantir que o cargo do funcionário seja válido
ALTER TABLE Funcionários
ADD CONSTRAINT ck_cargo_valido CHECK (Cargo IN ('Gerente', 'Vendedor', 'Atendente'));

-- Inserir dados na tabela "Funcionários"
INSERT INTO Funcionários (Nome, Sobrenome, Cargo) VALUES
('João', 'Silva', 'Vendedor'),
('Maria', 'Santos', 'Atendente'),
('Pedro', 'Almeida', 'Gerente');

-- Inserir dados na tabela "Produtos"
INSERT INTO Produtos (Nome, Descricao, Preco) VALUES
('Camiseta', 'Camiseta básica de algodão', 25.00),
('Calça Jeans', 'Calça jeans masculina', 50.00),
('Tênis', 'Tênis esportivo', 80.00),
('Bermuda', 'Bermuda de praia', 30.00),
('Boné', 'Boné de baseball', 15.00);

-- Inserir dados na tabela "Categorias"
INSERT INTO Categorias (Nome) VALUES
('Roupas'),
('Calçados'),
('Acessórios');

-- Inserir dados na tabela "Pedidos_Produtos"
INSERT INTO Pedidos_Produtos (ID_Pedido, ID_Produto) VALUES
(1, 1),  -- Associando o Produto 1 ao Pedido 1
(2, 2),  -- Associando o Produto 2 ao Pedido 2
(3, 3),  -- Associando o Produto 3 ao Pedido 3
(4, 4),  -- Associando o Produto 4 ao Pedido 4
(5, 5);  -- Associando o Produto 5 ao Pedido 5

-- Inserir dados na tabela "Produtos_Categorias"
INSERT INTO Produtos_Categorias (ID_Produto, ID_Categoria) VALUES
(1, 2),
(2, 2),
(3, 1),
(4, 3),
(5, 2);

-- Atualizar o preço de um produto específico na tabela "Produtos"
UPDATE Produtos
SET Preco = 30.00
WHERE ID = 1;

-- Excluir registros correspondentes na tabela "Pedidos_Produtos"
DELETE FROM Pedidos_Produtos WHERE ID_Produto = 1;

-- Excluir o produto da tabela "Produtos"
DELETE FROM Produtos WHERE ID = 1;

-- Selecionar os produtos de uma categoria específica
SELECT p.*
FROM Produtos p
JOIN Produtos_Categorias pc ON p.ID = pc.ID_Produto
JOIN Categorias c ON pc.ID_Categoria = c.ID
WHERE c.ID = 1;

-- Selecionar todos os funcionários e seus cargos
SELECT Nome, Cargo
FROM Funcionários;

-- Atualizar o cargo de um funcionário na tabela "Funcionários"
UPDATE Funcionários
SET Cargo = 'Gerente'
WHERE ID = 1;

-- Excluir um funcionário da tabela "Funcionários"
DELETE FROM Funcionários
WHERE ID = 1;

-- Selecionar todos os pedidos
SELECT *
FROM Pedidos;

-- Selecionar os cinco produtos mais caros
SELECT *
FROM Produtos
ORDER BY Preco DESC
LIMIT 5;

-- Calcular o valor total de todos os pedidos
SELECT SUM(Total) AS Valor_Total_Pedidos
FROM Pedidos;

-- Selecionar os clientes que fizeram pelo menos um pedido cancelado
SELECT DISTINCT c.*
FROM Clientes c
JOIN Pedidos p ON c.ID = p.ID_Cliente
WHERE p.Status = 'Cancelado';

-- Atualizar o status de todos os pedidos para "Finalizado" onde a data do pedido for anterior a uma determinada data
UPDATE Pedidos
SET Status = 'Finalizado'
WHERE Data_Pedido < '2024-04-01';

-- Excluir todos os pedidos finalizados há mais de um ano
DELETE FROM Pedidos
WHERE Status = 'Finalizado' 
AND Data_Pedido < CURRENT_DATE - INTERVAL '1 year';

-- Selecionar os clientes que fizeram mais de dois pedidos nos últimos três meses
SELECT c.*
FROM Clientes c
JOIN (
    SELECT ID_Cliente, COUNT(*) AS num_pedidos
    FROM Pedidos
    WHERE Data_Pedido >= CURRENT_DATE - INTERVAL '3 months'
    GROUP BY ID_Cliente
    HAVING COUNT(*) > 2
) p ON c.ID = p.ID_Cliente;

-- Selecionar os pedidos agrupados por status e ordenados pela data do pedido
SELECT *
FROM Pedidos
ORDER BY Status, Data_Pedido;

-- Atualizar o status de todos os pedidos com mais de 30 dias para "Atrasado"
UPDATE Pedidos
SET Status = 'Atrasado'
WHERE Data_Pedido < CURRENT_DATE -  30;

-- Calcular o total de vendas por categoria de produto
SELECT c.Nome AS Categoria, SUM(p.Total) AS Total_Vendas
FROM Pedidos_Produtos pp
JOIN Produtos_Categorias pc ON pp.ID_Produto = pc.ID_Produto
JOIN Categorias c ON pc.ID_Categoria = c.ID
JOIN Pedidos p ON pp.ID_Pedido = p.ID
GROUP BY c.Nome;

-- Selecionar os produtos que nunca foram associados a nenhum pedido
SELECT *
FROM Produtos
WHERE ID NOT IN (SELECT DISTINCT ID_Produto FROM Pedidos_Produtos);