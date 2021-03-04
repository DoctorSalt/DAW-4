<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String usuario=request.getParameter("usuario"); %>   

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
				<h4 class="text-left">Bienvenido Usuario: 			
				<%if(usuario!=""){   %>
				<%=usuario %>
				<% } %>
				</h4>
				<h1 class="mt-3">Opciones</h1>
			</div>
		</div>
		<div class="row text-center p-2 pt-3 mb-lg-2 mt-lg-2">
			<div class="col-12 mt-3  col-md-6 col-lg-6">
				<a href="/ElProyectoPractica/opcionesComprobantes?lugarRedireccion=libros" class="btn btn-success">Libros</a>
			</div>
			<div class="col-12 mt-3 col-md-6 col-lg-6">
				<a href="/ElProyectoPractica/opcionesComprobantes?lugarRedireccion=autores" class="btn btn-primary">Autores</a>
			</div>
		</div>
		<div class="row text-center p-2 mb-lg-2 mt-lg-2">
			<div class="col-12 mt-3 col-md-6 col-lg-6">
				<a href="/ElProyectoPractica//opcionesComprobantes?lugarRedireccion=editorial" class="btn btn-warning">Editoriales</a>
			</div>
			<div class="col-12 mt-3 col-md-6 col-lg-6">
				<a href="/ElProyectoPractica/opcionesComprobantes?lugarRedireccion=pedidos" class="btn btn-secondary">Pedidos</a>
			</div>
		</div>
	</div>
	    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>