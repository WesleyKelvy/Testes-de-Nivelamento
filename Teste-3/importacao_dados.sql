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

