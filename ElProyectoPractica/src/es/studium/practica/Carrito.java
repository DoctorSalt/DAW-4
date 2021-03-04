package es.studium.practica;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Formatter;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class Carrito
 */
@WebServlet("/Carrito")
public class Carrito extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */


	public Carrito() {
		super();
		// TODO Auto-generated constructor stub
	}
	public void init(ServletConfig conf) throws ServletException
	{
		super.init(conf);
		CarritoMVC.cargarDatos();
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		// Establecemos el tipo MIME del mensaje de respuesta
		response.setContentType("text/html");
		// Creamos un objeto para poder escribir la respuesta
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("UTF-8");
		// Recupera la sesi�n actual o crea una nueva si no existe
		HttpSession session = request.getSession(true);
		String usuario = (String) session.getAttribute("usuario");
		// Recupera el carrito de la sesi�n actual
		@SuppressWarnings("unchecked")
		ArrayList<ElementoPedido> elCarrito = (ArrayList<ElementoPedido>)session.getAttribute("carrito");
		session.getAttribute("carrito");
		// Determina a qu� p�gina jsp se redirigir�
		String nextPage = "";
		String todo = request.getParameter("todo");
		String enviado = request.getParameter("creado");
		if(todo==null)
		{
			nextPage = "/order.jsp?usuario="+usuario;
		}
		else if(todo.equals("add"))
		{
			// Mandado por order.jsp con los par�metros idLibro y cantidad
			// Creamos un elementoPedido y lo a�adimos al carrito
			ElementoPedido nuevoElementoPedido = new ElementoPedido(Integer.parseInt(request.getParameter("idLibro")),
					Integer.parseInt(request.getParameter("cantidad")));
			if(elCarrito==null)
			{
				// El carrito est� vac�o
				elCarrito = new ArrayList<>();
				elCarrito.add(nuevoElementoPedido);
				// Enlazar el carrito con la sesi�n
				session.setAttribute("carrito", elCarrito);
			}
			else
			{
				// Comprueba si el libro est� ya en el carrito
				// Si lo est�, actualizamos la cantidad
				// Si no est�, lo a�adimos
				boolean encontrado = false;
				Iterator<ElementoPedido> iter = elCarrito.iterator();
				while(!encontrado&&iter.hasNext())
				{
					ElementoPedido unElementoPedido = (ElementoPedido)iter.next();
					if(unElementoPedido.getIdLibro() ==
							nuevoElementoPedido.getIdLibro())
					{
						unElementoPedido.setCantidad(unElementoPedido.getCantidad() +
								nuevoElementoPedido.getCantidad());
						encontrado = true;
					}
				}
				if(!encontrado)
				{
					// Lo a�ade al carrito
					elCarrito.add(nuevoElementoPedido);
				}
			}
			// Volvemos a order.jps para seguir con la compra
			nextPage = "/order.jsp?usuario="+usuario;
		}
		else if(todo.equals("remove"))
		{
			// Enviado por order.jsp con el par�metro indiceElemento
			// Borra el elemento indiceElemento del carrito
			int indiceCarrito = Integer.parseInt(request.getParameter("indiceElemento"));
			elCarrito.remove(indiceCarrito);
			// Vuelve a order.jsp para seguir con la compra
			nextPage = "/order.jsp?usuario="+usuario;
		}
		else if (todo.equals("checkout"))
		{
			// Comprobar si hay m�s cantidad que libro
			boolean cutre=false;
			for(ElementoPedido item: elCarrito) {
				if(item.getCantidad()>Libro.cantidadLibro) {
					cutre=true;					
				}
			}
			if(cutre) {
				nextPage = "/order.jsp?usuario="+usuario+"&error=Excesos de productos con respecto al stock";
			}else {
				double precioTotal = 0;
				int cantidadTotalOrdenada = 0;
				for(ElementoPedido item: elCarrito)
				{
					System.out.println("Id propiedad autocalculo"+item.getIdLibro());
					double precio = item.getPrecio();
					int cantidadOrdenada = item.getCantidad();
					precioTotal += precio * cantidadOrdenada;
					cantidadTotalOrdenada += cantidadOrdenada;
				}
				// Da formato al precio con dos decimales
				StringBuilder sb = new StringBuilder();
				Formatter formatter = new Formatter(sb);
				formatter.format("%.2f", precioTotal);
				formatter.close();
				// Coloca el precioTotal y la cantidadtotal en el request
				request.setAttribute("precioTotal", sb.toString());
				request.setAttribute("cantidadTotal", cantidadTotalOrdenada+"");
				request.setAttribute("usuario", usuario+"");
				// Redirige a checkout.jsp
				System.out.println(usuario);
				nextPage = "/checkout.jsp?usuario="+usuario;
				System.out.println(nextPage);
			}
		}else if(enviado.equals("true")) {
			nextPage = "/order.jsp?exitoEnviado="+"true"+"&usuario="+usuario;
		}else {
			nextPage = "/order.jsp?error="+"Error al insertar en base de datos el pedido"+"&usuario="+usuario;
		}
		ServletContext servletContext = getServletContext();
		RequestDispatcher requestDispatcher = servletContext.getRequestDispatcher(nextPage);
		requestDispatcher.forward(request, response);
	}
}
