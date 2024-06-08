-- Este comando é para criar um novo banco de dados chamado sa4_ex1_bd.
 CREATE DATABASE sa4_ex1_bd;

-- Criação da tabela "Clientes" com campos ID, Nome, Sobrenome e Email.
CREATE TABLE IF NOT EXISTS Clientes (
    ID SERIAL PRIMARY KEY, -- Chave primária autoincrementada
    Nome VARCHAR(255),
    Sobrenome VARCHAR(255),
    Email VARCHAR(255) 
);
ALTER TABLE Clientes
ADD CONSTRAINT email_unique UNIQUE (Email);


-- Criação da tabela "Pedidos" com campos ID, ID_Cliente, Data_Pedido, Total e Status.
CREATE TABLE IF NOT EXISTS Pedidos (
    ID SERIAL PRIMARY KEY, -- Chave primária autoincrementada
    ID_Cliente INT,
    Data_Pedido DATE,
    Total DECIMAL(10, 2),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID) -- Chave estrangeira referenciando a tabela "Clientes"
);

-- Adição do campo "Status" na tabela "Pedidos" com uma restrição de valores possíveis.
ALTER TABLE Pedidos
ADD Status VARCHAR(20) NOT NULL CHECK (Status IN ('Em andamento', 'Finalizado', 'Cancelado'));

-- Inserção de alguns registros na tabela "Clientes".
INSERT INTO Clientes (Nome, Sobrenome, Email) VALUES
('João', 'Silva', 'joao@gmail.com'),
('Maria', 'Santos', 'maria@gmail.com'),
('Pedro', 'Almeida', 'pedro@gmail.com');

-- Inserção de alguns registros na tabela "Pedidos", associados a clientes existentes.
INSERT INTO Pedidos (ID_Cliente, Data_Pedido, Total, Status) VALUES
(1, '2024-04-05', 100.00, 'Em andamento'),
(2, '2024-04-06', 150.00, 'Finalizado'),
(3, '2024-04-07', 80.00, 'Em andamento'),
(1, '2024-04-08', 200.00, 'Finalizado'),
(2, '2024-04-09', 120.00, 'Cancelado');

-- Atualização do campo "Total" de um pedido específico na tabela "Pedidos".
UPDATE Pedidos
SET Total = 120.00
WHERE ID = 1;

-- Exclusão de pedidos associados a um cliente específico na tabela "Pedidos".
DELETE FROM Pedidos WHERE ID_Cliente = 1;

-- Exclusão de um cliente específico na tabela "Clientes".
DELETE FROM Clientes WHERE ID = 1;

-- Seleção de todos os pedidos com status "Em andamento" na tabela "Pedidos".
SELECT * FROM Pedidos WHERE Status = 'Em andamento';

-- Seleção do nome do cliente, data do pedido e total dos pedidos feitos nos últimos 30 dias.
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