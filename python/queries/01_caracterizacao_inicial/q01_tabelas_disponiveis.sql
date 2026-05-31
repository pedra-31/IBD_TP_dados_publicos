SELECT
    table_name AS nome_tabela
FROM information_schema.tables
WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
ORDER BY nome_tabela;

