package com.sist.web.controller;

import java.util.Random;

//import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
//import org.springframework.mail.javamail.JavaMailSender;
//import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sist.common.model.FileData;
import com.sist.common.util.StringUtil;
import com.sist.web.model.Response;
import com.sist.web.model.User;
import com.sist.web.model.UserFile;
import com.sist.web.service.UserService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;
import com.sist.web.util.JsonUtil;

@Controller("userController")
public class UserController {
	private static Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	//Autowired
	//private JavaMailSender mailSender;
	
	//쿠키
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	//파일저장경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	//로그인
	@RequestMapping(value="/user/login", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> login(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		String userPhone = HttpUtil.get(request, "userPhone");
		String userEmail = HttpUtil.get(request, "userEmail");
		
		if (!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd)) {
			User user = userService.userSelect(userId);
			
			if (user != null) {
				if (StringUtil.equals(user.getUserPwd(), userPwd)) {
					CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userId));
					res.setResponse(0, "성공");
				}
				
				else {
					res.setResponse(-1, "비밀번호 잘못");
				}
			}
			
			else {
				res.setResponse(404, "회원 없음");
			}
		}
		
		else {
			res.setResponse(400, "잘못 요청");
		}
		
		if (logger.isDebugEnabled()) {
			logger.debug("[UserController] /user/login response \n" + JsonUtil.toJsonPretty(res));
		}
		
		return res;
	}
	
	//로그아웃
	@RequestMapping(value="/user/logout", method=RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		if(CookieUtil.getCookie(request, AUTH_COOKIE_NAME) != null) {
			CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
		}
		
		return "redirect:/";
	}
	
	//회원가입 화면
	@RequestMapping(value="/user/signUp", method=RequestMethod.GET)
	public String signUp(HttpServletRequest request, HttpServletResponse response) {
		return "/user/signUp";
	}
	
	//아이디 중복체크
	@RequestMapping(value="/user/idCheck", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> idCheck(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		
		if (!StringUtil.isEmpty(userId)) {
			if (userService.userSelect(userId) == null) {
				res.setResponse(0, "성공");
			}
			
			else {
				res.setResponse(100, "아이디 중복");
			}
		}
		
		else {
			res.setResponse(400, "잘못 요청");
		}
		
		if (logger.isDebugEnabled()) {
			logger.debug("[UserController] /user/idCheck response \n" + JsonUtil.toJsonPretty(res));
		}
		
		return res;
	}
	
	//회원가입
	@RequestMapping(value="/user/signUpProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> signUpProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		String userName = HttpUtil.get(request, "userName");
		String userPhone = HttpUtil.get(request, "userPhone");
		String userEmail = HttpUtil.get(request, "userEmail");
		
		if (!StringUtil.isEmpty(userId) && !StringUtil.isEmpty(userPwd) 
				&& !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail)) {
			if (userService.userSelect(userId) == null) {
				User user = new User();
				
				user.setUserId(userId);
				user.setUserPwd(userPwd);
				user.setUserName(userName);
				user.setUserPhone(userPhone);
				user.setUserEmail(userEmail);
				user.setStatus("Y");
				user.setEmailAuth("N");
				
				if (userService.userInsert(user) > 0) {
					CookieUtil.addCookie(response, "/", -1, AUTH_COOKIE_NAME, CookieUtil.stringToHex(userId));
					res.setResponse(0, "성공");
				}
				
				else {
					res.setResponse(500, "서버 에러");
				}
			}
			
			else {
				res.setResponse(100, "아이디 중복");
			}
		}
		
		else {
			res.setResponse(400, "잘못 요청");
		}
		
		if (logger.isDebugEnabled()) {
			logger.debug("[UserController] /user/signUp response \n" + JsonUtil.toJsonPretty(res));
		}
		
		return res;
	}
	
	//메일인증 화면
	@RequestMapping(value="/user/emailAuth", method=RequestMethod.GET)
	public String emailAuth(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		User user = userService.userSelect(cookieUserId);
		
		model.addAttribute("user", user);
		
		return "/user/emailAuth";
	}
	
	//메일인증
	@RequestMapping(value="/user/mailCheck", method=RequestMethod.GET)
	@ResponseBody
	public String mailCheck(String email) throws Exception {
		System.out.println("이메일 데이터 전송 확인");  //확인용
		System.out.println("인증 이메일 : " + email);  
		
		//인증번호 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		System.out.println("인증번호 :"+ checkNum);
		
		
		//이메일 전송 내용
		String setFrom = "sistagram";  //발신 이메일
		String toMail = email;         //받는 이메일
		String title = "회원가입 인증 이메일 입니다.";
		String content = "인증 번호는 " + checkNum + "입니다. <br> " + 
						 "해당 인증번호를 인증코드에 기입하여 주세요.";
		//이메일 전송 코드
		/*
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
		} 
		
		catch (Exception e) {
			e.printStackTrace();
		}
		*/
		logger.debug("setFrom : " + setFrom);
		logger.debug("toMail : " + toMail);
		logger.debug("title : " + title);
		logger.debug("content : " + content);
		
		String num = Integer.toString(checkNum); // ajax를 뷰로 반환시 데이터 타입은 String 타입만 가능
		
		return num; // String 타입으로 변환 후 반환
	}
	
	//비밀번호찾기 화면
	@RequestMapping(value="/user/findPw", method=RequestMethod.GET)
	public String findPw(HttpServletRequest request, HttpServletResponse response) {
		return "/user/findPw";
	}
	
	
	//비밀번호찾기
	@RequestMapping(value="/user/findPwProc", method=RequestMethod.GET)
	@ResponseBody
	public String findPwProc(String email) throws Exception {
		System.out.println("이메일 데이터 전송 확인");  //확인용
		System.out.println("인증 이메일 : " + email);  
		
		//인증번호 생성
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		System.out.println("인증번호 :"+ checkNum);
		
		//이메일 전송 내용
		String setFrom = "sistagram";  //발신 이메일
		String toMail = email;         //받는 이메일
		String title = "회원가입 인증 이메일 입니다.";
		String content = "인증 번호는 " + checkNum + "입니다. <br> " + 
						 "해당 인증번호를 인증코드에 기입하여 주세요.";
		
		
		/*
		//이메일 전송 코드
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
			helper.setFrom(setFrom);
			helper.setTo(toMail);
			helper.setSubject(title);
			helper.setText(content, true);
			mailSender.send(message);
		} 
		
		catch (Exception e) {
			e.printStackTrace();
		}
		*/
		logger.debug("setFrom : " + setFrom);
		logger.debug("toMail : " + toMail);
		logger.debug("title : " + title);
		logger.debug("content : " + content);
		
		String num = Integer.toString(checkNum); // ajax를 뷰로 반환시 데이터 타입은 String 타입만 가능
		
		return num; // String 타입으로 변환 후 반환
	}
	
	//회원수정 화면
	@RequestMapping(value="/user/update", method=RequestMethod.GET)
	public String update(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		User user = userService.userSelect(cookieUserId);
		
		model.addAttribute("user", user);
		
		return "/user/update";
	}
	
	//회원수정
	@RequestMapping(value="/user/updateProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> updateProc(MultipartHttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		
		String userId = HttpUtil.get(request, "userId");
		String userPwd = HttpUtil.get(request, "userPwd");
		String userName = HttpUtil.get(request, "userName");
		String userEmail = HttpUtil.get(request, "userEmail");
		String userIntro = HttpUtil.get(request, "userIntro");
		FileData fileData = HttpUtil.getFile(request, "userFile", UPLOAD_SAVE_DIR);
		
		if (!StringUtil.isEmpty(cookieUserId)) {
			if (StringUtil.equals(userId, cookieUserId)) {
				User user = userService.userSelect(cookieUserId);
				
				if (user != null) {
					if (!StringUtil.isEmpty(userPwd) && !StringUtil.isEmpty(userName) && !StringUtil.isEmpty(userEmail)) {
						user.setUserPwd(userPwd);
						user.setUserName(userName);
						user.setUserEmail(userEmail);
						user.setUserIntro(userIntro);
						
						if (fileData != null && fileData.getFileSize() > 0) {
							UserFile userFile = new UserFile();
							
							userFile.setFileName(fileData.getFileName());
							userFile.setFileOrgName(fileData.getFileOrgName());
							userFile.setFileExt(fileData.getFileExt());
							userFile.setFileSize(fileData.getFileSize());
							
							user.setUserFile(userFile);
						}
						
						try {
							if (userService.userUpdate(user) > 0) {
								res.setResponse(0, "성공");
							}
							
							else {
								res.setResponse(500, "서버 에러");
							}
						}
						
						catch (Exception e) {
							logger.error("[UserController] updateProc Exception", e);
							res.setResponse(500, "서버 에러");
						}
						
					}
					
					else {
						res.setResponse(400, "잘못 요청");
					}
				}
				
				else {
					CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
					res.setResponse(404, "회원 없음");
				}
			}
			
			else {
				CookieUtil.deleteCookie(request, response, "/", AUTH_COOKIE_NAME);
				res.setResponse(430, "아이디 다름");
			}
		}
		
		else {
			res.setResponse(410, "로그인 실패");
		}
		
		if (logger.isDebugEnabled()) {
			logger.debug("[UserController] /user/updateProc response \n" + JsonUtil.toJsonPretty(res));
		}
		
		return res;
	}
}
