SELECT RA_FILIAL                                         CODIGO_FILIAL,
       APS_DESC_FILIAL                                   FILIAL,
       RA_MAT                                            MATRICULA,
       RA_NOME                                           NOME,
       IIF(RA_ADMISSA = '', '', dbo.stod(RA_ADMISSA))    ADMISSAO,
       TIPOADM.X5_CHAVE                                  CODIGO_TIPO_ADMISSAO,
       TIPOADM.X5_DESCRI                                 TIPO_ADMISSAO,
       IIF(RA_DEMISSA = '', '', dbo.stod(RA_DEMISSA))    DEMISSAO,
       RA_RESCRAI                                        CODIGO_TIPO_DEMISSAO,
       IIF(RA_RESCRAI = '', '', TIPO_RESCISAO.X5_DESCRI) TIPO_DEMISSAO,
       dbo.calculaidade(RA_ADMISSA)                      TEMPO_DE_EMPRESA,
       IIF(RA_NASC = '', '', dbo.stod(RA_NASC))          NASCIMENTO,
       dbo.calculaidade(RA_NASC)                         IDADE,
       RA_MAE                                            NOME_MAE,
       RA_PAI                                            NOME_PAI,
       RA_MUNNASC                                        MUN_NASCIMENTO,
       RA_CIC                                            CPF,
       RA_PIS                                            PIS,
       RA_RG                                             RG,
       RA_RGUF                                           UF_RG,
       RA_COMPLRG                                        COMPLEMENTO_RG,
       RA_RGORG                                          EMISSOR_RG,
       IIF(RA_DTRGEXP = '', '', dbo.stod(RA_DTRGEXP))    EMISSAO_RG,
       RA_NUMCP                                          NUM_CTPS,
       RA_SERCP                                          SERIE_CTPS,
       RA_UFCP                                           UF_CTPS,
       IIF(RA_DTCPEXP = '', '', dbo.stod(RA_DTCPEXP))    EMISSAO_CTPS,
       RA_TITULOE                                        TITULO_ELEITOR,
       RA_ZONASEC                                        ZONA_ELEITORAL,
       RA_RESERVI                                        RESERVISTA,
       RA_DDDFONE                                        DDD_TELEFONE,
       RA_TELEFON                                        TELEFONE,
       RA_DDDCELU                                        DDD_CELULAR,
       RA_NUMCELU                                        CELULAR,
       RA_NATURAL                                        NATURAL,
       RA_SEXO                                           SEXO,
       CASE RA_RACACOR
           WHEN '2' THEN 'BRANCA'
           WHEN '4' THEN 'PRETA'
           WHEN '8' THEN 'PARDA'
           WHEN '6' THEN 'AMARELA'
           WHEN '1' THEN 'INDIGENA'
           ELSE 'SEMINFORMACAO'
           END                                           RACA_COR,
       CASE RA_ESTCIVI
           WHEN 'C' THEN 'Casado(a)'
           WHEN 'D' THEN 'Divorciado(a)'
           WHEN 'M' THEN N'União estável'
           WHEN 'Q' THEN 'Separado(a)'
           WHEN 'S' THEN 'Solteiro(a)'
           WHEN 'V' THEN 'Viuvo(a)'
           ELSE 'Outros'
           END                                           ESTADO_CIVIL,
       IIF(RA_DEFIFIS = '1', 'SIM', 'NAO')               DEFICIENTE_FISICO,
       RA_TNOTRAB                                        CODIGO_TURNO_TRABALHO,
       R6_DESC                                           TURNO_TRABALHO,
       RA_CATFUNC                                        CATEGORIA,
       RA_SITFOLH                                        SITUACAO_FOLHA,
       RA_CODFUNC                                        CODIGO_FUNCAO,
       RJ_DESC                                           FUNCAO,
       RJ_CODCBO                                         CBO,
       RA_SALARIO                                        SALARIO,
       RA_CC                                             CODIGO_CENTRO_CUSTO,
       CTT_DESC01                                        CENTRO_DE_CUSTO,
       GRINRAI.X5_DESCRI                                 ESCOLARIDADE,
       RA_HABILIT                                        CNH,
       CASE RA_CATCNH
           WHEN '' THEN ''
           WHEN '1' THEN 'A'
           WHEN '2' THEN 'B'
           WHEN '3' THEN 'C'
           WHEN '4' THEN 'D'
           WHEN '5' THEN 'E'
           WHEN '6' THEN 'AB'
           WHEN '7' THEN 'AC'
           WHEN '8' THEN 'AD'
           WHEN '9' THEN 'AE'
           END                                           CATEGORIA_CNH,
       RA_UFCNH                                          UF_CNH,
       IIF(RA_DTINCON = '', '', dbo.stod(RA_DTINCON))    PRIMEIRA_CNH,
       RA_CNHORG                                         EMISSOR_CNH,
       IIF(RA_DTEMCNH = '', '', dbo.stod(RA_DTEMCNH))    EMISSAO_CNH,
       IIF(RA_DTVCCNH = '', '', dbo.stod(RA_DTVCCNH))    VALIDADE_CNH,
       RA_SINDICA                                        CODIGO_SINDICATO,
       RCE_DESCRI                                        SINDICATO,
       RA_BCDEPSA                                        BANCO_AGENCIA,
       CASE RA_TPCTSAL
           WHEN 1 THEN 'CORRENTE'
           WHEN 2 THEN 'POUPANCA'
           ELSE ''
           END                                           TIPO_CONTA,
       RA_CTDEPSA                                        CONTA,
       RA_ENDEREC                                        ENDERECO,
       RA_NUMENDE                                        NUM_ENDERECO,
       RA_COMPLEM                                        COMPLEMENTO_ENDERECO,
       RA_BAIRRO                                         BAIRRO,
       RA_ESTADO                                         ESTADO,
       RA_CODMUN                                         CODIGO_MUNICIPIO,
       RA_MUNICIP                                        MUNICIPIO,
       RA_CEP                                            CEP,
       RA_EMAIL                                          EMAIL,
       CASE RA_TPCONTR
           WHEN '1' THEN 'INDETERMINADO'
           WHEN '2' THEN 'DETERMINADO'
           WHEN '3' THEN 'INTERMITENTE'
           END                                           TIPO_CONTRATO,
       IIF(RA_DTFIMCT = '', '', dbo.stod(RA_DTFIMCT))    DT_TERMINO_CONTRATO,
       IIF(RA_HOPARC = '1', 'SIM', 'NAO')                CT_PARCIAL,
       IIF(RA_COMPSAB = '1', 'SIM', 'NAO')               COMP_SABADO,
       IIF(RA_CLAURES = '1', 'SIM', 'NAO')               CLAUSULA_ASSECURATORIA,
       RA_DEPIR                                          QNT_DEP_IR,
       RA_DEPSF                                          QNT_DEP_SF,
       RA_DTVTEST                                        VENCIMENTO_ESTABILIDADE,
       IIF(RA_EAPOSEN = '1', 'SIM', 'NAO')               APOSENTADO,
       IIF(RA_MENSIND = '1', 'SIM', 'NAO')               MENSALIDADE_SINDICAL,
       IIF(RA_ASSIST = '1', 'SIM', 'NAO')                CONTRIBUICAO_ASSISTENCIAL,
       IIF(RA_VCTOEXP = '', '', dbo.stod(RA_VCTOEXP))    VENCIMENTO_EXPERIENCIA,
       IIF(RA_VCTEXP2 = '', '', dbo.stod(RA_VCTEXP2))    VENCIMENTO_EXPERIENCIA_2,
       IIF(RA_EXAMEDI = '', '', dbo.stod(RA_EXAMEDI))    VENCIMENTO_EXAME_MEDICO,
       RA_HRSMES                                         HORAS_MENSAIS,
       RA_HRSEMAN                                        HORAS_SEMANAIS,
       RA_FECREI                                         DATA_REINTEGRACAO,
       CASE RA_ADCPERI
           WHEN 1 THEN 'NAO'
           WHEN 2 THEN N'INSALUBRIDADE MÍNIMA'
           WHEN 3 THEN N'INSALUBRIDADE MÉDICA'
           WHEN 4 THEN N'INSALUBRIDADE MÁXIMA'
           END                                           POSSUI_PERICULOSIDADE,
       CASE RA_ADCINS
           WHEN 1 THEN 'NAO'
           WHEN 2 THEN N'INSALUBRIDADE MÍNIMA'
           WHEN 3 THEN N'INSALUBRIDADE MÉDICA'
           WHEN 4 THEN N'INSALUBRIDADE MÁXIMA'
           END                                           POSSUI_INSALUBRIDADE,
       IIF(RA_CTPCD = '1', 'SIM', 'NAO')                 COTA_DEFICIENTE,
       RA_DEPTO                                          CODIGO_DEPARTAMENTO,
       IIF(QB_DESCRIC IS NULL, '', QB_DESCRIC)           DEPARTAMENTO,
       RA_CPAISOR                                        CODIGO_PAIS_ORIGEM,
       CCH_PAIS                                          PAIS_ORIGEM,
       IIF(RA_DATNATU = '', '', dbo.stod(RA_DATNATU))    DATA_NATURALIZACAO,
       RA_NUMNATU                                        NUMERO_NATURALIZACAO,
       RA_ANOCHEG                                        ANO_CHEGADA,
       IIF(RA_DATCHEG = '', '', dbo.stod(RA_DATCHEG))    DATA_CHEGADA,
       CASE RA_CASADBR
           WHEN '' THEN ''
           WHEN 1 THEN 'SIM'
           WHEN 2 THEN N'NÃO'
           END                                           CASADO_BRASILEIRO,
       CASE RA_FILHOBR
           WHEN '' THEN ''
           WHEN 1 THEN 'SIM'
           WHEN 2 THEN N'NÃO'
           END                                           FILHO_BRASILERO,
       RA_CLASEST                                        CLASSIFICACAO_ESTRANGEIRO,
       RA_PERCADT                                        PERCENTUAL_ADIANTAMENTO
FROM SRA$P!{CODIGO_EMPRESA} SRA
         JOIN API_SIGAMAT
              ON RA_FILIAL = APS_COD_FILIAL
                  AND APS_COD_EMPRESA = '$P!{CODIGO_EMPRESA}'
         JOIN SRJ$P!{CODIGO_EMPRESA} SRJ ON (RA_FILIAL = RJ_FILIAL
    OR LEFT(RA_FILIAL, 2) = RJ_FILIAL
    OR RJ_FILIAL = '')
    AND RA_CODFUNC = RJ_FUNCAO
    AND SRJ.D_E_L_E_T_ = ''
         JOIN CTT$P!{CODIGO_EMPRESA} CTT ON (RA_FILIAL = CTT_FILIAL
    OR LEFT(RA_FILIAL, 2) = CTT_FILIAL
    OR CTT_FILIAL = '')
    AND RA_CC = CTT_CUSTO
    AND CTT.D_E_L_E_T_ = ''
         JOIN SR6$P!{CODIGO_EMPRESA} SR6 ON (RA_FILIAL = R6_FILIAL
    OR LEFT(RA_FILIAL, 2) = R6_FILIAL
    OR R6_FILIAL = '')
    AND RA_TNOTRAB = R6_TURNO
    AND SR6.D_E_L_E_T_ = ''
         LEFT JOIN SX5$P!{CODIGO_EMPRESA} GRINRAI ON (RA_FILIAL = GRINRAI.X5_FILIAL
    OR LEFT(RA_FILIAL, 2) = GRINRAI.X5_FILIAL
    OR GRINRAI.X5_FILIAL = '')
    AND RA_GRINRAI = GRINRAI.X5_CHAVE
    AND GRINRAI.X5_TABELA = '26'
    AND GRINRAI.D_E_L_E_T_ = ''
         LEFT JOIN SX5$P!{CODIGO_EMPRESA} TIPOADM ON (RA_FILIAL = TIPOADM.X5_FILIAL
    OR LEFT(RA_FILIAL, 2) = TIPOADM.X5_FILIAL
    OR TIPOADM.X5_FILIAL = '')
    AND RA_TIPOADM = TIPOADM.X5_CHAVE
    AND TIPOADM.X5_TABELA = '38'
    AND TIPOADM.D_E_L_E_T_ = ''
         LEFT JOIN RCE$P!{CODIGO_EMPRESA} RCE ON (RA_FILIAL = RCE_FILIAL
    OR LEFT(RA_FILIAL, 2) = RCE_FILIAL
    OR RCE_FILIAL = '')
    AND RCE_CODIGO = RA_SINDICA
    AND RCE.D_E_L_E_T_ = ''
         LEFT JOIN SQB$P!{CODIGO_EMPRESA} SQB ON (RA_FILIAL = QB_FILIAL
    OR LEFT(RA_FILIAL, 2) = QB_FILIAL
    OR QB_FILIAL = '')
    AND QB_DEPTO = RA_DEPTO
    AND SQB.D_E_L_E_T_ = ''
         JOIN CCH$P!{CODIGO_EMPRESA} CCH ON (RA_FILIAL = CCH_FILIAL
    OR LEFT(RA_FILIAL, 2) = CCH_FILIAL
    OR CCH_FILIAL = '')
    AND CCH_CODIGO = RA_CPAISOR
    AND CCH.D_E_L_E_T_ = ''
         LEFT JOIN SX5$P!{CODIGO_EMPRESA} TIPO_RESCISAO ON (RA_FILIAL = TIPO_RESCISAO.X5_FILIAL
    OR LEFT(RA_FILIAL, 2) = TIPO_RESCISAO.X5_FILIAL
    OR TIPO_RESCISAO.X5_FILIAL = '')
    AND TIPO_RESCISAO.X5_TABELA = '27'
    AND TIPO_RESCISAO.X5_CHAVE = RA_RESCRAI
    AND TIPO_RESCISAO.D_E_L_E_T_ = ''
WHERE SRA.D_E_L_E_T_ = ''
  AND (RA_DEMISSA = ''
    OR LEFT(RA_DEMISSA
           , 6) >= '$P!{ANO}$P!{MES}')
  AND RA_PROCES = '00001'
  AND RA_FILIAL = '$P!{CODIGO_FILIAL}'
ORDER BY RA_FILIAL,
         RA_NOME;
