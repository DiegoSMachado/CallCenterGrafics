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
   // === Ajax carrega as funções em POST BACK ==================================================================================
   $.ajax({
    type: 'POST', dataType: 'json', contentType: 'application/json', url: 'Default.aspx/GetDadosGrafico', data: '{}',
    success:
     function (response) {
      drawDropdown(response.d);
      drawgauge1(response.d);
     },
    error:
     function () {
      erro.innerHTML = 'Erro ao carregar os dados do Relógio';
     }
   });
   //---------------------------------------------------------------------------------------------------------------------------
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
      erro.innerHTML = 'Erro ao carregar os dados da Tabela';
     }
   });
  })
  //============================================================================================================================
  // --- Funções ---------------------------------------------------------------------------------------------
  function convertedatas(datades) {
   ano = datades.substring(0, 4);
   mes = datades.substring(5, 7);
   dia = datades.substring(8, 10);
   dataconv = dia + '/' + mes + '/' + ano;
   return dataconv;
  }
  // --- Monta detalhes da página ----------------------------------------------------------------------------
  function ultimaAtualizao(dataValues) {
   i = dataValues.length - 1;
   datades = dataValues[i].dt_referencia;
   var dataconv = convertedatas(datades);
   ultimaatual.innerHTML = 'última atualização em ' + dataconv + ' às ' + dataValues[i].hr_referencia + ' horas';
   dataselecionada.innerHTML = '( ' + dataconv + ' )';
   titulo.innerHTML = 'Tecnocall';
  }

  // --- Popula Dropdown ---------------------------------------
  function drawDropdown(dataValues) {
   data.innerHTML = '';
   //montando o html <option value="xxxx-xx-xx">xxxx-xx-xx</option> de forma decrescente
   for (var i = dataValues.length - 1; i >= 0; i--) {
    datades = dataValues[i].dt_referencia;
    var dataconv = convertedatas(datades);
    data.innerHTML += '<option value="' + dataValues[i].dt_referencia + '">' + dataconv + '</option>';
   }
  }
  //==========================================================================================================================
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
   for (var i = 0; i < dataValues.length; i++) {
    if (dataValues[i].dt_referencia == data.value) {
     data2.addRow([
          { v: dataValues[i].alo_acionamento, f: dataValues[i].alo_acionamento + '%' },
          { v: dataValues[i].cpc_acionamento, f: dataValues[i].cpc_alo + '%' },
          { v: dataValues[i].venda_acionamento, f: dataValues[i].venda_cpc + '%' }
     ]);
    }
   }
   // Monta a visualização do Google Chart Gauge
   var gaugeOptions = { min: 0, max: 100, minorTicks: 5 };
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
   for (var i = 0; i < dataValues.length; i++) {
    if (dataValues[i].dt_referencia == data.value) {
     data2.addRow([
          { v: dataValues[i].alo_acionamento, f: dataValues[i].alo_acionamento + '%' },
          { v: dataValues[i].cpc_acionamento, f: dataValues[i].cpc_acionamento + '%' },
          { v: dataValues[i].venda_acionamento, f: dataValues[i].venda_acionamento + '%' }
     ]);
    }
   }
   // Monta a visualização do Google Chart Gauge
   var gaugeOptions = { min: 0, max: 100, minorTicks: 5 };
   var grafico2;
   grafico2 = new google.visualization.Gauge(document.getElementById('gauge'));
   grafico2.draw(data2, gaugeOptions);
  }

  // --- Gráfico Misto (barra x coluna) --------
  function drawcolunm(dataValues) {
   //Insere os botoes e divs adicionais no painel
   if (document.getElementById('combo') == null) {
    panel.innerHTML += '<h3 class="titulo">Vendas × CPC/Alô</h3><div id="combo" class="comtitulo"></div>'
    $('#menudash').addClass('active');
    $('#menuoper').removeClass('active');
   }
   var data3 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data3.addColumn('string', 'Hora');
   data3.addColumn('number', 'Vendas');
   data3.addColumn({ type: 'number', role: 'annotation' });
   data3.addColumn('number', 'CPC/Alô');
   data3.addColumn({ type: 'number', role: 'annotation' });
   // Populando a DataTable
   for (var i = 0; i < dataValues.length; i++) {
    //condição SE verifica qual dropbox esta selecionado no momento
    if (dataValues[i].dt_referencia == data.value) {
     data3.addRow([
              { v: dataValues[i].hr_referencia, f: dataValues[i].hr_referencia + 'h' },
              dataValues[i].tot_venda,
              dataValues[i].tot_venda,
              dataValues[i].cpc_alo,
              { v: dataValues[i].cpc_alo, f: dataValues[i].cpc_alo + '%' }
     ]);
    } else { }
   }
   // Monta a visualização do Google Chart Gauge   
   var comboOptions = { vAxis: { title: 'Qt' }, seriesType: 'bars', series: { 1: { type: 'line', curveType: 'function', pointSize: 3, color: 'green' } }, legend: { position: 'bottom' } };
   var grafico3;
   grafico3 = new google.visualization.ComboChart(document.getElementById('combo'));
   grafico3.draw(data3, comboOptions);
  }

  // --- Tabela  ---------------------------------------
  function drawtable(dataValues) {
   //Insere os botoes e divs adicionais no painel
   if (document.getElementById('tabela1') == null) {
    panel.innerHTML += '<div id="tabela1" class="center-block tabela1 col-xs-12 col-lg-12"></div>'
   }
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
    if (dataValues[i].dt_referencia == data.value) {
     horapos = parseInt(dataValues[i].hr_referencia, 10);
     horapos++;
     data4.addRow([
           'de ' + dataValues[i].hr_referencia + ' às ' + horapos,
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
   // Monta a visualização do Google tabela   
   var comboOptions = { allowHtml: true, showRowNumber: false, width: '100%', height: '100%', showRowNumber: true, text: '15px' };
   var grafico4;
   grafico4 = new google.visualization.Table(document.getElementById('tabela1'));

   var formatter = new google.visualization.ColorFormat();
   formatter.addRange(10, 0, 'lightgreen', 'lightred');
   formatter.format(data4, 3); // O numero e referente a coluna

   grafico4.draw(data4, comboOptions);
  }
  //============================================================================================================================
  // --- Constrói tabela operadores  -------------------------------------------------------------------------------------------
  function drawoperadores(dataValues) {

   //Insere os botoes e divs adicionais no painel
   if (document.getElementById('tabela2') == null) {
    panel.innerHTML = '<div id="tabela2" class="center-block"></div>'
    $('#menuoper').addClass('active');
    $('#menudash').removeClass('active');
   }
   var data5 = new google.visualization.DataTable();
   // Construção das colunas do DataTable
   data5.addColumn('string', 'Operador');
   data5.addColumn('number', 'Acionamentos');
   data5.addColumn('number', 'Alô');
   data5.addColumn('number', 'Alô /Acion.');
   data5.addColumn('number', 'CPC');
   data5.addColumn('number', 'CPC/ Alô');
   data5.addColumn('number', 'Venda');
   data5.addColumn('number', 'Venda/ CPC');
   // Populando a DataTable
   for (var i = 0; i < dataValues.length; i++) {
     data5.addRow([
           dataValues[i].nm_colaborador,
           dataValues[i].tot_acionamento,
           dataValues[i].tot_alo,
           { v: dataValues[i].alo_acionamento, f: dataValues[i].alo_acionamento + '%' },
           dataValues[i].tot_cpc,
           { v: dataValues[i].cpc_alo, f: dataValues[i].cpc_alo + '%' },
           dataValues[i].tot_venda,
           { v: dataValues[i].venda_cpc, f: dataValues[i].venda_cpc + '%' },
     ]);
   }
   // Monta a visualização do Google tabela   
   var comboOptions = { allowHtml: true, showRowNumber: false, width: '100%', height: '100%', showRowNumber: true, text: '15px' };
   var grafico5;
   grafico5 = new google.visualization.Table(document.getElementById('tabela2'));

   var formatter = new google.visualization.ColorFormat();
   formatter.addRange(10, 0, 'lightgreen', 'lightred');
   formatter.format(data5, 3); // O numero e referente a coluna

   grafico5.draw(data5, comboOptions);
  }
 </script>
</head>
<!-- ==================================================================================== -->
<body>
 <form id="form1" runat="server">
  <div id="erro" class="alert-warning"></div>
  <div class="navbar navbar-default navbar-fixed-top hidden-print">
   <div class="container-fluid">
    <div class="navbar-header">
     <a id="titulo" class="navbar-brand no-wrap" href="#" tabindex="-1">Carregando...</a>
    </div>

    <div class="collapse navbar-collapse" id="navbar-collapse">
<!--     <div class="form-group">
      <label for="id_quebra" class="sr-only">Quebra</label>
      <select id="id_quebra" name="id" class="form-control" required>
       <option value="">Carteira / Quebra</option>
      </select>
     </div> -->

     <div class="form-group">
      <label for="data" class="sr-only">Data</label>
      <select id="data" name="data" class="form-control" onchange="dataselect()">
       <option value="">Carregando...</option>
      </select>
     </div>
    </div>
   </div>
  </div>
 </form>
 <div class="col-xs-12 col-lg-10 col-lg-offset-1">
  <div class="page-header">
   <h1>Hora a Hora
    <small class="text-muted">ADT - </small>
    <small id="dataselecionada" class="text-muted">Carregando ...</small>
   </h1>
  </div>
  <p id="ultimaatual" class="text-muted text-right"></p>
  <ul id="abas" class="nav nav-tabs hidden-print">
   <li id="menudash" role="presentation" class="active">
    <a href="#" onclick="dataselect()">Dashboard</a></li>
   <li id="menuoper" role="presentation" class="">
    <a href="#" onclick="selecionoper()">
     <span class="hidden-xs">Operadores</span>
     <span class="visible-xs-inline">Operad.</span>
    </a>
   </li>
<!--   <li role="presentation">
    <a href="#">
     <span class="hidden-xs">Finalizações do dia</span>
    </a>
   </li> -->
  </ul>
  <div class="panel-body">
   <div id="panel" class="panel text-center">
   </div>
  </div>
 </div>
</body>
</html>


<script>
 //=========================================================================================
 // --- Função contrói Relogio 1 --------------------------------
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

 // --- Função contrói Relogio 2 --------------------------------
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

 // --- Seleção Dropbox Data  --------------------------------
 function dataselect() {
  datades = data.value;
  var dataconv = convertedatas(datades);
  dataselecionada.innerHTML = '( ' + dataconv + ' )';
  $.ajax({
   type: 'POST', dataType: 'json', contentType: 'application/json', url: 'Default.aspx/GetDadosGrafico', data: '{}',
   success:
    function (response) {
     drawgauge1(response.d);
    },
   error:
    function () {
     erro.innerHTML = 'Erro ao carregar os dados dos Relógio';
    }
  });
  $.ajax({
   type: 'POST', dataType: 'json', contentType: 'application/json', url: 'Default.aspx/GetDadosGraficoB', data: '{}',
   success:
    function (response) {
     drawcolunm(response.d);
     drawtable(response.d);
    },
   error:
    function () {
     erro.innerHTML = 'Erro ao carregar os dados dos Tabela';
    }
  });
 }

 // --- Seleção menu operadores  --------------------------------
 function selecionoper() {
  dataselecionada.innerHTML = '( Resultado dos últimos 30 dias )';
   $.ajax({
    type: 'POST', dataType: 'json', contentType: 'application/json',  url: 'Default.aspx/GetDadosGraficoC',  data: '{}',
    success:
        function (response) {
         drawoperadores(response.d);
        },
    error: 
     function () {
      erro.innerHTML = 'Erro ao carregar os dados dos Operadores';
     }
   });
  }
</script>
