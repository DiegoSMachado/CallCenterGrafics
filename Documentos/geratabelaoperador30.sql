DROP TABLE indicadores.tb_operadores;

CREATE TABLE indicadores.tb_operadores (
cd_colaborador    VARCHAR
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
 CAST(a.cd_colaborador               AS VARCHAR)
 ,CAST(a.nm_colaborador               AS VARCHAR)
 ,CASE WHEN qt_chamadas ISNULL THEN
    0
 ELSE
    CAST(qt_chamadas                    AS INT) 
 END tot_acionamento

 ,CASE WHEN tot_alo ISNULL THEN
   0
 ELSE
   CAST(tot_alo                        AS INT)
 END tot_alo

 ,CASE WHEN tot_cpc ISNULL THEN
    0
 ELSE
    CAST(tot_cpc                        AS INT)
 END tot_cpc

 ,CASE WHEN tot_venda ISNULL THEN
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
 d.cdlogincolaborador            AS cd_colaborador
 ,c.nmcolaborador                 AS nm_colaborador
 ,SUM(d.fgcontato)                AS tot_alo
 ,SUM(d.fgcpc)                    AS tot_cpc
 ,SUM(d.fgvenda)                  AS tot_venda
 ,COUNT(1)                        AS qt_chamadas
FROM dm_f_acionamento d
LEFT JOIN er_a_agtcolaboradordia c
on d.cdlogincolaborador = c.cdlogincolaborador
WHERE CAST(d.dhreferencia AS DATE) >= CURRENT_DATE -30
AND c.nmcolaborador <> ''
GROUP BY d.cdlogincolaborador,c.nmcolaborador
) a
ORDER BY  a.cd_colaborador;