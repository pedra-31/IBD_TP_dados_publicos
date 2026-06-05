SELECT nome_tabela, total_linhas
FROM (
    SELECT 'prestador' AS nome_tabela, COUNT(*) AS total_linhas FROM prestador
    UNION ALL
    SELECT 'municipio' AS nome_tabela, COUNT(*) AS total_linhas FROM municipio
    UNION ALL
    SELECT 'fato_saneamento' AS nome_tabela, COUNT(*) AS total_linhas FROM fato_saneamento
    UNION ALL
    SELECT 'doenca' AS nome_tabela, COUNT(*) AS total_linhas FROM doenca
    UNION ALL
    SELECT 'doenca_municipio' AS nome_tabela, COUNT(*) AS total_linhas FROM doenca_municipio
    UNION ALL
    SELECT 'raw_saneamento_minas_municipios' AS nome_tabela, COUNT(*) AS total_linhas FROM raw_saneamento_minas_municipios
    UNION ALL
    SELECT 'raw_fato_doencas_2021' AS nome_tabela, COUNT(*) AS total_linhas FROM raw_fato_doencas_2021
) contagens
ORDER BY total_linhas DESC, nome_tabela;
