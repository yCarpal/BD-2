--- TAREFA DE STORED PROCEDURES E FUNCTIONS---
---PAULO GOMES E LENOARDO CUTRIM

-- 1. Stored Procedure para inserir um novo produto
CREATE OR REPLACE PROCEDURE sp_inserir_produto(
    p_nome VARCHAR(40),
    p_categoria_id INTEGER,
    p_preco DECIMAL,
    p_descricao TEXT)
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
    p_quantidade DECIMAL)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Estoque
    SET quantidade = p_quantidade, data_atualizacao = CURRENT_TIMESTAMP
    WHERE produto_id = p_produto_id AND loja_id = p_loja_id;
END;
$$;

-- 3. Stored Procedure para registrar cobrança
CREATE PROCEDURE sp_registrar_cobranca(
    p_crediario_id INTEGER,
    p_funcionario_id INTEGER,
    p_valor_cobrado DECIMAL,
    p_data_cobranca DATE)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Cobranca (crediario_id, funcionario_id, valor_cobrado, data_cobranca, status_cobranca)
    VALUES (p_crediario_id, p_funcionario_id, p_valor_cobrado, p_data_cobranca, 'Pendente');
END;
$$;

-- 4. Stored Procedure para adicionar cliente
CREATE OR REPLACE PROCEDURE sp_adicionar_cliente(
    p_nome VARCHAR(40),
    p_cpf VARCHAR(14),
    p_email VARCHAR(60),
    p_telefone VARCHAR(20))
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO Cliente (nome, cpf, email, telefone, data_criacao)
    VALUES (p_nome, p_cpf, p_email, p_telefone, CURRENT_TIMESTAMP);
END;
$$;

-- 5. Stored Procedure para atualizar limite de crédito
CREATE OR REPLACE PROCEDURE sp_atualizar_limite_credito(
    p_cliente_id INTEGER,
    p_novo_limite DECIMAL)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Crediario
    SET limite_credito = p_novo_limite, data_atualizacao = CURRENT_TIMESTAMP
    WHERE cliente_id = p_cliente_id;
END;
$$;

-- FUNCTIONS

-- 1. Function para calcular o total vendido de um produto
CREATE OR REPLACE FUNCTION fn_total_vendido_produto(p_produto_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    total_vendido DECIMAL;
BEGIN
    SELECT SUM(iv.quantidade) INTO total_vendido
    FROM ItemVenda iv
    WHERE iv.produto_id = p_produto_id;

    RETURN COALESCE(total_vendido, 0);
END;
$$ LANGUAGE plpgsql;

-- 2. Function para calcular o saldo devedor de um cliente
CREATE OR REPLACE FUNCTION fn_saldo_devedor_cliente(p_cliente_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    saldo_devedor DECIMAL;
BEGIN
    SELECT saldo_devedor INTO saldo_devedor
    FROM Crediario
    WHERE cliente_id = p_cliente_id;

    RETURN COALESCE(saldo_devedor, 0);
END;
$$ LANGUAGE plpgsql;

-- 3. Function para calcular o total de um pedido de reposição
CREATE OR REPLACE FUNCTION fn_total_pedido_reposicao(p_pedido_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    total_pedido DECIMAL;
BEGIN
    SELECT SUM(valor) INTO total_pedido
    FROM PedidoItem
    WHERE pedido_id = p_pedido_id;

    RETURN COALESCE(total_pedido, 0);
END;
$$ LANGUAGE plpgsql;

-- 4. Function para calcular o limite de crédito disponível de um cliente
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

-- 5. Function para calcular o estoque de um produto em uma loja
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