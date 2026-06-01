SELECT
    c.table_name AS nome_tabela,
    COUNT(*) AS total_colunas,
    SUM(CASE WHEN c.data_type IN ('integer', 'bigint', 'smallint', 'numeric', 'real', 'double precision') THEN 1 ELSE 0 END) AS colunas_numericas,
    SUM(CASE WHEN c.data_type IN ('character varying', 'text', 'character') THEN 1 ELSE 0 END) AS colunas_textuais,
    SUM(CASE WHEN c.data_type LIKE '%date%' OR c.data_type LIKE '%time%' THEN 1 ELSE 0 END) AS colunas_temporais
FROM information_schema.columns c
WHERE c.table_schema = 'public'
GROUP BY c.table_name
ORDER BY total_colunas DESC, nome_tabela;
