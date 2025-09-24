package com.spring.springGroupS.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS.service.ScheduleService;
import com.spring.springGroupS.vo.ScheduleVO;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {
	@Autowired
	ScheduleService scheduleService;
	
	// 전체 스케쥴 표시.
	@GetMapping("/Schedule")
	public String scheduleGet() {
		scheduleService.getScheduleList();
		return "schedule/schedule";
	}
	
	// 스케쥴 메뉴 표시.
	@GetMapping("/ScheduleMenu")
	public String scheduleGet(Model model, HttpSession session, String ymd) {
		String mid = session.getAttribute("sMid").toString();
		
		if(ymd.length() != 10) {
			String mm = "", dd = "";
			String[] ymdArr = ymd.split("-");
			
			if(ymdArr[1].length() == 1) mm = "0"+ymdArr[1];
			else mm=ymdArr[1];
			if(ymdArr[2].length() == 1) dd = "0"+ymdArr[2];
			else dd=ymdArr[2];
			
			ymd = ymdArr[0]+"-"+mm+"-"+dd;
		}
		
		List<ScheduleVO> vos = scheduleService.getScheduleMenu(mid, ymd);
		
		model.addAttribute("vos", vos);
		model.addAttribute("scheduleCnt", vos.size());
		model.addAttribute("ymd", ymd);
		
		return "schedule/scheduleMenu";
	}
	// 일정 삭제.
	@ResponseBody
	@PostMapping("/DelCheck")
	public int delCheckPost(int idx) {
		return scheduleService.setDelCehck(idx);
	}

	@ResponseBody
	@PostMapping("/ScheduleInputOk")
	public int scheduleInputOkPost(ScheduleVO vo) {
		return scheduleService.setScheduleInputOk(vo);
	}
}
