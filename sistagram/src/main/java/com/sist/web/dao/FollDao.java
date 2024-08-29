package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Foll;

@Repository("follDao")
public interface FollDao {
	public int follInsert(Foll foll);
	
	//팔로워 리스트
	public List<Foll> follList1(String userId);
	
	//팔로잉 리스트
	public List<Foll> follList2(String userId);
	
	//팔로워 수
	public long follCnt1(String userId);
	
	//팔로잉 수
	public long follCnt2(String userId);
}
