package es.studium.practica;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class opcionesComprobantes
 */
@WebServlet("/opcionesComprobantes")
public class opcionesComprobantes extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public opcionesComprobantes() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		ServletContext servletContext = getServletContext();
		RequestDispatcher requestDispatcher = null;
		HttpSession session = request.getSession();		
		System.out.println(session);
		String lugarDestion = request.getParameter("lugarRedireccion");
		System.out.println("Direccionados: "+lugarDestion);
		String nombreUsuario = (String) session.getAttribute("usuario");
		String tipoUsuario = (String) session.getAttribute("tipoUsuario");
		System.out.println("Nombre Usuario: "+nombreUsuario);
		System.out.println("Tipo Usuario: "+tipoUsuario);
		String rutaRedirrecion="";
		if(tipoUsuario.equals("admin")) {
			rutaRedirrecion=hubRedireccionante(lugarDestion,nombreUsuario);
		}else if(tipoUsuario=="usuario") {
			//Redireccionar a login
			rutaRedirrecion="/login.html?error=05";
		}else {
			//Redireccionar a login
			rutaRedirrecion="/login.html?error=06";
		}
		requestDispatcher = servletContext.getRequestDispatcher(rutaRedirrecion);
		requestDispatcher.forward(request, response);	
	}

	private String hubRedireccionante(String lugarDestion, String usuario) {
		String destino="";
		switch(lugarDestion) {
		case "general":
			destino="/OpcionesAdmin.jsp?usuario="+usuario;
			break;
		case "libros":
			destino="/Libros.jsp?usuario="+usuario;
			break;
		case "libroAlta":
			destino="/LibrosAlta.jsp?usuario="+usuario;
			break;
		case "editorial":
			destino="/Editorial?usuario="+usuario;
			break;
		case "autores":
			destino="/Autores?usuario="+usuario;
			break;
		case "pedidos":
			destino="/Pedido.jsp?usuario="+usuario;
			break;
		case "pedidosEspecifico":
			destino="/pedidosEspecifico.html?usuario="+usuario;
			break;
		}
		return destino;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
