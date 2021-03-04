package es.studium.practica;

import java.util.regex.Pattern;

public class TranformadorDatos {
	public TranformadorDatos(){
		super();
	}
	public String fechaEspaniol(String fechaMandada) {
		String result="";
		String [] fechaArray=fechaMandada.split("-");
		result = fechaArray[2]+"/"+fechaArray[1]+"/"+fechaArray[0];
		return result;
	}
	public String numeroPuntoComa(String datos) {
		String result=datos;
		System.out.println("numero: "+result);
		String [] numerosArray=result.split(Pattern.quote("."));
		System.out.println("array: "+numerosArray.length);
		result=numerosArray[0]+","+numerosArray[1];
		return result;
	}	
}
