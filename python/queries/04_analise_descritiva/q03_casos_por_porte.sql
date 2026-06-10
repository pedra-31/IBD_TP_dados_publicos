SELECT 
    CASE 
        WHEN m.pop_munip < 20000 THEN '1. Pequeno (Até 20k)'
        WHEN m.pop_munip BETWEEN 20000 AND 100000 THEN '2. Médio (20k - 100k)'
        ELSE '3. Grande (Mais de 100k)' 
    END AS porte_populacional,
    COUNT(DISTINCT m.cod_munip) AS qtd_municipios,
    SUM(m.pop_munip) AS populacao_total_faixa,
    SUM(dm.total_casos) AS total_casos_doencas,
    ROUND((SUM(dm.total_casos)::numeric / SUM(m.pop_munip)) * 100000, 2) AS taxa_casos_por_100k
FROM municipio m
JOIN doenca_municipio dm ON m.cod_munip = dm.cod_munip
GROUP BY 1
ORDER BY 1;