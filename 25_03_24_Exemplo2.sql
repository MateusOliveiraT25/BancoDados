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



-- Remover tabelas existentes
DROP TABLE IF EXISTS Fornecimento;
DROP TABLE IF EXISTS Projeto;
DROP TABLE IF EXISTS Peca;
DROP TABLE IF EXISTS Cidade;
DROP TABLE IF EXISTS Fornecedor;

-- Criar nova tabela Fornecedor
CREATE TABLE IF NOT EXISTS Fornecedor (
    Fcod SERIAL PRIMARY KEY, -- Código do fornecedor, autoincremento
    Fnome VARCHAR(255) NOT NULL, -- Nome do fornecedor, não pode ser nulo
    Status BOOLEAN, -- Status do fornecedor
    Fone VARCHAR(20), -- Telefone do fornecedor
    Ccod INT NOT NULL, -- Código da cidade, não pode ser nulo
    FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod) -- Chave estrangeira referenciando a tabela Cidade
);

-- Criar nova tabela Cidade
CREATE TABLE IF NOT EXISTS Cidade (
    Ccod SERIAL PRIMARY KEY, -- Código da cidade, autoincremento
    Cnome VARCHAR(255) NOT NULL, -- Nome da cidade, não pode ser nulo
    uf VARCHAR(2) NOT NULL -- UF da cidade, não pode ser nulo
);

-- Criar nova tabela Peca
CREATE TABLE IF NOT EXISTS Peca (
    Pcod SERIAL PRIMARY KEY, -- Código da peça, autoincremento
    Pnome VARCHAR(255) NOT NULL, -- Nome da peça, não pode ser nulo
    Cor VARCHAR(50) NOT NULL, -- Cor da peça, não pode ser nulo
    Peso DECIMAL(10, 2) NOT NULL, -- Peso da peça, não pode ser nulo
    Ccod INT NOT NULL, -- Código da cidade, não pode ser nulo
    FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod) -- Chave estrangeira referenciando a tabela Cidade
);

-- Criar nova tabela Projeto
CREATE TABLE IF NOT EXISTS Projeto (
    PRcod SERIAL PRIMARY KEY, -- Código do projeto, autoincremento
    PRnome VARCHAR(255) NOT NULL, -- Nome do projeto, não pode ser nulo
    Ccod INT NOT NULL, -- Código da cidade, não pode ser nulo
    FOREIGN KEY (Ccod) REFERENCES Cidade(Ccod) -- Chave estrangeira referenciando a tabela Cidade
);

-- Criar nova tabela Fornecimento
CREATE TABLE IF NOT EXISTS Fornecimento (
    Fcod INT NOT NULL, -- Código do fornecedor
    Pcod INT NOT NULL, -- Código da peça
    PRcod INT NOT NULL, -- Código do projeto
    Quantidade INT NOT NULL, -- Quantidade fornecida
    PRIMARY KEY (Fcod, Pcod, PRcod), -- Define uma chave primária composta
    FOREIGN KEY (Fcod) REFERENCES Fornecedor(Fcod), -- Chave estrangeira referenciando a tabela Fornecedor
    FOREIGN KEY (Pcod) REFERENCES Peca(Pcod), -- Chave estrangeira referenciando a tabela Peca
    FOREIGN KEY (PRcod) REFERENCES Projeto(PRcod) -- Chave estrangeira referenciando a tabela Projeto
);
