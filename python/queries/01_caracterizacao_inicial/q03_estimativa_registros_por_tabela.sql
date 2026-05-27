SELECT
    schemaname AS schema_name,
    relname AS table_name,
    n_live_tup AS estimativa_linhas
FROM pg_stat_user_tables
ORDER BY n_live_tup DESC, relname;

