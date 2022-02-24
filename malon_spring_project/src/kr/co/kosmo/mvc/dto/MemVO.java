package kr.co.kosmo.mvc.dto;

public class MemVO {
	private String mem_acc_id;
	private String mem_pwd;
	private String mem_nick;
	private String mem_email;
	
	
	public String getMem_acc_id() {
		return mem_acc_id;
	}
	public void setMem_acc_id(String mem_acc_id) {
		this.mem_acc_id = mem_acc_id;
	}
	public String getMem_pwd() {
		return mem_pwd;
	}
	public void setMem_pwd(String mem_pwd) {
		this.mem_pwd = mem_pwd;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public String getMem_email() {
		return mem_email;
	}
	public void setMem_email(String mem_email) {
		this.mem_email = mem_email;
	}
	
	
}
