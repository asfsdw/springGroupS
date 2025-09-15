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
import com.spring.springGroupS.service.GuestService;
import com.spring.springGroupS.service.MemberService;
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
	
	@GetMapping("/AdminMain")
	public String adminMainGet(Model model, String flag) {
		// flag != null이면 limit 1이 mapper에서 안 보이는 구조(if).
		List<GuestVO> gVOS = guestService.getNewGuestList(flag);
		List<MemberVO> mVOS = memberService.getNewMemberList(flag);
		
		int memberNewCount = 0;
		int cancelMember = 0;
		// adminMain에서 건 수 보여주기 위해 newCount만 뽑아서 보낸다.
		int guestNewCount = gVOS.get(0).getNewCount();
		// mVOS의 검색결과가 있으면 건 수 갱신.
		if(!mVOS.isEmpty()) {
			memberNewCount = mVOS.get(0).getNewCount();
			// 탈퇴대기중인 회원 건 수.
			cancelMember = mVOS.get(0).getCancelMember();
		}
		model.addAttribute("guestNewCount", guestNewCount);
		model.addAttribute("memberNewCount", memberNewCount);
		model.addAttribute("cancelMember", cancelMember);
		
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
		vo = pagination.pagination(vo, "guest");
		
		// flag가 null이거나 공백이면 전체 리스트를 vos에 담는다. flag가 null이 아니면 최근 7일의 리스트를 vos에 담는다.
		List<GuestVO> vos = null;
		if(vo.getFlag() == null || vo.getFlag().equals("")) vos = guestService.getGuestList(vo.getStartIndexNo(), vo.getPageSize());
		else vos = guestService.getNewGuestList(vo.getFlag());
		
		model.addAttribute("gVO", vo);
		model.addAttribute("vos", vos);
		
		return "admin/guest/guestList";
	}

	// 관리자 메뉴에서 회원 리스트 보여주기.
	@GetMapping("/member/MemberList")
	public String memberListGet(Model model, String flag,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="level", defaultValue = "100", required = false) int level) {
		// 7일 이내에 가입한 사람만 보여줄 때의 페이징처리를 위해 flag변수 사용.
		int totRecCnt = memberService.getTotRecCnt(flag);
		int totPage = (int)Math.ceil((double)totRecCnt/pageSize);
		int startIndexNo = (pag-1) * pageSize;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		List<MemberVO> vos = null;
		// flag가 null이거나 공백이면 전체 리스트를 vos에 담는다. flag가 null이 아니면 최근 7일의 리스트를 vos에 담는다.
		if(flag == null || flag.equals("")) vos = memberService.getMemberList(startIndexNo, pageSize, level);
		else vos = memberService.getNewMemberList(flag);
		
		model.addAttribute("vos", vos);
		
		model.addAttribute("flag", flag);
		model.addAttribute("level", level);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
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
}
