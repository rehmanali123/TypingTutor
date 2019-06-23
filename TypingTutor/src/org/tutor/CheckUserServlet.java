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

import org.json.JSONException;
import org.json.JSONObject;
import org.tutor.dao.DAO;


@WebServlet("/CheckUserServlet")
public class CheckUserServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private DAO dao = new DAO();
	private boolean result = false;

       
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
		String json = "";
		if (br != null) {
			json = br.readLine();
		}
		
		System.out.println(json);
		
		JSONObject jo;
		try {
			
			jo = new JSONObject(json);
			String username = jo.getString("username");
			System.out.println("Username is Check: " + username);
			result = dao.userExists(username);
		
		} catch (JSONException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		PrintWriter out = response.getWriter();
		out.print(result);
		
		
		
		
	}

}
