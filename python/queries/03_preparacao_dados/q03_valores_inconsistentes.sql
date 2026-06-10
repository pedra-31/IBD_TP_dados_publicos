SELECT
    m.nome_munip,
    m.pop_munip,
    f.pop_atendida_agua,
    f.pop_atendida_esgoto
FROM Municipio m
JOIN Fato_Saneamento f
    ON m.cod_munip = f.cod_munip
WHERE
    f.pop_atendida_agua > m.pop_munip
    OR
    f.pop_atendida_esgoto > m.pop_munip;