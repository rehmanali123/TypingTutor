package org.tutor.user;

public class Login {

	private int id;
	private String username;
	private String password;
	private boolean isadmin;
	
	public Login() {
		
	}

	public Login(String username, String password, boolean isadmin) {
		this.username = username;
		this.password = password;
		this.isadmin = isadmin;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean getIsadmin() {
		return isadmin;
	}

	public void setIsadmin(boolean isadmin) {
		this.isadmin = isadmin;
	}

}
