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
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.tutor.dao.DAO;
import org.tutor.user.Login;

import com.google.gson.Gson;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private Login login = new Login();
	private DAO dao = new DAO();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 1. get received JSON data from request
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
		String json = "";
		if (br != null) {
			json = br.readLine();
		}

		Login user = new Login();

		Gson gson = new Gson();
		login = gson.fromJson(json, Login.class);

		JSONObject obj = new JSONObject();

		try {

			user = dao.loginUser(login);

			if (user != null) {
				
				HttpSession session = request.getSession();
				String username = user.getUsername();
				session.setAttribute("username", username);
				obj.put("username", user.getUsername());
				
			} else {
				obj = null;
			}
			System.out.println(obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		PrintWriter out = response.getWriter();
		out.print(obj);

	}

}
