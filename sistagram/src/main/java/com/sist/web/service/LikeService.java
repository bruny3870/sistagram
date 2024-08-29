package com.sist.web.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.web.dao.LikeDao;
import com.sist.web.model.Like;

@Service("likeService")
public class LikeService {
	private static Logger logger = LoggerFactory.getLogger(LikeService.class);

	@Autowired
	private LikeDao likeDao;

	public long likeSelect(Like like) {
		long cnt = 0;

		try {
			cnt = likeDao.likeSelect(like);
		}

		catch (Exception e) {
			logger.error("[LikeService] likeSelect Exception", e);
		}

		return cnt;
	}

	public long likeCount(long boardNum) {
		long cnt = 0;

		try {
			cnt = likeDao.likeCount(boardNum);
		}

		catch (Exception e) {
			logger.error("[LikeService] likeCount Exception", e);
		}

		return cnt;
	}

	public int likeInsert(Like like) {
		int cnt = 0;

		try {
			cnt = likeDao.likeInsert(like);
		}

		catch (Exception e) {
			logger.error("[LikeService] likeInsert Exception", e);
		}

		return cnt;
	}

	public int likeDelete(Like like) {
		int cnt = 0;

		try {
			cnt = likeDao.likeDelete(like);
		}

		catch (Exception e) {
			logger.error("[LikeService] likeDelete Exception", e);
		}

		return cnt;
	}
	
	
	public long likeSelect2(Like like) {
		long cnt = 0;

		try {
			cnt = likeDao.likeSelect2(like);
		}

		catch (Exception e) {
			logger.error("[LikeService] likeSelect Exception", e);
		}

		return cnt;
	}

	public long likeCount2(long boardNum) {
		long cnt = 0;

		try {
			cnt = likeDao.likeCount2(boardNum);
		}

		catch (Exception e) {
			logger.error("[LikeService] likeCount Exception", e);
		}

		return cnt;
	}
	
	public int likeInsert2(Like like) {
		int cnt = 0;
		
		try {
			cnt = likeDao.likeInsert2(like);
		}
		
		catch (Exception e) {
			logger.error("[LikeService] likeInsert2 Exception", e);
		}
		
		return cnt;
	}
	
	public int likeDelete2(Like like) {
		int cnt = 0;
		
		try {
			cnt = likeDao.likeDelete2(like);
		}
		
		catch (Exception e) {
			logger.error("[LikeService] likeDelete2 Exception", e);
		}
		
		return cnt;
	}
}
