package com.sist.web.model;

import java.io.Serializable;

public class User implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String userId;			//아이디
	private String userPwd;			//비밀번호
	private String userName;		//이름
	private String userPhone;		//전화번호
	private String userEmail;		//이메일
	private String userIntro;		//소개
	private String status;			//상태 (Y: 정상, N: 탈퇴, S: 정지, K: 퇴출)
	private String emailAuth;		//이메일인증 (Y: 인증, N: 미인증)
	private String regDate;			//가입일자
	
	private String fileName;		//
	
	private UserFile userFile;	//
	
	public User() {
		userId = "";
		userPwd = "";
		userName = "";
		userPhone = "";
		userEmail = "";
		userIntro = "";
		status = "N";
		emailAuth = "N";
		regDate = "";
		
		fileName = "";
		
		userFile = null;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserIntro() {
		return userIntro;
	}

	public void setUserIntro(String userIntro) {
		this.userIntro = userIntro;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEmailAuth() {
		return emailAuth;
	}

	public void setEmailAuth(String emailAuth) {
		this.emailAuth = emailAuth;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public UserFile getUserFile() {
		return userFile;
	}

	public void setUserFile(UserFile userFile) {
		this.userFile = userFile;
	}
	
	
	
}
