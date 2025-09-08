package com.spring.springGroupS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springGroupS.service.UserService;
import com.spring.springGroupS.vo.UserVO;

@Controller
@RequestMapping("/dbTest")
public class DBTestController {
	@Autowired
	UserService userService;
	
	// 모든 유저 불러오기.
	@GetMapping("UserList")
	public String UserListGet(Model model) {
		List<UserVO> vos = userService.getUserList();
		model.addAttribute("vos", vos);
		return "dbTest/userList";
	}
	// 유저 검색.
	@PostMapping("UserList")
	public String UserListPost(Model model, String mid) {
		UserVO vo = userService.getUser(mid);
		model.addAttribute("vo", vo);
		return "dbTest/userList";
	}
}
