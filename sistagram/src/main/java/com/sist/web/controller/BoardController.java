package com.sist.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.common.model.FileData;
import com.sist.common.util.StringUtil;
import com.sist.web.model.Board;
import com.sist.web.model.BoardFile;
import com.sist.web.model.Comment;
import com.sist.web.model.Foll;
import com.sist.web.model.Like;
import com.sist.web.model.Response;
import com.sist.web.model.User;
import com.sist.web.service.BoardService;
import com.sist.web.service.CommentService;
import com.sist.web.service.FollService;
import com.sist.web.service.LikeService;
import com.sist.web.service.UserService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("boardController")
public class BoardController {
	private static Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private LikeService likeService;
	
	@Autowired
	private FollService follService;
	
	//쿠키
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일저장경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	//메인 화면
	@RequestMapping(value="/main", method=RequestMethod.GET)
	public String main(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		User user = userService.userSelect(cookieUserId);
		List<Board> list = null;
		Board board = new Board();
		long cnt = 0;
		List<User> random = null;
		
		random = userService.userRandom(cookieUserId);
		
		cnt = boardService.boardListCount(board);
		
		logger.debug("================");
		logger.debug("cnt : " + cnt);
		logger.debug("================");
		
		Like like = new Like();
		long isLike = 0;
		
		long likeCnt = 0;
		long commentCnt = 0;
		
		long boardNum = 0;
		
		if (cnt > 0) {
			list = boardService.boardList(board);
			
			for (Board board2 : list) {
				like.setUserId(cookieUserId);
				like.setBoardNum(board2.getBoardNum());
				
				isLike = likeService.likeSelect(like);
				likeCnt = likeService.likeCount(board2.getBoardNum());
				commentCnt = commentService.commentCount(board2.getBoardNum());
				
				board2.setIsLike(isLike);
				board2.setLikeCnt(likeCnt);
				board2.setCommentCnt(commentCnt);
				boardNum = board2.getBoardNum();

				logger.debug("isLike : " + isLike);
				logger.debug("boardNum : " + boardNum);
			}
		}
		
		model.addAttribute("cookieUserId", cookieUserId);
		model.addAttribute("user", user);
		model.addAttribute("list", list);
		model.addAttribute("random", random);
		model.addAttribute("boardNum", boardNum);
		
		return "/main";
	}
	
	//게시물 등록
	@RequestMapping(value="/board/writeProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> writeProc(MultipartHttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String boardContent = HttpUtil.get(request, "boardContent" , "");
		FileData fileData = HttpUtil.getFile(request, "boardFile", UPLOAD_SAVE_DIR);
		
		if (!StringUtil.isEmpty(boardContent)) {
			Board board = new Board();
			
			board.setUserId(cookieUserId);
			board.setBoardContent(boardContent);
			
			if (fileData != null && fileData.getFileSize() > 0) {
				BoardFile boardFile = new BoardFile();
				
				boardFile.setFileOrgName(fileData.getFileOrgName());
				boardFile.setFileName(fileData.getFileName());
				boardFile.setFileExt(fileData.getFileExt());
				boardFile.setFileSize(fileData.getFileSize());
				
				board.setBoardFile(boardFile);
			}
			
			try {
				if (boardService.boardInsert(board) > 0) {
					res.setResponse(0, "성공");
				}
				
				else {
					res.setResponse(500, "서버 에러");
				}
			}
			
			catch (Exception e) {
				logger.error("[BoardContriller] writeProc Exception", e);
				res.setResponse(500, "서버 에러");
			}
		}
		
		else {
			res.setResponse(400, "잘못 요청");
		}
		
		return res;
	}
	
	//게시물 상세
	@RequestMapping(value="/board/view", method=RequestMethod.POST)
	public String view(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		long boardNum = HttpUtil.get(request, "boardNum", (long)0);
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userId = HttpUtil.get(request, "userId");
		
		User user = userService.userSelect(cookieUserId);
		List<Comment> list = null;
		
		Like like = new Like();
		like.setUserId(cookieUserId);
		like.setBoardNum(boardNum);
		long isLike = 0;
		long likeCnt = 0;
		long commentNum = 0;
		Like like2 = new Like();
		long isLike2 = 0;

		Board board = null;
		
		if (boardNum > 0) {
			board = boardService.boardView(boardNum);
			list = commentService.commentSelect(boardNum);
			isLike = likeService.likeSelect(like);
			likeCnt = likeService.likeCount(boardNum);
			
			for (Comment comment : list) {
				commentNum = commentService.getCommentNum(comment.getCommentNum());
				like2.setUserId(cookieUserId);
				like2.setCommentNum(commentNum);
				
				isLike2 = likeService.likeSelect2(like2);
				
				comment.setIsLike(isLike2);
				logger.debug("isLike2 : " + isLike2);
			}
		}
		
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("cookieUserId", cookieUserId);
		model.addAttribute("userId", userId);
		model.addAttribute("user", user);
		model.addAttribute("list", list);
		model.addAttribute("board", board);
		model.addAttribute("isLike", isLike);
		model.addAttribute("likeCnt", likeCnt);
		model.addAttribute("commentNum", commentNum);
		
		return "/board/view";
	}
	
	//게시물 수정
	@RequestMapping(value="/board/updateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardNum = HttpUtil.get(request, "boardNum", (long)0);
		String boardContent = HttpUtil.get(request, "boardContent", "");
		
		logger.debug("cookieUserId : " + cookieUserId);
		logger.debug("boardNum : " + boardNum);
		logger.debug("boardContent : " + boardContent);
		
		
		if (boardNum > 0 && !StringUtil.isEmpty(boardContent)) {
			Board board = boardService.boardSelect(boardNum);
			
			if (board != null) {
				if (StringUtil.equals(board.getUserId(), cookieUserId)) {
					board.setBoardContent(boardContent);
					
					try {
						if (boardService.boardUpdate(board) > 0) {
							res.setResponse(0, "성공");
						}
						
						else {
							res.setResponse(500, "서버 에러");
						}
					}
					
					
					catch (Exception e) {
						logger.error("[BoardContriller] updateProc Exception", e);
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
	
	//게시물 삭제
	@RequestMapping(value="/board/delete", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> delete(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		long boardNum = HttpUtil.get(request, "boardNum", (long)0);
		
		if (boardNum > 0) {
			Board board = boardService.boardSelect(boardNum);
			
			if (board != null) {
				if (StringUtil.equals(board.getUserId(), cookieUserId)) {
					try {
						if (boardService.boardDelete(boardNum) > 0) {
							res.setResponse(0, "성공");
						}
						
						else {
							res.setResponse(500, "서버 에러");
						}
					}
					
					catch (Exception e) {
						logger.error("[BoardContriller] delete Exception", e);
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
	
	//프로필
	@RequestMapping(value="/user/profile", method=RequestMethod.POST)
	public String profile(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userId = HttpUtil.get(request, "userId");
		
		User user = userService.userSelect(cookieUserId);
		User user2 = userService.userSelect(userId);
		List<Board> list = null;
		List<Foll> follList1 = null;
		List<Foll> follList2 = null;
		
		long boradCnt = 0;
		long likeCnt = 0;
		long commentCnt = 0;
		long follCnt1 = 0;
		long follCnt2 = 0;
		
		boradCnt = boardService.boardUserSelectCount(userId);
		
		logger.debug("================");
		logger.debug("boradCnt : " + boradCnt);
		logger.debug("================");
		
		if (boradCnt > 0) {
			list = boardService.boardUserSelect(userId);
			
			for (Board board : list) {
				likeCnt = likeService.likeCount(board.getBoardNum());
				commentCnt = commentService.commentCount(board.getBoardNum());
				
				board.setLikeCnt(likeCnt);
				board.setCommentCnt(commentCnt);
			}
		}
		
		//팔로워 리스트
		follList1 = follService.follList1(cookieUserId);
		//팔로잉 리스트
		follList2 = follService.follList2(cookieUserId);
		
		//팔로워 수
		follCnt1 = follService.follCnt1(cookieUserId);
		//팔로잉 수
		follCnt2 = follService.follCnt2(cookieUserId);
		
		model.addAttribute("cookieUserId", cookieUserId);
		model.addAttribute("user", user);
		model.addAttribute("user2", user2);
		model.addAttribute("boradCnt", boradCnt);
		model.addAttribute("list", list);
		model.addAttribute("follList1", follList1);
		model.addAttribute("follList2", follList2);
		model.addAttribute("follCnt1", follCnt1);
		model.addAttribute("follCnt2", follCnt2);
		
		return "/user/profile";
	}
	
}
