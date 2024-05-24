CREATE DATABASE sa05_db;
--DROP DATABASE sa05_db;
--DDL (Data Definition Language) Exercício:
--1 Tabela "Clientes"
--Campos: ID (chave primária), Nome, Sobrenome, Email.
CREATE TABLE IF NOT EXISTS Clientes (
    ID SERIAL PRIMARY KEY, -- SERIAL para autoincremento no PostgreSQL, INT AUTO_INCREMENT no MySQL
    Nome VARCHAR(255) NOT NULL,
    Sobrenome VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL
);
--Restrições: Garantir que o campo "Email" seja único.
ALTER TABLE Clientes
ADD CONSTRAINT Email_Unique UNIQUE (Email);
--2 Tabela "Pedidos"
--Campos: ID (chave primária), ID_Cliente (chave estrangeira referenciando a tabela "Clientes"), Data_Pedido, Total.
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
--Restrições: Definir uma restrição de chave estrangeira na tabela "Pedidos" para garantir integridade referencial com a tabela "Clientes".
ALTER TABLE Pedidos
ADD CONSTRAINT fk_pedidos_clientes FOREIGN KEY (ID_Cliente)
REFERENCES Clientes(ID)
ON DELETE CASCADE
ON UPDATE CASCADE;
--3 Tabela "Produtos"
--Campos: ID (chave primária), Nome, Descrição, Preço.
CREATE TABLE IF NOT EXISTS Produtos (
    ID SERIAL PRIMARY KEY, -- SERIAL para autoincremento no PostgreSQL, INT AUTO_INCREMENT no MySQL
   Nome VARCHAR(255) NOT NULL,
    Descricao VARCHAR(255) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL
);
--Restrições: Adicionar uma restrição para garantir que o campo "Preço" seja positivo.
ALTER TABLE Produtos
ADD CONSTRAINT preco_positivo CHECK (Preco > 0);
--4 Tabela "Categorias"
--Campos: ID (chave primária), Nome.
CREATE TABLE Categorias (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL
);
--5 Tabela "Pedidos_Produtos" (Tabela de junção)
--Campos: ID_Pedido (chave estrangeira referenciando a tabela "Pedidos"), ID_Produto (chave estrangeira referenciando a tabela "Produtos").
--Restrições: Definir uma restrição de chave composta utilizando os campos "ID_Pedido" e "ID_Produto".
CREATE TABLE Pedidos_Produtos (
    ID_Pedido INT,
    ID_Produto INT,
    PRIMARY KEY ( ID_Pedido,  ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID)
);

--6 Tabela "Produtos_Categorias" (Tabela de junção)
--Campos: ID_Produto (chave estrangeira referenciando a tabela "Produtos"), ID_Categoria (chave estrangeira referenciando a tabela "Categorias").
--Restrições: Definir uma restrição de chave composta utilizando os campos "ID_Pedido" e "ID_Categoria".
CREATE TABLE Produtos_Categorias (
    ID_Produto INT NOT NULL,
    ID_Categoria INT NOT NULL,
    PRIMARY KEY (ID_Produto, ID_Categoria),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID)
);
--7 Tabela "Empregados"
--Campos: ID (chave primária), Nome, Sobrenome, Cargo.
CREATE TABLE Empregados (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Sobrenome VARCHAR(255) NOT NULL,
    Cargo VARCHAR(255) NOT NULL
);
--Restrições: Adicionar uma restrição de verificação para garantir que o campo "Cargo" contenha apenas valores válidos (por exemplo, "Gerente", "Vendedor", "Atendente").
ALTER TABLE Empregados
ADD CONSTRAINT chk_cargo_valido CHECK (Cargo IN ('Gerente', 'Vendedor', 'Atendente'));
--8 Tabela "Vendas"
--Campos: ID (chave primária), ID_Produto (chave estrangeira referenciando a tabela "Produtos"), ID_Cliente (chave estrangeira referenciando a tabela "Clientes"), Data_Venda, Quantidade.
--Restrições: Definir restrições de chave estrangeira para garantir integridade referencial com as tabelas "Produtos" e "Clientes".
CREATE TABLE IF NOT EXISTS Vendas (
    ID INT PRIMARY KEY,
    ID_Produto INT NOT NULL,
    ID_Cliente INT NOT NULL,
    Data_Venda DATE NOT NULL,
    Quantidade DECIMAL(10, 2), -- nº total de 10 dígitos, dos quais 2 são reservados para a parte decimal
    CONSTRAINT fk_vendas_produtos FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    CONSTRAINT fk_vendas_clientes FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID)
);
--9 Alteração de Tabelas:
--Adicione uma coluna chamada "Telefone" à tabela "Clientes" para armazenar o número de telefone dos clientes.
ALTER TABLE Clientes
ADD COLUMN Telefone VARCHAR(20);
--Modifique a coluna "Descrição" da tabela "Produtos" para permitir valores nulos.
ALTER TABLE Produtos ALTER COLUMN Descricao DROP NOT NULL;
--Remova a restrição de chave estrangeira que referencia a tabela "Clientes" na tabela "Pedidos".
ALTER TABLE Pedidos
DROP CONSTRAINT fk_pedidos_clientes;
--Renomeie a tabela "Empregados" para "Funcionários".
ALTER TABLE Empregados RENAME to Funcionarios;
--DML (Data Manipulation Language) Exercício:
-- 1 Insira cinco novos clientes na tabela "Clientes".
INSERT INTO Clientes (Nome, Sobrenome, Email)
VALUES
('João', 'Silva', 'joao.silva@example.com'),
('Maria', 'Souza', 'maria.souza@example.com'),
('Jessica', 'Gomes', 'jessica.gomes@example.com'),
('Mike', 'Faria', 'mike.faria@example.com'),
('Pedro', 'Ferreira', 'pedro.ferreira@example.com');
-- 2 Insira dez novos registros de pedidos na tabela "Pedidos", associando-os a diferentes clientes.
ALTER TABLE Pedidos
ADD Status VARCHAR(20) NOT NULL,
ADD CONSTRAINT CHK_Status CHECK (Status IN ('Em andamento', 'Finalizado', 'Cancelado'));

INSERT INTO Pedidos (ID_Cliente, Data_Pedido, Total, Status)
VALUES
(1, '2024-02-07', 100, 'Em andamento' ),
(2, '2024-04-08', 150 , 'Em andamento'),
(4, '2024-02-14', 200 , 'Em andamento'),
(1, '2024-03-10', 120 , 'Em andamento'),
(2, '2024-01-29', 180, 'Finalizado' ),
(5, '2024-01-29', 300, 'Cancelado'),
(3, '2024-04-14', 200, 'Cancelado'),
(1, '2024-03-10', 89, 'Finalizado'),
(5, '2024-01-29', 180, 'Finalizado');
--3 Insira quinze novos produtos na tabela "Produtos".
INSERT INTO Produtos (Nome, Descricao, Preco)
VALUES
('Camiseta Branca', 'Camiseta de algodão', 58.99),
('Calça Jeans Preta ', 'Calça jeans masculina', 75.99),
('Tênis Esportivo Branco', 'Tênis para corrida', 120.99),
('Mochila', 'Mochila escolar', 39.99),
('Óculos de Sol', 'Óculos de sol estilo aviador', 89.99),
('Camiseta Preta', 'Camiseta de algodão', 29.99),
('Calça Jeans Azul', 'Calça jeans Femenina', 59.99),
('Tênis Casual', 'Tênis para passeio', 99.99),
('Mochila', 'Mochila', 25.99),
('Óculos de Sol', 'Óculos de sol estilo piloto', 75.99),
('Camiseta Verde', 'Camiseta de algodão', 29.99),
('Calça Jeans Azul', 'Calça jeans masculina', 59.99),
('Tênis Esportivo', 'Tênis para corrida', 99.99),
('Mochila', 'Mochila escolar', 39.99),
('Óculos de Sol', 'Óculos de sol estilo aviador', 49.99);
--4 Associe 3 produtos aos pedidos na tabela "Pedidos_Produtos".
INSERT INTO Pedidos_Produtos (ID_Pedido, ID_Produto)
VALUES
(4, 5), -- Produto 1 associado ao Pedido 1
(2, 2), -- Produto 2 associado ao Pedido 1
(1, 3); -- Produto 3 associado ao Pedido 2
--5 Associe 3 produtos às categorias na tabela "Produtos_Categorias".
INSERT INTO Categorias (Nome)
VALUES
('Eletrônicos'),
('Roupas'),
('Calçados'),
('Acessórios'),
('Esportes');
INSERT INTO Produtos_Categorias (ID_Produto, ID_Categoria)
VALUES
(4, 5), -- Produto 1 associado ao Pedido 1
(2, 2), -- Produto 2 associado ao Pedido 1
(1, 3);
--6 Insira cinco registros de funcionários na tabela "Funcionários".
INSERT INTO Funcionarios (Nome, Sobrenome, Cargo)
VALUES
('João', 'Silva', 'Vendedor'),
('Maria', 'Santos', 'Atendente'),
('Pedro', 'Almeida', 'Gerente'),
('Ana', 'Furlan', 'Vendedor'),
('Carlos', 'Ferreira', 'Atendente');
--7 Registre algumas vendas na tabela "Vendas", associando produtos a clientes.
INSERT INTO Vendas (ID,ID_Produto, ID_Cliente, Data_Venda, Quantidade)
VALUES
(1,1, 2,'2024-02-07', 25), -- Produto 1 associado ao Pedido 1
(2,3, 2,'2024-03-25', 10); -- Produto 1 associado ao Pedido 1
--8 Atualize o preço de um produto específico na tabela "Produtos".
UPDATE Produtos
SET Preco = 48.99
WHERE ID = 1;
--9 Atualize o cargo de um funcionário na tabela "Funcionários".
UPDATE Funcionarios
SET Cargo = 'Gerente'
WHERE ID = 1;
--10 Exclua um cliente da tabela "Clientes" e seus respectivos pedidos na tabela "Pedidos".
DELETE FROM Pedidos
WHERE ID_Cliente = 3;
-- Excluir cliente
DELETE FROM Clientes
WHERE ID = 3;
--11 Exclua um produto da tabela "Produtos" e seus registros correspondentes na tabela "Pedidos_Produtos".
BEGIN;
-- Exclua os registros na tabela "Pedidos_Produtos" correspondentes ao produto
DELETE FROM Pedidos_Produtos
WHERE ID_Produto = 4;
-- Exclua o produto da tabela "Produtos_Categorias"
DELETE FROM Produtos_Categorias
WHERE ID_Produto = 4;
-- Exclua o produto da tabela "Produtos"
DELETE FROM Produtos
WHERE ID = 4;
COMMIT;
--12 Exclua um funcionário da tabela "Funcionários".
DELETE FROM Funcionarios WHERE ID = 3;
--13 Selecione todos os pedidos com status "Em andamento" na tabela "Pedidos".
SELECT *
FROM Pedidos
WHERE Status = 'Em andamento';
--14 Liste o nome do cliente, a data do pedido e o total de cada pedido feito nos últimos 30 dias na tabela "Pedidos".(não precisa usar Join)
SELECT 
    c.Nome AS Nome_Cliente, 
    p.Data_Pedido, 
    p.Total
FROM 
    Pedidos p
-- Junta a tabela Pedidos com a tabela Clientes usando o ID_Cliente
JOIN 
    Clientes c ON p.ID_Cliente = c.ID
-- Filtra apenas os pedidos feitos nos últimos 30 dias
WHERE 
    p.Data_Pedido >= CURRENT_DATE - 30;
--15 Liste todos os produtos de uma categoria específica na tabela "Produtos_Categorias".(não precisa usar join)
SELECT *
FROM Produtos
WHERE ID in (SELECT ID_Produto FROM Produtos_Categorias  WHERE ID_Categoria = 2); -- certo JOIN
