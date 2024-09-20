--BD 2
--LEONARDO CUTRIM E PAULO OLIVEIRA

--1. Clientes com Crediário em Atraso
SELECT cl.nome AS cliente, cr.saldo_devedor, pc.data_vencimento
FROM Cliente cl
JOIN Crediario cr ON cl.cliente_id = cr.cliente_id
JOIN Parcela pc ON cr.crediario_id = pc.crediario_id
WHERE pc.data_vencimento < CURRENT_DATE
ORDER BY pc.data_vencimento;

--2. Produtos Vendidos por Categoria
SELECT c.nome AS categoria, p.nome AS produto, SUM(iv.quantidade) AS total_vendido, 
       SUM(iv.quantidade * iv.preco_unitario) AS valor_arrecadado
FROM Categoria c
JOIN Produto p ON c.categoria_id = p.categoria_id
JOIN ItemVenda iv ON p.produto_id = iv.produto_id
GROUP BY c.nome, p.nome
ORDER BY c.nome, valor_arrecadado DESC;

--3. Limite de Cada Cliente e Seu Saldo Devedor
SELECT C.nome AS "Nome do Cliente", Cr.limite_credito AS "Limite de Crédito", 
       Cr.saldo_devedor AS "Saldo Devedor"
FROM Cliente C
JOIN Crediario Cr ON C.cliente_id = Cr.cliente_id
ORDER BY C.nome ASC;

--4. Informações de Todas as Vendas com Clientes e Produtos
SELECT V.venda_id, C.nome AS cliente_nome, P.nome AS produto_nome, 
       IV.quantidade, IV.preco_unitario
FROM Venda V
JOIN Cliente C ON V.cliente_id = C.cliente_id
JOIN ItemVenda IV ON V.venda_id = IV.venda_id
JOIN Produto P ON IV.produto_id = P.produto_id;

--5. Informações de Pedidos de Reposição com Fornecedor e Produtos

SELECT PR.pedido_id, F.nome AS fornecedor_nome, E.quantidade, P.nome AS produto_nome 
FROM PedidoReposicao PR 
JOIN Fornecedor F ON PR.fornecedor_id = F.fornecedor_id 
JOIN Estoque E ON PR.produto_id = E.produto_id
 JOIN Produto P ON E.produto_id = P.produto_id;

--6. Informações de Crediário e Funcionários Responsáveis
SELECT CL.nome AS cliente_nome, CR.limite_credito, CR.saldo_devedor, 
       CO.data_cobranca, F.nome AS funcionario_nome
FROM Crediario CR
JOIN Cliente CL ON CR.cliente_id = CL.cliente_id
JOIN Cobranca CO ON CR.crediario_id = CO.crediario_id
JOIN Funcionario F ON CO.funcionario_id = F.funcionario_id;

