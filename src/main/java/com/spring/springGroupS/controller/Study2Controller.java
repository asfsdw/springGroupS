package com.spring.springGroupS.controller;

import java.util.UUID;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS.service.Study2Service;

@Controller
@RequestMapping("/study2")
public class Study2Controller {
	@Autowired
	Study2Service study2Service;
	
	// 랜덤 연습 폼.
	@GetMapping("/random/RandomForm")
	public String randomFormGet() {
		return "study2/random/randomForm";
	}
	@ResponseBody
	@PostMapping("/random/RandomCheck")
	public String randomCheckPost(int flag) {
		// (최대값-최소값+1)+최소값
		if(flag == 1) return ((int)(Math.random()*(99999999-10000000+1))+10000000)+"";
		else if(flag == 2) return UUID.randomUUID()+"";
		else if(flag == 3) return RandomStringUtils.randomAlphanumeric(64);
		return "";
	}
	
	// 달력 연습 폼.
	@GetMapping("/calendar/Calendar")
	public String calendarGet() {
		study2Service.getCalendar();
		return "study2/calendar/calendar";
	}
}
