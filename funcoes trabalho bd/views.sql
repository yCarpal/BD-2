--Consultas para criação de VIEW:
--Criação de uma view para listar as informações de produtos em estoque por loja:

CREATE VIEW ProdutosEmEstoque AS
SELECT L.nome AS loja_nome, P.nome AS produto_nome, E.quantidade, E.data_atualizacao
FROM Estoque E
JOIN Loja L ON E.loja_id = L.loja_id
JOIN Produto P ON E.produto_id = P.produto_id;

--Criação de uma view para listar todos os clientes e suas respectivas informações de crediário:

CREATE VIEW ClientesCrediario AS
SELECT C.nome AS cliente_nome, C.email, CR.limite_credito, CR.saldo_devedor, CR.data_abertura
FROM Cliente C
JOIN Crediario CR ON C.cliente_id = CR.cliente_id;

--Criação de uma view para listar todas as vendas à vista:

CREATE VIEW VendasAVista AS
SELECT V.venda_id, V.data_venda, V.cliente_total, C.nome AS cliente_nome
FROM Venda V
JOIN Cliente C ON V.cliente_id = C.cliente_id
WHERE V.tipo_venda = 'vista';

--Criação de uma view para listar os funcionários com suas lojas:

CREATE VIEW FuncionariosPorLoja AS
SELECT F.nome AS funcionario_nome, F.cargo, L.nome AS loja_nome
FROM Funcionario F
JOIN Loja L ON F.loja_id = L.loja_id;

--Criação de uma view para listar as parcelas de vendas realizadas no crediário:

CREATE VIEW ParcelasCrediario AS
SELECT P.numero_parcela, P.valor_parcela, P.data_vencimento, V.data_venda, C.nome AS cliente_nome
FROM Parcela P
JOIN Venda V ON P.venda_id = V.venda_id
JOIN Cliente C ON V.cliente_id = C.cliente_id;


