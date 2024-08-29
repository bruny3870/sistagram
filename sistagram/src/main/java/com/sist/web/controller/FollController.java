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

import com.sist.web.model.Foll;
import com.sist.web.model.Response;
import com.sist.web.service.FollService;
import com.sist.web.util.CookieUtil;
import com.sist.web.util.HttpUtil;

@Controller("follController")
public class FollController {
	private static Logger logger = LoggerFactory.getLogger(FollController.class);
	
	@Autowired
	private FollService follService;
	
	//쿠키
	@Value("#{env['auth.cookie.name']}")
	private String AUTH_COOKIE_NAME;
	
	@RequestMapping(value="/user/follProc", method=RequestMethod.POST)
	@ResponseBody
	public Response<Object> follProc(HttpServletRequest request, HttpServletResponse response) {
		Response<Object> res = new Response<Object>();
		
		long follNum = HttpUtil.get(request, "follNum", (long)0);
		String cookieUserId = CookieUtil.getHexValue(request, AUTH_COOKIE_NAME);
		String userId = HttpUtil.get(request, "userId", "");
		
		logger.debug("================");
		logger.debug("cookieUserId : " + cookieUserId);
		logger.debug("userId : " + userId);
		logger.debug("================");
		
		Foll foll = new Foll();
		
		foll.setFollNum(follNum);
		foll.setToUser(userId);
		foll.setFromUser(cookieUserId);
		
		try {
			if (follService.follInsert(foll) > 0) {
				res.setResponse(0, "성공");
			}
			
			else {
				res.setResponse(500, "서버 에러");
			}
		}
		
		catch (Exception e) {
			logger.error("[FollController] follProc Exception", e);
			res.setResponse(500, "서버 에러");
		}
		
		return res;
	}
}
