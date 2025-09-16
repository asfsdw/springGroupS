package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.BoardVO;

public interface BoardDAO {

	List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	int getTotRecCnt(@Param("flag") String flag, @Param("search") String search, @Param("searchStr") String searchStr);

	int setBoardInput(@Param("vo") BoardVO vo);

	BoardVO getBoardContent(@Param("idx") int idx);

	List<BoardVO> getNewBoardList(@Param("flag") String flag);

	void setBoardReadNum(@Param("idx") int idx);

	void setBoardGood(@Param("idx") int idx, @Param("goodCnt") int goodCnt);

	BoardVO getPreNextSearch(@Param("idx") int idx, @Param("str") String str);

	int setBoardUpdate(@Param("vo") BoardVO vo);

}
