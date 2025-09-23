package com.spring.springGroupS.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.ReviewVO;

public interface ReviewDAO {

	int setReviewInputOk(@Param("vo") ReviewVO vo);

	int setReviewDelete(@Param("idx") int idx);

	int setReviewReplyInputOk(@Param("vo") ReviewVO vo);

	int setReviewReplyDelete(@Param("replyIdx") int replyIdx);

}
