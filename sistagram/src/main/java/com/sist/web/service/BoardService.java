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
import com.sist.web.dao.BoardDao;
import com.sist.web.model.Board;
import com.sist.web.model.BoardFile;

@Service("boardService")
public class BoardService {
	private static Logger logger = LoggerFactory.getLogger(BoardService.class);
	
	@Autowired
	private BoardDao boardDao;
	
	//파일저장경로
	@Value("#{env['upload.save.dir']}")
	private String UPLOAD_SAVE_DIR;
	
	//게시물 리스트
	public List<Board> boardList(Board board) {
		List<Board> list = null;
		
		try {
			list = boardDao.boardList(board);
		}
		
		catch (Exception e) {
			logger.error("[BoardService] boardList Exception", e);
		}
		
		return list;
	}
	
	//게시물 수
	public long boardListCount(Board board) {
		long cnt = 0;
		
		try {
			cnt = boardDao.boardListCount(board);
		}
		
		catch (Exception e) {
			logger.error("[BoardService] boardListCount Exception", e);
		}
		
		return cnt;
	}
	
	//게시물 등록 (첨부파일)
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardInsert(Board board) throws Exception {
		int cnt = 0;
		
		cnt = boardDao.boardInsert(board);
		
		if (cnt > 0 && board.getBoardFile() != null) {
			BoardFile boardFile = board.getBoardFile();
			
			boardFile.setBoardNum(board.getBoardNum());
			boardFile.setFileNum((short)1);
			
			boardDao.boardFileInsert(boardFile);
		}
		
		return cnt;
	}
	
	//게시물 상세 (첨부파일x)
	public Board boardSelect(long boardNum) {
		Board board = null;
		
		try {
			board = boardDao.boardSelect(boardNum);
		}
		
		catch (Exception e) {
			logger.error("[BoardService] boardSelect Exception", e);
		}
		
		return board;
	}
	
	//게시물 상세 (첨부파일)
	public Board boardView(long boardNum) {
		Board board = null;
		
		try {
			board = boardDao.boardSelect(boardNum);
			
			if (board != null) {
				BoardFile boardFile = boardDao.boardFileSelect(boardNum); 
				
				if (boardFile != null) {
					board.setBoardFile(boardFile);
				}
			}
		}
		
		catch (Exception e) {
			logger.error("[BoardService] boardView Exception", e);
		}
		
		return board;
	}
	
	//게시물 수정
	public int boardUpdate(Board board) {
		int cnt = 0;
		
		try {
			cnt = boardDao.boardUpdate(board);
		}
		
		catch (Exception e) {
			logger.error("[BoardService] boardUpdate Exception", e);
		}
		
		return cnt;
	}
	
	//게시물 삭제 (첨부파일 같이)
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Exception.class)
	public int boardDelete(long boardNum) throws Exception {
		int cnt = 0;
		
		Board board = boardView(boardNum);
		
		BoardFile boardFile = board.getBoardFile();
		
		if (boardFile != null) {
			if (boardDao.boardFileDelete(boardNum) > 0) {
				FileUtil.deleteFile(UPLOAD_SAVE_DIR + FileUtil.getFileSeparator() + boardFile.getFileName());
			}
		}
		
		if (board != null) {
			cnt = boardDao.boardDelete(boardNum);
		}
		
		return cnt;
	}
	
	//회원 게시물
	public List<Board> boardUserSelect(String userId) {
		List<Board> list = null;
		
		try {
			list = boardDao.boardUserSelect(userId);
		}
		
		catch (Exception e) {
			logger.error("[BoardService] boardUserSelect Exception", e);
		}
		
		return list;
	}
	
	//회원 게시물 수
	public long boardUserSelectCount(String userId) {
		long cnt = 0;
		
		try {
			cnt = boardDao.boardUserSelectCount(userId);
		}
		
		catch (Exception e) {
			logger.error("[BoardService] boardUserSelectCount Exception", e);
		}
		
		return cnt;
	}
}
