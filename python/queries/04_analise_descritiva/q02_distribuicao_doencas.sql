SELECT 
    d.nome_doenca,
    SUM(dm.total_casos) AS total_casos_estado,
    ROUND((SUM(dm.total_casos)::numeric / SUM(SUM(dm.total_casos)) OVER()) * 100, 2) AS percentual_do_total_pct,
    ROUND(AVG(dm.total_casos), 2) AS media_casos_por_municipio,
    MAX(dm.total_casos) AS pico_casos_em_um_municipio
FROM doenca_municipio dm
JOIN doenca d ON dm.cod_doenca = d.cod_doenca
GROUP BY d.nome_doenca
ORDER BY total_casos_estado DESC;