Imports System.Data
Imports System.Web.Services
Imports Npgsql




Partial Class _Default
 Inherits System.Web.UI.Page
 <WebMethod>
 Public Shared Function GetDadosGrafico() As List(Of DadosDetalhes)
  Dim dt As New DataTable()
  'Dim Conexao As String = "Server=localhost;Port=5432;UserId=postgres;Password=mktec;Database=Tecnocall"
  Dim Conexao As String = "Server=192.168.0.62;Port=5432;UserId=mktec;Password=mktec;Database=Tecnocall"
  Dim con As NpgsqlConnection = New NpgsqlConnection(Conexao)
  con.Open()
  Dim cmd As String
  cmd = "  SELECT CAST(a.dt_referencia AS VARCHAR)"
  cmd += ",ROUND((CAST(a.tot_alo AS NUMERIC)/CAST(a.qt_chamadas AS NUMERIC)*100),2)   as alo_acionamento"
  cmd += ",ROUND((CAST(a.tot_cpc AS NUMERIC)/CAST(a.tot_alo AS NUMERIC)*100),2)       as cpc_alo"
  cmd += ",ROUND((CAST(a.tot_venda AS NUMERIC)/CAST(a.tot_cpc AS NUMERIC)*100),2)     as venda_cpc"
  cmd += ",ROUND((CAST(a.tot_cpc AS NUMERIC)/CAST(a.qt_chamadas AS NUMERIC)*100),2)   as cpc_acionamento"
  cmd += ",ROUND((CAST(a.tot_venda AS NUMERIC)/CAST(a.qt_chamadas AS NUMERIC)*100),2) as venda_acionamento"
  cmd += " FROM("
  cmd += " SELECT "
  cmd += " CAST(dt_referencia AS DATE)"
  cmd += ",SUM(tot_alo)         As tot_alo"
  cmd += ",SUM(tot_cpc)         As tot_cpc"
  cmd += ",SUM(tot_venda)       As tot_venda"
  cmd += ",SUM(tot_acionamento) As qt_chamadas"
  cmd += " FROM indicadores.tb_indicadores"
  cmd += " GROUP BY CAST(dt_referencia As Date)"
  cmd += " ) a "
  cmd += " ORDER BY a.dt_referencia"
  Dim da As Npgsql.NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd, con)
  da.Fill(dt)
  con.Close()

  Dim listaDados As New List(Of DadosDetalhes)()
  For Each dtrow As DataRow In dt.Rows
   Dim details As New DadosDetalhes()
   details.dt_referencia = dtrow(0).ToString()
   details.alo_acionamento = Convert.ToString(dtrow(1))
   details.cpc_alo = Convert.ToSingle(dtrow(2))
   details.venda_cpc = Convert.ToSingle(dtrow(3))
   details.cpc_acionamento = Convert.ToSingle(dtrow(4))
   details.venda_acionamento = Convert.ToSingle(dtrow(5))

   listaDados.Add(details)
  Next
  Return listaDados
 End Function

 Public Class DadosDetalhes
  Public Property dt_referencia() As String
  Public Property alo_acionamento() As Single
  Public Property cpc_alo() As Single
  Public Property venda_cpc() As Single
  Public Property cpc_acionamento() As Single
  Public Property venda_acionamento() As Single

 End Class

 <WebMethod>
 Public Shared Function GetDadosGraficoB() As List(Of DadosDetalhesB)
  Dim dt As New DataTable()
  'Dim Conexao As String = "Server=localhost;Port=5432;UserId=postgres;Password=mktec;Database=Tecnocall"
  Dim Conexao As String = "Server=192.168.0.62;Port=5432;UserId=mktec;Password=mktec;Database=Tecnocall"
  Dim con As NpgsqlConnection = New NpgsqlConnection(Conexao)
  con.Open()
  Dim cmd As String
  cmd = "SELECT CAST(dt_referencia As VARCHAR), hr_referencia, tot_alo, tot_cpc, tot_venda,tot_acionamento, alo_acionamento, "
  cmd += " cpc_alo, venda_cpc, cpc_acionamento, venda_acionamento"
  cmd += " FROM indicadores.tb_indicadores"
  Dim da As Npgsql.NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd, con)
  da.Fill(dt)
  con.Close()

  Dim listaDadosB As New List(Of DadosDetalhesB)()
  For Each dtrow As DataRow In dt.Rows
   Dim details As New DadosDetalhesB()
   details.dt_referencia = dtrow(0).ToString()
   details.hr_referencia = dtrow(1).ToString()
   details.tot_alo = Convert.ToInt32(dtrow(2))
   details.tot_cpc = Convert.ToInt32(dtrow(3))
   details.tot_venda = Convert.ToInt32(dtrow(4))
   details.tot_acionamento = Convert.ToInt32(dtrow(5))
   details.alo_acionamento = Convert.ToSingle(dtrow(6))
   details.cpc_alo = Convert.ToSingle(dtrow(7))
   details.venda_cpc = Convert.ToSingle(dtrow(8))
   details.cpc_acionamento = Convert.ToSingle(dtrow(9))
   details.venda_acionamento = Convert.ToSingle(dtrow(10))

   listaDadosB.Add(details)
  Next
  Return listaDadosB
 End Function




 Public Class DadosDetalhesB
  Public Property dt_referencia() As String
  Public Property hr_referencia() As String
  Public Property tot_alo() As Single
  Public Property tot_cpc() As Single
  Public Property tot_venda() As Single
  Public Property tot_acionamento() As Single
  Public Property alo_acionamento() As Single
  Public Property cpc_alo() As Single
  Public Property venda_cpc() As Single
  Public Property cpc_acionamento() As Single
  Public Property venda_acionamento() As Single

 End Class


 <WebMethod>
 Public Shared Function GetDadosGraficoC() As List(Of DadosDetalhesC)
  Dim dt As New DataTable()
  'Dim Conexao As String = "Server=localhost;Port=5432;UserId=postgres;Password=mktec;Database=Tecnocall"
  Dim Conexao As String = "Server=192.168.0.62;Port=5432;UserId=mktec;Password=mktec;Database=Tecnocall"
  Dim con As NpgsqlConnection = New NpgsqlConnection(Conexao)
  con.Open()
  Dim cmd As String
  cmd = "SELECT CAST(dt_referencia As VARCHAR), hr_referencia, tot_alo, tot_cpc, tot_venda,tot_acionamento, alo_acionamento, "
  cmd += " cpc_alo, venda_cpc, cpc_acionamento, venda_acionamento"
  cmd += " FROM indicadores.tb_indicadores"
  Dim da As Npgsql.NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd, con)
  da.Fill(dt)
  con.Close()

  Dim listaDadosC As New List(Of DadosDetalhesC)()
  For Each dtrow As DataRow In dt.Rows
   Dim details As New DadosDetalhesC()
   details.dt_referencia = dtrow(0).ToString()
   details.hr_referencia = dtrow(1).ToString()
   details.tot_alo = Convert.ToInt32(dtrow(2))
   details.tot_cpc = Convert.ToInt32(dtrow(3))
   details.tot_venda = Convert.ToInt32(dtrow(4))
   details.tot_acionamento = Convert.ToInt32(dtrow(5))
   details.alo_acionamento = Convert.ToSingle(dtrow(6))
   details.cpc_alo = Convert.ToSingle(dtrow(7))
   details.venda_cpc = Convert.ToSingle(dtrow(8))
   details.cpc_acionamento = Convert.ToSingle(dtrow(9))
   details.venda_acionamento = Convert.ToSingle(dtrow(10))

   listaDadosC.Add(details)
  Next
  Return listaDadosC
 End Function


 Public Class DadosDetalhesC
  Public Property dt_referencia() As String
  Public Property hr_referencia() As String
  Public Property tot_alo() As Single
  Public Property tot_cpc() As Single
  Public Property tot_venda() As Single
  Public Property tot_acionamento() As Single
  Public Property alo_acionamento() As Single
  Public Property cpc_alo() As Single
  Public Property venda_cpc() As Single
  Public Property cpc_acionamento() As Single
  Public Property venda_acionamento() As Single

 End Class
End Class