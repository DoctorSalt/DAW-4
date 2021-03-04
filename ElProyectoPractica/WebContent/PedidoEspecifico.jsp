
<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page session="true" import="java.util.*, es.studium.practica.*"%>
   <% String usuario=request.getParameter("usuario");
   String idPedido = request.getParameter("idPedido");
   String estadoPedido = request.getParameter("estadoPedido");
   PedidoHecho pedido = new PedidoHecho(idPedido);   
   TranformadorDatos trand = new TranformadorDatos() ;
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
		<div class="row">
			<div class="col-12 text-center">
					<h4 class="text-left">
					Bienvenido Usuario:
					<%if(usuario!=""){   %>
					<%=usuario %>
					<% } %>
				</h4>
				<h1 class="mt-3">Pedidos Específico</h1>
			</div>
			<div class="col-12 mt-4">
				<table class="table text-center">
					<thead class="thead-dark">
						<tr>
							<th scope="col">Usuario</th>
							<th scope="col">Total</th>
							<th scope="col">Fecha Origen</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><%=pedido.getNombreUsuario() %></td>
							<td><%=trand.numeroPuntoComa(pedido.getPrecioTotal()+"") %> &euro;</td>
							<td><%=trand.fechaEspaniol(pedido.getFecha()) %></td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>
		<div class="row"> 
			<div class="col-12 mt-4">
				<table class="table text-center">
					<thead class="thead-dark">
						<tr>
							<th scope="col">Libro</th>
							<th scope="col">Autor</th>
							<th scope="col">Editorial</th>
							<th scope="col">Precio Unitario</th>
							<th scope="col">Cantidad</th>
							<th scope="col">Subtotal</th>
						</tr>
					</thead>
					<tbody>
					<%System.out.println("Numero pedidos"+pedido.getListaPedidos().size()); %>
					<%for(ElementoPedido item: pedido.getListaPedidos()){ %>
					<tr>
						<td><%=PedidoEspecificoMVC.getTitulo(item.getIdLibro())%></td>
						<td><%=PedidoEspecificoMVC.getAutor(item.getIdLibro())%></td>
						<td><%=PedidoEspecificoMVC.getEditorial(item.getIdLibro())%></td>
						<td><%=trand.numeroPuntoComa(PedidoEspecificoMVC.getPrecio(item.getIdLibro())+"" ) %> &euro; </td>
						<td><%=item.getCantidad()%></td>
						<td><%=PedidoEspecificoMVC.getPrecio(item.getIdLibro()) * item.getCantidad()%></td>
					</tr>
										<%} %>						
					</tbody>
				</table>
			</div>
		</div>
		<div class="row text-center">
			<div class="col-12">
				<a href="/ElProyectoPractica/opcionesComprobantes?lugarRedireccion=pedidos" class="btn btn-danger mt-2">Volver</a>				
			</div>
			<div class="col-12">
			<%if(estadoPedido.equals("No")){ %>
				<form method="POST" action="/ElProyectoPractica/ConfirmarPedido">
					<input type="hidden" name="idPedido" value="<%=idPedido %>">
					<input type="submit" name="enviar" value="Confirmar Envio" class="btn btn-primary mt-2">
				</form>
				<%} %>
			</div>
		</div>
	</div>
</body>
</html>