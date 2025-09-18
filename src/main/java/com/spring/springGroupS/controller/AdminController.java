package com.spring.springGroupS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS.common.Pagination;
import com.spring.springGroupS.service.AdminService;
import com.spring.springGroupS.service.BoardService;
import com.spring.springGroupS.service.GuestService;
import com.spring.springGroupS.service.MemberService;
import com.spring.springGroupS.vo.BoardVO;
import com.spring.springGroupS.vo.ComplaintVO;
import com.spring.springGroupS.vo.GuestVO;
import com.spring.springGroupS.vo.MemberVO;
import com.spring.springGroupS.vo.PageVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	Pagination pagination;
	@Autowired
	AdminService adminService;
	@Autowired
	MemberService memberService;
	@Autowired
	GuestService guestService;
	@Autowired
	BoardService boardService;
	
	// 관리자 메뉴.
	@GetMapping("/AdminMain")
	public String adminMainGet(Model model, String flag) {
		// flag != null이면 limit 1이 mapper에서 안 보이는 구조(if).
		List<GuestVO> gVOS = guestService.getNewGuestList(flag);
		List<MemberVO> mVOS = memberService.getNewMemberList(flag);
		List<BoardVO> bVOS = boardService.getNewBoardList(flag);
		List<ComplaintVO> cVOS = adminService.getNewBoardList(flag);
		
		int memberNewCount = 0;
		int cancelMember = 0;
		int guestNewCount = 0;
		int boardNewCount = 0;
		int complaintNewCount = 0;
		
		guestNewCount = gVOS.get(0).getNewCount();
		// gVOS의 검색결과가 있으면 건 수 갱신.
		if(!gVOS.isEmpty()) guestNewCount = mVOS.get(0).getNewCount();
		// mVOS의 검색결과가 있으면 건 수 갱신.
		if(!mVOS.isEmpty()) {
			memberNewCount = mVOS.get(0).getNewCount();
			// 탈퇴대기중인 회원 건 수.
			cancelMember = mVOS.get(0).getCancelMember();
		}
		if(!bVOS.isEmpty()) boardNewCount = bVOS.get(0).getNewCount();
		if(!cVOS.isEmpty()) complaintNewCount = cVOS.get(0).getNewCount();
		
		model.addAttribute("guestNewCount", guestNewCount);
		model.addAttribute("memberNewCount", memberNewCount);
		model.addAttribute("cancelMember", cancelMember);
		model.addAttribute("boardNewCount", boardNewCount);
		model.addAttribute("complaintNewCount", complaintNewCount);
		
		return "admin/adminMain";
	}
	@GetMapping("/AdminLeft")
	public String adminLeftGet() {
		return "admin/adminLeft";
	}
	@GetMapping("/AdminContent")
	public String adminContentGet() {
		return "admin/adminContent";
	}
	
	//관리자 메뉴에서 방명록 리스트 보여주기.
	@GetMapping("/guest/GuestList")
	// pagination 사용자 정의 메소드 부를 때 방명록 목록에서 주는 값(pag, pageSize 등)을 넣어주기 위해 PageVO로 받는다.
	public String guestListGet(Model model, PageVO vo) {
		// pagination 처리.
		vo.setSection("guest");
		vo = pagination.pagination(vo);
		
		// flag가 null이거나 공백이면 전체 리스트를 vos에 담는다. flag가 null이 아니면 최근 7일의 리스트를 vos에 담는다.
		List<GuestVO> vos = null;
		if(vo.getFlag().equals("")) vos = guestService.getGuestList(vo.getStartIndexNo(), vo.getPageSize());
		else vos = guestService.getNewGuestList(vo.getFlag());
		
		model.addAttribute("gVO", vo);
		model.addAttribute("vos", vos);
		
		return "admin/guest/guestList";
	}

	// 관리자 메뉴에서 회원 리스트 보여주기.
	@GetMapping("/member/MemberList")
	public String memberListGet(Model model, PageVO vo,
			@RequestParam(name = "level", defaultValue = "100", required = false) int level) {
		vo.setSection("member");
		vo = pagination.pagination(vo);
		
		List<MemberVO> vos = null;
		// flag가 공백이면 전체 리스트를 vos에 담는다. flag가 공백이 아니면 최근 7일의 리스트를 vos에 담는다.
		if(vo.getFlag().equals("")) vos = memberService.getMemberList(vo.getStartIndexNo(), vo.getPageSize(), level);
		else vos = memberService.getNewMemberList(vo.getFlag());
		
		model.addAttribute("vos", vos);
		model.addAttribute("mVO", vo);
		
		return "admin/member/memberList";
	}
	// 회원 리스트에서 회원의 등급 변경.
	@ResponseBody
	@PostMapping("/member/MemberLevelChange")
	public int memberLevelChangePost(int idx, int level) {
		return memberService.setMemberLevelUp(idx, level);
	}
	// 회원 리스트에서 선택한 회원의 등급 변경.
	@ResponseBody
	@PostMapping("/member/MemberLevelSelectChange")
	public int memberLevelSelectChangePost(String idxCheckedArray, int levelSelect) {
		return adminService.setMemberLevelSelectChange(idxCheckedArray, levelSelect);
	}
	// 회원 리스트에서 탈퇴신청 중이며 마지막 접속일에서 30일 이상 경과한 회원 삭제.
	@ResponseBody
	@PostMapping("/member/MemberDelete")
	public int memberDeletePost(int idx) {
		return adminService.memberDeleteGet(idx);
	}
	
	// 관리자 메뉴에서 게시판 보여주기.
	@GetMapping("/board/BoardList")
	public String boardListGet(Model model, PageVO vo) {
		vo.setSection("board");
		vo = pagination.pagination(vo);
		
		List<BoardVO> vos = null;
		if(vo.getFlag().equals("")) vos = boardService.getBoardList(vo.getStartIndexNo(), vo.getPageSize(), "", "");
		else vos = boardService.getNewBoardList(vo.getFlag());
		
		model.addAttribute("vos", vos);
		model.addAttribute("bVO", vo);
		
		return "admin/board/BoardList";
	}
	
	// 신고글 목록.
	@GetMapping("/complaint/ComplaintList")
	public String complaintListGet(Model model, PageVO pVO, ComplaintVO vo) {
		pVO.setSection("admin");
		pVO = pagination.pagination(pVO);
		
		List<ComplaintVO> vos = adminService.getComplaintList(pVO.getStartIndexNo(), pVO.getPageSize());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pVO", pVO);
		
		return "admin/complaint/complaintList";
	}
	// 신고글 내용보기.
	@GetMapping("/complaint/ComplaintContent")
	public String complaintContentGet(Model model, PageVO pVO, ComplaintVO vo) {
		pVO.setSection("admin");
		pVO = pagination.pagination(pVO);
		
		vo = adminService.getComplaintContent(vo.getPartIdx());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pVO", pVO);
		
		return "admin/complaint/complaintContent";
	}
	// 신고 처리.
	@ResponseBody
	@PostMapping("/complaint/ComplaintProgress")
	public int complaintProgressPost(Model model, PageVO pVO, ComplaintVO vo) {
		pVO.setSection("admin");
		pVO = pagination.pagination(pVO);
		
		int res = 0;
		
		if(vo.getComplaintSW().equals("D")) {
			res = adminService.setComplaintDelete(vo.getPart(), vo.getPartIdx());
			vo.setComplaintSW("처리완료(D)");
		}
		else if(vo.getComplaintSW().equals("H")) {
			res = adminService.setComplaintPrgress(vo.getPart(), vo.getPartIdx(), "HI");
			vo.setComplaintSW("처리중(H)");
		}
		else if(vo.getComplaintSW().equals("M")) {
			res = adminService.setComplaintPrgress(vo.getPart(), vo.getPartIdx(), "DE");
			vo.setComplaintSW("처리중(M)");
		}
		else {
			res = adminService.setComplaintPrgress(vo.getPart(), vo.getPartIdx(), "NO");
			vo.setComplaintSW("처리완료(S)");
		}
		if(res != 0) adminService.setComplaintProgressOk(vo.getIdx(), vo.getComplaintSW());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pVO", pVO);
		
		return res;
	}
}
