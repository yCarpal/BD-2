---View 
--LEONARDO CUTRIM E PAULO OLIVEIRA

--1. Produtos em Estoque por Loja
CREATE VIEW ProdutosEmEstoque AS
SELECT L.nome AS loja_nome, P.nome AS produto_nome, E.quantidade, E.data_atualizacao
FROM Estoque E
JOIN Loja L ON E.loja_id = L.loja_id
JOIN Produto P ON E.produto_id = P.produto_id;

--2. Clientes e Informações de Crediário
CREATE VIEW ClientesCrediario AS
SELECT C.nome AS cliente_nome, C.email, CR.limite_credito, 
       CR.saldo_devedor, CR.data_abertura
FROM Cliente C
JOIN Crediario CR ON C.cliente_id = CR.cliente_id;

--3. Vendas à Vista
CREATE VIEW VendasAVista AS
SELECT V.venda_id, V.data_venda, V.cliente_total, C.nome AS cliente_nome
FROM Venda V
JOIN Cliente C ON V.cliente_id = C.cliente_id
WHERE V.tipo_venda = 'vista';

--4. Funcionários com Suas Lojas
CREATE VIEW FuncionariosPorLoja AS
SELECT F.nome AS funcionario_nome, F.cargo, L.nome AS loja_nome
FROM Funcionario F
JOIN Loja L ON F.loja_id = L.loja_id;

--5. Parcelas de Vendas Realizadas no Crediário
CREATE VIEW ParcelasCrediario AS
SELECT P.numero_parcela, P.valor_parcela, P.data_vencimento, 
       V.data_venda, C.nome AS cliente_nome
FROM Parcela P
JOIN Venda V ON P.venda_id = V.venda_id
JOIN Cliente C ON V.cliente_id = C.cliente_id;

