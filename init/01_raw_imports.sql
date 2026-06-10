-- Carga bruta dos CSVs na primeira inicializacao do Postgres (docker-entrypoint-initdb.d)

-- 1) Doencas (arquivo com cabecalho na primeira linha)
CREATE TABLE IF NOT EXISTS raw_fato_doencas_2021 (
    codigo_ibge TEXT,
    internacoes_amebiase TEXT,
    internacoes_colera TEXT,
    internacoes_diarreia_provavel_infec TEXT,
    internacoes_esquistossomose TEXT,
    internacoes_febre_tifoide TEXT,
    internacoes_helmintiases TEXT,
    internacoes_leptospiroses TEXT,
    total_mortes_baixo_saneamento TEXT
);

COPY raw_fato_doencas_2021 (
    codigo_ibge,
    internacoes_amebiase,
    internacoes_colera,
    internacoes_diarreia_provavel_infec,
    internacoes_esquistossomose,
    internacoes_febre_tifoide,
    internacoes_helmintiases,
    internacoes_leptospiroses,
    total_mortes_baixo_saneamento
)
FROM '/imports/raw_doencas_saneamento_mg_2021_unificado_completo.csv'
WITH (
    FORMAT csv,
    HEADER true
);

-- 2) Saneamento
-- O arquivo tem 2 linhas iniciais de metadados, depois o cabecalho e os dados.
CREATE TABLE IF NOT EXISTS raw_saneamento_minas_municipios (
    cod_munip TEXT,
    nome_munip TEXT,
    cod_prestador TEXT,
    nome_prestador TEXT,
    sigla_prestador TEXT,
    abrangencia_prestador TEXT,
    tipo_prestador TEXT,
    tipo_servico_recebido TEXT,
    pop_munip TEXT,
    pop_atendida_agua TEXT,
    vol_agua_anual TEXT,
    vol_agua_eta TEXT,
    vol_agua_desinfec TEXT,
    vol_agua_fluor TEXT,
    pop_atendida_esgoto TEXT,
    vol_esgoto_coletado TEXT,
    vol_esgoto_tratado TEXT,
    amostra_cloro TEXT,
    amostra_cloro_irregular TEXT,
    amostra_turbidez TEXT,
    amostra_turbidez_irregular TEXT,
    amostra_coliformes TEXT,
    amostra_coliformes_irregular TEXT
);

-- Criando uma tabela auxiliar
DROP TABLE IF EXISTS raw_saneamento_minas_municipios_staging;
CREATE TABLE raw_saneamento_minas_municipios_staging (
    cod_munip TEXT,
    nome_munip TEXT,
    cod_prestador TEXT,
    nome_prestador TEXT,
    sigla_prestador TEXT,
    abrangencia_prestador TEXT,
    tipo_prestador TEXT,
    tipo_servico_recebido TEXT,
    pop_munip TEXT,
    pop_atendida_agua TEXT,
    vol_agua_anual TEXT,
    vol_agua_eta TEXT,
    vol_agua_desinfec TEXT,
    vol_agua_fluor TEXT,
    pop_atendida_esgoto TEXT,
    vol_esgoto_coletado TEXT,
    vol_esgoto_tratado TEXT,
    amostra_cloro TEXT,
    amostra_cloro_irregular TEXT,
    amostra_turbidez TEXT,
    amostra_turbidez_irregular TEXT,
    amostra_coliformes TEXT,
    amostra_coliformes_irregular TEXT
);

-- importanto os dados brutos
COPY raw_saneamento_minas_municipios_staging (
    cod_munip,
    nome_munip,
    cod_prestador,
    nome_prestador,
    sigla_prestador,
    abrangencia_prestador,
    tipo_prestador,
    tipo_servico_recebido,
    pop_munip,
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
FROM '/imports/raw_saneamento_minas_municipios.csv'
WITH (
    FORMAT csv,
    HEADER false
);

-- Filtrando só onde os dados existem
INSERT INTO raw_saneamento_minas_municipios (
    cod_munip,
    nome_munip,
    cod_prestador,
    nome_prestador,
    sigla_prestador,
    abrangencia_prestador,
    tipo_prestador,
    tipo_servico_recebido,
    pop_munip,
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
    cod_munip,
    nome_munip,
    cod_prestador,
    nome_prestador,
    sigla_prestador,
    abrangencia_prestador,
    tipo_prestador,
    tipo_servico_recebido,
    pop_munip,
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
FROM raw_saneamento_minas_municipios_staging
WHERE cod_munip IS NOT NULL
  AND TRIM(cod_munip) != ''
  AND cod_munip NOT IN ('-', 'cod_munip');

DROP TABLE raw_saneamento_minas_municipios_staging;
