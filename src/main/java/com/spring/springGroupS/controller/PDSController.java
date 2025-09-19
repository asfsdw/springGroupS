package com.spring.springGroupS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springGroupS.common.Pagination;
import com.spring.springGroupS.service.PDSService;
import com.spring.springGroupS.vo.PDSVO;
import com.spring.springGroupS.vo.PageVO;

@Controller
@RequestMapping("/pds")
public class PDSController {
	@Autowired
	Pagination pagination;
	@Autowired
	PDSService pdsService;
	
	@GetMapping("/PDSList")
	public String pdsListGet(Model model, PageVO pVO, PDSVO vo) {
		pVO.setSection("pds");
		pVO = pagination.pagination(pVO);
		
		List<PDSVO> vos = pdsService.getPDSList(pVO.getStartIndexNo(), pVO.getPageSize(), pVO.getPart(), "",  "");
		
		model.addAttribute("vos", vos);
		model.addAttribute("pVO", pVO);
		
		return "pds/pdsList";
	}
	@GetMapping("/PDSInput")
	public String pdsInputGet(Model model, PageVO pVO) {
		pVO.setSection("pds");
		pVO = pagination.pagination(pVO);
		
		model.addAttribute("pVO", pVO);
		
		return "pds/pdsInput";
	}
	@GetMapping("/PDSSearchList")
	public String pdsSearchListGet(Model model, PageVO pVO) {
		pVO.setSection("pds");
		pVO = pagination.pagination(pVO);
		
		model.addAttribute("pVO", pVO);
		
		return "pds/pdsSearchList";
	}
}
