package es.studium.practica;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class PedidoHecho {
	String idPedido;
	String nombreUsuario;
	String fechaPedido;
	Double precioTotal;
	static ArrayList <ElementoPedido> pedidos = new ArrayList<ElementoPedido>();
	public PedidoHecho(String idpedidoEspecifico){
		idPedido=idpedidoEspecifico;
		System.out.println("Constructor");
		PedidoEspecificoMVC.cargarDatos();
		System.out.println("Carga Datos");
		consulta();		
		System.out.println("Consulta");

	}
	public void consulta() {
		// TODO Auto-generated method stub
				// Creamos objetos para la conexión
				Connection conn = null;
				Statement stmt = null;
				if(pedidos.size()>0) {
					pedidos.clear();
				}
				try {
					Class.forName(ConexionValores.clasesforName);
					String userName =  ConexionValores.userName;
					String password = ConexionValores.passName;
					// URL de la base de datos
					String url = ConexionValores.url;
					conn = DriverManager.getConnection(url, userName, password);
					// Paso 3: Crear las sentencias SQL utilizando objetos de la clase Statement
					stmt = conn.createStatement();
					// Paso 4: Ejecutar las sentencias
					String sqlStr = "SELECT nombreUsuario, fechaPedido, nombreLibro, precioLibro, idLibro, "
							+ "cantidadLibros FROM tiendalibros.pedidos, tiendalibros.usuarios, tiendalibros.pedidoslibros,  tiendalibros.libros where"
							+ " idPedidoFK="+getIdPedido()+" and idUsuarioFK=idUsuario and idLibroFK=idLibro AND idPedido=idPedidoFK;";
					System.out.println("Sentencia "+sqlStr);
					ResultSet rs = stmt.executeQuery(sqlStr);
					int counter =0;
					while(rs.next())
					{
						System.out.println("Ciclo"+counter);
						int idLibro = rs.getInt("idLibro");
						int cantidadLibros = rs.getInt("cantidadLibros");
						if(fechaPedido==null) {
							fechaPedido = rs.getString("fechaPedido");
							nombreUsuario = rs.getString("nombreUsuario");
						}
						System.out.println("El idLibro es "+idLibro);
						System.out.println("Cantidad es"+cantidadLibros);
						pedidos.add(new ElementoPedido(idLibro,cantidadLibros));
						counter++;
					}
				}
				catch(Exception ex)
				{
					ex.printStackTrace();
				}
				finally
				{
					try
					{
						// Cerramos el resto de recursos
						if(stmt != null)
						{
							stmt.close();
						}
						if(conn != null)
						{
							conn.close();
						}
						calcularPrecioTotal();
						for(ElementoPedido item: getListaPedidos()){ 
						
							String x =PedidoEspecificoMVC.getTitulo(item.getIdLibro());
							Double y=PedidoEspecificoMVC.getPrecio(item.getIdLibro());
							int a=item.getCantidad();
							System.out.println("El pedido "+x+" es"+(a*y));					
						}	
						System.out.println(pedidos);
					}
					catch(Exception ex)
					{
						ex.printStackTrace();
					}
				}
		
	}
	public String getIdPedido(){
		return idPedido;
	}
	
	
	public void calcularPrecioTotal() {
		double total=0;
		for(ElementoPedido item:pedidos) {
			double precioUnitario=PedidoEspecificoMVC.getPrecio(item.getIdLibro());
			int cantidadPedido = item.getCantidad();
			double Subtotal = precioUnitario*cantidadPedido;
			total =total+ Subtotal;
		}
		precioTotal = total;
	}
	public double getPrecioTotal() {
		return precioTotal;
	}
	public String getFecha() {
		return fechaPedido;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public String getNombreEspecifico(int idLibro) {
		return PedidoEspecificoMVC.getTitulo(idLibro);
	}
	public Double getPrecioEspecifico(int idLibro) {
		return PedidoEspecificoMVC.getPrecio(idLibro);
	}
	public ArrayList <ElementoPedido> getListaPedidos(){
		return pedidos;
	}
}
