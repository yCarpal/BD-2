-- 1. Relatório de Vendas com Detalhes do Cliente, Produto e Item Vendido
SELECT v.venda_id, c.nome AS cliente, p.nome AS produto, iv.quantidade, iv.preco_unitario, v.data_venda
FROM Venda v
JOIN Cliente c ON v.cliente_id = c.cliente_id
JOIN ItemVenda iv ON v.venda_id = iv.venda_id
JOIN Produto p ON iv.produto_id = p.produto_id;

-- 2. Relatório de Estoque de Produtos por Loja
SELECT l.nome AS loja, p.nome AS produto, e.quantidade
FROM Estoque e
JOIN Loja l ON e.loja_id = l.loja_id
JOIN Produto p ON e.produto_id = p.produto_id;

-- 3. Relatório de Crediário com Detalhes do Cliente e Saldo Devedor
SELECT c.nome AS cliente, cr.limite_credito, cr.saldo_devedor
FROM Crediario cr
JOIN Cliente c ON cr.cliente_id = c.cliente_id;

-- 4. Relatório de Pedidos de Reposição com Fornecedor e Situação
SELECT pr.pedido_id, f.nome AS fornecedor, pr.situacao, pr.valor
FROM PedidoReposicao pr
JOIN Fornecedor f ON pr.fornecedor_id = f.fornecedor_id;

-- 5. Relatório de Cobranças com Funcionário e Status de Cobrança
SELECT cb.cobranca_id, c.nome AS cliente, f.nome AS funcionario, cb.status_cobranca, cb.data_cobranca
FROM Cobranca cb
JOIN Crediario cr ON cb.crediario_id = cr.crediario_id
JOIN Cliente c ON cr.cliente_id = c.cliente_id
JOIN Funcionario f ON cb.funcionario_id = f.funcionario_id;

-- 6. Relatório de Pedidos e Itens Vendidos com Detalhes de Produto
SELECT p.nome AS produto, iv.quantidade, iv.preco_unitario, pr.situacao
FROM PedidoReposicao pr
JOIN PedidoItem pi ON pr.pedido_id = pi.pedido_id
JOIN Produto p ON pi.produto_id = p.produto_id
JOIN ItemVenda iv ON p.produto_id = iv.produto_id;


-- VIEWS
-- 1. View para Vendas com Detalhes de Cliente e Item
CREATE OR REPLACE VIEW view_vendas_detalhadas AS
SELECT v.venda_id, c.nome AS cliente, p.nome AS produto, iv.quantidade, iv.preco_unitario, v.data_venda
FROM Venda v
JOIN Cliente c ON v.cliente_id = c.cliente_id
JOIN ItemVenda iv ON v.venda_id = iv.venda_id
JOIN Produto p ON iv.produto_id = p.produto_id;

-- 2. View para Estoque por Loja e Produto
CREATE OR REPLACE VIEW view_estoque_lojas AS
SELECT l.nome AS loja, p.nome AS produto, e.quantidade
FROM Estoque e
JOIN Loja l ON e.loja_id = l.loja_id
JOIN Produto p ON e.produto_id = p.produto_id;

-- 3. View para Crediário de Clientes com Saldo Devedor
CREATE OR REPLACE VIEW view_crediario_clientes AS
SELECT c.nome AS cliente, cr.limite_credito, cr.saldo_devedor
FROM Crediario cr
JOIN Cliente c ON cr.cliente_id = c.cliente_id;

-- 4. View para Pedidos de Reposição com Fornecedor
CREATE OR REPLACE VIEW view_pedidos_reposicao AS
SELECT pr.pedido_id, f.nome AS fornecedor, pr.situacao, pr.valor
FROM PedidoReposicao pr
JOIN Fornecedor f ON pr.fornecedor_id = f.fornecedor_id;

-- 5. View para Cobranças com Detalhes de Funcionario
CREATE OR REPLACE VIEW view_cobrancas_funcionarios AS
SELECT cb.cobranca_id, c.nome AS cliente, f.nome AS funcionario, cb.status_cobranca
FROM Cobranca cb
JOIN Crediario cr ON cb.crediario_id = cr.crediario_id
JOIN Cliente c ON cr.cliente_id = c.cliente_id
JOIN Funcionario f ON cb.funcionario_id = f.funcionario_id;

-- STORED PROCEDURES

-- 1. Stored Procedure para Inserir um Novo Produto
CREATE OR REPLACE PROCEDURE sp_inserir_produto(
    p_nome VARCHAR,
    p_categoria_id INTEGER,
    p_preco DECIMAL(10, 2),
    p_descricao TEXT
) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO Produto (nome, categoria_id, preco, descricao, data_criacao, data_atualizacao)
    VALUES (p_nome, p_categoria_id, p_preco, p_descricao, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
END;
$$;

-- 2. Stored Procedure para Atualizar o Estoque de um Produto
CREATE OR REPLACE PROCEDURE sp_atualizar_estoque(
    p_produto_id INTEGER,
    p_loja_id INTEGER,
    p_quantidade DECIMAL
) LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Estoque
    SET quantidade = p_quantidade, data_atualizacao = CURRENT_TIMESTAMP
    WHERE produto_id = p_produto_id AND loja_id = p_loja_id;
END;
$$;

-- 3. Stored Procedure para Registrar Cobrança de um Crediário
CREATE OR REPLACE PROCEDURE sp_registrar_cobranca(
    p_crediario_id INTEGER,
    p_funcionario_id INTEGER,
    p_valor_cobrado DECIMAL(10, 2),
    p_data_cobranca DATE
) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO Cobranca (crediario_id, funcionario_id, valor_cobrado, data_cobranca, status_cobranca)
    VALUES (p_crediario_id, p_funcionario_id, p_valor_cobrado, p_data_cobranca, 'Pendente');
END;
$$;

-- 4. Stored Procedure para Adicionar um Cliente ao Sistema
CREATE OR REPLACE PROCEDURE sp_adicionar_cliente(
    p_nome VARCHAR,
    p_cpf VARCHAR,
    p_email VARCHAR,
    p_telefone VARCHAR
) LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO Cliente (nome, cpf, email, telefone, data_criacao)
    VALUES (p_nome, p_cpf, p_email, p_telefone, CURRENT_TIMESTAMP);
END;
$$;

-- 5. Stored Procedure para Atualizar o Limite de Crédito de um Cliente
CREATE OR REPLACE PROCEDURE sp_atualizar_limite_credito(
    p_cliente_id INTEGER,
    p_novo_limite DECIMAL(10, 2)
) LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Crediario
    SET limite_credito = p_novo_limite, data_atualizacao = CURRENT_TIMESTAMP
    WHERE cliente_id = p_cliente_id;
END;
$$;

-- FUNCTIONS

-- 1. Function para Calcular o Total Vendido de um Produto
CREATE OR REPLACE FUNCTION fn_total_vendido_produto(p_produto_id INTEGER)
RETURNS DECIMAL(10, 2) AS $$
DECLARE
    total_vendido DECIMAL(10, 2);
BEGIN
    SELECT SUM(iv.quantidade) INTO total_vendido
    FROM ItemVenda iv
    WHERE iv.produto_id = p_produto_id;

    RETURN COALESCE(total_vendido, 0);
END;
$$ LANGUAGE plpgsql;

-- 2. Function para Calcular o Saldo Devedor de um Cliente
CREATE OR REPLACE FUNCTION fn_saldo_devedor_cliente(p_cliente_id INTEGER)
RETURNS DECIMAL(10, 2) AS $$
DECLARE
    saldo_devedor DECIMAL(10, 2);
BEGIN
    SELECT saldo_devedor INTO saldo_devedor
    FROM Crediario
    WHERE cliente_id = p_cliente_id;

    RETURN COALESCE(saldo_devedor, 0);
END;
$$ LANGUAGE plpgsql;

-- 3. Function para Calcular o Total de um Pedido de Reposição
CREATE OR REPLACE FUNCTION fn_total_pedido_reposicao(p_pedido_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    total_pedido DECIMAL;
BEGIN
    SELECT SUM(pi.quantidade * p.preco) INTO total_pedido
    FROM PedidoItem pi
    JOIN Produto p ON pi.produto_id = p.produto_id
    WHERE pi.pedido_id = p_pedido_id;

    RETURN COALESCE(total_pedido, 0);
END;
$$ LANGUAGE plpgsql;

-- 4. Function para Mostrar o Limite de Crédito Disponível de um Cliente
CREATE OR REPLACE FUNCTION fn_limite_credito_disponivel(p_cliente_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    limite_disponivel DECIMAL;
BEGIN
    SELECT (limite_credito - saldo_devedor) INTO limite_disponivel
    FROM Crediario
    WHERE cliente_id = p_cliente_id;

    RETURN COALESCE(limite_disponivel, 0);
END;
$$ LANGUAGE plpgsql;

-- 5. Function para Mostrar a Quantidade de Produtos em Estoque para uma Loja
CREATE OR REPLACE FUNCTION fn_estoque_produto_loja(p_produto_id INTEGER, p_loja_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    quantidade_estoque DECIMAL;
BEGIN
    SELECT quantidade INTO quantidade_estoque
    FROM Estoque
    WHERE produto_id = p_produto_id AND loja_id = p_loja_id;

    RETURN COALESCE(quantidade_estoque, 0);
END;
$$ LANGUAGE plpgsql;

-- 6. Function para Calcular o Total de Vendas de um Cliente
CREATE OR REPLACE FUNCTION fn_total_vendas_cliente(p_cliente_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    total_vendas DECIMAL;
BEGIN
    SELECT SUM(iv.quantidade * iv.preco_unitario) INTO total_vendas
    FROM ItemVenda iv
    JOIN Venda v ON iv.venda_id = v.venda_id
    WHERE v.cliente_id = p_cliente_id;

    RETURN COALESCE(total_vendas, 0);
END;
$$ LANGUAGE plpgsql;

-- 7. Function para Calcular o Total de Pedidos de Reposição Pendentes
CREATE OR REPLACE FUNCTION fn_total_pedidos_pendentes()
RETURNS DECIMAL AS $$
DECLARE
    total_pendentes DECIMAL;
BEGIN
    SELECT SUM(pr.valor) INTO total_pendentes
    FROM PedidoReposicao pr
    WHERE pr.situacao = 'Pendente';

    RETURN COALESCE(total_pendentes, 0);
END;
$$ LANGUAGE plpgsql;

-- 8. Function para Verificar a Quantidade de Produtos em Estoque
CREATE OR REPLACE FUNCTION fn_verificar_estoque_produto(p_produto_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    quantidade_estoque DECIMAL;
BEGIN
    SELECT SUM(e.quantidade) INTO quantidade_estoque
    FROM Estoque e
    WHERE e.produto_id = p_produto_id;

    RETURN COALESCE(quantidade_estoque, 0);
END;
$$ LANGUAGE plpgsql;

-- 9. Function para Obter o Preço Total de um Produto no Estoque de uma Loja
CREATE OR REPLACE FUNCTION fn_preco_total_estoque(p_produto_id INTEGER, p_loja_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    preco_total DECIMAL;
BEGIN
    SELECT e.quantidade * p.preco INTO preco_total
    FROM Estoque e
    JOIN Produto p ON e.produto_id = p.produto_id
    WHERE e.produto_id = p_produto_id AND e.loja_id = p_loja_id;

    RETURN COALESCE(preco_total, 0);
END;
$$ LANGUAGE plpgsql;

-- 10. Function para Calcular o Limite de Crédito Total de Todos os Clientes
CREATE OR REPLACE FUNCTION fn_limite_credito_total()
RETURNS DECIMAL AS $$
DECLARE
    limite_total DECIMAL;
BEGIN
    SELECT SUM(limite_credito) INTO limite_total
    FROM Crediario;

    RETURN COALESCE(limite_total, 0);
END;
$$ LANGUAGE plpgsql;

-- 11. Function para Contar o Número de Vendas Realizadas por Cliente
CREATE OR REPLACE FUNCTION fn_num_vendas_cliente(p_cliente_id INTEGER)
RETURNS INTEGER AS $$
DECLARE
    num_vendas INTEGER;
BEGIN
    SELECT COUNT(*) INTO num_vendas
    FROM Venda
    WHERE cliente_id = p_cliente_id;

    RETURN COALESCE(num_vendas, 0);
END;
$$ LANGUAGE plpgsql;

-- 12. Function para Calcular o Desconto Total Aplicado em Vendas
CREATE OR REPLACE FUNCTION fn_total_desconto_vendas(p_venda_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    total_desconto DECIMAL;
BEGIN
    SELECT SUM(iv.quantidade * iv.preco_unitario * (iv.desconto / 100)) INTO total_desconto
    FROM ItemVenda iv
    WHERE iv.venda_id = p_venda_id;

    RETURN COALESCE(total_desconto, 0);
END;
$$ LANGUAGE plpgsql;

-- 13. Function para Calcular o Total de Vendas de um Produto Específico
CREATE OR REPLACE FUNCTION fn_total_vendas_produto(p_produto_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    total_produto DECIMAL;
BEGIN
    SELECT SUM(iv.quantidade * iv.preco_unitario) INTO total_produto
    FROM ItemVenda iv
    WHERE iv.produto_id = p_produto_id;

    RETURN COALESCE(total_produto, 0);
END;
$$ LANGUAGE plpgsql;

-- 14. Function para Calcular o Valor Médio de Venda por Cliente
CREATE OR REPLACE FUNCTION fn_valor_medio_venda_cliente(p_cliente_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    media_venda DECIMAL;
BEGIN
    SELECT AVG(iv.quantidade * iv.preco_unitario) INTO media_venda
    FROM ItemVenda iv
    JOIN Venda v ON iv.venda_id = v.venda_id
    WHERE v.cliente_id = p_cliente_id;

    RETURN COALESCE(media_venda, 0);
END;
$$ LANGUAGE plpgsql;

-- 15. Function para Verificar o Total de Produtos Vendidos em um Período Específico
CREATE OR REPLACE FUNCTION fn_total_produtos_vendidos_periodo(p_data_inicial DATE, p_data_final DATE)
RETURNS DECIMAL AS $$
DECLARE
    total_produtos DECIMAL;
BEGIN
    SELECT SUM(iv.quantidade) INTO total_produtos
    FROM ItemVenda iv
    JOIN Venda v ON iv.venda_id = v.venda_id
    WHERE v.data_venda BETWEEN p_data_inicial AND p_data_final;

    RETURN COALESCE(total_produtos, 0);
END;
$$ LANGUAGE plpgsql;


-- TRIGGERS
-- TRIGGERS
-- 1. Trigger para Atualizar Data de Atualização do Produto ao Alterar o Preço
CREATE OR REPLACE FUNCTION fn_atualizar_data_produto()
RETURNS TRIGGER AS $$
BEGIN
    NEW.data_atualizacao = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_data_produto
BEFORE UPDATE ON Produto
FOR EACH ROW
WHEN (OLD.preco IS DISTINCT FROM NEW.preco)
EXECUTE FUNCTION fn_atualizar_data_produto();

-- 2. Trigger para Atualizar Estoque Após Venda
CREATE OR REPLACE FUNCTION fn_atualizar_estoque_venda()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Estoque
    SET quantidade = quantidade - NEW.quantidade, data_atualizacao = CURRENT_TIMESTAMP
    WHERE produto_id = NEW.produto_id AND loja_id IN (
        SELECT loja_id FROM Funcionario WHERE funcionario_id = (SELECT funcionario_id FROM Venda WHERE venda_id = NEW.venda_id)
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_estoque_venda
AFTER INSERT ON ItemVenda
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_estoque_venda();

-- 3. Trigger para Atualizar Status de Cobranca
CREATE OR REPLACE FUNCTION fn_atualizar_status_cobranca()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.valor_cobrado >= (SELECT saldo_devedor FROM Crediario WHERE crediario_id = NEW.crediario_id) THEN
        NEW.status_cobranca = 'Pago';
    ELSE
        NEW.status_cobranca = 'Pendente';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_status_cobranca
BEFORE UPDATE ON Cobranca
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_status_cobranca();

-- 4. Trigger para Verificar o Saldo do Crediário Antes de Atualizar
CREATE OR REPLACE FUNCTION fn_verificar_saldo_crediario()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.saldo_devedor < 0 THEN
        RAISE EXCEPTION 'Saldo devedor não pode ser negativo.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verificar_saldo_crediario
BEFORE UPDATE ON Crediario
FOR EACH ROW
EXECUTE FUNCTION fn_verificar_saldo_crediario();

-- 5. Trigger para Atualizar a Data de Última Compra ao Inserir um Novo Pedido
CREATE OR REPLACE FUNCTION fn_atualizar_ultima_compra_cliente()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Cliente
    SET ultima_compra = CURRENT_TIMESTAMP
    WHERE cliente_id = NEW.cliente_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_ultima_compra_cliente
AFTER INSERT ON Pedido
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_ultima_compra_cliente();


-- Transações 

BEGIN;

-- Inserir um novo cliente
INSERT INTO Cliente (nome, dtnascimento, email, telefone, endereco, data_cadastro) 
VALUES ('João Silva', '1985-06-15', 'joao.silva@email.com', '123456789', 'Rua Exemplo, 123', CURRENT_TIMESTAMP);

-- Inserir uma nova venda para o cliente João Silva
INSERT INTO Venda (data_venda, cliente_id, total, tipo_venda) 
VALUES (CURRENT_TIMESTAMP, (SELECT cliente_id FROM Cliente WHERE nome = 'João Silva'), 500.00, 'vista');

-- Inserir itens para a venda
INSERT INTO ItemVenda (venda_id, produto_id, quantidade, preco_unitario)
VALUES 
    ((SELECT venda_id FROM Venda WHERE cliente_id = (SELECT cliente_id FROM Cliente WHERE nome = 'João Silva') AND tipo_venda = 'vista'), 1, 2, 100.00),
    ((SELECT venda_id FROM Venda WHERE cliente_id = (SELECT cliente_id FROM Cliente WHERE nome = 'João Silva') AND tipo_venda = 'vista'), 2, 1, 200.00);


COMMIT;

-- Caso haja algum erro, a transação pode ser revertida com ROLLBACK.
-- ROLLBACK;

--2

BEGIN;

-- Atualizar a quantidade de um produto em estoque
UPDATE Estoque 
SET quantidade = quantidade + 50, data_atualizacao = CURRENT_TIMESTAMP 
WHERE produto_id = 1 AND loja_id = 1;

-- Inserir um pedido de reposição para o fornecedor
INSERT INTO PedidoReposicao (data_pedido, situacao, fornecedor_id, valor) 
VALUES (CURRENT_TIMESTAMP, 'pendente', 1, 500.00);

-- Commit para confirmar a transação
COMMIT;

-- Caso haja algum erro, a transação pode ser revertida com ROLLBACK.
-- ROLLBACK;

--3
BEGIN;

-- Registrar o pagamento de uma parcela de crediário
UPDATE Parcela
SET valor_parcela = 0.00, data_vencimento = CURRENT_DATE
WHERE parcela_id = 1 AND valor_parcela > 0;

-- Criar um registro de cobrança
INSERT INTO Cobranca (crediario_id, funcionario_id, data_cobranca, status_cobranca, observacoes) 
VALUES (1, 2, CURRENT_TIMESTAMP, 'paga', 'Pagamento realizado com sucesso');

-- Atualizar o saldo devedor do cliente
UPDATE Crediario
SET saldo_devedor = saldo_devedor - 100.00
WHERE crediario_id = 1;

-- Commit para confirmar a transação
COMMIT;

-- Caso haja algum erro, a transação pode ser revertida com ROLLBACK.
-- ROLLBACK;