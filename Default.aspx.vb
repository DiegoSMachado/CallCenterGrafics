Imports System.Data
Imports System.Web.Services
Imports Npgsql

Partial Class _Default
 Inherits System.Web.UI.Page

 <WebMethod>
 Public Shared Function GetDadosGrafico() As List(Of DadosDetalhes)
  Dim dt As New DataTable()
  Dim Conexao As String = "Server=localhost;Port=5432;UserId=postgres;Password=mktec;Database=DB_Graph"
  Dim con As NpgsqlConnection = New NpgsqlConnection(Conexao)
  con.Open()
  'Dim cmd As String = "SELECT nome, total, idade FROM public.dadosgraficos ORDER BY total desc"
  Dim cmd As String = "SELECT nome, total, idade FROM public.dadosgraficos ORDER BY total desc"
  Dim da As Npgsql.NpgsqlDataAdapter = New NpgsqlDataAdapter(cmd, con)
  da.Fill(dt)
  con.Close()

  Dim listaDados As New List(Of DadosDetalhes)()
  For Each dtrow As DataRow In dt.Rows
   Dim details As New DadosDetalhes()
   details.NomePais = dtrow(0).ToString().Trim()
   details.Total = Convert.ToInt32(dtrow(1))
   details.Idade = Convert.ToInt32(dtrow(2))
   listaDados.Add(details)
  Next
  Return listaDados
 End Function
End Class

Public Class DadosDetalhes
 Public Property NomePais() As String
 Public Property Total() As Integer
 Public Property Idade() As Integer

End Class


