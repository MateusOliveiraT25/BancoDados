-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Cliente (
CPF Varchar(14) Not Null PRIMARY KEY,
Nome Varchar(80) Not Null,
Telefone Varchar(15) Not Null,
Endereco Varchar(100) Not Null
)

CREATE TABLE Pedido (
Num_Pedido Int Not Null PRIMARY KEY,
CPF Varchar(14) Not Null,
Data_Pedido Date Not Null,
Total_Pedido Decimal(7,2) Not Null,
FOREIGN KEY(CPF) REFERENCES Cliente (CPF)
)

CREATE TABLE Produto (
Id_produto Int Not Null PRIMARY KEY,
Nome Varchar(50) Not Null,
Preço Int Not Null,
Estoque Int Not Null
)

CREATE TABLE Contem (
Quantidade Int,
Comprovante Varchar(255) PRIMARY KEY,
Id_produto Int Not Null,
Num_Pedido Int Not Null,
FOREIGN KEY(id_produto) REFERENCES Produto (Id_produto),
FOREIGN KEY(Num_Pedido) REFERENCES Pedido (Num_Pedido)
)