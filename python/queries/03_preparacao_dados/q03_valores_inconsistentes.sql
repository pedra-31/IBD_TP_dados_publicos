DELETE FROM raw_fato_doencas_2021
WHERE cod_munip NOT IN (
    SELECT cod_munip FROM municipio
);