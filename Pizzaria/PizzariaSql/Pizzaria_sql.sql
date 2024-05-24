-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Cliente (
CPF varchar(14) Not Null PRIMARY KEY,
Nome varchar(80) not null,
Endereco varchar(100) not null,
Telefone varchar(15) not null
)

CREATE TABLE Pedido (
Num_Pedido int not null PRIMARY KEY,
Data_Pedido date not null,
Total_Pedido decimal(7,2) not null,
CPF varchar(14) Not Null,
FOREIGN KEY(CPF) REFERENCES Cliente (CPF)
)

CREATE TABLE Produto (
Id_Produto int not null PRIMARY KEY,
Nome varchar(50) not null,
Estoque int not null,
Preco decimal (7,2) not null
)

CREATE TABLE Contem (
Quantidade int not null,
Comprovante varchar(250) PRIMARY KEY,
Id_Produto int not null,
Num_Pedido int not null,
FOREIGN KEY(Id_Produto) REFERENCES Produto (Id_Produto)
FOREIGN KEY(Id_Pedido) REFERENCES Pedido (Id_Pedido)

)

-- Inserir 10 clientes
INSERT INTO Cliente (CPF, Nome, Endereco, Telefone) VALUES
('111.111.111-11', 'João Silva', 'Rua A, 123', '(11) 1111-1111'),
('222.222.222-22', 'Maria Souza', 'Rua B, 456', '(22) 2222-2222'),
('333.333.333-33', 'José Santos', 'Rua C, 789', '(33) 3333-3333'),
('444.444.444-44', 'Ana Oliveira', 'Rua D, 012', '(44) 4444-4444'),
('555.555.555-55', 'Pedro Almeida', 'Rua E, 345', '(55) 5555-5555'),
('666.666.666-66', 'Carla Pereira', 'Rua F, 678', '(66) 6666-6666'),
('777.777.777-77', 'Márcio Costa', 'Rua G, 901', '(77) 7777-7777'),
('888.888.888-88', 'Aline Fernandes', 'Rua H, 234', '(88) 8888-8888'),
('999.999.999-99', 'Fernando Rodrigues', 'Rua I, 567', '(99) 9999-9999'),
('123.456.789-00', 'Juliana Lima', 'Rua J, 890', '(00) 0000-0000');


-- Inserir 10 pedidos
INSERT INTO Pedido (Num_Pedido, Data_Pedido, Total_Pedido, CPF) VALUES
(1, '2024-05-03', 100.00, '111.111.111-11'),
(2, '2024-05-03', 150.00, '222.222.222-22'),
(3, '2024-05-03', 200.00, '333.333.333-33'),
(4, '2024-05-03', 80.00, '444.444.444-44'),
(5, '2024-05-03', 120.00, '555.555.555-55'),
(6, '2024-05-03', 90.00, '666.666.666-66'),
(7, '2024-05-03', 60.00, '777.777.777-77'),
(8, '2024-05-03', 110.00, '888.888.888-88'),
(9, '2024-05-03', 70.00, '999.999.999-99'),
(10, '2024-05-03', 130.00, '123.456.789-00');


-- Inserir 10 pizzas
INSERT INTO Produto (Id_Produto, Nome, Estoque, Preco) VALUES
(1, 'Pizza Margherita', 50, 10.00),
(2, 'Pizza Pepperoni', 30, 15.00),
(3, 'Pizza Quatro Queijos', 20, 20.00),
(4, 'Pizza Calabresa', 40, 8.00),
(5, 'Pizza Frango com Catupiry', 60, 12.00),
(6, 'Pizza Portuguesa', 25, 9.00),
(7, 'Pizza Bacon', 35, 6.00),
(8, 'Pizza Vegetariana', 45, 11.00),
(9, 'Pizza Mexicana', 55, 7.00),
(10, 'Pizza Doce', 65, 13.00);

-- Inserir 10 relações entre produtos e pedidos
INSERT INTO Contem (Quantidade, Comprovante, Id_Produto, Num_Pedido) VALUES
(2, 'ABC123', 1, 1),
(3, 'DEF456', 2, 2),
(1, 'GHI789', 3, 3),
(4, 'JKL012', 4, 4),
(2, 'MNO345', 5, 5),
(3, 'PQR678', 6, 6),
(1, 'STU901', 7, 7),
(4, 'VWX234', 8, 8),
(2, 'YZA567', 9, 9),
(3, 'BCD890', 10, 10);


SELECT CPF, Nome FROM Cliente;

SELECT CPF, Nome FROM Cliente;

SELECT * FROM Produto WHERE Preco > 200;


SELECT * FROM Produto ORDER BY Id_Produto ASC;

--clasula limit
SELECT PRODUTO, PRECO  FROM PRODUTO
ORDER BY NOME
LIMIT 5;
