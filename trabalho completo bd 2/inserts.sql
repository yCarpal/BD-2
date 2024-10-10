-- Inserções na tabela Categoria
INSERT INTO Categoria (nome) VALUES
    ('Eletrônicos'),
    ('Roupas'),
    ('Alimentos'),
    ('Livros'),
    ('Decoração');

-- Inserções na tabela Produto
INSERT INTO Produto (nome, categoria_id, preco, descricao, data_criacao, data_atualizacao) VALUES
    ('Smartphone XYZ', 1, 1500.00, 'Smartphone avançado com câmera de alta resolução.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Camiseta Preta', 2, 29.99, 'Camiseta básica na cor preta, tamanho M.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Arroz Integral', 3, 5.99, 'Pacote de 1kg de arroz integral.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Livro de Ficção', 4, 39.90, 'Best-seller de um autor renomado.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('Vaso Decorativo', 5, 49.99, 'Vaso decorativo para plantas.', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Inserções na tabela Loja
INSERT INTO Loja (nome, endereco, telefone) VALUES
    ('Loja Pormenos', 'Av. Farrapos, 123, Porto Alegre, RS', '(51) 91234-5678'),
    ('Loja gzt', 'Rua da Praia, 456, Porto Alegre, RS', '(51) 95678-9012'),
    ('Loja Grazziotin', 'Av. Rio Branco, 789, Santa Maria, RS', '(55) 99876-5432'),
    ('Loja Franco Giorgi', 'Rua dos Andradas, 321, Porto Alegre, RS', '(51) 96543-2109'),
    ('Loja Tottal', 'Av. Salgado Filho, 987, Canoas, RS', '(51) 98765-4321');

-- Inserções na tabela Cliente
INSERT INTO Cliente (nome, email, telefone, endereco, data_cadastro) VALUES
    ('João Silva', 'joao.silva@email.com', '(11) 99999-8888', 'Rua A, 123, São Paulo, SP', CURRENT_TIMESTAMP),
    ('Maria Santos', 'maria.santos@email.com', '(21) 99876-5432', 'Av. B, 456, Rio de Janeiro, RJ', CURRENT_TIMESTAMP),
    ('Carlos Oliveira', 'carlos.oliveira@email.com', '(31) 91234-5678', 'Rua C, 789, Belo Horizonte, MG', CURRENT_TIMESTAMP),
    ('Ana Souza', 'ana.souza@email.com', '(85) 92222-3333', 'Av. D, 987, Fortaleza, CE', CURRENT_TIMESTAMP),
    ('Pedro Costa', 'pedro.costa@email.com', '(41) 98765-4321', 'Rua E, 654, Curitiba, PR', CURRENT_TIMESTAMP);

-- Inserções na tabela Fornecedor
INSERT INTO Fornecedor (nome, contato, email, telefone, endereco) VALUES
    ('Fornecedor Eletrônicos Ltda', 'Fulano de Tal', 'contato@fornecedoreletronicos.com', '(11) 91111-2222', 'Av. X, 789, São Paulo, SP'),
    ('Fornecedor Moda Ltda', 'Ciclano de Almeida', 'contato@fornecedormoda.com', '(21) 93333-4444', 'Rua Y, 456, Rio de Janeiro, RJ'),
    ('Distribuidora Alimentos S.A.', 'Beltrano Pereira', 'contato@distribuidoraalimentos.com', '(31) 95555-6666', 'Av. Z, 123, Belo Horizonte, MG'),
    ('Livraria Cultural', 'Atendimento ao Cliente', 'atendimento@livrariacultural.com', '(81) 97777-8888', 'Rua W, 321, Recife, PE'),
    ('Decorações Mais Bonitas', 'Maria da Silva', 'contato@decoracoes.com', '(41) 9999-0000', 'Av. V, 987, Curitiba, PR');

-- Inserções na tabela Funcionario
INSERT INTO Funcionario (nome, email, telefone, cargo, loja_id) VALUES
    ('José Santos', 'jose.santos@email.com', '(11) 91111-1111', 'Vendedor', 1),
    ('Mariana Lima', 'mariana.lima@email.com', '(21) 92222-2222', 'Gerente', 2),
    ('Rafaela Oliveira', 'rafaela.oliveira@email.com', '(31) 93333-3333', 'Caixa', 3),
    ('Paulo Pereira', 'paulo.pereira@email.com', '(85) 94444-4444', 'Supervisor', 4),
    ('Fernanda Souza', 'fernanda.souza@email.com', '(41) 95555-5555', 'Vendedor', 5);

-- Inserções na tabela Estoque
INSERT INTO Estoque (produto_id, loja_id, quantidade, data_atualizacao) VALUES
    (1, 1, 100, CURRENT_TIMESTAMP),
    (2, 1, 200, CURRENT_TIMESTAMP),
    (3, 2, 150, CURRENT_TIMESTAMP),
    (4, 2, 50, CURRENT_TIMESTAMP),
    (5, 3, 300, CURRENT_TIMESTAMP);

-- Inserções na tabela Venda
INSERT INTO Venda (data_venda, cliente_id, total, tipo_venda) VALUES
    (CURRENT_TIMESTAMP, 1, 1599.90, 'vista'),
    (CURRENT_TIMESTAMP, 2, 79.98, 'crediario'),
    (CURRENT_TIMESTAMP, 3, 120.90, 'crediario');

-- Inserções na tabela ItemVenda
INSERT INTO ItemVenda (venda_id, produto_id, quantidade, preco_unitario) VALUES
    (1, 1, 1, 1500.00),
    (1, 2, 2, 29.99),
    (2, 3, 10, 5.99),
    (2, 4, 2, 39.90);