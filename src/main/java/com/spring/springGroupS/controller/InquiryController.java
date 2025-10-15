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
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS.common.Pagination;
import com.spring.springGroupS.service.InquiryService;
import com.spring.springGroupS.vo.InquiryReplyVO;
import com.spring.springGroupS.vo.InquiryVO;
import com.spring.springGroupS.vo.PageVO;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
	@Autowired
	InquiryService inquiryService;
	
	@Autowired
	Pagination pagination;
	
	@GetMapping("/inquiryList")
	public String inquiryListGet(Model model, HttpSession session, PageVO pageVO,
			@RequestParam(name="part", defaultValue="전체", required=false) String part
		) {
		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");
		if(level == 0) mid = "admin";
		
		pageVO.setSection("inquiry");
		pageVO.setPart(part);
		pageVO.setSearchStr(mid);
		pageVO = pagination.pagination(pageVO);
		List<InquiryVO> vos = inquiryService.getInquiryList(pageVO.getStartIndexNo(), pageVO.getPageSize(), part, mid);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("part", part);
		
		return "inquiry/inquiryList";
	}
	
	@GetMapping("/inquiryInput")
	public String inquiryInputGet(Model model, int pag) {
		model.addAttribute("pag", pag);
		return "inquiry/inquiryInput";
	}
	
	@PostMapping("/inquiryInput")
	public String inquiryInputPost(MultipartFile file, InquiryVO vo) {
		inquiryService.setInquiryInput(file, vo);
		
		return "redirect:/Message/inquiryInputOk";
	}
	
	@GetMapping("/inquiryView")
	public String inquiryViewGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag
			) {
		InquiryVO vo = inquiryService.getInquiryView(idx);
		
		// 해당 문의글의 답변글 가져오기
		InquiryReplyVO reVO = inquiryService.getInquiryReply(idx);

		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("pag", pag);
		
		return "inquiry/inquiryView";
	}
	
	// 본인이 올린 문의글 수정하기 폼 보기
	@GetMapping("/inquiryUpdate")
	public String inquiryUpdateGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag
		) {
		InquiryVO vo = inquiryService.getInquiryView(idx);
		
		// 해당 문의글의 답변글 가져오기
		InquiryReplyVO reVO = inquiryService.getInquiryReply(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("pag", pag);
		model.addAttribute("idx", idx);
		
		return "inquiry/inquiryUpdate";
	}
	
	// 1:1 문의글 수정하기 처리
	@PostMapping("/inquiryUpdate")
	public String inquiryUpdatePost(Model model, MultipartFile file, InquiryVO vo,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag
		) {
		int res = inquiryService.setInquiryUpdate(file, vo);
		model.addAttribute("pag", pag);
		model.addAttribute("idx",vo.getIdx());
		if (res != 0) return "redirect:/Message/inquiryUpdateOk";
		else return "redirect:/Message/inquiryUpdateNo";
	}

	// 1:1문의 내용 삭제처리(글쓴이는 답글이 달리기전까지는 현재글을 '수정/삭제'할수 있다. 삭제시 '답변글'을 먼저 삭제하고 원본글을 삭제처리한다.
	@GetMapping("/inquiryDelete")
	public String inquiryDeleteGet(Model model, int idx,
			@RequestParam(name="fSName", defaultValue="", required=false) String fSName
		) {
		int res = inquiryService.setInquiryDelete(idx, fSName);
		if(res != 0) return "redirect:/Message/inquiryDeleteOk";
		else return "redirect:/Message/inquiryDeleteNo?idx="+idx;
	}
}
