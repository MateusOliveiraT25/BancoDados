CREATE DATABASE sa4_db;
-- Ex.1  
--DDL (Data Definition Language) 
--Crie uma tabela chamada "Clientes" com os seguintes campos: ID (chave primária), Nome, Sobrenome, e Email.
CREATE TABLE IF NOT EXISTS Clientes (
    ID SERIAL PRIMARY KEY, -- SERIAL para autoincremento no PostgreSQL, INT AUTO_INCREMENT no MySQL
    Nome VARCHAR(255) NOT NULL,
    Sobrenome VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL
);
--Adicione uma restrição para garantir que o campo "Email" na tabela "Clientes" seja único.
ALTER TABLE Clientes
ADD CONSTRAINT Email_Unique UNIQUE (Email);
--Crie uma tabela chamada "Pedidos" com os seguintes campos: ID (chave primária), ID_Cliente (chave estrangeira referenciando a tabela "Clientes"), Data_Pedido, e Total.
CREATE TABLE IF NOT EXISTS Pedidos (
    ID SERIAL PRIMARY KEY,
    ID_Cliente INT NOT NULL,
    Data_Pedido DATE NOT NULL,
    Total DECIMAL(10, 2) NOT NULL, -- Supondo que Total é um valor monetário com até 10 dígitos, incluindo 2 casas decimais
    CONSTRAINT fk_ID_Cliente FOREIGN KEY (ID_Cliente)
        REFERENCES Clientes (ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
--Defina uma restrição de chave estrangeira na tabela "Pedidos" para garantir que o campo "ID_Cliente" referencie um cliente existente na tabela "Clientes".
ALTER TABLE Pedidos
ADD CONSTRAINT fk_pedidos_clientes FOREIGN KEY (ID_Cliente)
REFERENCES Clientes(ID)
ON DELETE CASCADE
ON UPDATE CASCADE;
--Modifique a estrutura da tabela "Pedidos" para adicionar um campo "Status" para indicar se o pedido está "Em andamento", "Finalizado" ou "Cancelado".
ALTER TABLE Pedidos
ADD Status VARCHAR(20) NOT NULL,
ADD CONSTRAINT CHK_Status CHECK (Status IN ('Em andamento', 'Finalizado', 'Cancelado'));
-- DML (Data Manipulation Language) Exercícios:
-- Insira três novos clientes na tabela "Clientes".
INSERT INTO Clientes (Nome, Sobrenome, Email)
VALUES
('João', 'Silva', 'joao.silva@example.com'),
('Maria', 'Souza', 'maria.souza@example.com'),
('Pedro', 'Ferreira', 'pedro.ferreira@example.com');
-- Insira cinco novos registros de pedidos na tabela "Pedidos", associando-os a diferentes clientes.
INSERT INTO Pedidos (ID_Cliente, Data_Pedido, Total, Status)
VALUES
(1, '2024-04-07', 100, 'Em andamento'),
(2, '2024-04-08', 150, 'Cancelado'),
(3, '2024-04-09', 200, 'Em andamento'),
(1, '2024-04-10', 120, 'Finalizado'),
(2, '2024-02-11', 180, 'Em andamento');
--Atualize o campo "Total" de um pedido específico na tabela "Pedidos".
UPDATE Pedidos
SET Total = 900
WHERE ID = 1;
--Exclua um cliente da tabela "Clientes" e seus respectivos pedidos na tabela "Pedidos".
BEGIN TRANSACTION;

-- Excluir pedidos do cliente
DELETE FROM Pedidos
WHERE ID_Cliente = 1;

-- Excluir cliente
DELETE FROM Clientes
WHERE ID = 1;

COMMIT;
--Selecione todos os pedidos com status "Em andamento" na tabela "Pedidos".
SELECT *
FROM Pedidos
WHERE Status = 'Em andamento';
--Liste o nome do cliente, a data do pedido e o total de cada pedido feito nos últimos 30 dias.
SELECT 
    c.Nome AS Nome_Cliente, 
    p.Data_Pedido, 
    p.Total
FROM 
    Pedidos p
JOIN 
    Clientes c ON p.ID_Cliente = c.ID
WHERE 
    p.Data_Pedido >= CURRENT_DATE - INTERVAL '30 days';
--Ex.2 
--DDL (Data Definition Language) 
--Crie uma tabela chamada "Produtos" com os seguintes campos: ID (chave primária), Nome, Descrição e Preço.
CREATE TABLE Produtos (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10, 2) NOT NULL
);
--Adicione uma restrição para garantir que o campo "Preço" na tabela "Produtos" seja positivo.
ALTER TABLE Produtos
ADD CONSTRAINT preco_positivo CHECK (Preco > 0);
--Crie uma tabela de junção chamada "Pedidos_Produtos" para registrar os produtos associados a cada pedido, contendo os campos:
-- ID_Pedido (chave estrangeira referenciando a tabela "Pedidos") e ID_Produto (chave estrangeira referenciando a tabela "Produtos").
CREATE TABLE Pedidos_Produtos (
    ID_Pedido INT,
    ID_Produto INT,
    PRIMARY KEY (ID_Pedido, ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID)
);
--Defina uma restrição de chave composta na tabela "Pedidos_Produtos" utilizando os campos "ID_Pedido" e "ID_Produto".
ALTER TABLE Pedidos_Produtos
ADD CONSTRAINT pk_pedidos_produtos PRIMARY KEY (ID_Pedido, ID_Produto);
--Adicione um índice na coluna "Nome" da tabela "Produtos" para otimizar consultas por nome do produto.
CREATE INDEX idx_nome_produtos ON Produtos(Nome);
--Crie uma tabela chamada "Categorias" com os campos: ID (chave primária) e Nome.
CREATE TABLE Categorias (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL
);
--Defina uma relação mutua entre as tabelas "Produtos" e "Categorias" utilizando uma tabela de junção chamada "Produtos_Categorias", que contenha os campos
-- ID_Produto (chave estrangeira referenciando "Produtos") e ID_Categoria (chave estrangeira referenciando "Categorias").
CREATE TABLE Produtos_Categorias (
    ID_Produto INT NOT NULL,
    ID_Categoria INT NOT NULL,
    PRIMARY KEY (ID_Produto, ID_Categoria),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID)
);
--Crie uma tabela chamada "Funcionários" com os campos: ID (chave primária), Nome, Sobrenome e Cargo.
CREATE TABLE Funcionarios (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Sobrenome VARCHAR(255) NOT NULL,
    Cargo VARCHAR(255) NOT NULL
);
--Adicione uma restrição de verificação na tabela "Funcionários" para garantir que o campo "Cargo" contenha apenas valores válidos 
--(por exemplo, "Gerente", "Vendedor", "Atendente").
ALTER TABLE Funcionarios
ADD CONSTRAINT chk_cargo_valido CHECK (Cargo IN ('Gerente', 'Vendedor', 'Atendente'));
--DML (Data Manipulation Language)
--Insira cinco novos produtos na tabela "Produtos".
INSERT INTO Produtos (Nome, Descricao, Preco)
VALUES
('Camiseta', 'Camiseta de algodão', 29.99),
('Calça Jeans', 'Calça jeans masculina', 59.99),
('Tênis Esportivo', 'Tênis para corrida', 99.99),
('Mochila', 'Mochila escolar', 39.99),
('Óculos de Sol', 'Óculos de sol estilo aviador', 49.99);
--Insira cinco novas Categorias na tabela "Categorias".
INSERT INTO Categorias (Nome)
VALUES
('Eletrônicos'),
('Roupas'),
('Calçados'),
('Acessórios'),
('Esportes');
--Associe alguns produtos aos pedidos na tabela "Pedidos_Produtos".
INSERT INTO Pedidos_Produtos (ID_Pedido, ID_Produto)
VALUES
(4, 5), -- Produto 1 associado ao Pedido 1
(7, 2), -- Produto 2 associado ao Pedido 1
(4, 3), -- Produto 3 associado ao Pedido 2
(5, 4); -- Produto 4 associado ao Pedido 2
--Atualize o preço de um produto específico na tabela "Produtos".
UPDATE Produtos
SET Preco = 39.99
WHERE ID = 1;
--Exclua um produto da tabela "Produtos" e todos os registros correspondentes na tabela "Pedidos_Produtos".
BEGIN;
-- Exclua os registros na tabela "Pedidos_Produtos" correspondentes ao produto
DELETE FROM Pedidos_Produtos
WHERE ID_Produto = 1;
-- Exclua o produto da tabela "Produtos"
DELETE FROM Produtos
WHERE ID = 1;
COMMIT;
--Selecione todos os produtos de uma categoria específica na tabela "Produtos_Categorias".
SELECT p.*
FROM Produtos p
JOIN Produtos_Categorias pc ON p.ID = pc.ID_Produto
WHERE pc.ID_Categoria = 3;
--Liste todos os funcionários e seus cargos na tabela "Funcionários".
SELECT Nome, Sobrenome, Cargo
FROM Funcionarios;
--Atualize o cargo de um funcionário na tabela "Funcionários".
INSERT INTO Funcionarios (Nome, Sobrenome, Cargo)
VALUES
('João', 'Silva', 'Vendedor'),
('Maria', 'Santos', 'Atendente'),
('Pedro', 'Almeida', 'Gerente'),
('Ana', 'Furlan', 'Vendedor'),
('Carlos', 'Ferreira', 'Atendente');
UPDATE Funcionarios
SET Cargo = 'Gerente'
WHERE ID = 1;
--Exclua um funcionário da tabela "Funcionários".
DELETE FROM Funcionarios WHERE ID = 3;
--Selecione todos os pedidos.
SELECT * FROM Pedidos;
--Liste os cinco produtos mais caros da tabela "Produtos".
SELECT * FROM Produtos ORDER BY Preco DESC LIMIT 5;
--Calcule o valor total de todos os pedidos na tabela "Pedidos".
SELECT SUM(Total) AS ValorTotal FROM Pedidos;
--Liste todos os clientes que fizeram pelo menos um pedido cancelado.
SELECT DISTINCT c.*
FROM Clientes c
JOIN Pedidos p ON c.ID = p.ID_Cliente
WHERE p.Status = 'Cancelado';
--Atualize o status de todos os pedidos para "Finalizado" onde a data do pedido for anterior a uma determinada data.
UPDATE Pedidos SET Status = 'Finalizado' WHERE Data_Pedido < '2024-04-08';
--Exclua todos os pedidos finalizados há mais de um ano.
DELETE FROM Pedidos WHERE Status = 'Finalizado' AND Data_Pedido < CURRENT_DATE - INTERVAL '1 year';
--Selecione os clientes que fizeram mais de dois pedidos nos últimos três meses.
SELECT ID_Cliente, COUNT(*) AS TotalPedidos
FROM Pedidos
WHERE Data_Pedido >= CURRENT_DATE - INTERVAL '3 months'
GROUP BY ID_Cliente
HAVING COUNT(*) > 2;
--Liste os pedidos agrupados por status e ordene-os pela data do pedido.
SELECT ID, Status, Data_Pedido
FROM Pedidos
ORDER BY Status, Data_Pedido;
--Atualize o status de todos os pedidos com mais de 30 dias para "Atrasado".
UPDATE Pedidos SET Status = 'Atrasado' WHERE Data_Pedido < CURRENT_DATE - INTERVAL '30 days';
--Calcule o total de vendas por categoria de produto.
SELECT c.Nome AS Categoria, SUM(p.Preco) AS TotalVendas
FROM Produtos_Categorias pc
JOIN Produtos p ON pc.ID_Produto = p.ID
JOIN Categorias c ON pc.ID_Categoria = c.ID
JOIN Pedidos_Produtos pp ON p.ID = pp.ID_Produto
JOIN Pedidos pe ON pp.ID_Pedido = pe.ID
WHERE pe.Status = 'Finalizado'
GROUP BY c.Nome;
--Liste os produtos que nunca foram associados a nenhum pedido na tabela "Pedidos_Produtos".




