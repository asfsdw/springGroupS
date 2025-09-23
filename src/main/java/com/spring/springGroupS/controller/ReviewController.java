package com.spring.springGroupS.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS.service.ReviewService;
import com.spring.springGroupS.vo.ReviewVO;


@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	ReviewService reviewService;
	
	// 원본글에 댓글달기
	@ResponseBody
	@PostMapping("/ReviewInputOk")
	public int reviewInputOkPost(ReviewVO vo) {
		return reviewService.setReviewInputOk(vo);
	}
	
	// 원본글에 작성한 댓글 삭제하기
	@ResponseBody
	@PostMapping("/ReviewDelete")
	public int reviewDeletePost(int idx) {
		return reviewService.setReviewDelete(idx);
	}
	
	// 댓글에 대댓글 달기
	@ResponseBody
	@PostMapping("/ReviewReplyInputOk")
	public int reviewReplyInputOkPost(ReviewVO vo) {
		return reviewService.setReviewReplyInputOk(vo);
	}
	
	// 리뷰에 작성한 댓글 삭제하기
	@ResponseBody
	@PostMapping("/ReviewReplyDelete")
	public int reviewReplyDeletePost(int replyIdx) {
		return reviewService.setReviewReplyDelete(replyIdx);
	}
}
