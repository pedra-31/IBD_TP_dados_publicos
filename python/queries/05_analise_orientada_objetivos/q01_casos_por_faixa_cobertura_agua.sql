WITH indicadores AS (
    SELECT
        m.cod_munip,
        m.nome_munip,
        m.pop_munip,

        ROUND(
            (fs.pop_atendida_agua::numeric / NULLIF(m.pop_munip, 0)) * 100,
            2
        ) AS cobertura_agua_pct,

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
        fs.pop_atendida_agua
)

SELECT
    CASE
        WHEN cobertura_agua_pct < 50 THEN 'Baixa cobertura de água'
        WHEN cobertura_agua_pct < 80 THEN 'Média cobertura de água'
        ELSE 'Alta cobertura de água'
    END AS faixa_cobertura_agua,

    COUNT(*) AS quantidade_municipios,
    SUM(total_casos) AS total_casos_faixa,
    ROUND(AVG(total_casos), 2) AS media_casos_por_municipio

FROM indicadores
GROUP BY faixa_cobertura_agua
ORDER BY media_casos_por_municipio DESC;