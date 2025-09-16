package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.BoardVO;

public interface BoardService {

	List<BoardVO> getBoardList(int startIndexNo, int pageSize);

	int getTotRecCnt(String flag, String search, String searchStr);

	int setBoardInput(BoardVO vo);

	BoardVO getBoardContent(int idx);

	List<BoardVO> getNewBoardList(String flag);

	void imgCheck(String content);

	void setBoardReadNum(int idx);

	void setBoardGood(int idx, int goodCnt);

	BoardVO getPreNextSearch(int idx, String str);

	void imgBackup(String content);

	int setBoardUpdate(BoardVO vo);

	void imgDelete(String content);

}
