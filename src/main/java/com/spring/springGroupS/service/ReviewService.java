package com.spring.springGroupS.service;

import com.spring.springGroupS.vo.ReviewVO;

public interface ReviewService {

	int setReviewInputOk(ReviewVO vo);

	int setReviewDelete(int idx);

	int setReviewReplyInputOk(ReviewVO vo);

	int setReviewReplyDelete(int replyIdx);

}
