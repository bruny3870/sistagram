package com.sist.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sist.common.util.StringUtil;
import com.sist.web.model.Board;
import com.sist.web.model.Comment;
import com.sist.web.model.Response;
import com.sist.web.service.BoardService;
import com.sist.web.service.CommentService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("commentController")
public class CommentController {
	private static Logger logger = LoggerFactory.getLogger(CommentController.class);
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CommentService commentService;
	
	//쿠키
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@RequestMapping(value="/board/commentProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> commentProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardNum = HttpUtil.get(request, "boardNum", (long)0);
		String commentContent = HttpUtil.get(request, "commentContent", "");
		
		logger.debug("cookieUserId : " + cookieUserId);
		logger.debug("boardNum : " + boardNum);
		logger.debug("commentContent : " + commentContent);
		
		if (boardNum > 0 && !StringUtil.isEmpty(commentContent)) {
			Board board = boardService.boardSelect(boardNum);
			
			if (board != null) {
				Comment comment = new Comment();
				
				comment.setBoardNum(boardNum);
				comment.setUserId(cookieUserId);
				comment.setCommentContent(commentContent);
				comment.setCommentParent(0);
				comment.setStatus("Y");
				
				try {
					if (commentService.commentInsert(comment) > 0) {
						res.setResponse(0, "성공");
					}
					
					else {
						res.setResponse(500, "서버 에러");
					}
				}
				
				catch (Exception e) {
					logger.error("[CommentController] commentProc Exception", e);
					res.setResponse(500, "서버 에러");
				}
			}
			
			else {
				res.setResponse(404, "게시물 없음");
			}
		}
		
		else {
			res.setResponse(400, "잘못 요청");
		}
		
		return res;
	}
	
	@RequestMapping(value="/board/commentDel", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> commentDel(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long commentNum = HttpUtil.get(request, "commentNum", (long)0);
		
		if (commentNum > 0) {
			Comment comment = commentService.commentNum(commentNum);
			
			if (comment != null) {
				//System.out.println("3333");
				//System.out.println(comment.getUserId());
				if (StringUtil.equals(comment.getUserId(), cookieUserId)) {
					try {
						if (commentService.commentDelete(comment) > 0) {
							res.setResponse(0, "성공");
						}
						
						else {
							res.setResponse(500, "서버 에러");
						}
						
					}
					
					catch (Exception e) {
						logger.error("[CommentController] commentDel Exception", e);
						res.setResponse(500, "서버 에러");
					}
				}
				
				else {
					res.setResponse(403, "아이디 다름");
				}
			}
			
			else {
				res.setResponse(404, "서버 없음");
			}
		}
		
		else {
			res.setResponse(400, "잘못 요청");
		}
		
		return res;
	}
	
	@RequestMapping(value="/board/replyProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> replyProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardNum = HttpUtil.get(request, "boardNum", (long)0);
		long commentNum = HttpUtil.get(request, "commentNum", (long)0);
		String replyContent = HttpUtil.get(request, "replyContent", "");
		
		logger.debug("cookieUserId : " + cookieUserId);
		logger.debug("boardNum : " + boardNum);
		logger.debug("commentNum : " + commentNum);
		logger.debug("replyContent : " + replyContent);
		
		if (commentNum > 0 && !StringUtil.isEmpty(replyContent)) {
			Comment parent = commentService.commentNum(commentNum);
			
			if (parent != null) {
				Comment comment = new Comment();
				
				logger.debug("1 : " + parent.getCommentGroup());
				logger.debug("2 : " + parent.getCommentOrder());
				logger.debug("3 : " + commentNum);
				
				comment.setBoardNum(boardNum);
				comment.setUserId(cookieUserId);
				comment.setCommentContent(replyContent);
				comment.setCommentGroup(parent.getCommentGroup());
				comment.setCommentOrder(parent.getCommentOrder() + 1);
				comment.setCommentParent(commentNum);
				comment.setStatus("Y");
				
				try {
					if (commentService.replyInsert(comment) > 0) {
						res.setResponse(0, "성공");
					}
					
					else {
						res.setResponse(500, "서버 에러");
					}
				}
				
				catch (Exception e) {
					logger.error("[CommentController] replyProc Exception", e);
					res.setResponse(500, "서버 에러");
				}
			}
			
			else {
				res.setResponse(404, "게시물 없음");
			}
		}
		
		else {
			res.setResponse(400, "잘못 요청");
		}
		
		return res;
	}
}
