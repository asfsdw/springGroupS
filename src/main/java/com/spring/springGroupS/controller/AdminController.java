package com.spring.springGroupS.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS.common.Pagination;
import com.spring.springGroupS.service.AdminService;
import com.spring.springGroupS.service.BoardService;
import com.spring.springGroupS.service.GuestService;
import com.spring.springGroupS.service.MemberService;
import com.spring.springGroupS.vo.BoardVO;
import com.spring.springGroupS.vo.ComplaintVO;
import com.spring.springGroupS.vo.GuestVO;
import com.spring.springGroupS.vo.InquiryReplyVO;
import com.spring.springGroupS.vo.InquiryVO;
import com.spring.springGroupS.vo.MemberVO;
import com.spring.springGroupS.vo.PageVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	Pagination pagination;
	@Autowired
	AdminService adminService;
	@Autowired
	MemberService memberService;
	@Autowired
	GuestService guestService;
	@Autowired
	BoardService boardService;
	
	// 관리자 메뉴.
	@GetMapping("/AdminMain")
	public String adminMainGet(Model model, String flag) {
		// flag != null이면 limit 1이 mapper에서 안 보이는 구조(if).
		List<GuestVO> gVOS = guestService.getNewGuestList(flag);
		List<MemberVO> mVOS = memberService.getNewMemberList(flag);
		List<BoardVO> bVOS = boardService.getNewBoardList(flag);
		List<ComplaintVO> cVOS = adminService.getNewBoardList(flag);
		
		int memberNewCount = 0;
		int cancelMember = 0;
		int guestNewCount = 0;
		int boardNewCount = 0;
		int complaintNewCount = 0;
		
		// gVOS의 검색결과가 있으면 건 수 갱신.
		if(!gVOS.isEmpty()) guestNewCount = gVOS.get(0).getNewCount();
		// mVOS의 검색결과가 있으면 건 수 갱신.
		if(!mVOS.isEmpty()) {
			memberNewCount = mVOS.get(0).getNewCount();
			// 탈퇴대기중인 회원 건 수.
			cancelMember = mVOS.get(0).getCancelMember();
		}
		// bVOS의 검색결과가 있으면 건 수 갱신.
		if(!bVOS.isEmpty()) boardNewCount = bVOS.get(0).getNewCount();
		// cVOS의 검색결과가 있으면 건 수 갱신.
		if(!cVOS.isEmpty()) complaintNewCount = cVOS.get(0).getNewCount();
		
		model.addAttribute("guestNewCount", guestNewCount);
		model.addAttribute("memberNewCount", memberNewCount);
		model.addAttribute("cancelMember", cancelMember);
		model.addAttribute("boardNewCount", boardNewCount);
		model.addAttribute("complaintNewCount", complaintNewCount);
		
		return "admin/adminMain";
	}
	@GetMapping("/AdminLeft")
	public String adminLeftGet() {
		return "admin/adminLeft";
	}
	@GetMapping("/AdminContent")
	public String adminContentGet() {
		return "admin/adminContent";
	}
	
	//관리자 메뉴에서 방명록 리스트 보여주기.
	@GetMapping("/guest/GuestList")
	// pagination 사용자 정의 메소드 부를 때 방명록 목록에서 주는 값(pag, pageSize 등)을 넣어주기 위해 PageVO로 받는다.
	public String guestListGet(Model model, PageVO vo) {
		// pagination 처리.
		vo.setSection("guest");
		vo = pagination.pagination(vo);
		
		// flag가 null이거나 공백이면 전체 리스트를 vos에 담는다. flag가 null이 아니면 최근 7일의 리스트를 vos에 담는다.
		List<GuestVO> vos = null;
		if(vo.getFlag().equals("")) vos = guestService.getGuestList(vo.getStartIndexNo(), vo.getPageSize());
		else vos = guestService.getNewGuestList(vo.getFlag());
		
		model.addAttribute("gVO", vo);
		model.addAttribute("vos", vos);
		
		return "admin/guest/guestList";
	}
	
	//관리자 메뉴에서 게시판 보여주기.
	@GetMapping("/board/BoardList")
	public String boardListGet(Model model, PageVO vo) {
		vo.setSection("board");
		vo = pagination.pagination(vo);
		
		List<BoardVO> vos = null;
		if(vo.getFlag().equals("")) vos = boardService.getBoardList(vo.getStartIndexNo(), vo.getPageSize(), "", "");
		else vos = boardService.getNewBoardList(vo.getFlag());
		
		model.addAttribute("vos", vos);
		model.addAttribute("bVO", vo);
		
		return "admin/board/BoardList";
	}
	//신고글 목록.
	@GetMapping("/complaint/ComplaintList")
	public String complaintListGet(Model model, PageVO pVO, ComplaintVO vo) {
		pVO.setSection("admin");
		pVO = pagination.pagination(pVO);
		
		List<ComplaintVO> vos = adminService.getComplaintList(pVO.getStartIndexNo(), pVO.getPageSize(), vo.getFlag());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pVO", pVO);
		
		return "admin/complaint/complaintList";
	}
	// 신고글 내용보기.
	@GetMapping("/complaint/ComplaintContent")
	public String complaintContentGet(Model model, PageVO pVO, ComplaintVO vo) {
		pVO.setSection("admin");
		pVO = pagination.pagination(pVO);
		
		vo = adminService.getComplaintContent(vo.getPartIdx());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pVO", pVO);
		
		return "admin/complaint/complaintContent";
	}
	// 신고 처리.
	@ResponseBody
	@PostMapping("/complaint/ComplaintProgress")
	public int complaintProgressPost(Model model, PageVO pVO, ComplaintVO vo) {
		pVO.setSection("admin");
		pVO = pagination.pagination(pVO);
		
		int res = 0;
		
		if(vo.getComplaintSW().equals("D")) {
			res = adminService.setComplaintDelete(vo.getPart(), vo.getPartIdx());
			vo.setComplaintSW("처리완료(D)");
		}
		else if(vo.getComplaintSW().equals("H")) {
			res = adminService.setComplaintPrgress(vo.getPart(), vo.getPartIdx(), "HI");
			vo.setComplaintSW("처리중(H)");
		}
		else if(vo.getComplaintSW().equals("M")) {
			res = adminService.setComplaintPrgress(vo.getPart(), vo.getPartIdx(), "DE");
			vo.setComplaintSW("처리중(M)");
		}
		else {
			res = adminService.setComplaintPrgress(vo.getPart(), vo.getPartIdx(), "NO");
			vo.setComplaintSW("처리완료(S)");
		}
		if(res != 0) adminService.setComplaintProgressOk(vo.getIdx(), vo.getComplaintSW());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pVO", pVO);
		
		return res;
	}
	
	// 자료 관리 폼.
	@GetMapping("/folder/FileManagement")
	public String fileManagementGet(HttpServletRequest request, Model model, PageVO pVO) {
		// part를 넣기위해 설정.
		pVO = pagination.pagination(pVO);
		
		String realPath = "";
		if(pVO.getPart().equals("전체")) realPath = request.getSession().getServletContext().getRealPath("/resources/data");
		else realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+pVO.getPart());
		
		String[] files = new File(realPath).list();
		
		// 파일의 총 수.
		pVO.setTotRecCnt(files.length);
		// totPage를 구하기 위해 다시 설정.
		pVO = pagination.pagination(pVO);
		
		// 페이징 처리.
		// 한 페이지에 보여줄 파일 정보를 담을 배열 생성(크기는 전체 파일 갯수만큼).
		String[] file = new String[files.length];
		// startIndexNo(pag-1 * pageSize)부터 startIndexNo+pageSize만큼 반복문을 돌린다.
		// pag=1, pageSize=10일 경우(0~9까지. pag=2일 경우 10~20까지.)
		for(int i=pVO.getStartIndexNo(); i<pVO.getStartIndexNo()+pVO.getPageSize(); i++) {
			// i가 전체 파일 갯수보다 작을 때까지만 돌려야한다(배열의 인덱스는 0부터 시작하고 length는 1부터 시작하니까).
			if(i < files.length) file[i] = files[i];
			// i가 전체 파일 갯수보다 크면 반복문 탈출.
			else break;
		}
		
		model.addAttribute("pVO", pVO);
		model.addAttribute("files", file);
		
		return "admin/folder/fileManagement";
	}
	@ResponseBody
	@PostMapping("/folder/FileManagement")
	public int fileManagementPost(HttpServletRequest request, Model model, PageVO pVO, String fileName, String fNames) {
		// fileName = 삭제버튼으로 파일을 삭제할 경우의 파일이름. fNames = 선택삭제로 파일을 삭제할 경우의 파일이름.
		int res = 0;
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+pVO.getPart()+"/");
		String[] fName = null;
		// 삭제할 파일이 여러개일 때.
		if(fNames.contains("/")) {
			fName = fNames.split("/");
		}
		
		// 삭제 버튼으로 삭제했을 때.
		if(fileName != "") {
			File file = new File(realPath+fileName);
			if(!file.isDirectory()) file.delete();
			res = 1;
		}
		// 여러 파일 삭제.
		else if(fName != null) {
			for(int i=0; i<fName.length; i++) {
				File file = new File(realPath+fName[i]);
				if(!file.isDirectory()) file.delete();
			}
			res = 1;
		}
		// 선택을 하나만 했을 경우.
		else {
			if(!fNames.contains("/")) {
				File file = new File(realPath+fNames);
				if(!file.isDirectory()) file.delete();
			}
			res = 1;
		}
		
		model.addAttribute("pVO", pVO);
		
		return res;
	}

	// 관리자 메뉴에서 회원 리스트 보여주기.
	@GetMapping("/member/MemberList")
	public String memberListGet(Model model, PageVO vo,
			@RequestParam(name = "level", defaultValue = "100", required = false) int level) {
		vo.setSection("member");
		vo = pagination.pagination(vo);
		
		List<MemberVO> vos = null;
		// flag가 공백이면 전체 리스트를 vos에 담는다. flag가 공백이 아니면 최근 7일의 리스트를 vos에 담는다.
		if(vo.getFlag().equals("")) vos = memberService.getMemberList(vo.getStartIndexNo(), vo.getPageSize(), level);
		else vos = memberService.getNewMemberList(vo.getFlag());
		
		model.addAttribute("vos", vos);
		model.addAttribute("mVO", vo);
		
		return "admin/member/memberList";
	}
	// 회원 리스트에서 회원의 등급 변경.
	@ResponseBody
	@PostMapping("/member/MemberLevelChange")
	public int memberLevelChangePost(int idx, int level) {
		return memberService.setMemberLevelUp(idx, level);
	}
	// 회원 리스트에서 선택한 회원의 등급 변경.
	@ResponseBody
	@PostMapping("/member/MemberLevelSelectChange")
	public int memberLevelSelectChangePost(String idxCheckedArray, int levelSelect) {
		return adminService.setMemberLevelSelectChange(idxCheckedArray, levelSelect);
	}
	// 회원 리스트에서 탈퇴신청 중이며 마지막 접속일에서 30일 이상 경과한 회원 삭제.
	@ResponseBody
	@PostMapping("/member/MemberDelete")
	public int memberDeletePost(int idx) {
		return adminService.memberDeleteGet(idx);
	}
	
	//관리자 1:1 리스트 보여주기
	@GetMapping("/inquiry/adInquiryList")
	public String adInquiryListGet(
			@RequestParam(name="part", defaultValue="전체", required=false) String part,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
	    @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
			Model model) {
		PageVO pageVO = new PageVO();
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setPart(part);
		pageVO.setSection("adminInquiry");
		pageVO = pagination.pagination(pageVO);
		
		ArrayList<InquiryVO> vos = adminService.getInquiryListAdmin(pageVO.getStartIndexNo(), pageSize, part);
   
		model.addAttribute("vos", vos);
	  model.addAttribute("pageVO", pageVO);
	  model.addAttribute("part", part);
		
		return "admin/inquiry/adInquiryList";
	}
	
	// 관리자 답변달기 폼 보여주기(관리자가 답변글 수정/삭제처리하였을때도 함께 처리하고 있다.)
	@GetMapping("/inquiry/adInquiryReply")
	public String adInquiryReplyGet(Model model, int idx,
			@RequestParam(name="part", defaultValue="전체", required=false) String part,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
	    @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
	    @RequestParam(name="replySw", defaultValue="", required=false) String replySw
		) {
		InquiryVO vo = adminService.getInquiryContent(idx);
		InquiryReplyVO reVO = adminService.getInquiryReplyContent(idx);
		
		model.addAttribute("part", part);
		model.addAttribute("pag", pag);
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("replySw", replySw);
		return "admin/inquiry/adInquiryReply";
	}
	
	// 관리자 답변달기 저장하기
	@Transactional
	@ResponseBody
	@PostMapping("/inquiry/adInquiryReplyInput")
	public int adInquiryReplyInputPost(InquiryReplyVO vo) {
		int res = 0;
		res = adminService.setInquiryInputAdmin(vo);
		if(res != 0) adminService.setInquiryUpdateAdmin(vo.getInquiryIdx());
		
		return res;
	}
	
	// 관리자 답변글 수정처리
	@PostMapping("/inquiry/adInquiryReply")
	public String adInquiryReplyUpdatePost(InquiryReplyVO reVO) {
		int res = adminService.setInquiryReplyUpdate(reVO);	// 관리자가 답변글을 수정했을때 처리루틴
		
		if(res != 0) return "redirect:/Message/adInpuiryReplyUpdateOk?idx="+reVO.getInquiryIdx();
		return "redirect:/Message/adInpuiryReplyUpdateNo?idx="+reVO.getInquiryIdx();
	}
	
	// 답변글만 삭제하기(답변글을 삭제처리하면 원본글의 '상태'는 '답변대기중'으로 수정해준다.
	@Transactional
	@ResponseBody
	@PostMapping("/inquiry/adInquiryReplyDelete")
	public int adInquiryReplyDeletePost(int inquiryIdx, int reIdx) {
		adminService.setAdInquiryReplyDelete(reIdx);
		return adminService.setInquiryReplyStatusUpdate(inquiryIdx);
	}
	
	// 관리자 원본글과 답변글 삭제처리(답변글이 있을경우는 답변글 먼저 삭제후 원본글을 삭제처리한다.)
	@Transactional
	@RequestMapping(value="/inquiry/adInquiryDelete", method = RequestMethod.GET)
	public String adInquiryDeleteGet(Model model, int idx, String fSName, int reIdx, int pag) {
		//adminService.setAdInquiryReplyDelete(reIdx);	// 관리자가 현재글을 삭제했을때 먼저 답변글을 삭제처리해준다.
		adminService.setAdInquiryDelete(idx, fSName, reIdx); // 답변글 삭제처리가 끝나면 원본글을 삭제처리해준다. (답변글삭제와 원본글 삭제를 동시에 처리한다.)
		model.addAttribute("pag", pag);
		return "redirect:/Message/adInquiryDeleteOk";
	}
}
