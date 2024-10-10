-- 1. Relatório de vendas com detalhes do cliente, produto e item vendido
SELECT v.venda_id, c.nome AS cliente, p.nome AS produto, iv.quantidade, iv.preco_unitario, v.data_venda
FROM Venda v
JOIN Cliente c ON v.cliente_id = c.cliente_id
JOIN ItemVenda iv ON v.venda_id = iv.venda_id
JOIN Produto p ON iv.produto_id = p.produto_id;

-- 2. Relatório de estoque de produtos por loja
SELECT l.nome AS loja, p.nome AS produto, e.quantidade
FROM Estoque e
JOIN Loja l ON e.loja_id = l.loja_id
JOIN Produto p ON e.produto_id = p.produto_id;

-- 3. Relatório de crediário com detalhes do cliente e saldo devedor
SELECT c.nome AS cliente, cr.limite_credito, cr.saldo_devedor
FROM Crediario cr
JOIN Cliente c ON cr.cliente_id = c.cliente_id;

-- 4. Relatório de pedidos de reposição com fornecedor e situação
SELECT pr.pedido_id, f.nome AS fornecedor, pr.situacao, pr.valor
FROM PedidoReposicao pr
JOIN Fornecedor f ON pr.fornecedor_id = f.fornecedor_id;

-- 5. Relatório de cobranças com funcionário e status de cobrança
SELECT cb.cobranca_id, c.nome AS cliente, f.nome AS funcionario, cb.status_cobranca, cb.data_cobranca
FROM Cobranca cb
JOIN Crediario cr ON cb.crediario_id = cr.crediario_id
JOIN Cliente c ON cr.cliente_id = c.cliente_id
JOIN Funcionario f ON cb.funcionario_id = f.funcionario_id;

---VIEWS

-- 1. View para vendas com detalhes de cliente e item
CREATE VIEW view_vendas_detalhadas AS
SELECT v.venda_id, c.nome AS cliente, p.nome AS produto, iv.quantidade, iv.preco_unitario, v.data_venda
FROM Venda v
JOIN Cliente c ON v.cliente_id = c.cliente_id
JOIN ItemVenda iv ON v.venda_id = iv.venda_id
JOIN Produto p ON iv.produto_id = p.produto_id;

-- 2. View para estoque por loja e produto
CREATE VIEW view_estoque_lojas AS
SELECT l.nome AS loja, p.nome AS produto, e.quantidade
FROM Estoque e
JOIN Loja l ON e.loja_id = l.loja_id
JOIN Produto p ON e.produto_id = p.produto_id;

-- 3. View para crediário de clientes com saldo devedor
CREATE VIEW view_crediario_clientes AS
SELECT c.nome AS cliente, cr.limite_credito, cr.saldo_devedor
FROM Crediario cr
JOIN Cliente c ON cr.cliente_id = c.cliente_id;

-- 4. View para pedidos de reposição
CREATE VIEW view_pedidos_reposicao AS
SELECT pr.pedido_id, f.nome AS fornecedor, pr.situacao, pr.valor
FROM PedidoReposicao pr
JOIN Fornecedor f ON pr.fornecedor_id = f.fornecedor_id;

--- STORED PRCEDURES
-- 1. Stored Procedure para inserir um novo produto
CREATE OR REPLACE PROCEDURE sp_inserir_produto(
    p_nome dom_varchar_40,
    p_categoria_id INTEGER,
    p_preco dom_decimal,
    p_descricao dom_text)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Produto (nome, categoria_id, preco, descricao, data_criacao, data_atualizacao)
    VALUES (p_nome, p_categoria_id, p_preco, p_descricao, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
END;
$$;

-- 2. Stored Procedure para atualizar o estoque de um produto
CREATE OR REPLACE PROCEDURE sp_atualizar_estoque(
    p_produto_id INTEGER,
    p_loja_id INTEGER,
    p_quantidade dom_decimal)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Estoque
    SET quantidade = p_quantidade, data_atualizacao = CURRENT_TIMESTAMP
    WHERE produto_id = p_produto_id AND loja_id = p_loja_id;
END;
$$;

CREATE PROCEDURE sp_registrar_cobranca(
    p_crediario_id INTEGER,
    p_funcionario_id INTEGER,
    p_valor_cobrado dom_decimal,
    p_data_cobranca DATE)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Cobranca (crediario_id, funcionario_id, valor_cobrado, data_cobranca, status_cobranca)
    VALUES (p_crediario_id, p_funcionario_id, p_valor_cobrado, p_data_cobranca, 'Pendente');
END;
$$;

CREATE OR REPLACE PROCEDURE sp_adicionar_cliente(
    p_nome dom_varchar_40,
    p_cpf dom_varchar_14,
    p_email dom_varchar_60,
    p_telefone dom_varchar_20)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Cliente (nome, cpf, email, telefone, data_criacao)
    VALUES (p_nome, p_cpf, p_email, p_telefone, CURRENT_TIMESTAMP);
END;
$$;

CREATE OR REPLACE PROCEDURE sp_atualizar_limite_credito(
    p_cliente_id INTEGER,
    p_novo_limite dom_decimal)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Crediario
    SET limite_credito = p_novo_limite, data_atualizacao = CURRENT_TIMESTAMP
    WHERE cliente_id = p_cliente_id;
END;
$$;

--- FUNCTIONS

-- 1. Function para calcular o total vendido de um produto
CREATE OR REPLACE FUNCTION fn_total_vendido_produto(p_produto_id INTEGER)
RETURNS dom_decimal AS $$
DECLARE
    total_vendido dom_decimal;
BEGIN
    SELECT SUM(iv.quantidade) INTO total_vendido
    FROM ItemVenda iv
    WHERE iv.produto_id = p_produto_id;

    RETURN COALESCE(total_vendido, 0);
END;
$$ LANGUAGE plpgsql;

-- 2. Function para calcular o saldo devedor de um cliente
CREATE OR REPLACE FUNCTION fn_saldo_devedor_cliente(p_cliente_id INTEGER)
RETURNS dom_decimal AS $$
DECLARE
    saldo_devedor dom_decimal;
BEGIN
    SELECT saldo_devedor INTO saldo_devedor
    FROM Crediario
    WHERE cliente_id = p_cliente_id;

    RETURN COALESCE(saldo_devedor, 0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_total_pedido_reposicao(p_pedido_id INTEGER)
RETURNS dom_decimal AS $$
DECLARE
    total_pedido dom_decimal;
BEGIN
    SELECT SUM(valor) INTO total_pedido
    FROM PedidoItem
    WHERE pedido_id = p_pedido_id;

    RETURN COALESCE(total_pedido, 0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_limite_credito_disponivel(p_cliente_id INTEGER)
RETURNS dom_decimal AS $$
DECLARE
    limite_disponivel dom_decimal;
BEGIN
    SELECT (limite_credito - saldo_devedor) INTO limite_disponivel
    FROM Crediario
    WHERE cliente_id = p_cliente_id;

    RETURN COALESCE(limite_disponivel, 0);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_estoque_produto_loja(p_produto_id INTEGER, p_loja_id INTEGER)
RETURNS dom_decimal AS $$
DECLARE
    quantidade_estoque dom_decimal;
BEGIN
    SELECT quantidade INTO quantidade_estoque
    FROM Estoque
    WHERE produto_id = p_produto_id AND loja_id = p_loja_id;

    RETURN COALESCE(quantidade_estoque, 0);
END;
$$ LANGUAGE plpgsql;


---TRIGGERS 

-- 1. Trigger para atualizar a data de atualização do produto ao alterar o preço
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

-- 2. Trigger para registrar automaticamente o valor do estoque ao inserir uma venda
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

CREATE OR REPLACE FUNCTION fn_atualizar_total_vendas()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Venda
    SET total_venda = (SELECT SUM(iv.preco_unitario * iv.quantidade) FROM ItemVenda iv WHERE iv.venda_id = NEW.venda_id)
    WHERE venda_id = NEW.venda_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualizar_total_vendas
AFTER INSERT ON ItemVenda
FOR EACH ROW
EXECUTE FUNCTION fn_atualizar_total_vendas();