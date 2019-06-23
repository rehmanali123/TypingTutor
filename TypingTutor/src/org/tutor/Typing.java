package org.tutor;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.tutor.dao.DAO;

@WebServlet("/Typing")
public class Typing extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private DAO dao = new DAO();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		System.out.println("Reached");
		String text = null;
		
		try {
			text = dao.getText();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		PrintWriter out = response.getWriter();
		out.println(text);
		
	}


}
