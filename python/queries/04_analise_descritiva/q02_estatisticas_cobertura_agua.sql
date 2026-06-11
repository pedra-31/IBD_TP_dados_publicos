SELECT 
    COUNT(m.cod_munip) AS total_municipios,
    ROUND(SUM(fs.pop_atendida_agua)::numeric / SUM(m.pop_munip) * 100, 2) AS cobertura_estado_pct,
    ROUND(AVG(fs.pop_atendida_agua::numeric / m.pop_munip) * 100, 2) AS media_cobertura_pct,
    ROUND(STDDEV(fs.pop_atendida_agua::numeric / m.pop_munip) * 100, 2) AS desvio_padrao_pct,
    ROUND(MIN(fs.pop_atendida_agua::numeric / m.pop_munip) * 100, 2) AS min_cobertura_pct,
    ROUND(MAX(fs.pop_atendida_agua::numeric / m.pop_munip) * 100, 2) AS max_cobertura_pct
FROM municipio m
JOIN fato_saneamento fs ON m.cod_munip = fs.cod_munip;