CREATE DATABASE sa5_matheus_bd;

CREATE TABLE Clientes (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

-- Tabela "Pedidos"
CREATE TABLE Pedidos (
    ID SERIAL PRIMARY KEY,
    ID_Cliente INT,
    Data_Pedido DATE,
    Total NUMERIC(10, 2),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID) 
);

-- Criar a tabela "Pedidos" sem a coluna "Status"
CREATE TABLE Pedidos (
    ID SERIAL PRIMARY KEY,
    ID_Cliente INT,
    Data_Pedido DATE,
    Total NUMERIC(10, 2),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID)
);

-- Adicionar a coluna "Status" à tabela "Pedidos"
ALTER TABLE Pedidos
ADD COLUMN Status VARCHAR(50) DEFAULT 'Andamento' CHECK (Status IN ('Andamento', 'Finalizado', 'Cancelado'));

-- Tabela "Categorias"
CREATE TABLE Categorias (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(100)
);

-- Tabela "Pedidos_Produtos" (Tabela de junção)
CREATE TABLE Pedidos_Produtos (
    ID_Pedido INT,
    ID_Produto INT,
    PRIMARY KEY (ID_Pedido, ID_Produto),
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID)
);

-- Tabela "Produtos_Categorias" (Tabela de junção)
CREATE TABLE Produtos_Categorias (
    ID_Produto INT,
    ID_Categoria INT,
    PRIMARY KEY (ID_Produto, ID_Categoria),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID)
);

-- Tabela "Funcionários" (anteriormente "Empregados")
CREATE TABLE Empregados (
    ID SERIAL PRIMARY KEY,
    Nome VARCHAR(50),
    Sobrenome VARCHAR(50),
    Cargo VARCHAR(50) CHECK (Cargo IN ('Gerente', 'Vendedor', 'Atendente'))
);

-- Tabela "Vendas"
CREATE TABLE Vendas (
    ID SERIAL PRIMARY KEY,
    ID_Produto INT,
    ID_Cliente INT,
    Data_Venda DATE,
    Quantidade INT,
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID)
);

-- Alteração de Tabelas
ALTER TABLE Clientes ADD COLUMN Telefone VARCHAR(20);
ALTER TABLE Produtos ALTER COLUMN Descrição DROP NOT NULL;
ALTER TABLE Pedidos DROP CONSTRAINT Pedidos_ID_Cliente_fkey;
ALTER TABLE Empregados RENAME TO Funcionarios;


-- Inserção de alguns registros na tabela "Clientes".
INSERT INTO Clientes (Nome, Sobrenome, Email, Telefone) VALUES
('João', 'Silva', 'joao@gmail.com', 19988349087),
('Maria', 'Santos', 'maria@gmail.com', 17975345789),
('Pedro', 'Almeida', 'pedro@gmail.com', 14981234568),
('Nicolas', 'Pereira', 'pereira@gmail.com', 11974332478),
('Cornélio', 'Cabral', 'cabral@gmail.com', 12987345678);

-- Inserção de alguns registros na tabela "Pedidos", associados a clientes existentes.
INSERT INTO Pedidos (ID_Cliente, Data_Pedido, Total, Status) VALUES
(1, '2022-03-05', 35.00, 'Andamento'),
(1, '2023-04-06', 150.00, 'Andamento'),
(3, '2020-01-09', 80.00, 'Finalizado'),
(5, '2021-07-25', 200.00, 'Finalizado'),
(4, '2019-03-11', 120.00, 'Cancelado'),
(1, '2024-04-05', 300.00, 'Andamento'),
(4, '2022-08-16', 1000.00, 'Cancelado'),
(3, '2018-10-07', 90.00, 'Andamento'),
(5, '2024-04-08', 700.00, 'Finalizado'),
(4, '2024-04-09', 120.00, 'Cancelado');


-- Inserir dados na tabela "Produtos"
INSERT INTO Produtos (Nome, Descrição, Preço) VALUES
('Camisa', 'Camiseta básica de algodão', 25.00),
('Calça Jeans', 'Calça jeans masculina', 50.00),
('Tênis', 'Tênis esportivo', 80.00),
('Bermuda', 'Bermuda de praia', 30.00),
('Boné', 'Boné de baseball', 15.00),
('Console', 'Playstation 5',3500.00 ),
('Pc Gamer', 'Pc Gamer Asus', 5000.00),
('Camisa Social', 'Camisa Social Masculina de algodão', 120.00),
('Notebook', 'Notebook Posivo', 3000.00),
('Cadeira', 'Cadeira Gamer', 450.00),
('Teclado', 'Teclado Dell', 50.00),
('Mouse', 'Mouse Multilaser', 35.00),
('Caixa de som', 'Caixa de  som JBL', 130.00),
('Bola', 'Bola de futebol Nike', 28.00),
('Gravata', 'Gravata Jacquard 1200 fios Slim', 26.00);

-- Inserir dados na tabela "Pedidos_Produtos"
INSERT INTO Pedidos_Produtos (ID_Pedido, ID_Produto) VALUES
(1, 1),  -- Associando o Produto 1 ao Pedido 1
(2, 2),  -- Associando o Produto 2 ao Pedido 2
(3, 3),  -- Associando o Produto 3 ao Pedido 3
(4, 4),  -- Associando o Produto 4 ao Pedido 4
(5, 5);  -- Associando o Produto 5 ao Pedido 5

-- Inserir dados na tabela "Categorias"
INSERT INTO Categorias (Nome) VALUES
('Roupas'),
('Calçados'),
('Eletronicos'),
('Acessórios');


INSERT INTO Produtos_Categorias (ID_Produto, ID_Categoria) VALUES
(1, 2),
(2, 3),
(3, 1);


-- Inserir dados na tabela "Funcionários"
INSERT INTO Funcionarios (Nome, Sobrenome, Cargo) VALUES
('João', 'Silva', 'Vendedor'),
('Maria', 'Santos', 'Vendedor'),
('Diogo', 'Branco', 'Atendente'),
('Jonas', 'Donizette', 'Atendente'),
('Pedro', 'Almeida', 'Gerente');

-- Inserir dados na tabela "Vendas"
INSERT INTO Vendas(ID_Produto,ID_Cliente,Data_Venda,Quantidade)VALUES
(1, 1, '2022-03-05', 3),
(2, 2, '2023-04-06', 2),
(3, 3, '2020-01-09', 5),
(4, 4, '2024-04-08', 1),
(5, 5, '2022-08-16', 4);

-- Atualizando preço de um produto
UPDATE Pedidos
SET Total = 35.00
WHERE ID = 1;

-- Atualizar o cargo de um funcionário na tabela "Funcionários"
UPDATE Funcionarios
SET Cargo = 'Gerente'
WHERE ID = 1;


-- Exclusão de uma venda específico na tabela "Vendas".
DELETE FROM Vendas WHERE ID = 1;

-- Exclusão de um cliente específico na tabela "Clientes".
DELETE FROM Clientes WHERE ID = 1;


-- Excluir registros da tabela "Pedidos_Produtos" correspondentes ao produto que será excluído
DELETE FROM Pedidos_Produtos
WHERE ID_Produto = (SELECT ID FROM Produtos WHERE Nome = 'Mouse');

-- Excluir o produto da tabela "Produtos"
DELETE FROM Produtos
WHERE Nome = 'Mouse';

-- Exclusão de um Funcionário específico na tabela "Funcionarios".
DELETE FROM Funcionarios WHERE ID = 1;

-- Seleção de todos os pedidos com status "Em andamento" na tabela "Pedidos".
SELECT * FROM Pedidos WHERE Status = 'Em andamento';

SELECT 
    c.Nome, 
    p.Data_Pedido, 
    p.Total 
FROM 
    Pedidos p
JOIN 
    Clientes c ON p.ID_Cliente = c.ID
WHERE 
    p.Data_Pedido >= CURRENT_DATE - 30

--  Seleção de todos os produtos de uma categoria específica na tabela "Produtos_Categorias"
SELECT *
FROM Produtos
WHERE ID IN (
    SELECT ID_Produto
    FROM Produtos_Categorias
    WHERE ID_Categoria = 1
);