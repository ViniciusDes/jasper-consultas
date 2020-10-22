SELECT RA_FILIAL                           CODIGO_FILIAL,
       APS_DESC_FILIAL                     FILIAL,
       RA_MAT                              MATRICULA,
       RA_NOME                             NOME,
       RA_CODFUNC                          CODIGO_FUNCAO,
       RJ_DESC                             FUNCAO,
       RA_CC                               CODIGO_CENTRO_CUSTO,
       CTT_DESC01                          CENTRO_CUSTO,
       dbo.stod(RA_ADMISSA)                ADMISSAO,
       RA_TIPOADM                          CODIGO_TIPO_ADMISSAO,
       TIPO_ADMISSAO.X5_DESCRI             TIPO_ADMISSAO,
       dbo.stod(RA_DEMISSA)                DEMISSAO,
       RA_RESCRAI                          CODIGO_TIPO_DEMISSAO,
       TIPO_RESCISAO.X5_DESCRI             TIPO_DEMISSAO,
       dbo.stod(RA_NASC)                   NASCIMENTO,
       RA_PIS                              PIS,
       RA_SEXO                             SEXO,
       IIF(RA_DEFIFIS = '1', 'SIM', 'NAO') DEFICIENTE_FISICO,
       RJ_CODCBO                           CBO,
       RA_SALARIO                          SALARIO,
       RA_HRSMES                           HORAS_MES,
       RA_HRSEMAN                          HORAS_SEMANA
FROM SRA$P!{CODIGO_EMPRESA} SRA
         JOIN API_SIGAMAT ON RA_FILIAL = APS_COD_FILIAL
    AND APS_COD_EMPRESA = '$P!{CODIGO_EMPRESA}'
         JOIN SRJ$P!{CODIGO_EMPRESA} SRJ ON (RA_FILIAL = RJ_FILIAL
    OR LEFT(RA_FILIAL,
            2) = RJ_FILIAL
    OR RJ_FILIAL = '')
    AND RA_CODFUNC = RJ_FUNCAO
    AND SRJ.D_E_L_E_T_ = ''
         JOIN CTT$P!{CODIGO_EMPRESA} CTT ON (RA_FILIAL = CTT_FILIAL
    OR LEFT(RA_FILIAL,
            2) = CTT_FILIAL
    OR CTT_FILIAL = '')
    AND RA_CC = CTT_CUSTO
    AND CTT.D_E_L_E_T_ = ''
         JOIN SX5$P!{CODIGO_EMPRESA} TIPO_ADMISSAO ON (RA_FILIAL = TIPO_ADMISSAO.X5_FILIAL
    OR LEFT(RA_FILIAL, 2) = TIPO_ADMISSAO.X5_FILIAL
    OR TIPO_ADMISSAO.X5_FILIAL = '')
    AND TIPO_ADMISSAO.X5_TABELA = '38'
    AND TIPO_ADMISSAO.X5_CHAVE = RA_TIPOADM
    AND TIPO_ADMISSAO.D_E_L_E_T_ = ''
         JOIN SX5$P!{CODIGO_EMPRESA} TIPO_RESCISAO ON (RA_FILIAL = TIPO_RESCISAO.X5_FILIAL
    OR LEFT(RA_FILIAL, 2) = TIPO_RESCISAO.X5_FILIAL
    OR TIPO_RESCISAO.X5_FILIAL = '')
    AND TIPO_RESCISAO.X5_TABELA = '27'
    AND TIPO_RESCISAO.X5_CHAVE = RA_RESCRAI
    AND TIPO_RESCISAO.D_E_L_E_T_ = ''
WHERE SRA.D_E_L_E_T_ = ''
  AND LEFT(RA_DEMISSA,
           6) = '$P!{ANO}$P!{MES}'
  AND RA_FILIAL LIKE (IIF( 1>'$P!{CONSOLIDADO}', '$P!{CODIGO_FILIAL}', '%%'));
ORDER BY RA_FILIAL,
         RA_NOME
