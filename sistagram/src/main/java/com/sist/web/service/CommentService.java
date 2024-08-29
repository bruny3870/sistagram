package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.CommentDao;
import com.sist.web.model.Comment;

@Service("commentService")
public class CommentService {
	private static Logger logger = LoggerFactory.getLogger(CommentService.class);
	
	@Autowired
	private CommentDao commentDao;
	
	//답글 조회
	public List<Comment> commentSelect(long boardNum) {
		List<Comment> list = null;
		
		try {
			list = commentDao.commentSelect(boardNum);
		}
		
		catch (Exception e) {
			logger.error("[CommentService] commentSelect Exception", e);
		}
		
		return list;
	}
	
	public long commentCount(long boardNum) {
		long cnt = 0;
		
		try {
			cnt = commentDao.commentCount(boardNum);
		}
		
		catch (Exception e) {
			logger.error("[CommentService] commentCount Exception", e);
		}
		
		return cnt;
	}
	
	//답글 등록
	public int commentInsert(Comment comment) {
		int cnt = 0;
		
		try {
			cnt = commentDao.commentInsert(comment);
		}
		
		catch (Exception e) {
			logger.error("[CommentService] commentInsert Exception", e);
		}
		
		return cnt;
	}
	
	//답글 번호
	public Comment commentNum(long commentNum) {
		Comment comment = null;
		
		try {
			comment = commentDao.commentNum(commentNum);
		}
		
		catch (Exception e) {
			logger.error("[CommentService] commentNum Exception", e);
		}
		
		return comment;
	}
	
	//답글 삭제
	public int commentDelete(Comment comment) {
		int cnt = 0;
		
		try {
			cnt = commentDao.commentDelete(comment);
		}
		
		catch (Exception e) {
			logger.error("[CommentService] commentDelete Exception", e);
		}
		
		return cnt;
	}
	
	public long getCommentNum(long commentNum) {
		long cnt = 0;
		
		try {
			cnt = commentDao.getCommentNum(commentNum);
		}
		
		catch (Exception e) {
			logger.error("[CommentService] getCommentNum Exception", e);
		}
		
		return cnt;
	}
	
	public int replyInsert(Comment comment) {
		int cnt = 0;
		
		try {
			cnt = commentDao.replyInsert(comment);
		}
		
		catch (Exception e) {
			logger.error("[CommentService] replyInsert Exception", e);
		}
		
		return cnt;
	}
}
