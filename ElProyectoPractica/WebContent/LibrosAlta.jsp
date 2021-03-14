<%@page import="es.studium.practica.ConexionValores"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<% 
		String resultado="";
		String usuario=request.getParameter("usuario"); 
		if(request.getParameter("resultado")!=null){
			resultado=request.getParameter("resultado"); 
		}
		Class.forName(ConexionValores.clasesforName);
		String userName = ConexionValores.userName;
		String password = ConexionValores.passName;
		String url = ConexionValores.url;
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
				<h1 class="mt-3">Alta</h1>
				<p class="mt-1">Rellenar todos los detalles requeridos</p>
			</div>
		</div>
		<form class="row mt-3" method="get" action="/ElProyectoPractica/CrearLibro">
			<div class="form-group col-12 mt-3 col-md-6 col-lg-6">
				<label for="nombreElegido">Nombre</label> 
				<input type="text"	placeholder="Suca Blia el libro" class="form-control" id="nombreElegido" name="nombreElegido">
			</div>
			<div class="form-group col-12 mt-3 col-md-6 col-lg-6">
				<label for="precioElegido">Precio</label>
				<input type="text" placeholder="19.9" class="form-control" id="precioElegido" name="precioElegido">
			</div>
			<div class="form-group col-12 mt-3 col-md-6 col-lg-6">
				<label for="cantidadElegido">Cantidad</label> 
				<input type="number" min="1" placeholder="1" class="form-control" id="cantidadElegido" name="cantidadElegido">
			</div>
			<div class="form-group col-12 mt-3 col-md-6 col-lg-6">
				<label for="fechaElegido">Fecha Elegido</label> 
				<input type="text" class="form-control" id="fechaElegido" name="fechaElegido">
			</div>
			<div class="form-group col-12 mt-3 col-md-6 col-lg-6">
				<label for="autorCorresp">Autor</label> 
				<select id="autorCorresp" name="autorCorresp" class="form-control">
					<option value="autor-0">Seleccione una opción</option>
					<%						 
							Connection conn = DriverManager.getConnection(url, userName, password);
							Statement stmt = conn.createStatement();	
							String sqlStr = "SELECT * FROM autores";
							ResultSet rs = stmt.executeQuery(sqlStr);
							int count = 0;		
							while(rs.next()){
								String idAutor =rs.getString("idAutor");
								String nombreAutor = rs.getString("nombreAutor");
								String apellidoAutor = rs.getString("apellidosAutor");								
								count++;
								%>
					<option value="autor-<%=idAutor%>">
						<%=idAutor%>-<%=nombreAutor%>-<%=apellidoAutor %></option>
					<% } %>
				</select>
			</div>
			<div class="form-group col-12 mt-3 col-md-6 col-lg-6">
				<label for="editorialCorresp">Editorial</label> 
				<select id="editorialCorresp" name="editorialCorresp" class="form-control">
					<option value="editorial-0">Seleccione una opción</option>
					<%						 	
							Connection conn2 = DriverManager.getConnection(url, userName, password);
							Statement stmt2 = conn.createStatement();	
							String sqlStr2 = "SELECT * FROM editoriales";
							ResultSet rs2 = stmt.executeQuery(sqlStr2);
							int count2 = 0;		
							while(rs2.next()){
								String idEditorial =rs2.getString("idEditorial");
								String nombreEditorial = rs2.getString("nombreEditorial");
								count2++;
						%>
					<option value="editorial-<%=idEditorial%>">
						<%=idEditorial%>-<%=nombreEditorial%></option>
					<% } %>

				</select>
			</div>
			<div class="form-group text-center col-12 mt-3">
				<input type="submit" class="btn btn-lg btn-success" name="Acceder" />
			</div>
			<div class="form-group text-center col-12 mt-3">
				<a	href='/ElProyectoPractica/opcionesComprobantes?lugarRedireccion=libros'
					class='btn btn-danger'>Volver</a>
			</div>
		</form>
		<div class="row">
			<%
			if(resultado.equals("Bien")){
			%>
			<div class="col-12">
				<p class="bg-success text-white">Se ha introducido sin problemas</p>
			</div>
			<%
			}else if(!resultado.equals("")){
			%>
			<% System.out.println("Resultado="+resultado);%>
				<div class="col-12">					
					<p class="bg-danger text-white">					
						<%="Se han cometido errores: "+resultado%> 
					</p>
				</div>
			<% }%>
		</div>
	</div>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>

