CREATE DATABASE pizzaria_matheus;

CREATE TABLE IF NOT EXISTS contatos (
    id_contato SERIAL PRIMARY KEY,
    nome VARCHAR(225) NOT NULL,
    email VARCHAR(225) NOT NULL,
    cel VARCHAR(225) NOT NULL,
    cadastro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS pizzas (
    id_pizza SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    ingredientes TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS entregas (
    id_entrega SERIAL PRIMARY KEY,
    id_contato INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    cel VARCHAR(255) NOT NULL,
    pizza VARCHAR(255) NOT NULL,
    cadastro DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    situacao VARCHAR(255) NOT NULL CHECK (situacao IN ('Em Andamento', 'Finalizada')),
    CONSTRAINT fk_contato FOREIGN KEY (id_contato) REFERENCES contatos (id_contato)
);

CREATE TABLE IF NOT EXISTS pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_entrega INT NOT NULL,
    id_contato INT NOT NULL,
    id_pizza INT NOT NULL,
    data_pedido DATE NOT NULL,
    CONSTRAINT fk_entrega FOREIGN KEY (id_entrega) REFERENCES entregas (id_entrega),
    CONSTRAINT fk_contato FOREIGN KEY (id_contato) REFERENCES contatos (id_contato),
    CONSTRAINT fk_pizza FOREIGN KEY (id_pizza) REFERENCES pizzas (id_pizza)
);

CREATE TABLE IF NOT EXISTS status_pizzas (
    id_status SERIAL PRIMARY KEY,
    id_pedido INT NOT NULL,
    status_producao VARCHAR(100) NOT NULL,
    status_entrega VARCHAR(100) NOT NULL,
    CONSTRAINT fk_pedido FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

CREATE TABLE IF NOT EXISTS funcionarios (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    id_supervisor INT,
    atribuicoes VARCHAR(100) NOT NULL,
    areas_trabalho VARCHAR(255) NOT NULL,
    FOREIGN KEY (id_supervisor) REFERENCES funcionarios(id_funcionario)
);

CREATE TABLE IF NOT EXISTS promocoes (
    id_promocao SERIAL PRIMARY KEY,
    nome_promocao VARCHAR(255) NOT NULL,
    descricao TEXT,
    desconto DECIMAL(5, 2) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    id_pizza INT,
    FOREIGN KEY (id_pizza) REFERENCES pizzas(id_pizza)
);

CREATE TABLE IF NOT EXISTS horario_funcionamento (
    id_horario SERIAL PRIMARY KEY,
    dia_semana VARCHAR(20) NOT NULL,
    hora_abertura TIME NOT NULL,
    hora_fechamento TIME NOT NULL
);


DROP TABLE IF EXISTS contatos;

INSERT INTO contatos (id_contato, nome, email, cell, pizza, cadastro) VALUES

SELECT * from contatos

SELECT * FROM contatos ORDER BY id_contato OFFSET :offset 1 :1

SELECT COUNT(*) FROM contatos

alter TABLE contatos
COLUMN id_contato rename to id

SELECT * FROM contatos WHERE id_contato = ?