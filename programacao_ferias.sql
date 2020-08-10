SELECT RF_FILIAL                                                            CODIGO_FILIAL,
       APS_DESC_FILIAL                                                      FILIAL,
       RA_CC                                                                CODIGO_CENTRO_CUSTO,
       CTT_DESC01                                                           CENTRO_CUSTO,
       RF_MAT                                                               MATRICULA,
       RA_NOME                                                              NOME,
       CONVERT(VARCHAR, CONVERT(DATE, RA_ADMISSA), 103)                     ADMISSAO,
       CONVERT(VARCHAR, CONVERT(DATE, RF_DATABAS), 103)                     BASE,
       CONVERT(VARCHAR, CONVERT(DATE, RF_DATABAS), 103) + ' - ' +
       CONVERT(VARCHAR, CONVERT(DATE, RF_DATAFIM), 103)                     PERIODO_AQUISITIVO,
       RF_DFERVAT                                                           VENCIDAS,
       isnull(CASE
                  WHEN RF_DFALVAT >= 6
                      AND RF_DFALVAT <= 14 THEN 6
                  WHEN RF_DFALVAT >= 15
                      AND RF_DFALVAT <= 23 THEN 12
                  WHEN RF_DFALVAT >= 24
                      AND RF_DFALVAT <= 32 THEN 18
                  WHEN RF_DFALVAT > 32 THEN 30
                  END, 0)                                                   D_ABAT,
       IIF(RF_DFERVAT <> 0, 0, datediff(MONTH, SUBSTRING(RF_DATABAS, 5, 2) + '/' + SUBSTRING(RF_DATABAS, 7, 2) + '/' +
                                               SUBSTRING(RF_DATABAS, 1, 4),
                                        SUBSTRING(RF_DATAATU, 5, 2) + '/' + SUBSTRING(RF_DATAATU, 7, 2) + '/' +
                                        SUBSTRING(RF_DATAATU, 1, 4)) * 2.5) PROPORCIONAIS,
       CASE
           WHEN RF_DATAINI = ' ' THEN 0
           ELSE CONVERT(VARCHAR, CONVERT(DATE, RF_DATAINI), 103)
           END                                                              "1_PROG_FERIAS",
       RF_DFEPRO1                                                           D_1_PROG_FERIAS,
       CASE
           WHEN RF_DATAINI = ' ' THEN 0
           ELSE CONVERT(VARCHAR, CONVERT(DATE, RF_DATINI2), 103)
           END                                                              "2_PROG_FERIAS",
       RF_DFEPRO2                                                           D_2_PROG_FERIAS,
       CASE
           WHEN RF_DATAINI = ' ' THEN 0
           ELSE CONVERT(VARCHAR, CONVERT(DATE, RF_DATINI3), 103)
           END                                                              "3_PROG_FERIAS",
       RF_DABPRO3                                                           D_3_PROG_FERIAS,
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
                                             ELSE datediff(MONTH, SUBSTRING(RF_DATABAS, 5, 2) + '/' +
                                                                  SUBSTRING(RF_DATABAS, 7, 2) + '/' +
                                                                  SUBSTRING(RF_DATABAS, 1, 4),
                                                           SUBSTRING(RF_DATAATU, 5, 2) + '/' +
                                                           SUBSTRING(RF_DATAATU, 7, 2) + '/' +
                                                           SUBSTRING(RF_DATAATU, 1, 4)) * 2.5
           END                                                              TOTAL
FROM SRF010 SRF
         JOIN API_SIGAMAT ON RF_FILIAL = APS_COD_FILIAL
    AND APS_COD_EMPRESA = '010'
         JOIN SRA010 SRA ON RA_FILIAL = RF_FILIAL
    AND RA_MAT = RF_MAT
    AND RA_SITFOLH NOT IN ('D')
    AND RA_CATFUNC NOT IN ('A', 'P')
    AND RA_DEMISSA = ''
    AND SRA.D_E_L_E_T_ = ''
         JOIN CTT010 CTT ON (RA_FILIAL = CTT_FILIAL OR LEFT(RA_FILIAL, 2) = CTT_FILIAL OR CTT_FILIAL = '') AND
                            RA_CC = CTT_CUSTO AND CTT.D_E_L_E_T_ = ''
WHERE SRF.D_E_L_E_T_ = ''
  AND RF_STATUS = '1'
ORDER BY FILIAL, MATRICULA, NOME, BASE
