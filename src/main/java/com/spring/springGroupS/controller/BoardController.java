package com.spring.springGroupS.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS.common.Pagination;
import com.spring.springGroupS.service.BoardService;
import com.spring.springGroupS.vo.BoardVO;
import com.spring.springGroupS.vo.PageVO;

@SuppressWarnings("unchecked")
@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	Pagination paginatino;
	@Autowired
	BoardService boardService;
	
	// 게시글 전체 보기.
	@GetMapping("/BoardList")
	public String boardListGet(Model model, PageVO pVO) {
		pVO.setSection("board");
		pVO = paginatino.pagination(pVO);
		
		List<BoardVO> vos = boardService.getBoardList(pVO.getStartIndexNo(), pVO.getPageSize());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pVO", pVO);
		
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
		// 게시글 내용에 이미지가 있다면
		if(vo.getContent().indexOf("src=\"/") != -1) {
			// 이미지를 board로 복사.
			boardService.imgCheck(vo.getContent());
			// 이미지 복사를 모두 마치면, 게시글의 ckeditor경로를 board로 변경시킨다.
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));
		}
		// 그림 정리가 모두 끝나면 변경된 내용을 vo에 담아서 DB에 저장한다.
		int res = boardService.setBoardInput(vo);
		if(res != 0) return "redirect:/Message/boardInputOk";
		else return "redirect:/Message/boardInputNo";
	}
	
	// 게시글 열람.
	@GetMapping("BoardContent")
	public String boardContentGet(HttpSession session, Model model, PageVO pVO, int idx) {
		pVO.setSection("board");
		pVO = paginatino.pagination(pVO);
		
		// 조회수 증가.
		List<String> contentReadNum = (List<String>)session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "board"+session.getAttribute("sMid")+idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			boardService.setBoardReadNum(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		BoardVO vo = boardService.getBoardContent(idx);
		
		// 이전글, 다음글.
		BoardVO preVO = boardService.getPreNextSearch(idx, "preVO");
		BoardVO nextVO = boardService.getPreNextSearch(idx, "nextVO");
		
		model.addAttribute("vo", vo);
		model.addAttribute("pVO", pVO);
		model.addAttribute("preVO", preVO);
		model.addAttribute("nextVO", nextVO);
		
		return "board/boardContent";
	}
	// 좋아요, 싫어요 처리.
	@ResponseBody
	@PostMapping("/BoardGoodCheckPlusMinus")
	public String boardGoodCheckPlusMinusPost(HttpSession session, int idx, int goodCnt) {
		// 세션에 저장한 조회수 증가 리스트 객체 불러온다.
		List<String> contentReadNum = (List<String>)session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "boardGood"+session.getAttribute("sMid")+idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			boardService.setBoardGood(idx, goodCnt);
			// 리스트 객체에 좋아요를 추가.
			contentReadNum.add(imsiContentReadNum);
			return "1";
		}
		return "0";
	}
	
	// 게시글 수정 폼 이동.
	@GetMapping("/BoardUpdate")
	public String boardUpdateGet(Model model, PageVO pVO, int idx) {
		pVO.setSection("board");
		pVO = paginatino.pagination(pVO);
		
		BoardVO vo = boardService.getBoardContent(idx);
		// 원본 글의 이미지 파일 복사(board => ckeditor).
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgBackup(vo.getContent());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pVO", pVO);
		
		return "board/boardUpdate";
	}
	// 게시글 수정.
	@PostMapping("/BoardUpdate")
	public String boardUpdatePost(Model model, PageVO pVO, BoardVO vo) {
		pVO.setSection("board");
		pVO = paginatino.pagination(pVO);
		
		// 수정된 content가 원본자료와 완전히 동일하다면 이미지를 수정할 필요가 없다.
		BoardVO originVO = boardService.getBoardContent(vo.getIdx());
		if(!vo.getContent().equals(originVO.getContent())) {
			// 원본 이미지 삭제(업로드보다 삭제가 빠르기 때문에 삭제 먼저).
			if(originVO.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(originVO.getContent());
			
			// 업로드할 이미지가 있다면 수정 안 하는 이미지 ckeditor로 복사.
			if(vo.getContent().indexOf("src=\"/") != -1) {
				vo.setContent(vo.getContent().replace("/data/board/", "/data/ckeditor/"));
				// ckeditor에 있는 이미지를 board로 업로드.
				boardService.imgCheck(vo.getContent());
				// ckeditor에 있는 이미지 board로 복사.
				vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));
			}
		}
		
		int res = boardService.setBoardUpdate(vo);
		
		if(res != 0) return "redirect:/Message/boardUpdateOk?idx="+vo.getIdx()+"&pag="+pVO.getPag()+"&pageSize="+pVO.getPageSize();
		else return "redirect:/Message/boardUpdateNo?idx="+vo.getIdx()+"&pag="+pVO.getPag()+"&pageSize="+pVO.getPageSize();
	}
}
