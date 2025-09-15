package com.spring.springGroupS.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springGroupS.common.Pagination;
import com.spring.springGroupS.service.BoardService;
import com.spring.springGroupS.vo.BoardVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	Pagination paginatino;
	@Autowired
	BoardService boardService;
	
	// 게시글 전체 보기.
	@GetMapping("/BoardList")
	public String boardListGet(Model model, String flag,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize) {
		int totRecCnt = boardService.getTotRecCnt(flag);
		int totPage = (int)Math.ceil((double)totRecCnt/pageSize);
		int startIndexNo = (pag-1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
			
		List<BoardVO> vos = boardService.getBoardList(startIndexNo, pageSize);
		
		model.addAttribute("vos", vos);
		
		model.addAttribute("flag", flag);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("startIndexNo", startIndexNo);
		model.addAttribute("curScrStartNo", curScrStartNo);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		return "board/boardList";
	}
	
	// 게시글 쓰기 폼 이동.
	@GetMapping("BoardInput")
	public String boardInputGet() {
		return "board/boardInput";
	}
	// 게시글 쓰기.
	@PostMapping("BoardInput")
	public String boardInputPost(BoardVO vo) {
		int res = boardService.setBoardInput(vo);
		if(res != 0) return "redirect:/Message/boardInputOk";
		else return "redirect:/Message/boardInputNo";
	}
	
	// 게시글 열람.
	@GetMapping("BoardContent")
	public String boardContentGet(Model model, int idx) {
		BoardVO vo = boardService.getBoardContent(idx);
		model.addAttribute("vo", vo);
		return "board/boardContent";
	}
}
