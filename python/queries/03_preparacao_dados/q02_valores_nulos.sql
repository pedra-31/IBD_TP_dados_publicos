UPDATE raw_saneamento_minas_municipios
SET 
    vol_esgoto_coletado = COALESCE(vol_esgoto_coletado, 0.00),
    vol_esgoto_tratado = COALESCE(vol_esgoto_tratado, 0.00),
    pop_atendida_esgoto = COALESCE(pop_atendida_esgoto, 0)
WHERE 
    vol_esgoto_coletado IS NULL 
    OR vol_esgoto_tratado IS NULL 
    OR pop_atendida_esgoto IS NULL;