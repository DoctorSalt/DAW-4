package es.studium.practica;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CrearLibro
 */
@WebServlet("/CrearLibro")
public class CrearLibro extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String userName = ConexionValores.userName;
	String password =  ConexionValores.passName;
	String url = ConexionValores.url;   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CrearLibro() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ServletContext servletContext = getServletContext();
		RequestDispatcher requestDispatcher = null;
		HttpSession session = request.getSession();	
		String nombreUsuario = (String) session.getAttribute("usuario");
		String rutaRedirrecion = "/LibrosAlta.jsp?usuario="+nombreUsuario;
		System.out.println("Variables Sesión");
		System.out.println("usuario: "+nombreUsuario);
		String nombreLibro= request.getParameter("nombreElegido");
		Double precioLibro= Double.parseDouble(numeroCorrecto(request.getParameter("precioElegido")));
		int cantidadLibro = Integer.parseInt(request.getParameter("cantidadElegido"));
		String fechaLibro =  request.getParameter("fechaElegido");
		String autorLibro =  request.getParameter("autorCorresp");
		String editorLibro = request.getParameter("editorialCorresp");
		System.out.println("Variables Get");
		System.out.println("nombreLibro: "+nombreLibro);
		System.out.println("precioLibro: "+precioLibro);
		System.out.println("cantidadLibro: "+cantidadLibro);
		System.out.println("fechaLibro: "+fechaLibro);
		System.out.println("autorLibro: "+autorLibro);
		System.out.println("editorLibro: "+editorLibro);		
		if((nombreLibro.equals(""))||(nombreLibro==null)				
				||(precioLibro<=0)
				||(fechaLibro.equals(""))||(fechaLibro==null)
				||(cantidadLibro<1)
				||(autorLibro.equals("autor-0"))||(autorLibro==null)
				||(editorLibro.equals("editorial-0"))||(editorLibro==null)
				) {
			String result =seCometieronErrores("Error 01");
			requestDispatcher = servletContext.getRequestDispatcher(rutaRedirrecion+"&resultado="+result);			
		}else {
			//Subsaco la editorial y autor del String
			String[]autores=autorLibro.split("-");
			String idAutorResultante = autores[1];
			String[]editoriales=editorLibro.split("-");
			String idEditorialResultante = editoriales[1];
			String fechaFormateada = transformadorFecha(fechaLibro);
			//Hacer Consulta
			try {
				
				Class.forName(ConexionValores.clasesforName);
				Connection conn = DriverManager.getConnection(url, userName, password);
				Statement stmt = conn.createStatement();
				String sqlStr = "INSERT INTO `tiendalibros`.`libros` (`nombrelibro`,`precioLibro`,`cantidadLibro`, `fechaLibro`, `idAutorFK`, `idEditorialFK`) "
						+ "VALUES ('"+nombreLibro+"', "+precioLibro+", "+cantidadLibro+", '"+fechaFormateada+"', "+idAutorResultante+", "+idEditorialResultante+")";
				System.out.println(sqlStr);
				int rs = stmt.executeUpdate(sqlStr);
				if(rs==1) {
					requestDispatcher = servletContext.getRequestDispatcher(rutaRedirrecion+"&resultado="+"Bien");
				}else {
					String result =seCometieronErrores("Error 02");
					requestDispatcher = servletContext.getRequestDispatcher(rutaRedirrecion+"&resultado="+result);
				}
				
		} catch (ClassNotFoundException | SQLException e) {				
				e.printStackTrace();
				String result =seCometieronErrores("Error 02");
				requestDispatcher = servletContext.getRequestDispatcher(rutaRedirrecion+"&resultado="+result);
			}			
		}		
			requestDispatcher.forward(request, response);			
	}
	private String numeroCorrecto(String precioLibro) {
		String result="";
		if(precioLibro.contains(",")) {
			String [] precios=precioLibro.split(",");
			result=precios[0]+"."+precios[1];
		}else {
			result=precioLibro;
		}		
		return result;
	}

	private String seCometieronErrores(String error) {
		String detallesError="";
		switch(error) {
		case "Error 01":
			detallesError = "Algun dato no está bien Escrito";
			break;
		case "Error 02":
			detallesError = "Se ha producido un error al crear el registro en la base de datos";		
			break;
		}
		return detallesError;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	private String transformadorFecha(String fechaCorrecta) {
		String fechaDevuelta="";
		if(fechaCorrecta.contains("/")) {
			String [] arrayFecha =fechaCorrecta.split("/");
			fechaDevuelta = arrayFecha[2]+"-"+arrayFecha[1]+"-"+arrayFecha[0];	
		}
		
		return fechaDevuelta;
	}
}