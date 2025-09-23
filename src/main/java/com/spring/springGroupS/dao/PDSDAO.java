package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.PDSVO;
import com.spring.springGroupS.vo.ReviewVO;

public interface PDSDAO {

	int getTotRecCnt(@Param("flag") String flag, @Param("part") String part, @Param("search") String search, @Param("searchStr") String searchStr);

	List<PDSVO> getPDSList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part, @Param("search") String search, @Param("searchStr") String searchStr);

	int setPDSInput(@Param("vo") PDSVO vo);

	PDSVO getPDSContent(@Param("idx") int idx);

	int setDownNumCheck(@Param("idx") int idx);

	int setDeleteCheck(@Param("idx") int idx);

	List<ReviewVO> getReviewList(@Param("idx") int idx, @Param("part") String part);

}
