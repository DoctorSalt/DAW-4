<%@page import="es.studium.practica.ConexionValores"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="es.studium.practica.TranformadorDatos"%>
<% String usuario=request.getParameter("usuario"); 
String mensaje=request.getParameter("mensaje"); 
String userName = ConexionValores.userName;
String password =ConexionValores.passName;
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
		<div class="row">
			<div class="col-12 text-center">
				<h4 class="text-left">Bienvenido Usuario: 			
				<%if(usuario!=""){   %>
				<%=usuario %>
				<% } %>
				</h4>
				<h1 class="mt-3">Pedidos</h1>
			</div>
			<div class="col-12 mt-4">
				<table class="table text-center">
					 <thead class="thead-dark">
					    <tr>
					      <th scope="col">Id</th>
					      <th scope="col">Fecha Origen</th>
					      <th scope="col">Usuario</th>
					      <th scope="col">Enviado</th>
					      <th scope="col">Consultar</th>
					    </tr>
  					</thead>
  					<tbody>
  					
  					<%
  					Connection conn = DriverManager.getConnection(url, userName, password);
					Statement stmt = conn.createStatement();	
					String sqlStr = "SELECT idPedido, fechaPedido, nombreUsuario, enviadoPedido FROM tiendalibros.pedidos, tiendalibros.usuarios where idUsuarioFK=idUsuario order by fechaPedido desc;";
					ResultSet rs = stmt.executeQuery(sqlStr);
					int count = 0;		
					while(rs.next()){
						String idPedido =rs.getString("idPedido");						
						String fechaPedido = datos.fechaEspaniol(rs.getString("fechaPedido"));
						String nombreUsuario = rs.getString("nombreUsuario");
						int enviadoSiNo = rs.getInt("enviadoPedido");					
						count++;
						String pedido="";
						if(enviadoSiNo==0){
							pedido="No";
						}else{
							pedido="Si";
						}					
  					%>
  					<tr>
					      <td><%=idPedido %></td>
					      <td><%=fechaPedido%></td>
					      <td><%=nombreUsuario %></td>					      
					      <td><%=pedido%></td>
    					  <td>
    					  <form method="POST" action="/ElProyectoPractica/PedidosEspecificos">
    					  	<input type="hidden" name="idPedido" value="<%=idPedido %>">
    					  	<input type="hidden" name="estadoPedido" value="<%=pedido %>">
    					  	<input type="submit" name="masDetalles" value="Mas detalles" class="btn btn-primary">
    					  </form>    					  
    					  </td>
  						</tr>   					
  				<%	}	%>  						 						
  					</tbody>
				</table>
			</div>
		</div>
		<div class="row text-center" id="respuesta">	
		<div class="col-12">		
			<% if(mensaje!=null){ %>
				<% if(mensaje.equals("Exito")){ %> 
				<p class="text-white bg-success text-center">Se ha actualizado el estado del envío correctamente</p>
				<% }else if(mensaje.equals("Mal")){	%>	
					<p class="text-white bg-danger text-center">Se han cometido errores al actualizar el estado del envío</p>					
				<% }
			}%>
			</div>
		</div>
		
		<div class="row text-center p-2 pt-3 mb-lg-2 mt-lg-2">
			<div class="col-12">
				<a href='/ElProyectoPractica/opcionesComprobantes?lugarRedireccion=general' class='btn btn-danger'>Volver</a>
			</div>
		</div>
	</div>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

</body>
</html>