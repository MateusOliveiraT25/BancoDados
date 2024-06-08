--ex.1
SELECT cliente.NOME, venda.duplic, venda.Valor
FROM cliente INNER Join venda ON venda.codcli = cliente.codcli
--WHERE cliente. NOME LIKE 'PCTEC%'
WHERE cliente. NOME = 'PCTEC - MICROCOMPUTADORES S/A.'

--ex.2
SELECT cliente.NOME, venda.vencto
FROM cliente INNER JOIN venda ON cliente.CODCLI = venda.codcli
WHERE EXTRACT (YEAR FROM venda.VENCTO) = 2004 AND EXTRACT (MONTH FROM venda.VENCTO) = 11
ORDER BY venda.VENCTO

--ex.3
SELECT cliente.NOME, venda.vencto
FROM cliente INNER JOIN venda ON cliente.CODCLI = venda.codcli
WHERE EXTRACT (MONTH FROM venda.VENCTO) = 10
ORDER BY venda.VENCTO

--ex.4
SELECT cliente.NOME, COUNT (*) AS QTDE, SUM (venda.VALOR) AS TOTAL
FROM cliente INNER Join venda ON cliente.codcli = venda.codcli
GROUP BY cliente.NOME
ORDER BY TOTAL;

--ex.5
SELECT cli.NOME, COUNT (*) AS TITULOS, SUM (ven.VALOR) AS TOTAL
FROM cliente cli INNER Join venda ven ON cli.codcli = ven.codcli
GROUP BY cli.NOME
ORDER BY TOTAL;

--ex.6
SELECT cliente.NOME AS CLIENTE, COUNT (*) AS VENCIDOS
FROM cliente INNER JOIN venda ON cliente.CODCLI = venda.codcli
WHERE venda.VENCTO < '2003-12-21'
GROUP BY cliente.NOME
ORDER BY cliente;

--ex.7
SELECT cliente.NOME AS CLIENTE, venda.VALOR, ROUND(venda.VALOR * 0.10, 2) AS JUROS,
ROUND (venda.VALOR * 1.10, 2) AS TOTAL
FROM cliente INNER JOIN venda ON cliente.CODCLi = venda.CODCLI
WHERE venda.VENCTO <= '1999-12-31'
ORDER BY CLIENTE;