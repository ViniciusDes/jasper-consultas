SELECT RF_FILIAL CODIGO_FILIAL,
       APS_DESC_FILIAL FILIAL,
       RA_CC CODIGO_CENTRO_CUSTO,
       CTT_DESC01 CENTRO_CUSTO,
       RF_MAT MATRICULA,
       RA_NOME NOME,
       CONVERT(VARCHAR, CONVERT(DATE, RA_ADMISSA), 103) ADMISSAO,
       CONVERT(VARCHAR, CONVERT(DATE, RF_DATABAS), 103) BASE,
       CONVERT(VARCHAR, CONVERT(DATE, RF_DATABAS), 103) + ' - ' + CONVERT(VARCHAR, CONVERT(DATE, RF_DATAFIM), 103) PERIODO_AQUISITIVO,
       CONVERT(VARCHAR, CONVERT(DATE, DATEADD(DAY, 30, SUBSTRING(RF_DATAFIM, 5, 2) + '/' + SUBSTRING(RF_DATAFIM, 7, 2) + '/' + SUBSTRING(RF_DATAFIM, 1, 4))), 103) DATA_LIMITE_IDEAL,
       CONVERT(VARCHAR, CONVERT(DATE, DATEADD(DAY, 320, SUBSTRING(RF_DATAFIM, 5, 2) + '/' + SUBSTRING(RF_DATAFIM, 7, 2) + '/' + SUBSTRING(RF_DATAFIM, 1, 4))), 103) DATA_LIMITE_MAX,
       RF_DFERVAT VENCIDAS,
       isnull(CASE
                  WHEN RF_DFALVAT >= 6
                       AND RF_DFALVAT <= 14 THEN 6
                  WHEN RF_DFALVAT >= 15
                       AND RF_DFALVAT <= 23 THEN 12
                  WHEN RF_DFALVAT >= 24
                       AND RF_DFALVAT <= 32 THEN 18
                  WHEN RF_DFALVAT > 32 THEN 30
              END, 0) D_ABAT,
       IIF(RF_DFERVAT <> 0, 0, datediff(MONTH, SUBSTRING(RF_DATABAS, 5, 2)+'/'+SUBSTRING(RF_DATABAS, 7, 2)+'/'+SUBSTRING(RF_DATABAS, 1, 4), SUBSTRING(RCH_DTPAGO, 5, 2)+'/'+SUBSTRING(RCH_DTPAGO, 7, 2)+'/'+SUBSTRING(RCH_DTPAGO, 1, 4))*2.5) PROPORCIONAIS,
       IIF(RF_DATAINI = '', '', dbo.stod(RF_DATAINI))                       "1_PROG_FERIAS",
       RF_DFEPRO1 D_1_PROG_FERIAS,
       IIF(RF_DATINI2 = '', '', dbo.stod(RF_DATINI2))                       "2_PROG_FERIAS",
       RF_DFEPRO2 D_2_PROG_FERIAS,
       IIF(RF_DATINI2 = '', '', dbo.stod(RF_DATINI2))                       "2_PROG_FERIAS",
       RF_DABPRO3 D_3_PROG_FERIAS,
       RF_DFERVAT - isnull(CASE
                               WHEN RF_DFALVAT >= 6
                                    AND RF_DFALVAT <= 14 THEN 6
                               WHEN RF_DFALVAT >= 15
                                    AND RF_DFALVAT <= 23 THEN 12
                               WHEN RF_DFALVAT >= 24
                                    AND RF_DFALVAT <= 32 THEN 18
                               WHEN RF_DFALVAT > 32 THEN 30
                           END, 0) + CASE
                                         WHEN RF_DFERVAT <> 0 THEN 0
                                         ELSE datediff(MONTH, SUBSTRING(RF_DATABAS, 5, 2) + '/' + SUBSTRING(RF_DATABAS, 7, 2) + '/' + SUBSTRING(RF_DATABAS, 1, 4), SUBSTRING(RCH_DTPAGO, 5, 2) + '/' + SUBSTRING(RCH_DTPAGO, 7, 2) + '/' + SUBSTRING(RCH_DTPAGO, 1, 4)) * 2.5
                                     END TOTAL
FROM SRF$P!{CODIGO_EMPRESA} SRF
JOIN API_SIGAMAT ON RF_FILIAL = APS_COD_FILIAL
AND APS_COD_EMPRESA = '$P!{CODIGO_EMPRESA}'
JOIN SRA$P!{CODIGO_EMPRESA} SRA ON RA_FILIAL = RF_FILIAL
AND RA_MAT = RF_MAT
AND RA_SITFOLH NOT IN ('D')
AND RA_CATFUNC NOT IN ('A',
                       'P')
AND RA_DEMISSA = ''
AND SRA.D_E_L_E_T_ = ''
JOIN CTT$P!{CODIGO_EMPRESA} CTT ON (RA_FILIAL = CTT_FILIAL
                    OR LEFT(RA_FILIAL, 2) = CTT_FILIAL
                    OR CTT_FILIAL = '')
AND RA_CC = CTT_CUSTO
AND CTT.D_E_L_E_T_ = ''
JOIN RCH$P!{CODIGO_EMPRESA} RCH ON RCH_PERSEL = '1'
AND RCH_ROTEIR = 'FER'
AND (RA_FILIAL = RCH_FILIAL
     OR LEFT(RA_FILIAL, 2) = RCH_FILIAL
     OR RCH_FILIAL = '')
AND RCH.D_E_L_E_T_<>'*'
WHERE SRF.D_E_L_E_T_ = ''
  AND RF_STATUS = '1'
    AND RA_FILIAL = '$P!{CODIGO_FILIAL}'
    AND RA_DEMISSA = ''
ORDER BY FILIAL,
         MATRICULA,
         NOME,
         BASE
