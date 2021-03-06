SELECT RA_FILIAL AS CODIGO_FILIAL,
    APS_DESC_FILIAL FILIAL,
    RA_MAT AS MATRICULA,
    RA_NOME AS NOME,
    dbo.stod(RA_NASC) NASCIMENTO,
    RA_CODFUNC AS CODIGO_FUNCAO,
    RJ_DESC AS FUNCAO,
    RA_CC AS CODIGO_CENTRO_CUSTO,
    CTT_DESC01 AS CENTRO_CUSTO
FROM SRA$P!{CODIGO_EMPRESA} SRA
    JOIN API_SIGAMAT ON RA_FILIAL = APS_COD_FILIAL
        AND APS_COD_EMPRESA = '$P!{CODIGO_EMPRESA}'
    JOIN SRJ$P!{CODIGO_EMPRESA} SRJ ON (RA_FILIAL = RJ_FILIAL OR LEFT(RA_FILIAL, 2) = RJ_FILIAL OR RJ_FILIAL = '') AND RA_CODFUNC = RJ_FUNCAO AND SRJ.D_E_L_E_T_ = ''
    JOIN CTT$P!{CODIGO_EMPRESA} CTT ON (RA_FILIAL = CTT_FILIAL OR LEFT(RA_FILIAL, 2) = CTT_FILIAL OR CTT_FILIAL = '') AND RA_CC = CTT_CUSTO AND CTT.D_E_L_E_T_ = ''
WHERE RIGHT(LEFT(RA_NASC, 6), 2) =  '$P!{MES}'
    AND SRA.D_E_L_E_T_ = ''
    AND RA_DEMISSA = ''
    AND RA_PROCES = '00001'
    AND RA_FILIAL LIKE (IIF( 1>'$P!{CONSOLIDADO}', '$P!{CODIGO_FILIAL}', '%%'));
