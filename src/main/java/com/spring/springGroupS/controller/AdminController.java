package com.spring.springGroupS.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springGroupS.service.AdminService;
import com.spring.springGroupS.service.MemberService;
import com.spring.springGroupS.vo.MemberVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminService adminService;
	@Autowired
	MemberService memberService;
	
	@GetMapping("/AdminMain")
	public String adminMainGet() {
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

	// 관리자 메뉴에서 회원 리스트 보여주기.
	@GetMapping("/member/MemberList")
	public String memberListGet(Model model, HttpSession session,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="level", defaultValue = "99", required = false) int level) {
		int totRecCnt = memberService.getTotRecCnt();
		int totPage = (int)Math.ceil((double)totRecCnt/pageSize);
		int startIndexNo = (pag-1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		List<MemberVO> vos = memberService.getMemberList(startIndexNo, pageSize, level);
		
		model.addAttribute("vos", vos);
		model.addAttribute("level", level);
		return "admin/member/MemberList";
	}
}
