package com.spring.springGroupS.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.dao.ReviewDAO;
import com.spring.springGroupS.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	ReviewDAO reviewDAO;

	@Override
	public int setReviewInputOk(ReviewVO vo) {
		return reviewDAO.setReviewInputOk(vo);
	}

	@Override
	public int setReviewDelete(int idx) {
		return reviewDAO.setReviewDelete(idx);
	}

	@Override
	public int setReviewReplyInputOk(ReviewVO vo) {
		return reviewDAO.setReviewReplyInputOk(vo);
	}

	@Override
	public int setReviewReplyDelete(int replyIdx) {
		return reviewDAO.setReviewReplyDelete(replyIdx);
	}
}
