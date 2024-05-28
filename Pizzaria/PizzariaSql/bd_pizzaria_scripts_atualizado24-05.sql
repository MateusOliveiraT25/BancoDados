create database pizzaria
DROP DATABASE pizzaria;


CREATE TABLE IF NOT EXISTS contatos (
	id_contato INT NOT NULL PRIMARY KEY,
  	nome varchar(255) NOT NULL,
  	email varchar(255) NOT NULL,
  	cel varchar(255) NOT NULL,
  	pizza varchar(255) NOT NULL,
  	cadastro date NOT NULL DEFAULT CURRENT_TIMESTAMP
	
) 

CREATE TABLE IF NOT EXISTS entregas (
	id_entregas INT NOT NULL PRIMARY KEY,
  	nome varchar(255) NOT NULL,
  	email varchar(255) NOT NULL,
  	cel varchar(255) NOT NULL,
  	pizza varchar(255) NOT NULL,
  	cadastro date NOT NULL DEFAULT CURRENT_TIMESTAMP,
	situacao VARCHAR(30)
	
) 

	-- Criar a tabela pedido
CREATE TABLE IF NOT EXISTS pedido (
    id_pedido SERIAL PRIMARY KEY,
    id_entregas INT NOT NULL,
	id_contato INT NOT NULL,
	id_pizza INT NOT NULL,	
	data_pedido DATE NOT NULL,
    CONSTRAINT fk_id_entregas FOREIGN KEY (id_entregas) REFERENCES entregas (id_entregas),
	CONSTRAINT fk_id_pizza FOREIGN KEY (id_pizza) REFERENCES pizzas (id_pizza),
	CONSTRAINT fk_id_contato FOREIGN KEY (id_contato) REFERENCES contatos (id_contato)
);

CREATE TABLE IF NOT EXISTS pizzas (
    id_pizza SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL,
    ingredientes TEXT NOT NULL
);

drop table pedido


INSERT INTO contatos (id_contato, nome, email, cel, pizza, cadastro) VALUES
(1, 'João Silva', 'joao@example.com', '(11) 98765-4321', 'Calabresa', '2024-05-24'),
(2, 'Maria Santos', 'maria@example.com', '(11) 91234-5678', 'Margherita', '2024-05-24'),
(3, 'Carlos Oliveira', 'carlos@example.com', '(11) 92345-6789', 'Pepperoni', '2024-05-24'),
(4, 'Ana Ferreira', 'ana@example.com', '(11) 93456-7890', 'Frango com Catupiry', '2024-05-24'),
(5, 'Paula Costa', 'paula@example.com', '(11) 94567-8901', 'Quatro Queijos', '2024-05-24'),
(6, 'Pedro Ramos', 'pedro@example.com', '(11) 95678-9012', 'Portuguesa', '2024-05-24'),
(7, 'Mariana Oliveira', 'mariana@example.com', '(11) 96789-0123', 'Bacon', '2024-05-24'),
(8, 'Fernando Silva', 'fernando@example.com', '(11) 97890-1234', 'Vegetariana', '2024-05-24'),
(9, 'Patrícia Almeida', 'patricia@example.com', '(11) 98901-2345', 'Calabresa', '2024-05-24'),
(10, 'Lucas Santos', 'lucas@example.com', '(11) 99012-3456', 'Margherita', '2024-05-24');

INSERT INTO entregas (id_entregas, nome, email, cel, pizza, cadastro, situacao) VALUES
(1, 'João Silva', 'joao@example.com', '(11) 98765-4321', 'Calabresa', '2024-05-24', 'cancelada'),
(2, 'Maria Santos', 'maria@example.com', '(11) 91234-5678', 'Margherita', '2024-05-24', 'entregue'),
(3, 'Carlos Oliveira', 'carlos@example.com', '(11) 92345-6789', 'Pepperoni', '2024-05-24', 'andamento'),
(4, 'Ana Ferreira', 'ana@example.com', '(11) 93456-7890', 'Frango com Catupiry', '2024-05-24', 'entregue'),
(5, 'Paula Costa', 'paula@example.com', '(11) 94567-8901', 'Quatro Queijos', '2024-05-24', 'entregue'),
(6, 'Pedro Ramos', 'pedro@example.com', '(11) 95678-9012', 'Portuguesa', '2024-05-24', 'cancelada'),
(7, 'Mariana Oliveira', 'mariana@example.com', '(11) 96789-0123', 'Bacon', '2024-05-24', 'andamento'),
(8, 'Fernando Silva', 'fernando@example.com', '(11) 97890-1234', 'Vegetariana', '2024-05-24', 'entregue'),
(9, 'Patrícia Almeida', 'patricia@example.com', '(11) 98901-2345', 'Calabresa', '2024-05-24', 'cancelada'),
(10, 'Lucas Santos', 'lucas@example.com', '(11) 99012-3456', 'Margherita', '2024-05-24', 'entregue');


-- Inserir dados na tabela pedido
INSERT INTO pedido (id_entregas, id_contato, id_pizza, data_pedido) 
VALUES 
(1, 1, 1, '2024-05-24'),
(2, 2, 2, '2024-05-24'),
(3, 3, 3, '2024-05-24'),
(4, 4, 4, '2024-05-24'),
(5, 5, 5, '2024-05-24'),
(6, 6, 6, '2024-05-24'),
(7, 7, 7, '2024-05-24'),
(8, 8, 8, '2024-05-24'),
(9, 9, 9, '2024-05-24'),
(10, 10, 10, '2024-05-24');

-- Inserir dados na tabela pizzas
INSERT INTO pizzas (nome, preco, ingredientes) 
VALUES 
('Calabresa', 30.00, 'Molho de tomate, calabresa, cebola, mussarela'),
('Margherita', 25.00, 'Molho de tomate, mussarela, manjericão'),
('Pepperoni', 35.00, 'Molho de tomate, pepperoni, mussarela'),
('Frango com Catupiry', 40.00, 'Molho de tomate, frango desfiado, catupiry'),
('Quatro Queijos', 35.00, 'Molho de tomate, mussarela, parmesão, provolone, gorgonzola'),
('Portuguesa', 30.00, 'Molho de tomate, presunto, ovos, cebola, ervilha, mussarela'),
('Bacon', 35.00, 'Molho de tomate, bacon, mussarela, cebola'),
('Vegetariana', 30.00, 'Molho de tomate, milho, ervilha, palmito, champignon, mussarela'),
('Calabresa', 30.00, 'Molho de tomate, calabresa, cebola, mussarela'),
('Margherita', 25.00, 'Molho de tomate, mussarela, manjericão');


-- Alterar o tipo de dados da coluna situacao para VARCHAR
ALTER TABLE entregas
ALTER COLUMN situacao TYPE VARCHAR(20);

DELETE FROM entregas cascade;


-- Adicionar uma restrição de verificação para permitir apenas os valores desejados
ALTER TABLE entregas
ADD CONSTRAINT situacao_check CHECK (situacao IN ('entregue', 'andamento', 'cancelada'));

