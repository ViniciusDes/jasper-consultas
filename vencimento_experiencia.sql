SELECT RA_FILIAL CODIGO_FILIAL,
    APS_DESC_FILIAL FILIAL,
    RA_MAT MATRICULA,
    RA_NOME NOME,
    RJ_FUNCAO CODIGO_FUNCAO,
    RJ_DESC FUNCAO,
    RA_CC CODIGO_CENTRO_CUSTO,
    CTT_DESC01 CENTRO_CUSTO,
    dbo.stod (RA_ADMISSA) ADMISSAO,
    dbo.stod(RA_VCTOEXP) VENC_1A_EXP,
    dbo.stod(RA_VCTEXP2) VENC_2A_EXP
FROM SRA$P!{CODIGO_EMPRESA} SRA
    JOIN API_SIGAMAT ON RA_FILIAL = APS_COD_FILIAL
        AND APS_COD_EMPRESA = '$P!{CODIGO_EMPRESA}'
    JOIN CTT$P!{CODIGO_EMPRESA} CTT ON (RA_FILIAL = CTT_FILIAL OR LEFT(RA_FILIAL, 2) = CTT_FILIAL OR CTT_FILIAL = '') AND RA_CC = CTT_CUSTO AND CTT.D_E_L_E_T_ = ''
JOIN SRJ$P!{CODIGO_EMPRESA} SRJ ON
(RA_FILIAL = RJ_FILIAL OR LEFT
(RA_FILIAL, 2) = RJ_FILIAL OR RJ_FILIAL = '') AND RA_CODFUNC = RJ_FUNCAO AND SRJ.D_E_L_E_T_ = ''
WHERE SRA.D_E_L_E_T_=''
    AND LEFT(RA_VCTEXP2, 6) = '$P!{ANO}$P!{MES}'
    AND RA_DEMISSA = ''
    AND RA_PROCES = '00001'
    AND RA_FILIAL LIKE (IIF( 1>'$P!{CONSOLIDADO}', '$P!{CODIGO_FILIAL}', '%%'));
ORDER BY RA_FILIAL
