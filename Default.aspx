<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" Debug="true" %>

<!DOCTYPE html>

<html>
<head runat="server">
 <title>Gráficos</title>
 <!-- CSS -->
 <link href="css/bootstrap.min.css" rel="stylesheet">
 <link href="css/base.css" rel="stylesheet">
 <!-- JavaScript-->
 <script src="js/bootstrap.min.js"></script>
 <script src="js/jquery-1.8.2.js" type="text/javascript"></script>
 <!-- <script src="js/loader.js" type="text/javascript"></script> -->
 <script src="js/jsapi.js" type="text/javascript"></script>
 <script type="text/javascript">
  //Carrega os pacotes de gráficos do Google
  google.load('visualization', '1', { packages: ['corechart'] });
  google.load('visualization', '1', { packages: ['gauge'] });
  google.load('visualization', '1', { packages: ['table'] });
 </script>

 <script type="text/javascript">
  $(function () {
   $.ajax({
    type: 'POST', dataType: 'json', contentType: 'application/json', url: 'Default.aspx/GetDadosGrafico', data: '{}',
    success:
     function (response) {
      drawgauge1(response.d);
     },
    error:
     function () {
      alert("Erro ao carregar o Relógio! Tente novamente.");
     }
   });
   //-----------------------------------------------------------------------------------------------------------------
   $.ajax({
    type: 'POST', dataType: 'json', contentType: 'application/json', url: 'Default.aspx/GetDadosGraficoB', data: '{}',
    success:
     function (response) {
      ultimaAtualizao(response.d);
      drawcolunm(response.d);
      drawtable(response.d);
     },
    error:
     function () {
      alert("Erro ao carregar Barra e a tabela! Tente novamente.");
     }
   });
  })

  function ultimaAtualizao(dataValues) {
   i = dataValues.length - 1;
   ultimaatual.innerHTML = 'última atualização em ' + dataValues[i].dt_referencia + ' às ' + dataValues[i].hr_referencia +' horas';
  }

  // --- Gráfico Relogio 1 -------------------------
  function drawgauge1(dataValues) {
   //Insere os botoes e divs adicionais no painel
   if (document.getElementById("gauge") == null) {
    panel.innerHTML = '<div id="gauge" class="center-block"></div>'
    panel.innerHTML += '<div class="panel-footer text-center hidden-print"><div class="btn-group btn-group-sm text-center" data-toggle="buttons"><button type="button" class="btn btn-default" onclick="Reloadgauge1()">Relativa</button><button type="button" class="btn btn-default" onclick="Reloadgauge2()">Esteira</button></div></div>'
   } else { }
   // Popula Dados ao Google DataTable
   var data2 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data2.addColumn('number', 'alo/acion.');
   data2.addColumn('number', 'cpc/alo');
   data2.addColumn('number', 'venda/cpc');
   data2.addRow([dataValues[0].alo_acionamento, dataValues[0].cpc_alo, dataValues[0].venda_cpc]);
   var gaugeOptions = { min: 0, max: 100, minorTicks: 5 };
   // Monta a visualização do Google Chart Gauge
   var grafico2;
   grafico2 = new google.visualization.Gauge(document.getElementById('gauge'));
   grafico2.draw(data2, gaugeOptions);
  }

  // --- Gráfico Relogio 2 -------------------------
  function drawgauge2(dataValues) {
   //Insere os botoes e divs adicionais no painel
   if (document.getElementById("gauge") == null) {
    panel.innerHTML = '<div id="gauge" class="center-block"></div>'
    panel.innerHTML += '<div class="panel-footer text-center hidden-print"><div class="btn-group btn-group-sm text-center" data-toggle="buttons"><button type="button" class="btn btn-default" onclick="Reloadgauge1()">Relativa</button><button type="button" class="btn btn-default" onclick="Reloadgauge2()">Esteira</button></div></div>'
   } else { }
   // Popula Dados ao Google DataTable
   var data2 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data2.addColumn('number', 'alo/acion.');
   data2.addColumn('number', 'cpc/acion.');
   data2.addColumn('number', 'venda/acion.');
   // Populando a DataTable
   data2.addRow([dataValues[0].alo_acionamento, dataValues[0].cpc_acionamento, dataValues[0].venda_acionamento]);
   var gaugeOptions = { min: 0, max: 100, minorTicks: 5 };
   // Monta a visualização do Google Chart Gauge
   var grafico2;
   grafico2 = new google.visualization.Gauge(document.getElementById('gauge'));
   grafico2.draw(data2, gaugeOptions);
  }

  // --- Gráfico Misto (barra x coluna) --------
  function drawcolunm(dataValues) {
   //Insere os botoes e divs adicionais no painel
   panel.innerHTML += '<h3 class="titulo">Vendas × CPC/Alô</h3><div id="combo" class="comtitulo"></div>'
   var data3 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data3.addColumn('string', 'Hora');
   data3.addColumn('number', 'Vendas');
   data3.addColumn({type:'number', role: 'annotation' });
   data3.addColumn('number', 'CPC/Alô');
   data3.addColumn({ type: 'number', role: 'annotation' });
   // Populando a DataTable
   for (var i = 0; i < dataValues.length; i++) {
    //condição SE verifica qual dropbox esta selecionado no momento
    if (dataValues[i].dt_referencia == '2016-08-30') {
     data3.addRow([dataValues[i].hr_referencia, dataValues[i].tot_venda, dataValues[i].tot_venda, dataValues[i].cpc_alo, dataValues[i].cpc_alo]);
    } else {}
   }
   // Monta a visualização do Google Chart Gauge   
   var comboOptions = {vAxis: { title: 'Qt' }, hAxis: { title: 'Horas' }, seriesType: 'bars', series: { 1: { type: 'line', curveType: 'function', pointSize: 3,color:'green' } }, legend: { position: 'bottom' }};
   var grafico3;
   grafico3 = new google.visualization.ComboChart(document.getElementById('combo'));
   grafico3.draw(data3, comboOptions);
  }

  // --- Tabela  ---------------------------------------
  function drawtable(dataValues) {
   //Insere os botoes e divs adicionais no painel
   panel.innerHTML += '<div id="tabela1" class="center-block tabela1"></div>'
   var data4 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data4.addColumn('string', 'Hora');
   data4.addColumn('number', 'Acionamentos');
   data4.addColumn('number', 'Alô');
   data4.addColumn('number', 'Alô /Acion.');
   data4.addColumn('number', 'CPC');
   data4.addColumn('number', 'CPC/ Alô');
   data4.addColumn('number', 'Venda');
   data4.addColumn('number', 'Venda/ CPC');
   // Populando a DataTable
   for (var i = 0; i < dataValues.length; i++) {
    //condição SE verifica qual dropbox esta selecionado no momento {v: 7000,  f: '$7,000'}
    if (dataValues[i].dt_referencia == '2016-08-30') {
     data4.addRow([
          'de ' + dataValues[i].hr_referencia + ' às ' + dataValues[i+1].hr_referencia,
          dataValues[i].tot_acionamento,
          dataValues[i].tot_alo,
          { v: dataValues[i].alo_acionamento, f: dataValues[i].alo_acionamento + '%' },
          dataValues[i].tot_cpc,
          { v: dataValues[i].cpc_alo, f: dataValues[i].cpc_alo + '%' },
          dataValues[i].tot_venda,
          { v: dataValues[i].venda_cpc, f: dataValues[i].venda_cpc + '%' },
     ]);
    } else { }
   }
   // Monta a visualização do Google Chart Gauge   
   var comboOptions = {allowHtml: true, showRowNumber: false, width: '100%', height: '100%', showRowNumber: true, text: '15px' };
   var grafico4;
   grafico4 = new google.visualization.Table(document.getElementById('tabela1'));
   grafico4.draw(data4, comboOptions);
  }
 </script>
</head>
<body>
 <form id="form1" runat="server">
  <div class="navbar navbar-default navbar-fixed-top hidden-print">
   <div class="container-fluid">
    <div class="navbar-header">
     <a class="navbar-brand no-wrap" href="#" tabindex="-1">Report</a>
    </div>

    <div class="collapse navbar-collapse" id="navbar-collapse">
     <div class="form-group">
      <label for="id_quebra" class="sr-only">Quebra</label>
      <select id="id_quebra" name="id" class="form-control" required>
       <!-- Código Inserido pelo back end -------------------------->
       <option value="">Carteira / Quebra</option>
       <!----------------------------------------------------------->
      </select>
     </div>

     <div class="form-group">
      <label for="data" class="sr-only">Data</label>
      <select id="data" name="data" class="form-control">
       <!-- Código Inserido pelo back end -------------------------->
       <option value="">xx/xx/xxxx</option>
       <!----------------------------------------------------------->
      </select>
     </div>
     <button type="submit" class="btn btn-primary">atualizar</button>
    </div>
   </div>
  </div>
 </form>
 <div class="col-xs-12 col-lg-10 col-lg-offset-1">
  <div class="page-header">
   <!-- Código Inserido pelo back end -------------------------->
   <h1>Hora a Hora
   
    <small class="text-muted">ADT - TODAS</small>
    <small class="text-muted">( 29/08/2016 )</small>
   </h1>
  </div>
  <p id="ultimaatual" class="text-muted text-right"></p>
  <!----------------------------------------------------------->
  <ul id="abas" class="nav nav-tabs hidden-print">
   <li role="presentation" class="active"><a href="#">Dashboard</a></li>
   <li role="presentation">
    <a href="#">
     <span class="hidden-xs">Operadores</span>
     <span class="visible-xs-inline">Operad.</span>
    </a>
   </li>
   <li role="presentation">
    <a href="#">
     <span class="hidden-xs">Finalizações do dia</span>
    </a>
   </li>
  </ul>
  <div class="panel-body">
   <!-- Painel Dashboard -------------------------------------------- -->
   <div id="panel" class="panel text-center">
   </div>
  </div>
  </div>
</body>
</html>


<script>
 // --- Função filtra dropdox --------------------------------
 // Reconstrói somente os gráficos não alterando o Dropbox
 function Reloadgauge1() {
  $.ajax({
   type: 'POST',
   dataType: 'json',
   contentType: 'application/json',
   url: 'Default.aspx/GetDadosGrafico',
   data: '{}',
   success:
       function (response) {
        drawgauge1(response.d);
       }
  })
 }

 function Reloadgauge2() {
  $.ajax({
   type: 'POST',
   dataType: 'json',
   contentType: 'application/json',
   url: 'Default.aspx/GetDadosGrafico',
   data: '{}',
   success:
       function (response) {
        drawgauge2(response.d);
       }
  })
 }
</script>
