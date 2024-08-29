package com.sist.web.model;

import java.io.Serializable;

public class Like implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long likeNum;
	private long boardNum;
	private long commentNum;
	private String userId;
	
	public Like() {
		likeNum = 0;
		boardNum = 0;
		commentNum = 0;
		userId = "";
	}

	public long getLikeNum() {
		return likeNum;
	}

	public void setLikeNum(long likeNum) {
		this.likeNum = likeNum;
	}

	public long getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(long boardNum) {
		this.boardNum = boardNum;
	}

	public long getCommentNum() {
		return commentNum;
	}

	public void setCommentNum(long commentNum) {
		this.commentNum = commentNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	
}
