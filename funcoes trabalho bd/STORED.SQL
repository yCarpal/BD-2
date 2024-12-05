-- TABELA: Categoria (Tipos de categorias de produtos)
CREATE TABLE Categoria (
    categoria_id SERIAL PRIMARY KEY,
    nome dom_nome NOT NULL
);

-- TABELA: Produto (Itens disponíveis para venda)
CREATE TABLE Produto (
    produto_id SERIAL PRIMARY KEY,
    nome dom_nome NOT NULL,
    categoria_id INTEGER NOT NULL,
    preco dom_preco NOT NULL,
    descricao dom_texto,
    data_criacao dom_data_hora NOT NULL,
    data_atualizacao dom_data_hora NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id)
);

-- TABELA: Cliente (Registro de clientes)
CREATE TABLE Cliente (
    cliente_id SERIAL PRIMARY KEY,
    nome dom_nome NOT NULL,
    dtnascimento dom_data,
    email dom_email,
    telefone dom_telefone,
    endereco dom_texto,
    data_cadastro dom_data_hora NOT NULL
);

-- TABELA: Fornecedor (Empresas fornecedoras)
CREATE TABLE Fornecedor (
    fornecedor_id SERIAL PRIMARY KEY,
    nome dom_descricao NOT NULL,
    contato dom_descricao,
    email dom_email,
    telefone dom_telefone,
    endereco dom_texto
);

-- TABELA: Loja (Informações sobre as lojas)
CREATE TABLE Loja (
    loja_id SERIAL PRIMARY KEY,
    nome dom_descricao NOT NULL,
    endereco dom_texto,
    telefone dom_telefone
);

-- TABELA: Funcionario (Funcionários da empresa)
CREATE TABLE Funcionario (
    funcionario_id SERIAL PRIMARY KEY,
    nome dom_descricao NOT NULL,
    email dom_email,
    telefone dom_telefone,
    cargo dom_nome,
    loja_id INTEGER NOT NULL,
    FOREIGN KEY (loja_id) REFERENCES Loja(loja_id)
);



CREATE TABLE Estoque (
    estoque_id SERIAL PRIMARY KEY,
    produto_id INTEGER NOT NULL,
    loja_id INTEGER NOT NULL,
    quantidade dom_valor NOT NULL,
    data_atualizacao dom_data_hora NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id),
    FOREIGN KEY (loja_id) REFERENCES Loja(loja_id)
);

-- TABELA: PedidoReposicao (Pedidos de reposição de produtos)
CREATE TABLE PedidoReposicao (
    pedido_id SERIAL PRIMARY KEY,
    data_pedido dom_data_hora NOT NULL,
    situacao dom_nome NOT NULL,
    fornecedor_id INTEGER NOT NULL,
    valor dom_valor NOT NULL,
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id)
);

-- TABELA: Crediario (Créditos dos clientes)
CREATE TABLE Crediario (
    crediario_id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    limite_credito dom_valor NOT NULL,
    saldo_devedor dom_valor NOT NULL,
    data_abertura dom_data_hora NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

-- TABELA: Parcela (Parcelas dos crediários)
CREATE TABLE Parcela (
    parcela_id SERIAL PRIMARY KEY,
    crediario_id INTEGER NOT NULL,
    venda_id INTEGER NOT NULL,
    numero_parcela INTEGER NOT NULL,
    valor_parcela dom_valor NOT NULL,
    data_vencimento dom_data NOT NULL,
    FOREIGN KEY (crediario_id) REFERENCES Crediario(crediario_id),
    FOREIGN KEY (venda_id) REFERENCES Venda(venda_id)
);

-- TABELA: Cobranca (Cobranças realizadas)
CREATE TABLE Cobranca (
    cobranca_id SERIAL PRIMARY KEY,
    crediario_id INTEGER NOT NULL,
    funcionario_id INTEGER NOT NULL,
    data_cobranca dom_data_hora NOT NULL,
    status_cobranca dom_nome NOT NULL,
    observacoes dom_texto,
    FOREIGN KEY (crediario_id) REFERENCES Crediario(crediario_id),
    FOREIGN KEY (funcionario_id) REFERENCES Funcionario(funcionario_id)
);

-- TABELA: Venda (Registros de vendas)
CREATE TABLE Venda (
    venda_id SERIAL PRIMARY KEY,
    data_venda dom_data_hora NOT NULL,
    cliente_id INTEGER NOT NULL,
    total dom_valor NOT NULL,
    tipo_venda dom_nome NOT NULL CHECK (tipo_venda IN ('vista', 'crediario')),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

-- TABELA: ItemVenda (Itens vendidos em cada venda)
CREATE TABLE ItemVenda (
    item_venda_id SERIAL PRIMARY KEY,
    venda_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade dom_valor NOT NULL,
    preco_unitario dom_valor NOT NULL,
    FOREIGN KEY (venda_id) REFERENCES Venda(venda_id),
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id)
);
