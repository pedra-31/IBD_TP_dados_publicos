SELECT 
    COUNT(m.cod_munip) AS total_municipios,
    
    ROUND(SUM(fs.pop_atendida_agua)::numeric / SUM(m.pop_munip) * 100, 2) AS cobertura_agua_estado_pct,
    ROUND(AVG(fs.pop_atendida_agua::numeric / m.pop_munip) * 100, 2) AS media_cobertura_agua_pct,
    ROUND(STDDEV(fs.pop_atendida_agua::numeric / m.pop_munip) * 100, 2) AS desvio_padrao_agua_pct,
    ROUND(MIN(fs.pop_atendida_agua::numeric / m.pop_munip) * 100, 2) AS min_cobertura_agua_pct,
    ROUND(MAX(fs.pop_atendida_agua::numeric / m.pop_munip) * 100, 2) AS max_cobertura_agua_pct,

    ROUND(SUM(fs.pop_atendida_esgoto)::numeric / SUM(m.pop_munip) * 100, 2) AS cobertura_esgoto_estado_pct,
    ROUND(AVG(fs.pop_atendida_esgoto::numeric / m.pop_munip) * 100, 2) AS media_cobertura_esgoto_pct,
    ROUND(STDDEV(fs.pop_atendida_esgoto::numeric / m.pop_munip) * 100, 2) AS desvio_padrao_esgoto_pct,
    ROUND(MIN(fs.pop_atendida_esgoto::numeric / m.pop_munip) * 100, 2) AS min_cobertura_esgoto_pct,
    ROUND(MAX(fs.pop_atendida_esgoto::numeric / m.pop_munip) * 100, 2) AS max_cobertura_esgoto_pct
FROM municipio m
JOIN fato_saneamento fs ON m.cod_munip = fs.cod_munip;