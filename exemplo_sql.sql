-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Cliente (
id_cliente serial PRIMARY KEY,
cpf_cliente NOT NULL varchar(14),
nome_cliente varchar(100),
celular_cliente varchar(15)
)

CREATE TABLE produto (
id_produto serial PRIMARY KEY,
qtd_produto int,
valor_produto decimal(7,2)
)

CREATE TABLE compra (
id_pedido serial PRIMARY KEY,
data_compra_produto date,
id_produto int,
id_cliente int,
FOREIGN KEY(id_produto) REFERENCES produto (id_produto)
FOREIGN KEY(id_cliente) REFERENCES produto (id_cliente)

