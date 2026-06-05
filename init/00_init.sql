CREATE TABLE IF NOT EXISTS Prestador (
    cod_prestador INT PRIMARY KEY,
    nome_prestador VARCHAR(200),
    sigla_prestador VARCHAR(20),
    abrangencia_prestador VARCHAR(50),
    tipo_prestador VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS Municipio (
    cod_munip INT PRIMARY KEY,
    nome_munip VARCHAR(150) NOT NULL,
    pop_munip INT,
    mortalidade_saneamento INT,
    tipo_servico_recebido VARCHAR(100),
    cod_prestador INT NOT NULL,

    CONSTRAINT fk_prestador_municipio
        FOREIGN KEY (cod_prestador)
        REFERENCES Prestador (cod_prestador)
        ON DELETE CASCADE
);

-- 1 : 1 Municipio e Fato_Saneamento, mas facilita a leitura/entendimento do modelo
CREATE TABLE IF NOT EXISTS Fato_Saneamento (
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

CREATE TABLE IF NOT EXISTS Doenca (
    cod_doenca SERIAL PRIMARY KEY,
    nome_doenca VARCHAR(200)
);

--Tabela N:M entre Doenca e Municipio com o atributo relacional total_casos
CREATE TABLE IF NOT EXISTS Doenca_Municipio (
    cod_doenca INT,
    cod_munip INT,
    total_casos INT NOT NULL DEFAULT 0,
    CONSTRAINT pk_doenca_municipio PRIMARY KEY (cod_doenca, cod_munip),

    CONSTRAINT fk_doenca
        FOREIGN KEY (cod_doenca)
        REFERENCES Doenca (cod_doenca)
        ON DELETE CASCADE,
    
    CONSTRAINT fk_municipio
        FOREIGN KEY (cod_munip)
        REFERENCES Municipio (cod_munip)
        ON DELETE CASCADE
);
