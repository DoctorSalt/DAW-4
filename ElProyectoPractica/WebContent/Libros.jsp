<%@page import="es.studium.practica.ConexionValores"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="es.studium.practica.TranformadorDatos"%>
<% String usuario=request.getParameter("usuario"); 
Class.forName(ConexionValores.clasesforName);
String userName = ConexionValores.userName;
String password = ConexionValores.passName;
String url = ConexionValores.url;
TranformadorDatos datos=new TranformadorDatos();
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">
<title>Los Libros Hueones</title>
</head>
<body>
	<div class="container">
		<div class="row text-right p-2 pt-3 mb-lg-2 mt-lg-2">
			<div class="col-12">
				<a href="/ElProyectoPractica/Deslogarse" class="btn btn-danger">Deslogarse</a>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row text-center">
			<div class="col-12">
				<h4 class="text-left">
					Bienvenido Usuario:
					<%if(usuario!=""){   %>
					<%=usuario %>
					<% } %>
				</h4>
				<h1 class="mt-3">Libros</h1>
			</div>
		</div>
		<div class="row text-center p-2 pt-3 mb-lg-2 mt-lg-2">
			<div class="col-12 mt-3  col-md-12 col-lg-12">
				<a
					href="/ElProyectoPractica/opcionesComprobantes?lugarRedireccion=libroAlta"
					class="btn btn-success text-center">Alta</a>
			</div>			
		</div>
		<div class="row text-center p-2 pt-3 mb-lg-2 mt-lg-2">
			<div class="col-12">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">idLibro</th>
							<th scope="col">nombreLibro</th>
							<th scope="col">precioLibro</th>
							<th scope="col">cantidadLibro</th>
							<th scope="col">fechaLibro</th>
							<th scope="col">Autor</th>
							<th scope="col">Editorial</th>
							<th scope="col">Modificar</th>
						</tr>
					</thead>
					<tbody>
						<%
						Connection conn = DriverManager.getConnection(url, userName, password);
						Statement stmt = conn.createStatement();	
						String sqlStr = "SELECT idLibro, nombreLibro, precioLibro, cantidadLibro, fechaLibro, nombreAutor, nombreEditorial FROM tiendalibros.libros," 
								+"editoriales, autores where idAutor=idAutorFK AND idEditorial=idEditorialFK;";
						ResultSet rs = stmt.executeQuery(sqlStr);
						int count = 0;		
						while(rs.next()){
							String idLibro =rs.getString("idLibro");
							String nombreLibro = rs.getString("nombreLibro");
							String precioLibro = datos.numeroPuntoComa(rs.getString("precioLibro"));
							String cantidadLibro = rs.getString("cantidadLibro");
							String fechaLibro = datos.fechaEspaniol(rs.getString("fechaLibro"));
							String nombreAutor = rs.getString("nombreAutor");
							String nombreEditorial = rs.getString("nombreEditorial");
							count++;
						%>
						<tr>
							
							<td><%=idLibro %></td>
							<td><%=nombreLibro%></td>
							<td><%=precioLibro %> &euro;</td>
							<td><%=cantidadLibro%></td>
							<td><%=fechaLibro%></td>
							<td><%=nombreAutor%></td>
							<td><%=nombreEditorial%></td>
							<td>
								<form method="get" action="/ElProyectoPractica/ModifiquenLibros">
									<input name="elIdLibro" value="<%=idLibro %>" type="hidden">
									<input type="submit" name="Modificar" value="Modificar"	class="btn btn-primary">
								</form>
							</td>							
						</tr>
						<% } %>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row text-center p-2 pt-3 mb-lg-2 mt-lg-2">
			<div class="col-12">
				<a
					href='/ElProyectoPractica/opcionesComprobantes?lugarRedireccion=general'
					class='btn btn-danger'>Volver</a>
			</div>
		</div>
	</div>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<%

%>
