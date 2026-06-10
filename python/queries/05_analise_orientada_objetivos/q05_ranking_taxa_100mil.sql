SELECT
    m.cod_munip,
    m.nome_munip,
    m.pop_munip,
    SUM(dm.total_casos) AS total_casos,

    ROUND(
        (SUM(dm.total_casos)::numeric / NULLIF(m.pop_munip, 0)) * 100000,
        2
    ) AS taxa_casos_100mil

FROM municipio m
JOIN doenca_municipio dm
    ON m.cod_munip = dm.cod_munip
GROUP BY
    m.cod_munip,
    m.nome_munip,
    m.pop_munip
ORDER BY taxa_casos_100mil DESC
LIMIT 20;