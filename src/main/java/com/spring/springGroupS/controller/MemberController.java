package com.spring.springGroupS.controller;

import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS.common.Mail;
import com.spring.springGroupS.service.MemberService;
import com.spring.springGroupS.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberService memberService;
	@Autowired
	Mail mail;
	
	// 회원가입 폼 이동.
	@GetMapping("/MemberJoin")
	public String memberJoinGet(Model model) {
		return "member/memberJoin"; 
	}
	
	// 아이디 중복체크.
	@ResponseBody
	@PostMapping("/MemberIdCheck")
	public MemberVO memberIdCheckPost(String mid) {
		return memberService.getMemberIdSerach(mid);
	}
	// 닉네임 중복체크.
	@ResponseBody
	@PostMapping("/MemberNickNameCheck")
	public MemberVO memberNickNameCheckPost(String nickName) {
		return memberService.getMemberNickNameSerach(nickName);
	}
	
	// 이메일로 인증번호 발송.
	@ResponseBody
	@PostMapping("/MemberEmailCheck")
	public int memberEmailCheckPost(HttpSession session, String email) throws MessagingException {
		String emailKey = UUID.randomUUID().toString().substring(0, 8);
		
		// 세션에 인증번호 저장.
		session.setAttribute("sEmailKey", emailKey);
		
		// 메일 전송 메소드 불러오기.
		mail.mailSend(email, "이메일 인증키입니다.", "이메일 인증키: "+emailKey);
		return 1;
	}
	// 인증번호 확인.
	@ResponseBody
	@PostMapping("/MemberEmailCheckOk")
	public int memberEmailCheckOk(HttpSession session, String checkKey) {
		// 세션에 저장한 인증번호와 비교.
		String emailKey = (String)session.getAttribute("sEmailKey");
		if(emailKey.equals(checkKey)) return 1;
		else return 0;
	}
	// 인증번호 제한시간(2분).
	@ResponseBody
	@PostMapping("/MemberEmailCheckNo")
	public void memberEmailCheckNo(HttpSession session) {
		session.removeAttribute("sEmeilKey");
	}
	
	// 로그인 폼 이동.
	@GetMapping("/MemberLogin")
	public String memberLogin() {
		return "member/memberLogin";
	}
	
	//이름으로 아이디 찾기.
	@ResponseBody
	@PostMapping("/MemberIdFind")
	public List<MemberVO> memberIdFind(String name) {
		return memberService.getMemberIdFind(name);
	}
	
	//이메일로 임시비밀번호 발송.
	@ResponseBody
	@PostMapping("/MemberTempPwd")
	public String memberTempPwd(String mid, String email) throws MessagingException {
		String tempPwd = UUID.randomUUID().toString().substring(0, 4);
		int res = memberService.setMemberTempPwd(mid, tempPwd);
		System.out.println(res);
		// 비밀번호를 임시비밀번호로 수정에 성공했을 때.
		if(res != 0) {
			mail.mailSend(email, "임시비밀번호입니다.", "임시 비밀번호: "+tempPwd);
			return "1";
		}
		else return "0";
	}
}
