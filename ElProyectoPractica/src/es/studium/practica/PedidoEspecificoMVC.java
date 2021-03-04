package es.studium.practica;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class PedidoEspecificoMVC {
	static ArrayList<Libro> tabla = new ArrayList<Libro>();	
	public static void cargarDatos() {
		// TODO Auto-generated method stub
		// Creamos objetos para la conexión
		Connection conn = null;
		Statement stmt = null;
		try {
			Class.forName(ConexionValores.clasesforName);
			String userName = ConexionValores.userName;
			String password = ConexionValores.passName;
			// URL de la base de datos
			String url = ConexionValores.url;
			conn = DriverManager.getConnection(url, userName, password);
			// Paso 3: Crear las sentencias SQL utilizando objetos de la clase Statement
			stmt = conn.createStatement();
			// Paso 4: Ejecutar las sentencias
			String sqlStr = "SELECT idLibro, nombreLibro, precioLibro, cantidadLibro, fechaLibro, nombreAutor, nombreEditorial "
					+ "FROM tiendalibros.libros, tiendalibros.autores, tiendalibros.editoriales where idAutor=idAutorFK AND idEditorial=idEditorialFK;";
			ResultSet rs = stmt.executeQuery(sqlStr);
			Libro libro;
			while(rs.next())
			{
				libro = new Libro(rs.getInt("idLibro"), rs.getString("nombreLibro"), 
						rs.getDouble("precioLibro"),rs.getInt("cantidadLibro"),rs.getString("fechaLibro"),
						rs.getString("nombreAutor"),rs.getString("nombreEditorial"));
				tabla.add(libro);
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
			}
			catch(Exception ex)
			{
				ex.printStackTrace();
			}
		}
	}

	public static int tamano()
	{
		return tabla.size();
	}
	/**
	 * Devuelve el título del libro identificado con idLibro
	 */
	public static String getTitulo(int idLibro)
	{
		String result="";
		for(Libro item: tabla) {
			if(item.getIdLibro()==idLibro) {
				result=item.getNombreLibro();
			}
		}
		return result;
	}
	/**
	 * Devuelve el autor del libro identificado con idLibro
	 */
	public static String getAutor(int idLibro)
	{
		String result="";
		for(Libro item: tabla) {
			if(item.getIdLibro()==idLibro) {
				result=item.getNombreAutor();
			}
		}
		return result;
	}
	public static String getEditorial(int idLibro)
	{
		String result="";
		for(Libro item: tabla) {
			if(item.getIdLibro()==idLibro) {
				result=item.getNombreEditorial();
			}
		}
		return result;

	}
	/**
	 * Devuelve el precio del libro identificado con idLibro
	 */
	public static double getPrecio(int idLibro)
	{
		double result=0.0;
		for(Libro item: tabla) {
			if(item.getIdLibro()==idLibro) {
				result=item.getPrecioLibro();
			}
		}
		return result;		
	}
	public static int getCantidadExistente(int idLibro)
	{
		int result=0;				
		for(Libro item: tabla) {
			if(item.getIdLibro()==idLibro) {
				result=item.getCantidadLibro();
			}
		}
		return result;	
	}	
}