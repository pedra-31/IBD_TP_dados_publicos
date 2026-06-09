ALTER TABLE doenca_municipio 
ADD COLUMN taxa_casos_100k NUMERIC(10, 2);

UPDATE doenca_municipio dm
SET taxa_casos_100k = ROUND(((dm.total_casos * 100000.0) / m.pop_munip), 2)
FROM municipio m
WHERE dm.cod_munip = m.cod_munip 
  AND m.pop_munip > 0;