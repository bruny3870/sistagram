package com.sist.web.model;

import java.io.Serializable;

public class Board implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long boardNum;			//
	private String userId;			//
	private String boardContent;	//
	//private int likeCnt;			//
	private String regDate;			//
	
	private String userName;		//
	private String userEmail;		//
	private String fileName;		//
	private String ufileName;		//
	
	private BoardFile boardFile;	//
	
	private long isLike;
	private long likeCnt;
	private long CommentCnt;
	
	public Board() {
		boardNum = 0;
		userId = "";
		boardContent = "";
		//likeCnt = 0;
		regDate= "";
		
		userName = "";
		userEmail = "";
		fileName = "";
		ufileName = "";
		
		boardFile = null;
		
		isLike = 0;
		likeCnt = 0;
		CommentCnt = 0;
	}

	public long getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(long boardNum) {
		this.boardNum = boardNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

//	public int getLikeCnt() {
//		return likeCnt;
//	}
//
//	public void setLikeCnt(int likeCnt) {
//		this.likeCnt = likeCnt;
//	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getUfileName() {
		return ufileName;
	}

	public void setUfileName(String ufileName) {
		this.ufileName = ufileName;
	}

	public BoardFile getBoardFile() {
		return boardFile;
	}

	public void setBoardFile(BoardFile boardFile) {
		this.boardFile = boardFile;
	}

	public long getIsLike() {
		return isLike;
	}

	public void setIsLike(long isLike) {
		this.isLike = isLike;
	}

	public long getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(long likeCnt) {
		this.likeCnt = likeCnt;
	}

	public long getCommentCnt() {
		return CommentCnt;
	}

	public void setCommentCnt(long commentCnt) {
		CommentCnt = commentCnt;
	}
	
	
}
