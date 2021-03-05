<%-- Página de órdenes de pedido --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true" import="java.util.*, es.studium.practica.*"%>
<% String usuario=request.getParameter("usuario");
 String error=request.getParameter("error");
 String exito = request.getParameter("exitoEnviado");
 System.out.println("Usuario "+usuario+" - "+" exitoEnviado "+exito+" - "+"Error "+error);
%>
<!DOCTYPE html>
<html lang="es">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">
<title>Pedido</title>
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
		<div class="row">
			<div class="col-12">
				<h4 class="text-left">
					Bienvenido Usuario:
					<%if(usuario!=""){   %>
					<%=usuario %>
					<% } %>
				</h4>
				<h1 class="text-center mt-3">Hacer Pedidos</h1>
				<p class="text-center mt-1">Seleccione un libro y la cantidad</p>
			</div>
		</div>
		<div class="row text-center p-2 pt-3 mb-lg-2 mt-lg-2">
			<form class="col-12" name="AgregarForm" action="/ElProyectoPractica/Carrito" method="POST">
				<div class="col-12 mt-3  ">
					<label>Libro a seleccionar:</label> 
					<input type="hidden" name="todo" value="add">
				</div>
				<div class="col-12 mt-3">
					<select id="libroCorresp" name="idLibro" class="form-control">
						<%
							// Scriplet 1: Carga los libros en el SELECT
						for (int i = 0; i < CarritoMVC.tamano(); i++) {
							out.println("<option value='" + CarritoMVC.getIdLibro(i) + "'>");
							out.println(CarritoMVC.getTitulo(i) + " | " + CarritoMVC.getAutor(i) + " | " + CarritoMVC.getPrecio(i));
							out.println("</option>");
						}
						%>
					</select>
				</div>
				<div class="col-12 mt-3 col-md-12 col-lg-12 text-center">
					<label>Cantidad</label> 
					<input type="number" min="0" class="form-group text-center" name="cantidad" size="10" value="1">
				</div>
				<div class="col-12 mt-3">
					<input type="submit" class="btn btn-success" value="Añadir a la cesta">
				</div>
			</form>

		</div>
	</div>
	<%
		// Scriplet 2: Chequea el contenido de la cesta
	ArrayList<ElementoPedido> cesta = (ArrayList<ElementoPedido>) session.getAttribute("carrito");
	if (cesta != null && cesta.size() > 0) {
	%>
	<div class="container mt-3">
		<div class="row">
			<div class="col-12 mb-2 text-center">
				<p>Tu cesta contiene:<p>
			</div>
		</div>
		<div class="row text-center">
			<div class="col-12">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">Título</th>
							<th scope="col">Autor</th>
							<th scope="col">Editorial</th>
							<th scope="col">Precio</th>
							<th scope="col">Cantidad</th>
							<th scope="col">Eliminar</th>
						</tr>
					</thead>
					<tbody class="text-center">
						<%
							// Scriplet 3: Muestra los libros del carrito							
						for (int i = 0; i < cesta.size(); i++) {
							ElementoPedido elementoPedido = cesta.get(i);
						%>
						<tr>
							<form name="borrarForm" action="/ElProyectoPractica/Carrito" method="POST">
								<input type="hidden" name="todo" value="remove"> 
								<input type="hidden" name="indiceElemento" value="<%=i%>">
								<td><%=elementoPedido.getTitulo()%></td>
								<td><%=elementoPedido.getAutor()%></td>
								<td><%=elementoPedido.getEditorial()%></td>
								<td><%=elementoPedido.getPrecio()%> &euro;</td>
								<td><%=elementoPedido.getCantidad()%></td>
								<td><input type="submit" class="btn btn-danger" value="Eliminar de la cesta"></td>
							</form>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
			</div>
		</div>

		<div class="row">
			<div class="col-12 text-center">
				<form name="checkoutForm" action="/ElProyectoPractica/Carrito" method="POST">
					<input type="hidden" name="todo" value="checkout"> 
					<input type="submit" class="btn btn-primary" value="Confirmar compra">
				</form>
			</div>
		</div>
		<% } %>
	</div>
	<% if(exito!=null){ %>
	<div class="bg-success text-white text-center">
		<p>Se ha realizado la inserción sin problemas</p>
	</div>
	<% } %>
	<% if(error!=null){ %>
	<div class="bg-danger text-white text-center">
		<p><%=error%></p>
	</div>
	<% } %>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>