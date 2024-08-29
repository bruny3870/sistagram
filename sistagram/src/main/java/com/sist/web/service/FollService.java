package com.sist.web.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.FollDao;
import com.sist.web.model.Foll;

@Service("follService")
public class FollService {
	private static Logger logger = LoggerFactory.getLogger(FollService.class);
	
	@Autowired
	private FollDao follDao;
	
	public int follInsert(Foll foll) {
		int cnt = 0;
		
		try {
			cnt = follDao.follInsert(foll);
		}
		
		catch (Exception e) {
			logger.error("[FollService] follInsert Exception", e);
		}
		
		return cnt;
	}
	
	//팔로워 리스트
	public List<Foll> follList1(String userId) {
		List<Foll> list = null;
		
		try {
			list = follDao.follList1(userId);
		}
		
		catch (Exception e) {
			logger.debug("[FollService] follList1 Exception", e);
		}
		
		return list;
	}
	
	//팔로잉 리스트
	public List<Foll> follList2(String userId) {
		List<Foll> list = null;
		
		try {
			list = follDao.follList2(userId);
		}
		
		catch (Exception e) {
			logger.debug("[FollService] follList2 Exception", e);
		}
		
		return list;
	}
	
	//팔로워 수
	public long follCnt1(String userId) {
		long cnt = 0;
		
		try {
			cnt = follDao.follCnt1(userId);
		}
		
		catch (Exception e) {
			logger.debug("[FollService] follCnt1 Exception", e);
		}
		
		return cnt;
	}
	
	//팔로잉 수
	public long follCnt2(String userId) {
		long cnt = 0;
		
		try {
			cnt = follDao.follCnt2(userId);
		}
		
		catch (Exception e) {
			logger.debug("[FollService] follCnt2 Exception", e);			
		}
		
		return cnt;
	}
	
}
