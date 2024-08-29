package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Comment;

@Repository("commentDao")
public interface CommentDao {
	//답글 조회
	public List<Comment> commentSelect(long boardNum);
	
	//답글수
	public long commentCount(long boardNum);
	
	//답글 등록
	public int commentInsert(Comment comment);
	
	//답글 번호
	public Comment commentNum(long commentNum);
	
	//답글 삭제
	public int commentDelete(Comment comment);
	
	public long getCommentNum(long commentNum);
	
	public int replyInsert(Comment comment);
}
