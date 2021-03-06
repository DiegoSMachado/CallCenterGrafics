﻿Imports System.Data
Imports System.Web.Services
Imports Npgsql

Partial Class operador
 Inherits System.Web.UI.Page
 <WebMethod>
 Public Shared Function GetDadosGrafico() As List(Of DadosDetalhes)
  Dim dt As New DataTable()
  Dim Conexao As String = "Server=localhost;Port=5432;UserId=mktec;Password=mktec;Database=Tecnocall"
  'Dim Conexao As String = "Server=192.168.0.62;Port=5432;UserId=mktec;Password=mktec;Database=Tecnocall"
  Dim con As NpgsqlConnection = New NpgsqlConnection(Conexao)
  con.Open()
  Dim cmd As String
  cmd = "SELECT * FROM indicadores.tb_operadores"

  Dim da As Npgsql.NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd, con)
  da.Fill(dt)
  con.Close()

  Dim listaDados As New List(Of DadosDetalhes)()
  For Each dtrow As DataRow In dt.Rows
   Dim operadores As New DadosDetalhes()
   operadores.cd_colaborador = dtrow(0).ToString()
   operadores.nm_colaborador = dtrow(1).ToString()
   operadores.tot_alo = Convert.ToInt32(dtrow(2))
   operadores.tot_cpc = Convert.ToInt32(dtrow(3))
   operadores.tot_venda = Convert.ToInt32(dtrow(4))
   operadores.tot_acionamento = Convert.ToInt32(dtrow(5))
   operadores.alo_acionamento = Convert.ToSingle(dtrow(6))
   operadores.cpc_alo = Convert.ToSingle(dtrow(7))
   operadores.venda_cpc = Convert.ToSingle(dtrow(8))
   operadores.cpc_acionamento = Convert.ToSingle(dtrow(9))
   operadores.venda_acionamento = Convert.ToSingle(dtrow(10))

   listaDados.Add(operadores)
  Next
  Return listaDados
 End Function




 Public Class DadosDetalhes
  Public Property cd_colaborador() As String
  Public Property nm_colaborador() As String
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
