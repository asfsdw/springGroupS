package com.spring.springGroupS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springGroupS.service.User2Service;
import com.spring.springGroupS.vo.UserVO;

@Controller
@RequestMapping("/dbTest2")
public class DBTest2Contorller {
	@Autowired
	User2Service user2Servuce;
	
	// 유저 전체 검색.
	@GetMapping("/UserList")
	public String User2ListGet(Model model) {
		List<UserVO> vos = user2Servuce.getUserList();
		model.addAttribute("vos", vos);
		return "dbTest2/userList";
	}
	// mid가 admin인 유저 검색.
	@GetMapping("/UserSearch")
	public String UserSearchGet(Model model) {
		List<UserVO> vos = user2Servuce.getUserSearch("admin");
		model.addAttribute("vos", vos);
		return "dbTest2/userList";
	}
	// client에게 검색할 mid를 받아서 검색.
	@PostMapping("/UserList")
	public String User2ListPost(Model model, UserVO vo, String mid) {
		vo = user2Servuce.getUser(mid);
		model.addAttribute("vo", vo);
		if(vo == null) return "redirect:/Message/userSearchNo?mid="+mid;
		else return "dbTest2/userList";
	}
	
	// 회원등록 폼 이동.
	@GetMapping("/UserInput")
	public String UserInputGet() {
		return "dbTest2/userInput";
	}
	// 회원등록.
	@PostMapping("/UserInput")
	public String UserInputPost(UserVO vo) {
		int res = user2Servuce.setUserInput(vo);
		String mid = vo.getMid();
		if(res == 0) return "redirect:/Message/userInputInputNo";
		else return "redirect:/Message/userInputOk?mid="+mid;
	}
	
	// 회원수정 폼 이동.
	@GetMapping("/UserUpdate")
	public String UserUpdateGet(Model model, UserVO vo, int idx) {
		vo = user2Servuce.getUserIdxSerach(idx);
		model.addAttribute("vo", vo);
		return "dbTest2/userUpdate";
	}
	// 회원수정.
	@PostMapping("/UserUpdate")
	public String UserUpdatePost(Model model, UserVO vo) {
		int res = user2Servuce.setUserUpdate(vo);
		String mid = vo.getMid();
		if(res == 0) return "redirect:/Message/userUpdateNo?idx="+vo.getIdx();
		else return "redirect:/Message/userUpdateOk?mid="+mid;
	}
	
	// 회원삭제.
	@GetMapping("/UserDelete")
	public String UserDeleteGet(int idx) {
		int res = user2Servuce.setUserDelete(idx);
		if(res == 0) return "redirect:/Message/userDeleteNo";
		else return "redirect:/Message/userDeleteOk";
	}
}
