package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.sist.common.util.FileUtil;
import com.sist.web.dao.UserDao;
import com.sist.web.model.Board;
import com.sist.web.model.User;
import com.sist.web.model.UserFile;

@Service("userService")
public class UserService {
	private static Logger logger = LoggerFactory.getLogger(UserService.class);
	
	//파일저장경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	@Autowired
	private UserDao userDao;
	
	//회원 조회
	public User userSelect(String userId) {
		User user = null;
		
		try {
			user = userDao.userSelect(userId);
		}
		
		 catch (Exception e) {
			 logger.debug("[UserService] userSelect Exception", e);
		 }
		
		return user;
	}
	
	//회원 등록
	public int userInsert(User user) {
		int cnt = 0;
		
		try {
			cnt = userDao.userInsert(user);
		}
		
		catch (Exception e) {
			logger.debug("[UserService] userInsert Exception", e);
		}
		
		return cnt;
	}
	
	//이메일 인증
	public int emailAuth(User user) {
		int cnt = 0;
		
		try {
			cnt = userDao.emailAuth(user);
		}
		
		catch (Exception e) {
			logger.debug("[UserService] emailAuth Exception", e);
		}
		
		return cnt;
	}
	
	//비밀번호 찾기
	public int findPw(User user) {
		int cnt = 0;
		
		try {
			cnt = userDao.findPw(user);
		}
		
		catch (Exception e) {
			logger.debug("[UserService] findPw Exception", e);
		}
		
		return cnt;
	}
	
	//회원 수정
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int userUpdate(User user) throws Exception {
		int cnt = 0;
		
		cnt = userDao.userUpdate(user);
		
		if (cnt > 0 && user.getUserFile() != null) {
			UserFile delUserFile = userDao.userFileSelect(user.getUserId());
			
			if (delUserFile != null) {
				FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + delUserFile.getFileName());
				
				userDao.userFileDelete(user.getUserId());
			}
			
			UserFile userFile = user.getUserFile();
			userFile.setUserId(user.getUserId());
			userFile.setFileNum((short)1);
			
			userDao.userFileInsert(userFile);
		}
		
		return cnt;
	}
	
	public List<User> userRandom(String userId) {
		List<User> list = null;
		
		try {
			list = userDao.userRandom(userId);
		}
		
		 catch (Exception e) {
			 logger.debug("[UserService] userSelect Exception", e);
		 }
		
		return list;
	}
}
