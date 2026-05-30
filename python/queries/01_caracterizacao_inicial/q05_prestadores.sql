SELECT
    p.cod_prestador,
    p.nome_prestador,
    COUNT(m.cod_munip) AS total_municipios_atendidos
FROM Prestador p
LEFT JOIN Municipio m
  ON m.cod_prestador = p.cod_prestador
GROUP BY p.cod_prestador, p.nome_prestador
ORDER BY total_municipios_atendidos DESC, p.nome_prestador;
