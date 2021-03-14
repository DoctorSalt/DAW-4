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
 * Servlet implementation class ModifiquenEliminenLibros
 */
@WebServlet("/ModifiquenLibros")
public class ModifiquenLibros extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String userName = ConexionValores.userName;
	String password = ConexionValores.passName;
	String url = ConexionValores.url;
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ModifiquenLibros() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Primera ejecución
		ServletContext servletContext = getServletContext();
		RequestDispatcher requestDispatcher = null;
		String BotonModificar = null,rutaRedirrecion = null;
		String idDelLibro = request.getParameter("elIdLibro");
		if(idDelLibro!=null) {
			BotonModificar = request.getParameter("Modificar");
			System.out.println(BotonModificar);
			rutaRedirrecion= "/ModifiquenLibros.jsp";
		}
		HttpSession session = request.getSession();	
		String nombreUsuario = (String) session.getAttribute("usuario");
		String botonModificar2 = request.getParameter("Modificar2");

		if(botonModificar2!=null) {
			String nombreLibro= request.getParameter("nombreElegido");
			Double precioLibro= Double.parseDouble(numeroCorrecto(request.getParameter("precioElegido")));
			int cantidadLibro = Integer.parseInt(request.getParameter("cantidadElegido"));
			String fechaLibro =  transformadorFecha(request.getParameter("fechaElegido"));
			String autorLibro =  request.getParameter("autorCorresp");
			String editorLibro = request.getParameter("editorialCorresp");
			try {
				Class.forName(ConexionValores.clasesforName);
				//Hacer consulta de datos
				Connection conn = DriverManager.getConnection(url, userName, password);
				Statement stmt = conn.createStatement();
				editorLibro=soloId(editorLibro);
				autorLibro=soloId(autorLibro);
				String sqlStrP = "Update tiendaLibros.libros set nombreLibro= '"+nombreLibro
						+ "',precioLibro="+precioLibro+",cantidadLibro="+cantidadLibro+",fechaLibro='"+fechaLibro
						+"',idEditorialFK="+editorLibro+",idAutorFK="+autorLibro
						+ " where idLibro=" + idDelLibro;
				int rsP = stmt.executeUpdate(sqlStrP);
				rutaRedirrecion="/ModifiquenLibros.jsp?&usuario="+nombreUsuario+"&elIdLibro="+idDelLibro;
				if(rsP==1) {
					String result ="bien";					
					requestDispatcher = servletContext.getRequestDispatcher(rutaRedirrecion+"&resultado="+result);
				}else {				
					String result ="mal";
					requestDispatcher = servletContext.getRequestDispatcher(rutaRedirrecion+"&resultado="+result);
				}
			} catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		}else {
			if(BotonModificar.equals("Modificar")) {
				if(idDelLibro!=null) {
					//Hacer consulta de eliminar idDelLibro
					rutaRedirrecion="/ModifiquenLibros.jsp?&usuario="+nombreUsuario+"&elIdLibro="+idDelLibro;
					requestDispatcher = servletContext.getRequestDispatcher(rutaRedirrecion+"");
				}else {
					//Fallo o entrada dos
					rutaRedirrecion="/ElProyectoPractica/opcionesComprobantes";
					requestDispatcher = servletContext.getRequestDispatcher(rutaRedirrecion+"&lugarRedireccion="+"libros");
				}
				//Fallo
			}else {
				rutaRedirrecion="/ElProyectoPractica/opcionesComprobantes";
				requestDispatcher = servletContext.getRequestDispatcher(rutaRedirrecion+"&lugarRedireccion="+"libros");
			}		
	}
		requestDispatcher.forward(request, response);	
	}
	private String soloId(String editorLibro) {	
		String[]librosC=editorLibro.split("-");
		return librosC[1];
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
