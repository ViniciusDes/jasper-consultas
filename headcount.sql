SELECT RA_FILIAL                                                         CODIGO_FILIAL,
       APS_DESC_FILIAL                                                   FILIAL,
       RA_MAT                                                            MATRICULA,
       RA_NOME                                                           NOME,
       dbo.stod(RA_ADMISSA)                                              ADMISSAO,
       IIF(RA_DEMISSA = '', '', dbo.stod(RA_DEMISSA))                    DEMISSAO,
       RA_RESCRAI                                                        CODIGO_TIPO_DEMISSAO,
       IIF(TIPO_RESCISAO.X5_DESCRI IS NULL, '', TIPO_RESCISAO.X5_DESCRI) TIPO_DEMISSAO,
       dbo.calculaidade(RA_ADMISSA)                                      TEMPO_DE_EMPRESA,
       IIF(RA_NASC = '', '', dbo.stod(RA_NASC))                          NASCIMENTO,
       dbo.calculaidade(RA_NASC)                                         IDADE,
       RA_SEXO                                                           SEXO,
       RA_SITFOLH                                                        SITUACAO,
       IIF(R8_TIPOAFA IS NULL, '', R8_TIPOAFA)                           CODIGO_TIPO_AFASTAMENTO,
       IIF(RCM_DESCRI IS NULL, '', RCM_DESCRI)                           TIPO_AFASTAMENTO,
       CASE RA_RACACOR
           WHEN '2' THEN 'BRANCA'
           WHEN '4' THEN 'PRETA'
           WHEN '8' THEN 'PARDA'
           WHEN '6' THEN 'AMARELA'
           WHEN '1' THEN 'INDIGENA'
           ELSE 'SEM INFORMACAO'
           END                                                           RACA_COR,
       CASE RA_ESTCIVI
           WHEN 'C' THEN 'Casado(a)'
           WHEN 'D' THEN 'Divorciado(a)'
           WHEN 'M' THEN N'União estável'
           WHEN 'Q' THEN 'Separado(a)'
           WHEN 'S' THEN 'Solteiro(a)'
           WHEN 'V' THEN 'Viuvo(a)'
           ELSE 'Outros'
           END                                                           ESTADO_CIVIL,
       IIF(RA_DEFIFIS = '1', 'SIM', 'NAO')                               DEFICIENTE_FISICO,
       RA_CATFUNC                                                        CATEGORIA,
       RA_CODFUNC                                                        CODIGO_FUNCAO,
       RJ_DESC                                                           FUNCAO,
       RA_CC                                                             CODIGO_CENTRO_CUSTO,
       CTT_DESC01                                                        CENTRO_CUSTO,
       GRINRAI.X5_DESCRI                                                 ESCOLARIDADE,
       IIF(RA_CTPCD = '1', 'SIM', 'NAO')                                 COTA_DEFICIENTE,
       RA_DEPTO                                                          CODIGO_DEPARTAMENTO,
       IIF(QB_DESCRIC IS NULL, '', QB_DESCRIC)                           DEPARTAMENTO,
       IIF(RA_FECREI = '', '', dbo.stod(RA_FECREI))                      REINTEGRACAO
FROM SRA$P!{CODIGO_EMPRESA} SRA
         JOIN API_SIGAMAT ON RA_FILIAL = APS_COD_FILIAL
    AND APS_COD_EMPRESA = '$P!{CODIGO_EMPRESA}'
         JOIN SRJ$P!{CODIGO_EMPRESA} SRJ ON (RA_FILIAL = RJ_FILIAL OR LEFT(RA_FILIAL, 2) = RJ_FILIAL OR RJ_FILIAL = '') AND
                            RA_CODFUNC = RJ_FUNCAO AND SRJ.D_E_L_E_T_ = ''
         JOIN CTT$P!{CODIGO_EMPRESA} CTT ON (RA_FILIAL = CTT_FILIAL OR LEFT(RA_FILIAL, 2) = CTT_FILIAL OR CTT_FILIAL = '') AND
                            RA_CC = CTT_CUSTO AND CTT.D_E_L_E_T_ = ''
         JOIN SR6$P!{CODIGO_EMPRESA} SR6 ON (RA_FILIAL = R6_FILIAL OR LEFT(RA_FILIAL, 2) = R6_FILIAL OR R6_FILIAL = '') AND
                            RA_TNOTRAB = R6_TURNO AND SR6.D_E_L_E_T_ = ''
         JOIN SX5$P!{CODIGO_EMPRESA} GRINRAI
              ON (RA_FILIAL = GRINRAI.X5_FILIAL OR LEFT(RA_FILIAL, 2) = GRINRAI.X5_FILIAL OR GRINRAI.X5_FILIAL = '') AND
                 RA_GRINRAI = GRINRAI.X5_CHAVE AND GRINRAI.X5_TABELA = '26' AND GRINRAI.D_E_L_E_T_ = ''
         LEFT JOIN SX5$P!{CODIGO_EMPRESA} TIPO_RESCISAO
                   ON (RA_FILIAL = TIPO_RESCISAO.X5_FILIAL
                       OR LEFT(RA_FILIAL, 2) = TIPO_RESCISAO.X5_FILIAL
                       OR TIPO_RESCISAO.X5_FILIAL = '')
                       AND TIPO_RESCISAO.X5_TABELA = '27'
                       AND TIPO_RESCISAO.X5_CHAVE = RA_RESCRAI
                       AND TIPO_RESCISAO.D_E_L_E_T_ = ''
         LEFT JOIN SR8$P!{CODIGO_EMPRESA}
                   ON R8_MAT = RA_MAT AND R8_FILIAL = RA_FILIAL AND R8_DATAFIM = '' AND R8_TIPOAFA <> '001' AND
                      SR8$P!{CODIGO_EMPRESA}.D_E_L_E_T_ = ''
         LEFT JOIN RCM$P!{CODIGO_EMPRESA} TIPO_AFASTAMENTO
                   ON (R8_FILIAL = TIPO_AFASTAMENTO.RCM_FILIAL OR LEFT(R8_FILIAL, 2) = TIPO_AFASTAMENTO.RCM_FILIAL OR
                       TIPO_AFASTAMENTO.RCM_FILIAL = '') AND
                      R8_TIPOAFA = TIPO_AFASTAMENTO.RCM_TIPO AND TIPO_AFASTAMENTO.D_E_L_E_T_ = ''
         LEFT JOIN SQB$P!{CODIGO_EMPRESA} SQB
                   ON (RA_FILIAL = QB_FILIAL
                       OR LEFT(RA_FILIAL, 2) = QB_FILIAL
                       OR QB_FILIAL = '')
                       AND QB_DEPTO = RA_DEPTO
                       AND SQB.D_E_L_E_T_ = ''
WHERE SRA.D_E_L_E_T_ = ''
  AND (RA_DEMISSA = ''
    OR LEFT(RA_DEMISSA
           , 6) >= '$P!{ANO}$P!{MES}')
  AND RA_PROCES = '00001'
  AND RA_FILIAL = '$P!{CODIGO_FILIAL}'
ORDER BY RA_NOME
