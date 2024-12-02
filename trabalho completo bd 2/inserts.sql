-- Tabela Categoria
INSERT INTO Categoria (nome) VALUES
('Eletrônicos'),
('Roupas'),
('Alimentos'),
('Móveis'),
('Livros'),
('Brinquedos'),
('Esportes'),
('Beleza'),
('Automóveis'),
('Eletrodomésticos');

-- Tabela Produto
INSERT INTO Produto (nome, categoria_id, preco, descricao, data_criacao, data_atualizacao) VALUES
('Smartphone', 1, 1500.00, 'Smartphone com tela de 6.5"', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Camiseta', 2, 39.90, 'Camiseta de algodão', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Arroz', 3, 4.50, 'Arroz 5kg', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Sofá', 4, 799.90, 'Sofá 3 lugares', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Livro A', 5, 29.90, 'Livro de ficção', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Boneca', 6, 69.90, 'Boneca de plástico', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Bola de Futebol', 7, 45.00, 'Bola para futebol', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Shampoo', 8, 19.90, 'Shampoo para cabelos normais', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Carro X', 9, 35000.00, 'Carro usado, 2015', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
('Geladeira', 10, 1200.00, 'Geladeira frost-free', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Tabela Cliente
INSERT INTO Cliente (nome, dtnascimento, email, telefone, endereco, data_cadastro) VALUES
('João Silva', '1990-05-15', 'joao@email.com', '1234567890', 'Rua A, 123', CURRENT_TIMESTAMP),
('Maria Oliveira', '1985-08-25', 'maria@email.com', '1234567891', 'Rua B, 456', CURRENT_TIMESTAMP),
('Pedro Santos', '2000-02-20', 'pedro@email.com', '1234567892', 'Rua C, 789', CURRENT_TIMESTAMP),
('Ana Costa', '1995-11-30', 'ana@email.com', '1234567893', 'Rua D, 101', CURRENT_TIMESTAMP),
('Lucas Pereira', '1988-06-10', 'lucas@email.com', '1234567894', 'Rua E, 202', CURRENT_TIMESTAMP),
('Fernanda Lima', '1993-01-22', 'fernanda@email.com', '1234567895', 'Rua F, 303', CURRENT_TIMESTAMP),
('Juliana Souza', '1987-12-14', 'juliana@email.com', '1234567896', 'Rua G, 404', CURRENT_TIMESTAMP),
('Carlos Almeida', '1979-09-09', 'carlos@email.com', '1234567897', 'Rua H, 505', CURRENT_TIMESTAMP),
('Patricia Martins', '1992-04-19', 'patricia@email.com', '1234567898', 'Rua I, 606', CURRENT_TIMESTAMP),
('Ricardo Barbosa', '1980-11-05', 'ricardo@email.com', '1234567899', 'Rua J, 707', CURRENT_TIMESTAMP);

-- Tabela Fornecedor
INSERT INTO Fornecedor (nome, contato, email, telefone, endereco) VALUES
('Fornecedor A', 'João', 'fornecedorA@email.com', '9876543210', 'Av. Central, 100'),
('Fornecedor B', 'Maria', 'fornecedorB@email.com', '9876543211', 'Av. Norte, 200'),
('Fornecedor C', 'Carlos', 'fornecedorC@email.com', '9876543212', 'Av. Sul, 300'),
('Fornecedor D', 'Fernanda', 'fornecedorD@email.com', '9876543213', 'Av. Leste, 400'),
('Fornecedor E', 'Lucas', 'fornecedorE@email.com', '9876543214', 'Av. Oeste, 500'),
('Fornecedor F', 'Juliana', 'fornecedorF@email.com', '9876543215', 'Rua Principal, 600'),
('Fornecedor G', 'Patricia', 'fornecedorG@email.com', '9876543216', 'Rua Secundária, 700'),
('Fornecedor H', 'Ricardo', 'fornecedorH@email.com', '9876543217', 'Rua Leste, 800'),
('Fornecedor I', 'Ana', 'fornecedorI@email.com', '9876543218', 'Rua Oeste, 900'),
('Fornecedor J', 'Pedro', 'fornecedorJ@email.com', '9876543219', 'Rua Norte, 1000');

-- Tabela Loja
INSERT INTO Loja (nome, endereco, telefone) VALUES
('Loja 1', 'Rua Comercial, 123', '9876543200'),
('Loja 2', 'Avenida Shopping, 456', '9876543201'),
('Loja 3', 'Rua da Moda, 789', '9876543202'),
('Loja 4', 'Avenida Central, 101', '9876543203'),
('Loja 5', 'Rua dos Eletrônicos, 202', '9876543204'),
('Loja 6', 'Rua do Café, 303', '9876543205'),
('Loja 7', 'Avenida Principal, 404', '9876543206'),
('Loja 8', 'Rua de Acessórios, 505', '9876543207'),
('Loja 9', 'Avenida do Centro, 606', '9876543208'),
('Loja 10', 'Rua do Verde, 707', '9876543209');

-- Tabela Funcionario
INSERT INTO Funcionario (nome, email, telefone, cargo, loja_id) VALUES
('Carlos Souza', 'carlos.souza@loja.com', '9876543210', 'Gerente', 1),
('Lucia Lima', 'lucia.lima@loja.com', '9876543211', 'Vendedora', 2),
('Ricardo Alves', 'ricardo.alves@loja.com', '9876543212', 'Caixa', 3),
('Fernanda Costa', 'fernanda.costa@loja.com', '9876543213', 'Assistente', 4),
('Juliana Ribeiro', 'juliana.ribeiro@loja.com', '9876543214', 'Estoquista', 5),
('Ana Oliveira', 'ana.oliveira@loja.com', '9876543215', 'Gerente', 6),
('Lucas Santos', 'lucas.santos@loja.com', '9876543216', 'Vendedor', 7),
('Paula Ferreira', 'paula.ferreira@loja.com', '9876543217', 'Supervisor', 8),
('Ricardo Pereira', 'ricardo.pereira@loja.com', '9876543218', 'Vendedor', 9),
('Patricia Almeida', 'patricia.almeida@loja.com', '9876543219', 'Assistente', 10);

-- Tabela Estoque
INSERT INTO Estoque (produto_id, loja_id, quantidade, data_atualizacao) VALUES
(1, 1, 50, CURRENT_TIMESTAMP),
(2, 2, 100, CURRENT_TIMESTAMP),
(3, 3, 200, CURRENT_TIMESTAMP),
(4, 4, 30, CURRENT_TIMESTAMP),
(5, 5, 75, CURRENT_TIMESTAMP),
(6, 6, 120, CURRENT_TIMESTAMP),
(7, 7, 60, CURRENT_TIMESTAMP),
(8, 8, 90, CURRENT_TIMESTAMP),
(9, 9, 40, CURRENT_TIMESTAMP),
(10, 10, 150, CURRENT_TIMESTAMP);

-- Tabela PedidoReposicao
INSERT INTO PedidoReposicao (data_pedido, situacao, fornecedor_id, valor) VALUES
(CURRENT_TIMESTAMP, 'Pendente', 1, 1000.00),
(CURRENT_TIMESTAMP, 'Pendente', 2, 2000.00),
(CURRENT_TIMESTAMP, 'Pendente', 3, 1500.00),
(CURRENT_TIMESTAMP, 'Pendente', 4, 3000.00),
(CURRENT_TIMESTAMP, 'Pendente', 5, 1200.00),
(CURRENT_TIMESTAMP, 'Pendente', 6, 1800.00),
(CURRENT_TIMESTAMP, 'Pendente', 7, 1300.00),
(CURRENT_TIMESTAMP, 'Pendente', 8, 2500.00),
(CURRENT_TIMESTAMP, 'Pendente', 9, 1600.00),
(CURRENT_TIMESTAMP, 'Pendente', 10, 2200.00);

-- Tabela Crediario
INSERT INTO Crediario (cliente_id, limite_credito, saldo_devedor, data_abertura) VALUES
(1, 500.00, 100.00, CURRENT_TIMESTAMP),
(2, 1000.00, 300.00, CURRENT_TIMESTAMP),
(3, 800.00, 150.00, CURRENT_TIMESTAMP),
(4, 1200.00, 450.00, CURRENT_TIMESTAMP),
(5, 700.00, 200.00, CURRENT_TIMESTAMP),
(6, 950.00, 100.00, CURRENT_TIMESTAMP),
(7, 1100.00, 250.00, CURRENT_TIMESTAMP),
(8, 600.00, 150.00, CURRENT_TIMESTAMP),
(9, 1300.00, 500.00, CURRENT_TIMESTAMP),
(10, 1400.00, 600.00, CURRENT_TIMESTAMP);

-- Tabela Parcela
INSERT INTO Parcela (crediario_id, venda_id, numero_parcela, valor_parcela, data_vencimento) VALUES
(1, 1, 1, 100.00, '2024-12-15'),
(2, 2, 1, 300.00, '2024-12-15'),
(3, 3, 1, 150.00, '2024-12-15'),
(4, 4, 1, 450.00, '2024-12-15'),
(5, 5, 1, 200.00, '2024-12-15'),
(6, 6, 1, 100.00, '2024-12-15'),
(7, 7, 1, 250.00, '2024-12-15'),
(8, 8, 1, 150.00, '2024-12-15'),
(9, 9, 1, 500.00, '2024-12-15'),
(10, 10, 1, 600.00, '2024-12-15');