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
import org.tutor.user.User;

import com.google.gson.Gson;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private User user = new User();
	private DAO dao = new DAO();
	private boolean result = false;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. get received JSON data from request
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
		String json = "";
		if (br != null) {
			json = br.readLine();
		}
		
		Gson gson = new Gson();
		user = gson.fromJson(json, User.class);
		
		try {
			result = dao.addUser(user);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		PrintWriter out = response.getWriter();
		out.print(result);
		
		

	}

}
