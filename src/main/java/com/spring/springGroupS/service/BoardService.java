package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.BoardReplyVO;
import com.spring.springGroupS.vo.BoardVO;

public interface BoardService {

	List<BoardVO> getBoardList(int startIndexNo, int pageSize, String search, String searchStr);

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

	int setBoardDelete(int idx);

	List<BoardReplyVO> getBoardReplyList(int boardIdx);

	BoardReplyVO getBoardParentReplyCheck(int boardIdx);

	int setBoardReplyInput(BoardReplyVO replyVO);

	void setBoardReplyOrderUp(int boardIdx, int re_order);

	BoardReplyVO getBoardParentReplyIdxCheck(int idx);

	int setBoardReplyDelete(int idx);

	int setBoardReplyUpdate(BoardReplyVO replyVO);

	void setBoardReplyOrderBy(int boardIdx, int ref, int re_order);

}
