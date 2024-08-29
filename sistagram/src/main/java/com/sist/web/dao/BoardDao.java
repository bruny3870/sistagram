package com.sist.web.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.sist.web.model.Board;
import com.sist.web.model.BoardFile;

@Repository("boardDao")
public interface BoardDao {
	//게시물 리스트
	public List<Board> boardList(Board board);
	
	//게시물 수
	public long boardListCount(Board board);
	
	//게시글 등록
	public int boardInsert(Board board);
	
	//첨부파일 등록
	public int boardFileInsert(BoardFile boardFile);
	
	//게시물 상세
	public Board boardSelect(long boardNum);
	
	//첨부파일 조회
	public BoardFile boardFileSelect(long boardNum);
	
	//게시물 수정
	public int boardUpdate(Board board);
	
	//첨부파일 삭제
	public int boardFileDelete(long boardNum);
	
	//게시물 삭제
	public int boardDelete(long boardNum);
	
	//회원 게시물
	public List<Board> boardUserSelect(String userId);
	
	//회원 게시물 수
	public long boardUserSelectCount(String userId);
}
