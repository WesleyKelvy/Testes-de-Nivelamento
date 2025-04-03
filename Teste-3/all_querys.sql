-- PostgreSQL 17.2 (Debian 17.2-1.pgdg120+1) on x86_64-pc-linux-gnu
-- Dbeaver 25.0.0

-- Estruturando tabelas:
CREATE TABLE operadoras (
    registro_ans VARCHAR(20) PRIMARY KEY,
    cnpj VARCHAR(20),
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(30),
    complemento VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf CHAR(2),
    cep VARCHAR(10),
    ddd VARCHAR(3),
    telefone VARCHAR(20),  
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(255),
    cargo_representante VARCHAR(255),
    regiao_comercializacao VARCHAR(100),
    data_registro_ans DATE
);

CREATE TABLE demonstracoes_contabeis (
    data DATE,
    reg_ans VARCHAR(6),
    cd_conta_contabil VARCHAR(9),
    descricao TEXT,
    vl_saldo_inicial DECIMAL(15, 2),
    vl_saldo_final DECIMAL(15, 2),
    PRIMARY KEY (data, reg_ans, cd_conta_contabil)
);

-- Importando o conteúdo dos arquivos preparados:
--  Copiando CSV das operadoras:

-- Para passar o seu arquivo csv para o volume do postgres do docker:
-- docker cp "/home/kelvy/Documents/Work/teste-tecnico/dados-teste-3/operadoras_de_plano_de_saude_ativas/Relatorio_cadop.csv" meu-postgres:/tmp/Relatorio_cadop.csv
-- Successfully copied 350kB to meu-postgres:/tmp/Relatorio_cadop.csv

COPY operadoras (
    registro_ans, cnpj, razao_social, nome_fantasia, modalidade, logradouro, 
    numero, complemento, bairro, cidade, uf, cep, ddd, telefone, fax, endereco_eletronico, 
    representante, cargo_representante, regiao_comercializacao, data_registro_ans
)
FROM '/tmp/Relatorio_cadop.csv'
WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8', DELIMITER ';', QUOTE '"');


-- Copiando CSVs das demonstracoes_contabeis: 

-- Para os arquivos das demonstracoes_contabeis:
-- docker cp /home/kelvy/Documents/Work/teste-tecnico/dados-teste-3/demonstracoes_contabeis/ meu-postgres:/tmp/demonstracoes_contabeis/
-- Successfully copied 537MB to meu-postgres:/tmp/demonstracoes_contabeis/

--  2023:
COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final
)
FROM '/tmp/demonstracoes_contabeis/1T2023.csv'
WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8', DELIMITER ';', QUOTE '"');

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final
)
FROM '/tmp/demonstracoes_contabeis/2t2023.csv'
WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8', DELIMITER ';', QUOTE '"');

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final
)
FROM '/tmp/demonstracoes_contabeis/3T2023.csv'
WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8', DELIMITER ';', QUOTE '"');

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final
)
FROM '/tmp/demonstracoes_contabeis/4T2023.csv'
WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8', DELIMITER ';', QUOTE '"');

--  2024:
COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final
)
FROM '/tmp/demonstracoes_contabeis/1T2024.csv'
WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8', DELIMITER ';', QUOTE '"');

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final
)
FROM '/tmp/demonstracoes_contabeis/2T2024.csv'
WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8', DELIMITER ';', QUOTE '"');

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final
)
FROM '/tmp/demonstracoes_contabeis/3T2024.csv'
WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8', DELIMITER ';', QUOTE '"');

COPY demonstracoes_contabeis (
    data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final
)
FROM '/tmp/demonstracoes_contabeis/4T2024.csv'
WITH (FORMAT CSV, HEADER TRUE, ENCODING 'UTF8', DELIMITER ';', QUOTE '"');


-- Querys analíticas:
--  Despesas no último trimestre:
SELECT 
    o.razao_social, 
    SUM(dc.vl_saldo_final) AS total_despesas
FROM demonstracoes_contabeis dc
JOIN operadoras o ON dc.reg_ans = o.registro_ans
WHERE 
    dc.descricao ILIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
    AND dc.data >= '2024-10-01' 
    AND dc.data <= '2024-12-31'
GROUP BY o.razao_social
ORDER BY total_despesas DESC
LIMIT 10;


--  Despesas no último ano:
SELECT 
    o.razao_social, 
    SUM(dc.vl_saldo_final) AS total_despesas
FROM demonstracoes_contabeis dc
JOIN operadoras o ON dc.reg_ans = o.registro_ans
WHERE 
    dc.descricao ILIKE '%EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS  DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR%'
    AND dc.data >= '2024-01-01' 
    AND dc.data <= '2024-12-31'
GROUP BY o.razao_social
ORDER BY total_despesas DESC
LIMIT 10;
