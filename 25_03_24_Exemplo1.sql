-- Cria um banco de dados chamado aula_sql
CREATE DATABASE aula_sql;
-- Exclui o banco de dados aula_sql caso ele exista
DROP DATABASE aula_sql;

-- Cria um novo banco de dados chamado DB_AULA25MAR24
CREATE DATABASE DB_AULA25MAR24;
-- No SQL padrão, o comando USE é utilizado para selecionar o banco de dados a ser usado. 
-- No PostgreSQL, por exemplo, você mudaria de banco usando o comando de conexão do seu cliente de banco de dados ou ferramentas de linha de comando.
USE DB_AULA25MAR24;

-- Cria uma tabela chamada fornecedor com quatro colunas: Fcodigo, Fnome, Status e Cidade
CREATE TABLE  IF  NOT EXISTS fornecedor( -- cria a tabela se nao existir e se existir nao acontece nada nem erro
    Fcodigo INT NOT NULL, -- Coluna Fcodigo do tipo inteiro que não pode ser nula
    Fnome  VARCHAR(30) NOT NULL, -- Coluna Fnome do tipo varchar com máximo de 30 caracteres que não pode ser nula
    Status INT, -- Coluna Status do tipo inteiro (pode ser nulo)
    Cidade VARCHAR(30) -- Coluna Cidade do tipo varchar com máximo de 30 caracteres (pode ser nulo)
);

-- Seleciona todos os registros da tabela fornecedor
SELECT * FROM fornecedor;

CREATE TABLE  IF  NOT EXISTS departamento(
Dcodigo INT NOT NULL,
Dnome VARCHAR(30) NOT NULL,
 Cidade VARCHAR(30),
 PRIMARY KEY (Dcodigo)
);

-- Seleciona todos os registros da tabela Departamento
SELECT * FROM Departamento;

CREATE TABLE  IF  NOT EXISTS empregado(
    Ecodigo INT NOT NULL,
    Enome VARCHAR(40) NOT NULL,
    CPF VARCHAR (15) NOT NULL,
    Salario DECIMAL (7,2),
    Dcodigo INT NOT NULL,
    PRIMARY KEY (Ecodigo, Enome)
);

-- Seleciona todos os registros da tabela empregado
SELECT * FROM empregado;

--apagar a tabela
DROP TABLE empregado;

-- Cria uma tabela FOREIGN KEY
CREATE TABLE  IF  NOT EXISTS empregado(
    Ecodigo INT NOT NULL,
    Enome VARCHAR(40) NOT NULL,
    CPF VARCHAR (15) NOT NULL,
    Salario DECIMAL (7,2),
    Dcodigo INT NOT NULL,
    PRIMARY KEY (Ecodigo, Enome),
    FOREIGN KEY (Dcodigo) REFERENCES departamento
);

--ALTERAR TABELAS COM O ALTER TABLE ADD(ADD COLUNA)
ALTER TABLE empregado ADD sexo CHAR(1);

-- Seleciona todos os registros da tabela empregado
SELECT * FROM empregado;

--ALTERAR TABELAS COM O ALTER TABLE Rename
ALTER TABLE empregado RENAME to funcionario;

