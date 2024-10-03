-- 1. Stored Procedure para obter dados de um funcionário pelo nome
CREATE OR REPLACE PROCEDURE dados_funcionario_nome (
    IN p_nome dom_varchar_100
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT *
    FROM Funcionario
    WHERE nome = p_nome;
END;
$$;

-- 2. Stored Procedure para obter os produtos mais vendidos
CREATE OR REPLACE PROCEDURE produtos_mais_vendidos (
    IN p_limite INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT p.nome, SUM(iv.quantidade) AS total_vendido
    FROM Produto p
    JOIN ItemVenda iv ON p.produto_id = iv.produto_id
    JOIN Venda v ON iv.venda_id = v.venda_id
    GROUP BY p.produto_id
    ORDER BY total_vendido DESC
    LIMIT p_limite;
END;
$$;

-- 3. Stored Procedure para obter os clientes com mais compras
CREATE OR REPLACE PROCEDURE clientes_com_mais_compras (
    IN p_limite INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT c.nome, COUNT(v.venda_id) AS total_compras
    FROM Cliente c
    JOIN Venda v ON c.cliente_id = v.cliente_id
    GROUP BY c.cliente_id
    ORDER BY total_compras DESC
    LIMIT p_limite;
END;
$$;

-- 4. Stored Procedure para obter o funcionário com mais vendas
CREATE OR REPLACE PROCEDURE funcionario_com_mais_vendas ()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT f.nome, COUNT(v.venda_id) AS total_vendas
    FROM Funcionario f
    JOIN Venda v ON f.funcionario_id = v.funcionario_id
    GROUP BY f.funcionario_id
    ORDER BY total_vendas DESC
    LIMIT 1;
END;
$$;

-- 5. Stored Procedure para obter o maior fornecedor baseado no total de produtos fornecidos
CREATE OR REPLACE PROCEDURE maior_fornecedor ()
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT f.nome, SUM(iv.quantidade) AS total_fornecido
    FROM Fornecedor f
    JOIN Produto p ON f.fornecedor_id = p.fornecedor_id
    JOIN Estoque e ON p.produto_id = e.produto_id
    GROUP BY f.fornecedor_id
    ORDER BY total_fornecido DESC
    LIMIT 1;
END;
$$;