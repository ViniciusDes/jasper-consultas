SELECT RF_FILIAL CODIGO_FILIAL,
    APS_DESC_FILIAL FILIAL,
    RF_MAT MATRICULA,
    RA_NOME NOME,
    CASE RF_STATUS 
    WHEN '1' THEN 'ATIVO' 
    WHEN '2' THEN 'PRESCRITO'
    ELSE 'Pago' END 'STATUS',
    dbo.stod(RA_ADMISSA) ADMISSAO,
    dbo.stod(RF_DATABAS) INI_PER_AQUISITIVO,
    dbo.stod(RF_DATAFIM) FIM_PER_AQUISITIVO,
    RIGHT('00' + CAST(DATEPART(DD, DATEADD(DAY, -60, RF_DATAFIM)) AS varchar), 2) + '/' + RIGHT('00' + CAST(DATEPART(MM, DATEADD(DAY, -60, RF_DATAFIM))AS varchar), 2) + '/' + CAST(DATEPART(YYYY, DATEADD(DAY, -60, RF_DATAFIM)) AS varchar) DATA_IDEAL,
    RF_DFERVAT DIAS_VENCIDOS,
    RF_DFERAAT DIAS_PROPORCIONAIS,
    RF_DIASANT DIAS_ANTECIPADOS,
    RF_DFERANT DIAS_PAGOS
FROM SRF$P!{CODIGO_EMPRESA} SRF
    JOIN API_SIGAMAT ON RF_FILIAL = APS_COD_FILIAL
        AND APS_COD_EMPRESA = '$P!{CODIGO_EMPRESA}'
    JOIN SRA$P!{CODIGO_EMPRESA} SRA ON RA_FILIAL = RF_FILIAL
        AND RA_MAT = RF_MAT
        AND SRA.D_E_L_E_T_ = ''
WHERE RA_DEMISSA = ''
    AND RF_STATUS != 3
    AND RA_PROCES = '00001'
    AND RF_FILIAL = '$P!{CODIGO_FILIAL}'
ORDER BY RA_NOME,
         RF_MAT,
         RF_DATAFIM