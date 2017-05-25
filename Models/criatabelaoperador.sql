-- DROP TABLE indicadores.tb_operadores;

CREATE TABLE indicadores.tb_operadores
(
  cd_colaborador character varying,
  nm_colaborador character varying,
  tot_alo integer,
  tot_cpc integer,
  tot_venda integer,
  tot_acionamento integer,
  alo_acionamento numeric(14,2),
  cpc_alo numeric(14,2),
  venda_cpc numeric(14,2),
  cpc_acionamento numeric(14,2),
  venda_acionamento numeric(14,2)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE indicadores.tb_operadores
  OWNER TO postgres;