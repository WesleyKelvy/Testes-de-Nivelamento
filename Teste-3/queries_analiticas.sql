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
