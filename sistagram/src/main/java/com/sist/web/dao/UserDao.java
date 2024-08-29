package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Board;
import com.sist.web.model.User;
import com.sist.web.model.UserFile;

@Repository("userDao")
public interface UserDao {
	//회원 조회
	public User userSelect(String userId);
	
	//회원 등록
	public int userInsert(User user);
	
	//이메일 인증
	public int emailAuth(User user);
	
	//비밀번호 찾기
	public int findPw(User user);
	
	//회원 수정
	public int userUpdate(User user);
	
	//프로필 조회
	public UserFile userFileSelect(String userId);

	//프로필 등록
	public int userFileInsert(UserFile userFile);

	//프로필 삭제
	public int userFileDelete(String userId);
	
	public List<User> userRandom(String userId);
	
}
