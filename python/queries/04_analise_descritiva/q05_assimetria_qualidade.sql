SELECT 
    p.nome_prestador,
    COUNT(DISTINCT m.cod_munip) AS qtd_municipios_atendidos,
    ROUND((SUM(fs.amostra_cloro_irregular)::numeric / NULLIF(SUM(fs.amostra_cloro), 0)) * 100, 2) AS taxa_irregularidade_cloro_pct,
    ROUND((SUM(fs.amostra_turbidez_irregular)::numeric / NULLIF(SUM(fs.amostra_turbidez), 0)) * 100, 2) AS taxa_irregularidade_turbidez_pct,
    ROUND((SUM(fs.amostra_coliformes_irregular)::numeric / NULLIF(SUM(fs.amostra_coliformes), 0)) * 100, 2) AS taxa_irregularidade_coliformes_pct
FROM prestador p
JOIN municipio m ON p.cod_prestador = m.cod_prestador
JOIN fato_saneamento fs ON m.cod_munip = fs.cod_munip
GROUP BY p.nome_prestador
HAVING SUM(fs.amostra_cloro) > 0 OR SUM(fs.amostra_turbidez) > 0 OR SUM(fs.amostra_coliformes) > 0;