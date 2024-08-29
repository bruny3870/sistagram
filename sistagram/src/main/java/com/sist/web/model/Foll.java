package com.sist.web.model;

import java.io.Serializable;

public class Foll implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long follNum;
	private String toUser;
	private String fromUser;
	
	private String fileName;
	private String userName;
	
	public Foll() {
		follNum = 0;
		toUser = "";
		fromUser = "";
		
		fileName = "";
		userName = "";
	}

	public long getFollNum() {
		return follNum;
	}

	public void setFollNum(long follNum) {
		this.follNum = follNum;
	}

	public String getToUser() {
		return toUser;
	}

	public void setToUser(String toUser) {
		this.toUser = toUser;
	}

	public String getFromUser() {
		return fromUser;
	}

	public void setFromUser(String fromUser) {
		this.fromUser = fromUser;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
}
