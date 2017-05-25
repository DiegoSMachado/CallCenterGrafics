DROP TABLE indicadores.tb_indicadores;

CREATE TABLE indicadores.tb_indicadores (
dt_referencia VARCHAR(10)
,hr_referencia VARCHAR(2)
,tot_alo INT
,tot_cpc INT
,tot_venda INT
,alo_acionamento NUMERIC(14,2)
,cpc_alo NUMERIC(14,2)
,venda_cpc NUMERIC(14,2)
,cpc_acionamento NUMERIC(14,2)
,venda_acionamento NUMERIC(14,2)
) TABLESPACE  tbs_indicadores;


INSERT INTO indicadores.tb_indicadores
SELECT a.dt_referencia
 ,a.hr_referencia

 ,tot_alo
 ,tot_cpc
 ,tot_venda

 ,CASE WHEN a.qt_chamadas > 0 THEN
    ROUND((CAST(a.tot_alo   AS NUMERIC)/CAST(a.qt_chamadas AS NUMERIC)*100),2)
 ELSE
   0  
 END alo_acionamento

 ,CASE WHEN a.tot_alo > 0 THEN
 ROUND((CAST(a.tot_cpc   AS NUMERIC)/CAST(a.tot_alo AS NUMERIC)*100),2)
 ELSE
   0  
 END cpc_alo

 ,CASE WHEN a.tot_cpc > 0 THEN
 ROUND((CAST(a.tot_venda AS NUMERIC)/CAST(a.tot_cpc AS NUMERIC)*100),2)
 ELSE
   0  
 END venda_cpc

 ,CASE WHEN a.qt_chamadas > 0 THEN
 ROUND((CAST(a.tot_cpc   AS NUMERIC)/CAST(a.qt_chamadas AS NUMERIC)*100),2)
 ELSE
   0  
 END cpc_acionamento

 ,CASE WHEN a.qt_chamadas > 0 THEN
 ROUND((CAST(a.tot_venda AS NUMERIC)/CAST(a.qt_chamadas AS NUMERIC)*100),2)
 ELSE
   0  
 END venda_acionamento

FROM(
SELECT
 CAST(dhreferencia AS DATE)     AS dt_referencia
 ,TO_CHAR(dhreferencia,'HH24')  AS hr_referencia
 ,SUM(fgcontato)                AS tot_alo
 ,SUM(fgcpc)                    AS tot_cpc
 ,SUM(fgvenda)                  AS tot_venda
 ,COUNT(1)                      AS qt_chamadas
FROM dm_f_acionamento
WHERE CAST(dhreferencia AS DATE) >= CURRENT_DATE -30
GROUP BY CAST(dhreferencia AS DATE),TO_CHAR(dhreferencia,'HH24')
) a
ORDER BY a.dt_referencia, a.hr_referencia;