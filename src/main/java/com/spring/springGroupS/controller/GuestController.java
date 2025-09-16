package com.spring.springGroupS.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springGroupS.service.GuestService;
import com.spring.springGroupS.vo.GuestVO;

@Controller
@RequestMapping("/guest")
public class GuestController {
	@Autowired
	GuestService guestService;
	
	// 방명록 전체 보기.
	@GetMapping("/GuestList")
	public String GuestListGet(Model model, GuestVO vo,
			String flag,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
		int totRecCnt = guestService.getTotRecCnt(flag, "", "");
		// int totPage = (int)Math.ceil((double)totRecCnt/pageSize);
		int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt/pageSize : (totRecCnt/pageSize) + 1;
		int startIndexNo = (pag-1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;

		List<GuestVO> vos = guestService.getGuestList(startIndexNo, pageSize);
		model.addAttribute("vos", vos);
		
		model.addAttribute("flag", flag);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("curScrStartNo", curScrStartNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		return "guest/guestList";
	}
	
	// 방명록 작성 폼 이동.
	@GetMapping("/GuestInput")
	public String GuestInputGet() {
		return "guest/guestInput";
	}
	// 방명록 작성.
	@PostMapping("/GuestInput")
	public String GuestInputPost(GuestVO vo) {
		int res = guestService.setGuestInput(vo);
		if(res == 0) return "redirect:/Message/guestInputNo";
		else return "redirect:/Message/guestInputOk";
	}
	
	// 관리자 인증 폼 보기.
	@GetMapping("Login")
	public String AdminGet() {
		return "guest/admin";
	}
	// 관리자 인증.
	@PostMapping("Login")
	public String AdminOkPost(HttpSession session, String mid, String pwd) {
		if(mid.equals("admin") && pwd.equals("1234")) {
			session.setAttribute("sAdmin", "adminOK");
			return "redirect:/Message/adminOk";
		}
		else return "redirect:/Message/adminNo";
	}
	
	// 방명록 삭제.
	@GetMapping("GuestDelete")
	public String GuestDeletePost(int idx) {
		int res = guestService.setGuestDelete(idx);
		if(res == 0)return "redirect:/Message/guestDeleteNo";
		else return "redirect:/Message/guestDeleteOk";
	}
	
	// 로그아웃.
	@GetMapping("Logout")
	public String LogoutGet(HttpSession session) {
		session.removeAttribute("sAdmin");
		return "redirect:/Message/adminLogout";
	}
}
