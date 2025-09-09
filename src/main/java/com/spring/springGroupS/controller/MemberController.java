package com.spring.springGroupS.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS.service.MemberService;
import com.spring.springGroupS.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberService memberService;
	
	// 회원가입 폼 이동.
	@GetMapping("/memberJoin")
	public String memberJoinGet() {
		return "member/memberJoin"; 
	}
	
	// 아이디 중복체크.
	@ResponseBody
	@PostMapping("/MemberIdCheck")
	public String MemberIdCheck(MemberVO vo, String mid) {
		String res = "";
		vo = memberService.getMemberIdSerach(mid);
		if(vo == null) res = "0";
		else res = "1";
		return res;
	}
	// 닉네임 중복체크.
	@ResponseBody
	@PostMapping("/MemberNickNameCheck")
	public String MemberNickNameCheck(MemberVO vo, String nickName) {
		String res = "";
		vo = memberService.getMemberNickNameSerach(nickName);
		if(vo == null) res = "0";
		else res = "1";
		return res;
	}
}
