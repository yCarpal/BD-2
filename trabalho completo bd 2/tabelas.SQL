-- Criação dos Domínios
CREATE DOMAIN VARCHAR AS VARCHAR(40);

CREATE DOMAIN dom_varchar_50 AS VARCHAR(50);

CREATE DOMAIN dom_varchar_100 AS VARCHAR(100);

CREATE DOMAIN dom_varchar_20 AS VARCHAR(20);

CREATE DOMAIN TEXT AS TEXT;

CREATE DOMAIN DECIMAL AS DECIMAL(10,2);

CREATE DOMAIN dom_timestamp AS TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

CREATE DOMAIN dom_date AS DATE;

-- Tabela: Categoria
CREATE TABLE Categoria (
    categoria_id SERIAL PRIMARY KEY,
    nome dom_varchar_50 NOT NULL
);

-- Tabela: Produto
CREATE TABLE Produto (
    produto_id SERIAL PRIMARY KEY NOT NULL,
    nome dom_varchar_40 NOT NULL,
    categoria_id INTEGER NOT NULL,
    preco dom_decimal NOT NULL,
    descricao dom_text,
    data_criacao dom_timestamp NOT NULL,
    data_atualizacao dom_timestamp NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id)
);

-- Tabela: Cliente
CREATE TABLE Cliente (
    cliente_id SERIAL PRIMARY KEY,
    nome dom_varchar_40 NOT NULL,
    dtnascimento dom_date,
    email dom_varchar_40,
    telefone dom_varchar_20,
    endereco dom_text,
    data_cadastro dom_timestamp NOT NULL
);

-- Tabela: Fornecedor
CREATE TABLE Fornecedor (
    fornecedor_id SERIAL PRIMARY KEY,
    nome dom_varchar_100 NOT NULL,
    contato dom_varchar_100,
    email dom_varchar_100,
    telefone dom_varchar_20,
    endereco dom_text
);

-- Tabela: Loja
CREATE TABLE Loja (
    loja_id SERIAL PRIMARY KEY,
    nome dom_varchar_100 NOT NULL,
    endereco dom_text,
    telefone dom_varchar_20
);

-- Tabela: Funcionario
CREATE TABLE Funcionario (
    funcionario_id SERIAL PRIMARY KEY,
    nome dom_varchar_100 NOT NULL,
    email dom_varchar_100,
    telefone dom_varchar_20,
    cargo dom_varchar_50,
    loja_id INTEGER NOT NULL,
    FOREIGN KEY (loja_id) REFERENCES Loja(loja_id)
);

-- Tabela: Estoque
CREATE TABLE Estoque (
    estoque_id SERIAL PRIMARY KEY,
    produto_id INTEGER NOT NULL,
    loja_id INTEGER NOT NULL,
    quantidade dom_decimal NOT NULL,
    data_atualizacao dom_timestamp NOT NULL,
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id),
    FOREIGN KEY (loja_id) REFERENCES Loja(loja_id)
);

-- Tabela: PedidoReposicao
CREATE TABLE PedidoReposicao (
    pedido_id SERIAL PRIMARY KEY,
    data_pedido dom_timestamp NOT NULL,
    situacao dom_varchar_20 NOT NULL,
    fornecedor_id INTEGER NOT NULL,
    valor dom_decimal NOT NULL,
    FOREIGN KEY (fornecedor_id) REFERENCES Fornecedor(fornecedor_id)
);

-- Tabela: Crediario
CREATE TABLE Crediario (
    crediario_id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    limite_credito dom_decimal NOT NULL,
    saldo_devedor dom_decimal NOT NULL,
    data_abertura dom_timestamp NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

-- Tabela: Parcela
CREATE TABLE Parcela (
    parcela_id SERIAL PRIMARY KEY,
    crediario_id INTEGER NOT NULL,
    venda_id INTEGER NOT NULL,
    numero_parcela INTEGER NOT NULL,
    valor_parcela dom_decimal NOT NULL,
    data_vencimento dom_date NOT NULL,
    FOREIGN KEY (crediario_id) REFERENCES Crediario(crediario_id),
    FOREIGN KEY (venda_id) REFERENCES Venda(venda_id)
);

-- Tabela: Cobranca
CREATE TABLE Cobranca (
    cobranca_id SERIAL PRIMARY KEY,
    crediario_id INTEGER NOT NULL,
    funcionario_id INTEGER NOT NULL,
    data_cobranca dom_timestamp NOT NULL,
    status_cobranca dom_varchar_20 NOT NULL,
    observacoes dom_text,
    FOREIGN KEY (crediario_id) REFERENCES Crediario(crediario_id),
    FOREIGN KEY (funcionario_id) REFERENCES Funcionario(funcionario_id)
);

-- Tabela: Venda
CREATE TABLE Venda (
    venda_id SERIAL PRIMARY KEY,
    data_venda dom_timestamp NOT NULL,
    cliente_id INTEGER NOT NULL,
    total dom_decimal NOT NULL,
    tipo_venda dom_varchar_10 NOT NULL CHECK (tipo_venda IN ('vista', 'crediario')),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

-- Tabela: ItemVenda
CREATE TABLE ItemVenda (
    item_venda_id SERIAL PRIMARY KEY,
    venda_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade dom_decimal NOT NULL,
    preco_unitario dom_decimal NOT NULL,
    FOREIGN KEY (venda_id) REFERENCES Venda(venda_id),
    FOREIGN KEY (produto_id) REFERENCES Produto(produto_id)
);
