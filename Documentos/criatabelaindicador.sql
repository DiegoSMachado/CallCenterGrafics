-- DROP TABLE indicadores.tb_indicadores;

CREATE TABLE indicadores.tb_indicadores
(
  dt_referencia date,
  hr_referencia character varying(2),
  tot_alo numeric(14,0),
  tot_cpc numeric(14,0),
  tot_venda numeric(14,0),
  tot_acionamento numeric(14,0),
  alo_acionamento numeric(14,2),
  cpc_alo numeric(14,2),
  venda_cpc numeric(14,2),
  cpc_acionamento numeric(14,2),
  venda_acionamento numeric(14,2)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE indicadores.tb_indicadores
  OWNER TO mktec;