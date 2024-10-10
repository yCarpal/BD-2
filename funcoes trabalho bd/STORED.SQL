-- STORED PRCEDURES
---Paulo Junior Gomes e Leonardo Cutrim
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
---Paulo Junior Gomes e Leonardo Cutrim
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
