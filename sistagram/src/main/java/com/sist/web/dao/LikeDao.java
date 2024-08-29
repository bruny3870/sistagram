package com.sist.web.dao;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Like;

@Repository("likeDao")
public interface LikeDao {
	public long likeSelect(Like like);
	
	public long likeCount(long boardNum);
	
	public int likeInsert(Like like);
	
	public int likeDelete(Like like);
	
	
	public long likeSelect2(Like like);
	
	public long likeCount2(long boardNum);
	
	public int likeInsert2(Like like);
	
	public int likeDelete2(Like like);
}
