UPDATE Fato_Saneamento
SET 
    pop_atendida_esgoto = COALESCE(pop_atendida_esgoto, 0),
    vol_esgoto_coletado = COALESCE(vol_esgoto_coletado, 0.00),
    vol_esgoto_tratado = COALESCE(vol_esgoto_tratado, 0.00),
    pop_atendida_agua = COALESCE(pop_atendida_agua, 0),
    vol_agua_anual = COALESCE(vol_agua_anual, 0.00),
    vol_agua_eta = COALESCE(vol_agua_eta, 0.00),
    vol_agua_desinfec = COALESCE(vol_agua_desinfec, 0.00),
    vol_agua_fluor = COALESCE(vol_agua_fluor, 0.00)
WHERE pop_atendida_esgoto IS NULL 
   OR vol_esgoto_coletado IS NULL 
   OR vol_esgoto_tratado IS NULL 
   OR pop_atendida_agua IS NULL 
   OR vol_agua_anual IS NULL 
   OR vol_agua_eta IS NULL 
   OR vol_agua_desinfec IS NULL 
   OR vol_agua_fluor IS NULL;