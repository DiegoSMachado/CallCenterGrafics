<%@ Page Language="VB" AutoEventWireup="false" CodeFile="operador.aspx.vb" Inherits="operador" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
  <!-- JavaScript-->
 <script src="js/bootstrap.min.js"></script>
 <script src="js/jquery-1.8.2.js" type="text/javascript"></script>
 <!-- <script src="js/loader.js" type="text/javascript"></script> -->
 <script src="js/jsapi.js" type="text/javascript"></script>
 <script type="text/javascript">
  $(function () {
   $.ajax({
    type: 'POST', dataType: 'json', contentType: 'application/json', url: 'operador.aspx/GetDadosGrafico', data: '{}',
    success:
        function (response) {
         drawoperadores(response.d);
        },
    error:
     function () {
      alert('Erro ao carregar os dados dos Operadores');
     }
   });
  })
  function drawoperadores(dataValues) {
   alert(dataValues[0].cd_colaborador);
  }
 </script>
</head>
<body>
    <form id="form1" runat="server">
     <select id="dataselec" runat="server">
      <option value="2016-08-31">31/08/2016</option>
     </select>
    <div>
    
    </div>
    </form>
</body>
</html>
