<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="_Default" Debug="true" %>

<!DOCTYPE html>

<html>
<head runat="server">
 <title>Gráficos</title>
 <!-- CSS -->
 <link rel="stylesheet" href="css/bootstrap.min.css">
 <link href="css/base.css" rel="stylesheet" type="text/css">
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
  google.load('visualization', '1', { packages: ['map'] });
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
     function (responseB) {
      drawChartcolunm(responseB.d);
     },
    error:
     function () {
      alert("Erro ao carregar Barra e a tabela! Tente novamente.");
     }
   });
  })

  // --- Gráfico Relogio 1 -------------------------
  function drawgauge1(dataValues) {
   panel.innerHTML =  '<div id="gauge" class="center-block"></div>'
   panel.innerHTML += '<div class="panel-footer text-center hidden-print"><div class="btn-group btn-group-sm text-center" data-toggle="buttons"><button type="button" class="btn btn-default" onclick="Reloadgauge1()">Relativa</button><button type="button" class="btn btn-default" onclick="Reloadgauge2()">Esteira</button></div></div>'
   // Popula Dados ao Google DataTable
   var data2 = new google.visualization.DataTable();
   //alert(dataValues[0].alo_acionamento + " | " + dataValues[0].cpc_alo + " | " + dataValues[0].venda_cpc);
   // Construção das colunas do DataTable
   data2.addColumn('number', 'alo/acionamento');
   data2.addColumn('number', 'cpc/alo');
   data2.addColumn('number', 'venda/cpc');
   data2.addRow([dataValues[0].alo_acionamento, dataValues[0].cpc_alo, dataValues[0].venda_cpc]);
   var gaugeOptions = { min: 0, max: 100, yellowFrom: 60, yellowTo: 90, redFrom: 90, redTo: 100, minorTicks: 5 };
   // Monta a visualização do Google Chart Gauge
   var grafico2;
   grafico2 = new google.visualization.Gauge(document.getElementById('gauge'));
   grafico2.draw(data2, gaugeOptions);
  }

  // --- Gráfico Relogio 2 -------------------------
  function drawgauge2(dataValues) {
   panel.innerHTML = '<div id="gauge" class="center-block"></div>'
   panel.innerHTML += '<div class="panel-footer text-center hidden-print"><div class="btn-group btn-group-sm text-center" data-toggle="buttons"><button type="button" class="btn btn-default" onclick="Reloadgauge1()">Relativa</button><button type="button" class="btn btn-default" onclick="Reloadgauge2()">Esteira</button></div></div>'
   // Popula Dados ao Google DataTable
   var data2 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data2.addColumn('number', 'alo/acionamento');
   data2.addColumn('number', 'cpc/acionamento');
   data2.addColumn('number', 'venda/acionamento');
   // Populando a DataTable
   data2.addRow([dataValues[0].alo_acionamento, dataValues[0].cpc_acionamento, dataValues[0].venda_acionamento]);
   var gaugeOptions = { min: 0, max: 100, yellowFrom: 60, yellowTo: 90, redFrom: 90, redTo: 100, minorTicks: 5 };
   // Monta a visualização do Google Chart Gauge
   var grafico2;
   grafico2 = new google.visualization.Gauge(document.getElementById('gauge'));
   grafico2.draw(data2, gaugeOptions);
   waitingDialog.hide();
  }

  // --- Gráfico Misto (barra x coluna) --------
  function colunm(dataValues) {
   // Popula Dados ao Google DataTable
   var data3 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data3.addColumn('number', 'alo/acionamento');
   data3.addColumn('number', 'cpc/acionamento');
   data3.addColumn('number', 'venda/acionamento');
   // Populando a DataTable
   data3.addRow([dataValues[0].hr_referencia, dataValues[0].tot_venda, dataValues[0].cpc_alo]);
   var gaugeOptions = {    title: 'Monthly Coffee Production by Country',    vAxis: { title: 'Cups' },    hAxis: {title:'Month'},    seriesType:'bars',    series: {5:{ type: 'line' } }};
   // Monta a visualização do Google Chart Gauge
   var grafico3;
   grafico3 = new google.visualization.ComboChart(document.getElementById('gauge'));
   grafico3.draw(data3, gaugeOptions);
   waitingDialog.hide();
  }

 </script>
</head>
<body onload="  waitingDialog.show('Carregando os dados', { dialogSize: 'sm', progressType: 'warning' });">
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
  <p class="text-muted text-right">última atualização em 29/08/2016 às 17h48</p>
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
   <div id="panel" class="panel">
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
