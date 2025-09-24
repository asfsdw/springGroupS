package com.spring.springGroupS.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS.service.PDSService;
import com.spring.springGroupS.service.ReviewService;
import com.spring.springGroupS.vo.PDSVO;
import com.spring.springGroupS.vo.ReviewVO;


@SuppressWarnings("unchecked")
@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	ReviewService reviewService;
	@Autowired
	PDSService pdsService;
	
	// 원본글에 리뷰달기
	@ResponseBody
	@PostMapping("/ReviewInputOk")
	public int reviewInputOkPost(HttpSession session, ReviewVO vo, PDSVO pdsVO) {
		pdsVO = pdsService.getPDSContent(vo.getPartIdx());
		String pdsMid = pdsVO.getMid();
		
		// 자신이 올린 글에 자신이 리뷰를 달아도 포인트 오르지 않게 한다.
		if(!pdsMid.equals(vo.getMid())) {
			List<String> reviewPointGain = (List<String>)session.getAttribute("pointGain");
			
			// 리스트에 pds+mid+게시글idx라는 문자열이 없을 경우 포인트 증가.
			if(reviewPointGain == null) reviewPointGain = new ArrayList<String>();
			String reviewPointTemp = "pds"+vo.getMid()+vo.getPartIdx();
			if(!reviewPointGain.contains(reviewPointTemp)) {
				reviewService.setReviewPointGain(vo.getMid());
				reviewPointGain.add(reviewPointTemp);
			}
			session.setAttribute("pointGain", reviewPointGain);
		}
		
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
