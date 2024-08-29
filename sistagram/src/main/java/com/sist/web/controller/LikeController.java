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
import com.sist.web.model.Like;
import com.sist.web.model.Response;
import com.sist.web.service.BoardService;
import com.sist.web.service.CommentService;
import com.sist.web.service.LikeService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("likeController")
public class LikeController {
	private static Logger logger = LoggerFactory.getLogger(LikeController.class);
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private LikeService likeService;
	
	@Autowired
	private CommentService commentService;
	
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@RequestMapping(value="/board/likeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> likeProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardNum = HttpUtil.get(request, "boardNum", (long)0);
		
		if (boardNum > 0 && !StringUtil.isEmpty(cookieUserId)) {
			Board board = boardService.boardSelect(boardNum);
			
			if (board != null) {
				Like like = new Like();
				like.setBoardNum(boardNum);
				like.setUserId(cookieUserId);
				
				long isLike = likeService.likeSelect(like);
				
				long likeCnt = 0;
				
				
				try {
					if (isLike == 0) {
						if (likeService.likeInsert(like) > 0) {
							likeCnt = likeService.likeCount(boardNum); 
							res.setResponse(0, "삽입 성공", likeCnt);
						}
						
						else {
							res.setResponse(500, "서버 에러");
						}
					}
					
					else {
						if (likeService.likeDelete(like) > 0) {
							likeCnt = likeService.likeCount(boardNum);
							res.setResponse(1, "삭제 성공", likeCnt);
						}
						
						else {
							res.setResponse(500, "서버 에러");
						}
					}
				}
				
				catch (Exception e) {
					logger.error("[LikeController] likeProc Exception", e);
					res.setResponse(500, "서버 에러");
				}
				
			}
			
			else {
				res.setResponse(400, "잘못 요청");
			}
		}
		
		return res;
	}
	
	@RequestMapping(value="/board/likeProc2", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> likeProc2(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long commentNum = HttpUtil.get(request, "commentNum", (long)0);
		
		if (commentNum > 0 & !StringUtil.isEmpty(cookieUserId)) {
			Comment comment = commentService.commentNum(commentNum);
			
			if (comment != null) {
				Like like = new Like();
				like.setCommentNum(commentNum);
				like.setUserId(cookieUserId);
				
				long isLike = likeService.likeSelect2(like);
				
				long likeCnt = 0;
				
				try {
					if (isLike == 0) {
						if (likeService.likeInsert2(like) > 0) {
							likeCnt = likeService.likeCount2(commentNum);
							res.setResponse(0, "삽입 성공", likeCnt);
						}
						
						else {
							res.setResponse(500, "서버 에러");
						}
					}
					
					else {
						if (likeService.likeDelete2(like) > 0) {
							likeCnt = likeService.likeCount2(commentNum);
							res.setResponse(1, "삭제 성공", likeCnt);
						}
						
						else {
							res.setResponse(500, "서버 에러");
						}
					}
				}
				
				catch (Exception e) {
					logger.error("[LikeController] likeProc2 Exception", e);
					res.setResponse(500, "서버 에러");
				}
				
			}
			
			else {
				res.setResponse(400, "잘못 요청");
			}
		}
		
		return res;
	}
}
