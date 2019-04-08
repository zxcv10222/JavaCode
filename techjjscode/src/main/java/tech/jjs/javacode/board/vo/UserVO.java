package tech.jjs.javacode.board.vo;

public class UserVO {
	private String id;
	private String password;
	private String permission;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getPermission() {
		return permission;
	}
	public void setPermission(String permission) {
		this.permission = permission;
	}
	@Override
	public String toString() {
		return "UserVO [id=" + id + ", password=" + password + ", permission=" + permission + "]";
	}
	
	
	
}
