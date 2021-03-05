package es.studium.practica;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class EnviarPedido
 */
@WebServlet("/EnviarPedido")
public class EnviarPedido extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static boolean bien=false;
	private static boolean error=false;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EnviarPedido() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		String usuario = (String) session.getAttribute("usuario");
		ArrayList<ElementoPedido> elCarrito = (ArrayList<ElementoPedido>) session.getAttribute("carrito");
		if(elCarrito!=null) {
			//Hacer insert Pedido devolviendo el numero de pedido creado
			System.out.println("Carrito no Nulo");
			int idUsuario = devuelveUsuarioId(usuario);
			System.out.println(idUsuario);
			if(idUsuario==0) {
				System.out.println("No hay idUsuario");
			}else {
				int numeroPedido = insertPedido(idUsuario);
				if(numeroPedido!=0) {
					for(ElementoPedido item: elCarrito) {
						//hacer insert
						System.out.println("Tamaño "+elCarrito.size()+"Uno"+item.getIdLibro());
						insertItemPedido(item,numeroPedido);
						int cantidadLibrosPedido = item.getCantidad();
						Libro.cantidadLibro=Libro.cantidadLibro-cantidadLibrosPedido;						
						actualizarPedido(item);					
					}
					if(error==false) {
						System.out.println("Se ha realizado sin problemas");
						bien=true;
						session.removeAttribute("carrito");
					}else {
						System.out.println("Se cometio un error");
						session.removeAttribute("carrito");
					}				
				}
			}			
			if(bien==true) {
			
				ServletContext servletContext = getServletContext();
				request.setAttribute("usuario", usuario);

				RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher("/Carrito?creado=true");
				requestDispatcher.forward(request, response);				
			}else {
				ServletContext servletContext = getServletContext();
				request.setAttribute("usuario", usuario);
				RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher("/Carrito?creado=false");
				requestDispatcher.forward(request, response);
			}
			
		}
	}

	private void insertItemPedido(ElementoPedido item, int numeroPedido) {		
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String userName = "servletUser";
			String password = "Patata01";
			// URL de la base de datos
			String url = "jdbc:mysql://localhost:3306/tiendalibros?useSSL=false&serverTimezone=UTC";
			conn = DriverManager.getConnection(url, userName, password);
			// Paso 3: Crear las sentencias SQL utilizando objetos de la clase Statement
			stmt = conn.createStatement();
			// Paso 4: Ejecutar las sentencias
			int idLibro = item.getIdLibro();
			int cantidadLibro = item.getCantidad();
			String sqlStr = "INSERT INTO tiendalibros.pedidoslibros (idPedidoFK, idLibroFK, cantidadLibros) VALUES ("+numeroPedido+","+idLibro+","+cantidadLibro+");";
			System.out.println(sqlStr);
			stmt.execute(sqlStr);		
			
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			error=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			error=true;
		}
		
	}

	private int insertPedido(int idUsuario) {
		int result=0;
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String userName = "servletUser";
			String password = "Patata01";
			// URL de la base de datos
			String url =
					"jdbc:mysql://localhost:3306/tiendalibros?useSSL=false&serverTimezone=UTC";
			conn = DriverManager.getConnection(url, userName, password);
			// Paso 3: Crear las sentencias SQL utilizando objetos de la clase Statement
			stmt = conn.createStatement();
			// Paso 4: Ejecutar las sentencias			
			String sqlStr = "INSERT INTO tiendalibros.pedidos ( fechaPedido, idUsuarioFK, enviadoPedido) VALUES ('"+saberFechaActual()+"', "+idUsuario+", 0);";
			stmt.execute(sqlStr, Statement.RETURN_GENERATED_KEYS);
			System.out.println(sqlStr);
			ResultSet rs = stmt.getGeneratedKeys();				
			if(rs.next())
			{
				/* Please note the index start from 1 not 0. */
				result = rs.getInt(1);
			}					
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			error=true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			error=true;
		}
		return result;
	}

	private String saberFechaActual() {		
		Date myDate = new Date();
		String fecha=""+new SimpleDateFormat("yyyy-MM-dd").format(myDate);
		return fecha;
	}

	private int devuelveUsuarioId(String usuario) {
		Connection conn = null;
		Statement stmt = null;
		int result=0;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String userName = "servletUser";
			String password = "Patata01";
			// URL de la base de datos
			String url =
					"jdbc:mysql://localhost:3306/tiendalibros?useSSL=false&serverTimezone=UTC";
			conn = DriverManager.getConnection(url, userName, password);
			// Paso 3: Crear las sentencias SQL utilizando objetos de la clase Statement
			stmt = conn.createStatement();
			// Paso 4: Ejecutar las sentencias
			String sqlStr = "Select idUsuario from tiendalibros.usuarios where loginUsuario='"+usuario+"';";
			ResultSet rs = stmt.executeQuery(sqlStr);
			System.out.println(sqlStr);
			Boolean first = false;
			while(rs.next()) {
				if(!first) {
					result=rs.getInt("idUsuario");
					first=true;
				}				
			}
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			error=true;
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			error=true;
			e.printStackTrace();
		}		
		return result;
	}

	private void actualizarPedido(ElementoPedido item) {
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String userName = "servletUser";
			String password = "Patata01";
			// URL de la base de datos
			String url =
					"jdbc:mysql://localhost:3306/tiendalibros?useSSL=false&serverTimezone=UTC";
			conn = DriverManager.getConnection(url, userName, password);
			// Paso 3: Crear las sentencias SQL utilizando objetos de la clase Statement
			stmt = conn.createStatement();
			// Paso 4: Ejecutar las sentencias
			String sqlStr = "Update tiendalibros.libros set cantidadLibro = "+item.getCantidadExistente()+" where idLibro="+item.getIdLibro()+";";
			System.out.println(sqlStr);
			int rs = stmt.executeUpdate(sqlStr);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}



	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub		
		doGet(request, response);
	}
}