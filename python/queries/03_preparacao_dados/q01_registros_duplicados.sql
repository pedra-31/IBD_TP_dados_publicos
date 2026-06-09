WITH duplicatas_cte AS (
    SELECT 
        cod_munip,
        cod_doenca,
        total_casos,
        ROW_NUMBER() OVER (
            PARTITION BY cod_munip, cod_doenca 
            ORDER BY total_casos DESC
        ) as num_linha
    FROM raw_fato_doencas_unificado_2021
)
DELETE FROM raw_fato_doencas_unificado_2021
WHERE (cod_munip, cod_doenca, total_casos) IN (
    SELECT cod_munip, cod_doenca, total_casos 
    FROM duplicatas_cte 
    WHERE num_linha > 1
);