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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS.common.Pagination;
import com.spring.springGroupS.service.AdminService;
import com.spring.springGroupS.service.BoardService;
import com.spring.springGroupS.vo.BoardReplyVO;
import com.spring.springGroupS.vo.BoardVO;
import com.spring.springGroupS.vo.ComplaintVO;
import com.spring.springGroupS.vo.PageVO;

@SuppressWarnings("unchecked")
@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	Pagination paginatino;
	@Autowired
	BoardService boardService;
	@Autowired
	AdminService adminService;
	
	// 게시글 전체 보기.
	@GetMapping("/BoardList")
	public String boardListGet(Model model, PageVO pVO) {
		pVO.setSection("board");
		pVO = paginatino.pagination(pVO);
		
		List<BoardVO> vos = boardService.getBoardList(pVO.getStartIndexNo(), pVO.getPageSize(), "", "");
		
		model.addAttribute("vos", vos);
		model.addAttribute("pVO", pVO);
		
		return "board/boardList";
	}
	
	// 게시글 검색.
	@GetMapping("/BoardSearchList")
	public String boardSearchListPost(Model model, PageVO pVO) {
		pVO.setSection("board");
		pVO = paginatino.pagination(pVO);
		
		List<BoardVO> vos = boardService.getBoardList(pVO.getStartIndexNo(), pVO.getPageSize(), pVO.getSearch(), pVO.getSearchStr());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pVO", pVO);
		
		return "board/boardSearchList";
	}
	
	// 게시글 쓰기 폼 이동.
	@GetMapping("/BoardInput")
	public String boardInputGet() {
		return "board/boardInput";
	}
	// 게시글 쓰기.
	@PostMapping("/BoardInput")
	public String boardInputPost(BoardVO vo) {
		// 제목에 대하여 html 태그를 사용할 수 없도록 처리.
		String title = vo.getTitle();
		title = title.replace("<", "&lt");
		title = title.replace(">", "&gt");
		vo.setTitle(title);
		
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
	@GetMapping("/BoardContent")
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
		
		// 댓글 가져오기.
		List<BoardReplyVO> replyVOS = boardService.getBoardReplyList(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pVO", pVO);
		model.addAttribute("replyVOS", replyVOS);
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
	
  // 댓글 처리.
  @ResponseBody
  @PostMapping("/BoardReplyInput") public int boardReplyInputPost(BoardReplyVO replyVO,
  		@RequestParam(name="replyIdx",defaultValue = "0", required = false) int replyIdx) {
  	// DB에서 default를 줘도 불러올 때는 아직 db를 거치지 않아서 0이 들어오기 때문에 기초치를 줘야한다.
  	replyVO.setRef(1);
  	replyVO.setRe_step(1);
  	replyVO.setRe_order(1);
  	
	  // 부모댓글은 re_step=1, re_order=1. 단, 대댓글의 경우는 부모댓글보다 큰 re_order전부 +1, 자신은 부모댓글의 re_step, re_order +1처리.
	  BoardReplyVO replyParentVO = boardService.getBoardParentReplyCheck(replyVO.getBoardIdx());
	  
	  // 대댓글이면 re_step, re_order +1.
	  if(replyVO.getFlag() != null) {
		  // 대댓글의 부모 idx를 받아와서 설정.
		  BoardReplyVO parentReplyVO = boardService.getBoardParentReplyIdxCheck(replyIdx);
		  
		  replyVO.setRef(parentReplyVO.getRef()+1);
		  // 부모의 re_order보다 큰 re_order +1. 단, 같은 boardIdx에 한해서.
		  boardService.setBoardReplyOrderUp(parentReplyVO.getBoardIdx(), parentReplyVO.getRe_order());
		  
		  // 자기 re_step, re_order는 부모 +1.
		  replyVO.setRe_step(parentReplyVO.getRe_step()+1);
		  replyVO.setRe_order(parentReplyVO.getRe_order()+1);
	  }
	  // 첫댓글이면 re_order =1.
	  else if(replyParentVO != null) replyVO.setRe_order(replyParentVO.getRe_order()+1);
	  
	  return boardService.setBoardReplyInput(replyVO);
  }
	 
	// 댓글 삭제.
	@ResponseBody
	@PostMapping("/BoardReplyDelete")
	public int boardReplyDeletePost(int idx) {
		return boardService.setBoardReplyDelete(idx);
	}
	// 댓글 수정.
	@ResponseBody
	@PostMapping("/BoardReplyUpdate")
	public int boardReplyUpdatePost(BoardReplyVO replyVO) {
		return boardService.setBoardReplyUpdate(replyVO);
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
		
		String title = vo.getTitle();
		title = title.replace("<", "&lt");
		title = title.replace(">", "&gt");
		vo.setTitle(title);

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
		
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("pag", pVO.getPag());
		model.addAttribute("pageSize", pVO.getPageSize());
		model.addAttribute("search", pVO.getSearch());
		model.addAttribute("searchStr", pVO.getSearchStr());
		
		if(res != 0) return "redirect:/Message/boardUpdateOk";
		else return "redirect:/Message/boardUpdateNo";
	}
	
	// 게시글 삭제.
	@GetMapping("/BoardDelete")
	public String boardDeleteGet(Model model, PageVO pVO, BoardVO vo) {
		vo = boardService.getBoardContent(vo.getIdx());
		
		// 게시글에 src가 존재하면 삭제.
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(vo.getContent());
		
		// src를 삭제한 후, DB에서 게시글 삭제.
		int res = boardService.setBoardDelete(vo.getIdx());
		
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("pag", pVO.getPag());
		model.addAttribute("pageSize", pVO.getPageSize());
		model.addAttribute("search", pVO.getSearch());
		model.addAttribute("searchStr", pVO.getSearchStr());
		
		if(res != 0) return "redirect:/Message/boardDeleteOk";
		else return "redirect:/Message/boardDeleteNo";
	}
	
	// 게시글 신고.
	@ResponseBody
	@PostMapping("/BoardComplaintInput")
	public int boardComplaintInputPost(ComplaintVO vo) {
		int res = 0;
		res = adminService.setBoardComplaintInput(vo);
		if(res != 0) adminService.setBoardTableComplaintOk(vo.getPartIdx());
		return res;
	}
}
