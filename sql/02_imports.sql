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
INSERT INTO Doenca (nome_doenca) VALUES ('esquistossomose');
INSERT INTO Doenca (nome_doenca) VALUES ('leptospirose');
INSERT INTO Doenca (nome_doenca) VALUES ('colera');

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
        'esquistossomose'::TEXT AS nome_doenca,
        codigo_ibge::INT AS cod_munip,
        COALESCE(NULLIF(REPLACE(total_casos_esquistossomose, ',', '.'), ''), '0')::NUMERIC::INT AS total_casos
    FROM raw_fato_doencas_unificado_2021

    UNION ALL

    SELECT
        'leptospirose'::TEXT AS nome_doenca,
        codigo_ibge::INT AS cod_munip,
        COALESCE(NULLIF(REPLACE(total_casos_leptospirose, ',', '.'), ''), '0')::NUMERIC::INT AS total_casos
    FROM raw_fato_doencas_unificado_2021

    UNION ALL

    SELECT
        'colera'::TEXT AS nome_doenca,
        codigo_ibge::INT AS cod_munip,
        COALESCE(NULLIF(REPLACE(total_casos_colera, ',', '.'), ''), '0')::NUMERIC::INT AS total_casos
    FROM raw_fato_doencas_unificado_2021
) src
JOIN Doenca d
  ON d.nome_doenca = src.nome_doenca;
