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
