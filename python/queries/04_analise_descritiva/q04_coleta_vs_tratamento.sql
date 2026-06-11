SELECT 
    m.nome_munip,
    fs.vol_esgoto_coletado,
    fs.vol_esgoto_tratado,
    (fs.vol_esgoto_coletado - fs.vol_esgoto_tratado) AS volume_esgoto_in_natura,
    ROUND(fs.vol_esgoto_tratado / fs.vol_esgoto_coletado * 100, 2) AS taxa_tratamento_pct,
    ROUND(SUM(fs.vol_esgoto_tratado) OVER() / SUM(fs.vol_esgoto_coletado) OVER() * 100, 2) AS taxa_media_estado_pct
FROM fato_saneamento fs
JOIN municipio m ON fs.cod_munip = m.cod_munip
WHERE fs.vol_esgoto_coletado > 0 
ORDER BY taxa_tratamento_pct ASC;