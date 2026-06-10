SELECT
    m.cod_munip,
    m.nome_munip,
    m.pop_munip,
    SUM(dm.total_casos) AS total_casos
FROM municipio m
JOIN doenca_municipio dm
    ON m.cod_munip = dm.cod_munip
GROUP BY
    m.cod_munip,
    m.nome_munip,
    m.pop_munip
ORDER BY total_casos DESC
LIMIT 20;