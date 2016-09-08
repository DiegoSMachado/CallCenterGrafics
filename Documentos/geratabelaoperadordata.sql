DROP TABLE indicadores.tb_operadores;

CREATE TABLE indicadores.tb_operadores (
dt_referencia      VARCHAR
,cd_colaborador    VARCHAR
,nm_colaborador    VARCHAR
,tot_alo           INT
,tot_cpc           INT
,tot_venda         INT
,tot_acionamento   INT
,alo_acionamento   NUMERIC(14,2)
,cpc_alo           NUMERIC(14,2)
,venda_cpc         NUMERIC(14,2)
,cpc_acionamento   NUMERIC(14,2)
,venda_acionamento NUMERIC(14,2)
) TABLESPACE  tbs_indicadores;


INSERT INTO indicadores.tb_operadores
SELECT 
  CAST(a.dt_referencia                AS VARCHAR)
 ,CAST(a.cd_colaborador               AS VARCHAR)
 ,CAST(a.nm_colaborador               AS VARCHAR)
 ,CASE qt_chamadas ISNULL THEN
    0
 ELSE
    CAST(qt_chamadas                    AS INT) as tot_acionamento 
 END qt_chamadas

 ,CASE tot_alo ISNULL THEN
   0
 ELSE
   CAST(tot_alo                        AS INT)
 END tot_alo

 ,CASE tot_cpc ISNULL THEN
    0
 ELSE
    CAST(tot_cpc                        AS INT)
 END tot_cpc

 ,CASE tot_venda ISNULL THEN
    0
 ELSE
    CAST(tot_venda                        AS INT)
 END tot_venda

 ,CASE WHEN a.qt_chamadas > 0 THEN
    ROUND((CAST(a.tot_alo   AS NUMERIC)/CAST(a.qt_chamadas AS NUMERIC)*100),2)
 ELSE
   0.00
 END alo_acionamento

 ,CASE WHEN a.tot_alo > 0 THEN
    ROUND((CAST(a.tot_cpc   AS NUMERIC)/CAST(a.tot_alo AS NUMERIC)*100),2)
 ELSE
   0.00
 END cpc_alo

 ,CASE WHEN a.tot_cpc > 0 THEN
 ROUND((CAST(a.tot_venda AS NUMERIC)/CAST(a.tot_cpc AS NUMERIC)*100),2)
 ELSE
   0.00
 END venda_cpc

 ,CASE WHEN a.qt_chamadas > 0 THEN
 ROUND((CAST(a.tot_cpc   AS NUMERIC)/CAST(a.qt_chamadas AS NUMERIC)*100),2)
 ELSE
   0.00
 END cpc_acionamento

 ,CASE WHEN a.qt_chamadas > 0 THEN
 ROUND((CAST(a.tot_venda AS NUMERIC)/CAST(a.qt_chamadas AS NUMERIC)*100),2)
 ELSE
   0.00
 END venda_acionamento

FROM(
SELECT
 CAST(d.dhreferencia AS DATE)     AS dt_referencia
 ,d.cdlogincolaborador            AS cd_colaborador
 ,c.nmcolaborador                 AS nm_colaborador
 ,SUM(d.fgcontato)                AS tot_alo
 ,SUM(d.fgcpc)                    AS tot_cpc
 ,SUM(d.fgvenda)                  AS tot_venda
 ,COUNT(1)                        AS qt_chamadas
FROM dm_f_acionamento d
LEFT JOIN er_a_agtcolaboradordia c
on d.cdlogincolaborador = c.cdlogincolaborador
and CAST(d.dhreferencia AS DATE) = c.dtreferencia
WHERE CAST(d.dhreferencia AS DATE) >= CURRENT_DATE -30
AND c.nmcolaborador <> ''
GROUP BY CAST(d.dhreferencia AS DATE),d.cdlogincolaborador,c.nmcolaborador
) a
ORDER BY a.dt_referencia, a.cd_colaborador;