CREATE DATABASE sa4_db;
-- Ex.1  DDL (Data Definition Language) 
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
(2, '2024-04-11', 180, 'Em andamento');
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
--Ex.2 DDL (Data Definition Language) 
