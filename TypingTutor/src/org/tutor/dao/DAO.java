package org.tutor.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.tutor.user.Login;
import org.tutor.user.Quote;
import org.tutor.user.User;

public class DAO {

	private static Connection con = null;
	private static PreparedStatement pstmt = null;
	private static String USERNAME = "root";
	private static String PASSWORD = "root";
	private static String DRIVER = "com.mysql.jdbc.Driver";
	private static String URL = "jdbc:mysql://localhost:3306/typingtutor";

	private static Statement statement = null;

	public static Connection getDatabaseConnection() throws SQLException {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
	}

	public String getText() throws SQLException {

		con = getDatabaseConnection();

		String text = null;

		statement = con.createStatement();
		System.out.println("executing query");
		int id = 1;
		String sql = "select `quote` from typingtutor.tbl_quotes where id=" + id + ";";
		ResultSet rs = statement.executeQuery(sql);
		System.out.println("results returned");

		while (rs.next()) {

			// validation required;
			text = rs.getString("quote");
			System.out.println(text);

		}

		return text;

	}

	public boolean addUser(User user) throws SQLException {

		boolean result = false;

		String fname = user.getFirstname();
		String lname = user.getLastname();
		String username = user.getUsername();
		String email = user.getEmail();
		String password = user.getPassword();
		boolean isadmin = user.getIsadmin();
		int admin;
		if(isadmin) {
			admin = 1;
		}else {
			admin = 0;
		}

		con = getDatabaseConnection();
		statement = con.createStatement();
		System.out.println("Sending data to database");

		boolean exists = userExists(username);
		if (exists) {
			result = false;
		} else {
			String sql = "insert into typingtutor.tbl_user(`firstname`,`lastname`,`username`,`email`,`password`,`isadmin`) "
					+ "values('" + fname + "','" + lname + "','" + username + "','" + email + "','" + password + "','"+admin+"');";

			int rs = statement.executeUpdate(sql);
			if (rs > 0) {
				result = true;
			}

			con.close();
		}

		return result;

	}

	public boolean addQuote(Quote quote) throws SQLException {

		boolean result = false;

		String text = quote.getQuote();
		String ref = quote.getReference();
		String author = quote.getAuthor();
		String status = quote.getStatus();

		System.out.println(quote);

		con = getDatabaseConnection();
		System.out.println("Sending data to database");

		String sql = "insert into typingtutor.tbl_quotes(`quote`,`reference`,`author`,`status`) "
				+ "values(?,?,?,?);";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, text);
		pstmt.setString(2, ref);
		pstmt.setString(3, author);
		pstmt.setString(4, status);

		int rs = pstmt.executeUpdate();
		if (rs > 0) {
			result = true;
		}

		con.close();

		return result;

	}

	public boolean userExists(String user) throws SQLException {

		boolean exists = false;
		con = getDatabaseConnection();
		statement = con.createStatement();

		String sql = "select * from typingtutor.tbl_user where username='" + user + "';";
		ResultSet rs = statement.executeQuery(sql);

		if (rs.next()) {
			exists = true;
		}

		return exists;

	}

	public Login loginUser(Login login) throws SQLException {

		Login user = new Login();
		boolean isadmin = false;
		int adm;

		String username = login.getUsername();
		String password = login.getPassword();
		boolean admin = login.getIsadmin();
		if(admin) {
			adm = 1;
		}else {
			adm = 0;
		}

		con = getDatabaseConnection();
		statement = con.createStatement();
		System.out.println("Sending data to database");
		String sql = "select * from typingtutor.tbl_user where `username`='" + username + "' && `password`=" + "'"
				+ password + "' && `isadmin` = '"+ adm +"';";

		ResultSet rs = statement.executeQuery(sql);
		if (rs.next()) {

			String userlog = rs.getString("username");
			String userpass = rs.getString("password");
			int administrator = rs.getInt("isadmin");
			if(administrator == 1) {
				isadmin = true;
			}else if(administrator==0){
				isadmin = false;
			}
			
			
			user = new Login(userlog, userpass, isadmin);

			System.out.println(userlog + ", " + userpass);

		} else {
			user = null;
		}

		con.close();

		return user;

	}

}
