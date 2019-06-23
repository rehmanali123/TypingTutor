package org.tutor;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.tutor.dao.DAO;
import org.tutor.user.Quote;

import com.google.gson.Gson;


@WebServlet("/AddQuoteServlet")
public class AddQuoteServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private Quote quote = new Quote();
	private DAO dao = new DAO();
	private boolean result = false;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
		String json = "";
		if (br != null) {
			json = br.readLine();
		}
		
		Gson gson = new Gson();
		quote = gson.fromJson(json, Quote.class);
		
		System.out.println("Received Quotes is: " + quote);
		
		try {
			result = dao.addQuote(quote);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		PrintWriter out = response.getWriter();
		out.print(result);
		
	}

}
