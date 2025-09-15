package com.spring.springGroupS.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.service.BoardService;
import com.spring.springGroupS.service.GuestService;
import com.spring.springGroupS.service.MemberService;
import com.spring.springGroupS.vo.PageVO;

@Service
public class Pagination {
	@Autowired
	MemberService memberService;
	@Autowired
	GuestService guestService;
	@Autowired
	BoardService boardService;
	
	public PageVO pagination(PageVO vo, String part) {
		// 아무 값도 안 줬을 때 기본값이 0이기 때문에 삼항연산자의 조건을 0으로 준다.
		vo.setPag((Integer)vo.getPag()==0 ? 1 : vo.getPag());
		vo.setPageSize((Integer)vo.getPageSize()==0 ? 10 : vo.getPageSize());
		if(part.equals("member")) vo.setTotRecCnt(memberService.getTotRecCnt(vo.getFlag()));
		else if(part.equals("guest")) vo.setTotRecCnt(guestService.getTotRecCnt(vo.getFlag()));
		else if(part.equals("board")) vo.setTotRecCnt(boardService.getTotRecCnt(vo.getFlag()));
		vo.setTotPage((int)Math.ceil((double)vo.getTotRecCnt()/vo.getPageSize()));
		vo.setStartIndexNo((vo.getPag()-1) * vo.getPageSize());
		vo.setCurScrStartNo(vo.getTotRecCnt() - vo.getStartIndexNo());
		
		vo.setBlockSize(3);
		vo.setCurBlock((vo.getPag()-1)/vo.getBlockSize());
		vo.setLastBlock((vo.getTotPage()-1)/vo.getBlockSize());
		
		// flag는 7일 이내의 글만 불러올 때 사용한다.
		vo.setFlag(vo.getFlag());
		return vo;
	}
}
