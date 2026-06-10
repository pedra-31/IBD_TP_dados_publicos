SELECT 
    p.nome_prestador,
    COUNT(DISTINCT m.cod_munip) AS qtd_municipios_atendidos,
    SUM(fs.amostra_cloro) AS total_amostras,
    SUM(fs.amostra_cloro_irregular) AS total_irregulares,
    ROUND((SUM(fs.amostra_cloro_irregular)::numeric / SUM(fs.amostra_cloro)) * 100, 2) AS taxa_irregularidade_pct
FROM prestador p
JOIN municipio m ON p.cod_prestador = m.cod_prestador
JOIN fato_saneamento fs ON m.cod_munip = fs.cod_munip
GROUP BY p.nome_prestador
HAVING SUM(fs.amostra_cloro) > 0
ORDER BY taxa_irregularidade_pct DESC;