SELECT
    COUNT(*) AS total_tabelas_usuario
FROM information_schema.tables
WHERE table_schema NOT IN ('pg_catalog', 'information_schema');

