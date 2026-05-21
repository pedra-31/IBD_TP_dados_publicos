CREATE TABLE Prestador (
    cod_prestador INT PRIMARY KEY,
    nome_prestador VARCHAR(200),
    sigla_prestador VARCHAR(20),
    abrangencia_prestador VARCHAR(50),
    tipo_prestador VARCHAR(150),
    tipo_servico VARCHAR(100)
);

CREATE TABLE Municipio (
    cod_munip INT PRIMARY KEY,
    nome_munip VARCHAR(150) NOT NULL,
    pop_munip INT,
    cod_prestador INT,

    CONSTRAINT fk_municipio_prestador
        FOREIGN KEY (cod_prestador)
        REFERENCES prestador (cod_prestador)
);

-- 1 : 1 Municipio e Fato_saneamento, mas facilita a leitura/entendimento do modelo
CREATE TABLE Fato_saneamento (
    cod_munip INT PRIMARY KEY,
    pop_atendida_agua INT,
    vol_agua_anual NUMERIC(15,2),
    vol_agua_eta NUMERIC(15,2),
    vol_agua_desinfec NUMERIC(15,2),
    vol_agua_fluor NUMERIC(15,2),
    pop_atendida_esgoto INT,
    vol_esgoto_coletado NUMERIC(15,2),
    vol_esgoto_tratado NUMERIC(15,2),
    amostra_cloro INT,
    amostra_cloro_irregular INT,
    amostra_turbidez INT,
    amostra_turbidez_irregular INT,
    amostra_coliformes INT,
    amostra_coliformes_irregular INT,
    CONSTRAINT fk_fato_saneamento_municipio
        FOREIGN KEY (cod_munip)
        REFERENCES municipio (cod_munip)
        ON DELETE CASCADE
);

-- 1 : 1 Municipio e Fato_doencas, mas facilita a leitura/entendimento do modelo
CREATE TABLE Fato_doencas (
    cod_munip INT PRIMARY KEY,
    total_casos_esquistossomose INT NOT NULL DEFAULT 0,
    total_casos_leptospirose INT NOT NULL DEFAULT 0,
    total_casos_colera INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_fato_doencas_municipio
        FOREIGN KEY (cod_munip)
        REFERENCES municipio (cod_munip)
        ON DELETE CASCADE
);
