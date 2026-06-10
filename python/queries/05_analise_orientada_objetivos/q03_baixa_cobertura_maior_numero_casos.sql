WITH indicadores AS (
    SELECT
        m.cod_munip,
        m.nome_munip,
        m.pop_munip,

        ROUND(
            (fs.pop_atendida_agua::numeric / NULLIF(m.pop_munip, 0)) * 100,
            2
        ) AS cobertura_agua_pct,

        ROUND(
            (fs.pop_atendida_esgoto::numeric / NULLIF(m.pop_munip, 0)) * 100,
            2
        ) AS cobertura_esgoto_pct,

        COALESCE(SUM(dm.total_casos), 0) AS total_casos

    FROM municipio m
    JOIN fato_saneamento fs
        ON m.cod_munip = fs.cod_munip
    LEFT JOIN doenca_municipio dm
        ON m.cod_munip = dm.cod_munip
    GROUP BY
        m.cod_munip,
        m.nome_munip,
        m.pop_munip,
        fs.pop_atendida_agua,
        fs.pop_atendida_esgoto
)

SELECT *
FROM indicadores
WHERE
    cobertura_agua_pct < 80
    OR cobertura_esgoto_pct < 70
ORDER BY total_casos DESC
LIMIT 20;