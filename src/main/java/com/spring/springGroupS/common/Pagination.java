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
	
	public PageVO pagination(PageVO vo) {
		vo.setSection(vo.getSection());
		vo.setPart(vo.getPart());
		vo.setSearch(vo.getSearch());
		vo.setSearchStr(vo.getSearchStr());
		vo.setFlag(vo.getFlag() == null ? "" : vo.getFlag());
		
		if(vo.getSearch() != null) {
			if(vo.getSearch().equals("title")) vo.setSearchKr("글제목");
			else if(vo.getSearch().equals("nickName")) vo.setSearchKr("닉네임");
			else if(vo.getSearch().equals("content")) vo.setSearchKr("글내용");
		}
		
		// 아무 값도 안 줬을 때 기본값이 0이기 때문에 삼항연산자의 조건을 0으로 준다.
		vo.setPag((Integer)vo.getPag()==0 ? 1 : vo.getPag());
		vo.setPageSize((Integer)vo.getPageSize()==0 ? 10 : vo.getPageSize());
		
		if(vo.getSection().equals("member")) vo.setTotRecCnt(memberService.getTotRecCnt(vo.getFlag()));
		else if(vo.getSection().equals("guest")) {
			if(vo.getSearch() == null) vo.setTotRecCnt(guestService.getTotRecCnt(vo.getFlag(), "", ""));
			else vo.setTotRecCnt(guestService.getTotRecCnt(vo.getFlag(), vo.getSearch(), vo.getSearchStr()));
		}
		else if(vo.getSection().equals("board")) {
			if(vo.getSearch() == null) vo.setTotRecCnt(boardService.getTotRecCnt(vo.getFlag(), "", ""));
			else vo.setTotRecCnt(boardService.getTotRecCnt(vo.getFlag(), vo.getSearch(), vo.getSearchStr()));
		}
		
		vo.setTotPage((int)Math.ceil((double)vo.getTotRecCnt()/vo.getPageSize()));
		vo.setStartIndexNo((vo.getPag()-1) * vo.getPageSize());
		vo.setCurScrStartNo(vo.getTotRecCnt() - vo.getStartIndexNo());
		
		vo.setBlockSize(3);
		vo.setCurBlock((vo.getPag()-1)/vo.getBlockSize());
		vo.setLastBlock((vo.getTotPage()-1)/vo.getBlockSize());
		
		return vo;
	}
}
