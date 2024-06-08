-- Criação do banco de dados
CREATE DATABASE pizzaria;

-- Seleção do banco de dados
\c pizzaria;

-- Criação da tabela contatos
CREATE TABLE IF NOT EXISTS contatos (
    id_contato SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    cel VARCHAR(255) NOT NULL,
    pizza VARCHAR(255) NOT NULL,
    cadastro DATE NOT NULL DEFAULT CURRENT_DATE
);

-- Criação da tabela entregas
CREATE TABLE IF NOT EXISTS entregas (
    id_entregas SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    cel VARCHAR(255) NOT NULL,
    pizza VARCHAR(255) NOT NULL,
    cadastro DATE NOT NULL DEFAULT CURRENT_DATE,
    situacao VARCHAR(20) CHECK (situacao IN ('entregue', 'andamento', 'cancelada'))
);

-- Criação da tabela pizzas
CREATE TABLE IF NOT EXISTS pizzas (
    id_pizza SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    ingredientes TEXT NOT NULL
);

-- Criação da tabela pedido
CREATE TABLE IF NOT EXISTS pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_entregas INT NOT NULL,
    id_contato INT NOT NULL,
    id_pizza INT NOT NULL,
    data_pedido DATE NOT NULL DEFAULT CURRENT_DATE,
    CONSTRAINT fk_id_entregas FOREIGN KEY (id_entregas) REFERENCES entregas (id_entregas),
    CONSTRAINT fk_id_contato FOREIGN KEY (id_contato) REFERENCES contatos (id_contato),
    CONSTRAINT fk_id_pizza FOREIGN KEY (id_pizza) REFERENCES pizzas (id_pizza)
);

-- Criação da tabela promocoes
CREATE TABLE IF NOT EXISTS promocoes (
    id_promocao SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    desconto DECIMAL(5, 2) NOT NULL -- Desconto em porcentagem
);

CREATE TABLE IF NOT EXISTS horario_funcionamento (
    id_horario SERIAL PRIMARY KEY,
    dia_semana VARCHAR(20) NOT NULL,
    horario_abertura TIME NOT NULL,
    horario_fechamento TIME NOT NULL
);

-- Inserção de dados na tabela contatos
INSERT INTO contatos (nome, email, cel, pizza, cadastro) VALUES
('João Silva', 'joao@example.com', '(11) 98765-4321', 'Calabresa', '2024-05-24'),
('Maria Santos', 'maria@example.com', '(11) 91234-5678', 'Margherita', '2024-05-24'),
('Carlos Oliveira', 'carlos@example.com', '(11) 92345-6789', 'Pepperoni', '2024-05-24'),
('Ana Ferreira', 'ana@example.com', '(11) 93456-7890', 'Frango com Catupiry', '2024-05-24'),
('Paula Costa', 'paula@example.com', '(11) 94567-8901', 'Quatro Queijos', '2024-05-24'),
('Pedro Ramos', 'pedro@example.com', '(11) 95678-9012', 'Portuguesa', '2024-05-24'),
('Mariana Oliveira', 'mariana@example.com', '(11) 96789-0123', 'Bacon', '2024-05-24'),
('Fernando Silva', 'fernando@example.com', '(11) 97890-1234', 'Vegetariana', '2024-05-24'),
('Patrícia Almeida', 'patricia@example.com', '(11) 98901-2345', 'Calabresa', '2024-05-24'),
('Lucas Santos', 'lucas@example.com', '(11) 99012-3456', 'Margherita', '2024-05-24');

-- Inserção de dados na tabela entregas
INSERT INTO entregas (nome, email, cel, pizza, cadastro, situacao) VALUES
('João Silva', 'joao@example.com', '(11) 98765-4321', 'Calabresa', '2024-05-24', 'cancelada'),
('Maria Santos', 'maria@example.com', '(11) 91234-5678', 'Margherita', '2024-05-24', 'entregue'),
('Carlos Oliveira', 'carlos@example.com', '(11) 92345-6789', 'Pepperoni', '2024-05-24', 'andamento'),
('Ana Ferreira', 'ana@example.com', '(11) 93456-7890', 'Frango com Catupiry', '2024-05-24', 'entregue'),
('Paula Costa', 'paula@example.com', '(11) 94567-8901', 'Quatro Queijos', '2024-05-24', 'entregue'),
('Pedro Ramos', 'pedro@example.com', '(11) 95678-9012', 'Portuguesa', '2024-05-24', 'cancelada'),
('Mariana Oliveira', 'mariana@example.com', '(11) 96789-0123', 'Bacon', '2024-05-24', 'andamento'),
('Fernando Silva', 'fernando@example.com', '(11) 97890-1234', 'Vegetariana', '2024-05-24', 'entregue'),
('Patrícia Almeida', 'patricia@example.com', '(11) 98901-2345', 'Calabresa', '2024-05-24', 'cancelada'),
('Lucas Santos', 'lucas@example.com', '(11) 99012-3456', 'Margherita', '2024-05-24', 'entregue');

-- Inserção de dados na tabela pizzas
INSERT INTO pizzas (nome, preco, ingredientes) VALUES
('Calabresa', 25.00, 'Calabresa, cebola, azeitona'),
('Margherita', 22.00, 'Molho de tomate, mozzarella, manjericão'),
('Pepperoni', 28.00, 'Pepperoni, queijo, molho de tomate'),
('Frango com Catupiry', 30.00, 'Frango desfiado, catupiry, milho'),
('Quatro Queijos', 35.00, 'Mozzarella, provolone, parmesão, gorgonzola'),
('Portuguesa', 27.00, 'Presunto, ovo, cebola, azeitona, mozzarella'),
('Bacon', 26.00, 'Bacon, mozzarella, cebola'),
('Vegetariana', 24.00, 'Pimentão, cebola, azeitona, tomate, mozzarella');

-- Inserção de dados na tabela promocoes
INSERT INTO promocoes (nome, descricao, data_inicio, data_fim, desconto) VALUES
('Promoção de Segunda', 'Desconto de 10% em todas as pizzas às segundas-feiras.', '2024-06-01', '2024-12-31', 10.00),
('Promoção de Aniversário', 'Desconto de 20% em todas as pizzas no mês do seu aniversário.', '2024-01-01', '2024-12-31', 20.00),
('Promoção de Fim de Semana', 'Desconto de 15% em todas as pizzas aos sábados e domingos.', '2024-06-01', '2024-12-31', 15.00);

INSERT INTO horario_funcionamento (dia_semana, horario_abertura, horario_fechamento) VALUES
('Segunda-feira', '10:00', '22:00'),
('Terça-feira', '10:00', '22:00'),
('Quarta-feira', '10:00', '22:00'),
('Quinta-feira', '10:00', '22:00'),
('Sexta-feira', '10:00', '23:00'),
('Sábado', '11:00', '23:00'),
('Domingo', '11:00', '22:00');

-- Verificação e limpeza de dados antigos na tabela entregas
DELETE FROM entregas CASCADE;
