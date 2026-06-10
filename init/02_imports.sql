-- Inserindo os dados de raw_saneamento_minas_municipios em Prestador
INSERT INTO Prestador (
    cod_prestador,
    nome_prestador,
    sigla_prestador,
    abrangencia_prestador,
    tipo_prestador
)
SELECT DISTINCT
    cod_prestador::INT,
    nome_prestador,
    sigla_prestador,
    abrangencia_prestador,
    tipo_prestador
FROM raw_saneamento_minas_municipios;

-- Inserindo os dados de raw_saneamento_minas_municipios em Municipio
INSERT INTO Municipio (
    cod_munip,
    nome_munip,
    pop_munip,
    tipo_servico_recebido,
    cod_prestador
)
SELECT
    cod_munip::INT,
    nome_munip,
    NULLIF(REPLACE(pop_munip, '.', ''), '')::INT,
    tipo_servico_recebido,
    cod_prestador::INT
FROM raw_saneamento_minas_municipios;

-- Inserindo os dados de raw_saneamento_minas_municipios em Fato_Saneamento
INSERT INTO Fato_Saneamento (
    cod_munip,
    pop_atendida_agua,
    vol_agua_anual,
    vol_agua_eta,
    vol_agua_desinfec,
    vol_agua_fluor,
    pop_atendida_esgoto,
    vol_esgoto_coletado,
    vol_esgoto_tratado,
    amostra_cloro,
    amostra_cloro_irregular,
    amostra_turbidez,
    amostra_turbidez_irregular,
    amostra_coliformes,
    amostra_coliformes_irregular
)
SELECT
    cod_munip::INT,
    NULLIF(REPLACE(pop_atendida_agua, '.', ''), '')::INT,
    NULLIF(REPLACE(REPLACE(vol_agua_anual, '.', ''), ',', '.'), '')::NUMERIC(15,2),
    NULLIF(REPLACE(REPLACE(vol_agua_eta, '.', ''), ',', '.'), '')::NUMERIC(15,2),
    NULLIF(REPLACE(REPLACE(vol_agua_desinfec, '.', ''), ',', '.'), '')::NUMERIC(15,2),
    NULLIF(REPLACE(REPLACE(vol_agua_fluor, '.', ''), ',', '.'), '')::NUMERIC(15,2),
    NULLIF(REPLACE(pop_atendida_esgoto, '.', ''), '')::INT,
    NULLIF(REPLACE(REPLACE(vol_esgoto_coletado, '.', ''), ',', '.'), '')::NUMERIC(15,2),
    NULLIF(REPLACE(REPLACE(vol_esgoto_tratado, '.', ''), ',', '.'), '')::NUMERIC(15,2),
    NULLIF(REPLACE(amostra_cloro, '.', ''), '')::INT,
    NULLIF(REPLACE(amostra_cloro_irregular, '.', ''), '')::INT,
    NULLIF(REPLACE(amostra_turbidez, '.', ''), '')::INT,
    NULLIF(REPLACE(amostra_turbidez_irregular, '.', ''), '')::INT,
    NULLIF(REPLACE(amostra_coliformes, '.', ''), '')::INT,
    NULLIF(REPLACE(amostra_coliformes_irregular, '.', ''), '')::INT
FROM raw_saneamento_minas_municipios;

-- Inserindo os nomes das doencas em Doenca
INSERT INTO Doenca (nome_doenca) VALUES ('amebiase');
INSERT INTO Doenca (nome_doenca) VALUES ('colera');
INSERT INTO Doenca (nome_doenca) VALUES ('diarreia_provavel_infec');
INSERT INTO Doenca (nome_doenca) VALUES ('esquistossomose');
INSERT INTO Doenca (nome_doenca) VALUES ('febre_tifoide');
INSERT INTO Doenca (nome_doenca) VALUES ('helmintiase');
INSERT INTO Doenca (nome_doenca) VALUES ('leptospirose');

-- Inserindo os dados em Doenca_Municipio
INSERT INTO Doenca_Municipio (
    cod_doenca,
    cod_munip,
    total_casos
)
SELECT
    d.cod_doenca,
    src.cod_munip,
    src.total_casos
FROM (
    SELECT
        'amebiase'::TEXT AS nome_doenca,
        codigo_ibge::INT AS cod_munip,
        COALESCE(NULLIF(REPLACE(internacoes_amebiase, ',', '.'), ''), '0')::NUMERIC::INT AS total_casos
    FROM raw_fato_doencas_2021

    UNION ALL

    SELECT
        'colera'::TEXT AS nome_doenca,
        codigo_ibge::INT AS cod_munip,
        COALESCE(NULLIF(REPLACE(internacoes_colera, ',', '.'), ''), '0')::NUMERIC::INT AS total_casos
    FROM raw_fato_doencas_2021

    UNION ALL

    SELECT
        'diarreia_provavel_infec'::TEXT AS nome_doenca,
        codigo_ibge::INT AS cod_munip,
        COALESCE(NULLIF(REPLACE(internacoes_diarreia_provavel_infec, ',', '.'), ''), '0')::NUMERIC::INT AS total_casos
    FROM raw_fato_doencas_2021

    UNION ALL

    SELECT
        'esquistossomose'::TEXT AS nome_doenca,
        codigo_ibge::INT AS cod_munip,
        COALESCE(NULLIF(REPLACE(internacoes_esquistossomose, ',', '.'), ''), '0')::NUMERIC::INT AS total_casos
    FROM raw_fato_doencas_2021

    UNION ALL

    SELECT
        'febre_tifoide'::TEXT AS nome_doenca,
        codigo_ibge::INT AS cod_munip,
        COALESCE(NULLIF(REPLACE(internacoes_febre_tifoide, ',', '.'), ''), '0')::NUMERIC::INT AS total_casos
    FROM raw_fato_doencas_2021

    UNION ALL

    SELECT
        'helmintiase'::TEXT AS nome_doenca,
        codigo_ibge::INT AS cod_munip,
        COALESCE(NULLIF(REPLACE(internacoes_helmintiases, ',', '.'), ''), '0')::NUMERIC::INT AS total_casos
    FROM raw_fato_doencas_2021

    UNION ALL

    SELECT
        'leptospirose'::TEXT AS nome_doenca,
        codigo_ibge::INT AS cod_munip,
        COALESCE(NULLIF(REPLACE(internacoes_leptospiroses, ',', '.'), ''), '0')::NUMERIC::INT AS total_casos
    FROM raw_fato_doencas_2021
) src
JOIN Doenca d
  ON d.nome_doenca = src.nome_doenca
JOIN Municipio m
  ON m.cod_munip = src.cod_munip;

-- Inserindo os dados de mortalidade em municipio
CREATE TABLE tmp_mortalidade (
    codigo_ibge TEXT,
    total_obitos_saneamento TEXT
);

COPY tmp_mortalidade
FROM '/imports/raw_fato_mortalidade_geral.csv'
WITH (FORMAT csv, HEADER true);

UPDATE Municipio m
SET mortalidade_saneamento =
    COALESCE(
        NULLIF(REPLACE(t.total_obitos_saneamento, ',', '.'), ''),'0')::NUMERIC::INT
FROM tmp_mortalidade t
WHERE m.cod_munip = t.codigo_ibge::INT;

DROP TABLE tmp_mortalidade;
