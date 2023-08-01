-- Criação do banco de dados
CREATE DATABASE loja;
USE loja;

-- Criação da tabela de clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL,
    tipo_cliente ENUM('PF', 'PJ') NOT NULL,
    cpf_cnpj VARCHAR(14)
);

-- Criação da tabela de produtos
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    quantidade_estoque INT NOT NULL
);

-- Criação da tabela de fornecedores
CREATE TABLE fornecedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    endereco VARCHAR(255) NOT NULL
);

-- Criação da tabela de pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_pedido DATETIME NOT NULL,
    cliente_id INT NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Criação da tabela de itens do pedido
CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Criação da tabela de pagamentos
CREATE TABLE pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_pagamento DATETIME NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    forma_pagamento ENUM('Boleto', 'Cartão de Crédito', 'Cartão de Débito', 'Transferência Bancária') NOT NULL,
    pedido_id INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
);

-- Criação da tabela de rastreamento de pedidos
CREATE TABLE rastreamento_pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    data_atualizacao DATETIME NOT NULL,
    status ENUM('Aguardando Pagamento', 'Pagamento Confirmado', 'Em Preparação', 'Enviado', 'Entregue') NOT NULL,
    codigo_rastreio VARCHAR(255),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
);


-- Inserção de dados na tabela de clientes
INSERT INTO clientes (nome, email, endereco, tipo_cliente, cpf_cnpj)
VALUES
('João Silva', 'joao.silva@email.com', 'Rua das Flores, 123', 'PF', '12345678901'),
('Maria Santos', 'maria.santos@email.com', 'Avenida Brasil, 456', 'PF', '23456789012'),
('Empresa XYZ', 'contato@empresaxyz.com.br', 'Rua das Palmeiras, 789', 'PJ', '12345678000123');

-- Inserção de dados na tabela de produtos
INSERT INTO produtos (nome, descricao, preco, quantidade_estoque)
VALUES
('Camiseta branca', 'Camiseta branca básica em algodão', 29.90, 100),
('Calça jeans', 'Calça jeans azul com corte reto', 89.90, 50),
('Tênis preto', 'Tênis preto em couro sintético', 129.90, 30);

-- Inserção de dados na tabela de fornecedores
INSERT INTO fornecedores (nome, email, endereco)
VALUES
('Fornecedor A', 'contato@fornecedora.com.br', 'Rua das Rosas, 321'),
('Fornecedor B', 'contato@fornecedorb.com.br', 'Avenida Paulista, 654');

-- Inserção de dados na tabela de pedidos
INSERT INTO pedidos (data_pedido, cliente_id)
VALUES
('2023-07-01 10:00:00', 1),
('2023-07-02 14:30:00', 2),
('2023-07-03 16:45:00', 3);

-- Inserção de dados na tabela de itens do pedido
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario)
VALUES
(1, 1, 2, 29.90),
(1, 2, 1, 89.90),
(2, 3, 1, 129.90),
(3, 1, 3, 29.90),
(3, 2, 2, 89.90);

-- Inserção de dados na tabela de pagamentos
INSERT INTO pagamentos (data_pagamento, valor, forma_pagamento, pedido_id)
VALUES
('2023-07-01 10:05:00', 149.70, 'Boleto', 1),
('2023-07-02 14:35:00', 129.90, 'Cartão de Crédito', 2),
('2023-07-03 16:50:00', 358.50, 'Transferência Bancária', 3);

-- Inserção de dados na tabela de rastreamento de pedidos
INSERT INTO rastreamento_pedidos (pedido_id, data_atualizacao, status)
VALUES
(1,'2023-07-01','Aguardando Pagamento'),
(1,'2023-07-02','Pagamento Confirmado'),
(1,'2023-07-03','Em Preparação'),
(1,'2023-07-04','Enviado'),
(1,'2023-07-05','Entregue'),
(2,'2023-07-02','Aguardando Pagamento'),
(2,'2023-07-03','Pagamento Confirmado'),
(2,'2023-07-04','Em Preparação'),
(2,'2023-07-05','Enviado'),
(2,'2023-07-06','Entregue'),
(3,'2023-07-03','Aguardando Pagamento'),
(3,'2023-07-04','Pagamento Confirmado'),
(3,'2023-07-05','Em Preparação'),
(3,'2023-07-06','Enviado');

SELECT c.nome, COUNT(p.id) AS numero_pedidos
FROM clientes c
JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id;