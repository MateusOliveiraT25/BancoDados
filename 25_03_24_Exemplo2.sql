CREATE DATABASE aula_01_04;
DROP DATABASE aula_01_04;

CREATE TABLE IF NOT EXISTS fornecedor (
    fcodigo INT NOT NULL PRIMARY KEY, -- Identificador único para cada fornecedor, não pode ser nulo
    fnome VARCHAR(255) NOT NULL, -- Nome do fornecedor, não pode ser nulo
    status BOOLEAN, -- Status do fornecedor, assumindo que você deseja um indicador booleano (ativo/inativo)
    cidade VARCHAR(255) -- Nome da cidade, pode ser nulo
);

CREATE TABLE IF NOT EXISTS peca (
    pcodigo INT NOT NULL PRIMARY KEY, -- Identificador único para cada peça, não pode ser nulo
    pnome VARCHAR(255) NOT NULL, -- Nome da peça, não pode ser nulo
    cor VARCHAR(50) NOT NULL, -- Cor da peça, não pode ser nulo
    peso DECIMAL(10, 2) NOT NULL, -- Peso da peça, não pode ser nulo. Ajuste a precisão e escala conforme necessário.
    cidade VARCHAR(255) NOT NULL -- Nome da cidade, não pode ser nulo
);


CREATE TABLE IF NOT EXISTS instituicao (
    icodigo INT NOT NULL PRIMARY KEY, -- Identificador único para cada instituição, não pode ser nulo
    nome VARCHAR(255) NOT NULL -- Nome da instituição, não pode ser nulo
);

CREATE TABLE IF NOT EXISTS Projeto (
    PRcod INT NOT NULL PRIMARY KEY, -- Código do projeto, único para cada projeto
    PRnome VARCHAR(255) NOT NULL, -- Nome do projeto, não pode ser nulo
    Cidade VARCHAR(255) NOT NULL, -- Cidade do projeto, não pode ser nulo
    icodigo INT NOT NULL, -- Código da instituição associada, não pode ser nulo
    FOREIGN KEY (icodigo) REFERENCES instituicao(icodigo) -- Define Icod como chave estrangeira que referencia icodigo da tabela instituicao
);

CREATE TABLE IF NOT EXISTS Fornecimento (
    Fcodigo INT NOT NULL, -- Código do fornecedor
    pcodigo INT NOT NULL, -- Código da peça
    PRcod INT NOT NULL, -- Código do projeto
    Quantidade INT NOT NULL, -- Quantidade fornecida
    PRIMARY KEY (Fcodigo, pcodigo, PRcod), -- Define uma chave primária composta
    FOREIGN KEY (Fcodigo) REFERENCES fornecedor(Fcodigo), -- Chave estrangeira referenciando fornecedores
    FOREIGN KEY (pcodigo) REFERENCES peca(pcodigo), -- Chave estrangeira referenciando peças
    FOREIGN KEY (PRcod) REFERENCES Projeto(PRcod) -- Chave estrangeira referenciando projetos
);

CREATE TABLE IF NOT EXISTS Projeto (
    PRcod INT NOT NULL PRIMARY KEY, -- Código do projeto, único para cada projeto
    PRnome VARCHAR(255) NOT NULL, -- Nome do projeto, não pode ser nulo
    Cidade VARCHAR(255) NOT NULL, -- Cidade do projeto, não pode ser nulo
    icodigo INT NOT NULL, -- Código da instituição associada, não pode ser nulo
    FOREIGN KEY (icodigo) REFERENCES instituicao(icodigo) -- Define Icod como chave estrangeira que referencia icodigo da tabela instituicao
);

CREATE TABLE IF NOT EXISTS Fornecimento (
   
    Fcodigo INT NOT NULL, -- Código do fornecedor
    pcodigo INT NOT NULL, -- Código da peça
    PRcod INT NOT NULL, -- Código do projeto
    Quantidade INT NOT NULL, -- Quantidade fornecida
    PRIMARY KEY (Fcodigo, pcodigo, PRcod), -- Define uma chave primária composta
    FOREIGN KEY (Fcodigo) REFERENCES fornecedor(Fcodigo), -- Chave estrangeira referenciando fornecedores
    FOREIGN KEY (pcodigo) REFERENCES peca(pcodigo), -- Chave estrangeira referenciando peças
    FOREIGN KEY (PRcod) REFERENCES Projeto(PRcod) -- Chave estrangeira referenciando projetos
);

-- Adiciona a coluna Fone à tabela Fornecedor
ALTER TABLE Fornecedor
ADD COLUMN Fone VARCHAR(20);

-- Criar nova tabela Cidade
CREATE TABLE IF NOT EXISTS Cidade (
    Ccod SERIAL PRIMARY KEY, -- Código da cidade, autoincremento
    Cnome VARCHAR(255) NOT NULL, -- Nome da cidade, não pode ser nulo
    uf VARCHAR(2) NOT NULL -- UF da cidade, não pode ser nulo
);



-- Adiciona a coluna Ccod à tabela Peca
ALTER TABLE Peca
ADD COLUMN Ccod INT NOT NULL;

-- Adiciona uma restrição de chave estrangeira na coluna Ccod da tabela Peca, referenciando a tabela Cidade
ALTER TABLE Peca
ADD CONSTRAINT fk_Ccod
FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);

-- Adiciona a coluna Ccod à tabela Projeto
ALTER TABLE Projeto
ADD COLUMN Ccod INT NOT NULL;

-- Adiciona uma restrição de chave estrangeira na coluna Ccod da tabela Projeto, referenciando a tabela Cidade
ALTER TABLE Projeto
ADD CONSTRAINT fk_Ccod
FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod);

-- Remove a coluna cidade da tabela Peca
ALTER TABLE Peca
DROP COLUMN cidade;

-- Remove a coluna cidade da tabela Projeto
ALTER TABLE Projeto
DROP COLUMN cidade;

-- Remove a coluna cidade da tabela Projeto
ALTER TABLE Projeto
DROP COLUMN  icodigo;

-- Remove a coluna cidade da tabela Fornecedor
ALTER TABLE Fornecedor
DROP COLUMN  cidade;

-- Remover tabelas existentes
DROP TABLE IF EXISTS instituicao ;