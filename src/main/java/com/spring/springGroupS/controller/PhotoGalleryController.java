package com.spring.springGroupS.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.springGroupS.common.Pagination;
import com.spring.springGroupS.common.ProjectProvide;
import com.spring.springGroupS.service.PhotoGalleryService;
import com.spring.springGroupS.vo.PhotoGalleryVO;

@Controller
@RequestMapping("/photoGallery")
public class PhotoGalleryController {
	
	@Autowired
	PhotoGalleryService photoGalleryService;
	
	@Autowired
	ProjectProvide projectProvide;
	
	@Autowired
	Pagination pagination;
	
	// 사진 여러장 보기 List
	@GetMapping("/photoGalleryList")
	public String photoGalleryListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="choice", defaultValue = "최신순", required = false) String choice
		) {
		int startIndexNo = (pag - 1) * pageSize;
		
		String imsiChoice = "";
		if(choice.equals("최신순")) imsiChoice = "idx";
		else if(choice.equals("추천순")) imsiChoice = "goodCount";
		else if(choice.equals("조회순")) imsiChoice = "readNum";
		else if(choice.equals("댓글순")) imsiChoice = "replyCnt";	
		else imsiChoice = choice;
		
		//PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "photoGallery", part, choice);
		List<PhotoGalleryVO> vos = photoGalleryService.getPhotoGalleryList(startIndexNo, pageSize, part, imsiChoice);
		model.addAttribute("vos", vos);
		model.addAttribute("part", part);
		model.addAttribute("choice", choice);
		return "photoGallery/photoGalleryList";
	}
	
	// 사진 여러장보기에서, 한화면 마지막으로 이동했을때 다음 페이지 스크롤하기
	@ResponseBody
	@PostMapping("/photoGalleryListPaging")
	public ModelAndView photoGalleryPagingPost(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="choice", defaultValue = "최신순", required = false) String choice
		) {
		int startIndexNo = (pag - 1) * pageSize;
		
		String imsiChoice = "";
		if(choice.equals("최신순")) imsiChoice = "idx";
		else if(choice.equals("추천순")) imsiChoice = "goodCount";
		else if(choice.equals("조회순")) imsiChoice = "readNum";
		else if(choice.equals("댓글순")) imsiChoice = "replyCnt";	
		else imsiChoice = choice;
		
		//PageVO pageVO = pagiNation.pagiNation(pag, pageSize, "photoGallery", part, choice);
		List<PhotoGalleryVO> vos = photoGalleryService.getPhotoGalleryList(startIndexNo, pageSize, part, imsiChoice);
		model.addAttribute("vos", vos);
		model.addAttribute("part", part);
		model.addAttribute("choice", choice);
		
		// ModelAndView에 담아서 return
		ModelAndView mv = new ModelAndView();
		mv.setViewName("photoGallery/photoGalleryListPaging");
		return mv;
	}
	
	// 사진 한장씩 전체 보기(나중에 올린순으로 보기)
	@GetMapping("/photoGallerySingle")
	public String photoGallerySingleGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "1", required = false) int pageSize
		) {
		int startIndexNo = (pag - 1) * pageSize;
		List<PhotoGalleryVO> vos = photoGalleryService.setPhotoGallerySingle(startIndexNo, pageSize);
		model.addAttribute("vos", vos);
		return "photoGallery/photoGallerySingle";
	}
	
	// 사진 한장씩 전체 보기(나중에 올린순으로 보기) - 한화면 마지막으로 이동했을때 다음 페이지 스크롤하기
	@ResponseBody
	@PostMapping("/photoGallerySinglePaging")
	public ModelAndView photoGallerySinglePagingPost(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "1", required = false) int pageSize
		) {
		int startIndexNo = (pag - 1) * pageSize;
		List<PhotoGalleryVO> vos = photoGalleryService.setPhotoGallerySingle(startIndexNo, pageSize);
		model.addAttribute("vos", vos);
		
	  // ModelAndView에 담아서 return
		ModelAndView mv = new ModelAndView();
		mv.setViewName("photoGallery/photoGallerySinglePaging");
		return mv;
	}
	
	// 포토갤러리 사진 등록하기 폼보기
	@GetMapping("/photoGalleryInput")
	public String photoGalleryInputGet() {
		return "photoGallery/photoGalleryInput";
	}
	
	// 포토갤러리 사진 등록처리
	@PostMapping("/photoGalleryInput")
	public String photoGalleryInputPost(PhotoGalleryVO vo, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		int res = photoGalleryService.imgCheck(vo, realPath);
		if(res != 0) return "redirect:/Message/photoGalleryInputOk";
		else return "redirect:/Message/photoGalleryInputNo";
	}
	
	// 개별항목 상세보기
	@SuppressWarnings("unchecked")
	@GetMapping("/photoGalleryContent")
	public String photoGalleryContentGet(HttpSession session, int idx, Model model, HttpServletRequest request) {
		// 게시글 조회수 1씩 증가시키기(중복방지)
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "photoGallery" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			photoGalleryService.setPhotoGalleryReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);

		// 조회자료 1건 담아서 내용보기로 보낼 준비
		PhotoGalleryVO vo = photoGalleryService.getPhotoGalleryIdxSearch(idx);
		model.addAttribute("vo", vo);
		
		// ckeditor의 사진정보만 뽑아서 넘겨주기(content화면에서 여러장의 사진을 보이고자 함)
		List<String> photoList = photoGalleryService.getPhotoGalleryPhotoList(vo.getContent());
		//model.addAttribute("photoList", photoList);
		request.setAttribute("photoList", photoList);
		
		// 댓글 처리
		ArrayList<PhotoGalleryVO> replyVos = photoGalleryService.getPhotoGalleryReply(idx);
		model.addAttribute("replyVos", replyVos);
		
		return "photoGallery/photoGalleryContent";
	}

	// 댓글달기
	@ResponseBody
	@PostMapping("/photoGalleryReplyInput")
	public int photoGalleryReplyInputPost(PhotoGalleryVO vo) {
		return photoGalleryService.setPhotoGalleryReplyInput(vo);
	}
	
	// 댓글 삭제
	@ResponseBody
	@PostMapping("/photoGalleryReplyDelete")
	public int photoGalleryReplyDeletePost(int idx) {
		return photoGalleryService.setPhotoGalleryReplyDelete(idx);
	}
	
	// 좋아요수 증가
	@SuppressWarnings("unchecked")
	@ResponseBody
	@PostMapping("/photoGalleryGoodCheck")
	public int photoGalleryGoodCheckPost(HttpSession session, int idx) {
		int res = 0;
		// 좋아요 클릭수 1씩 증가시키기(중복방지)
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentGood");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "photoGallery" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			photoGalleryService.setPhotoGalleryGoodPlus(idx);
			contentReadNum.add(imsiContentReadNum);
			res = 1;
		}
		session.setAttribute("sContentGood", contentReadNum);
		return res;
	}

	// 내용 삭제하기
	@GetMapping("/photoGalleryDelete")
	public String photoGalleryDeleteGet(int idx) {
		photoGalleryService.setPhotoGalleryDelete(idx);
	  return "redirect:/Message/photoGalleryDeleteOk";
	}
	
	// 내용 수정하기 폼보기
	@GetMapping("/photoGalleryUpdate")
	public String photoGalleryUpdateGet(Model model, int idx) {
		PhotoGalleryVO vo = photoGalleryService.getPhotoGalleryIdxSearch(idx);
		
		photoGalleryService.imgBackup(vo.getContent());	// 수정화면으로 들어갈때, 현재폴더(photoGallery)에서 그림파일파일을 ckeditor폴더로 복사한다.
		
		model.addAttribute("vo" , vo);
		return "photoGallery/photoGalleryUpdate";
	}
	
	// 내용 수정하기
	@PostMapping("/photoGalleryUpdate")
	public String boardUpdatePost(Model model, PhotoGalleryVO vo, HttpServletRequest request) {
		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없다.(DB자료와 수정자료를 비교한다.)
		PhotoGalleryVO origVO = photoGalleryService.getPhotoGalleryIdxSearch(vo.getIdx());
		
		// content내용중에서 조금이라도 수정한 것이 있다면 사진에 대한 처리를 한다.
		int res = 0;
		if(!origVO.getContent().equals(vo.getContent())) {
			// 1. 기존 PhotoGallery폴더(origVO를 확인)에 그림파일이 존재했다면 원본 그림파일(origVO)삭제처리
			if(origVO.getContent().indexOf("src=\"/") != -1) photoGalleryService.imgDelete(origVO.getContent());
			
			// content필드내용중 이미지 경로는 현재 photoGallery로 설정되어 있기에, photoGallery폴더를 ckeditor로 변경처리한다.
			// 처음 입력시 사진은 ckeditor폴더에 있어야 하고, 수정처리를 했던, 하지않았던 원본그림도 ckeditor폴더에 복사해 두었다.
			vo.setContent(vo.getContent().replace("/data/photoGallery/", "/data/ckeditor/"));
			
			// 2. photoGallery폴더의 그림파일 삭제 완료후(그림파일이 존재시), 입력시 작업과 같은 작업(ckeditor폴더에서 photoGallery폴더로 복사)을 수행처리한다.
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
			res = photoGalleryService.imgCheck(vo, realPath);
			
			// 3.이미지 작업(복사작업)을 모두 마치면, ckeditor폴더경로를 photoGallery폴더로 변경시킨다.
			//vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/photoGallery/"));
		}
		// 수정된 내용들을 DB에 업데이트 처리한다.
		//res = photoGalleryService.setPhotoGallery(vo);
		
		//model.addAttribute("idx", vo.getIdx());
		//model.addAttribute("pageVO", pageVO);		// redirect는 객체는 온전하게 넘어가지 않는다. 즉, 아래처럼 풀어서 넘겨야 한다.
		
		if(res != 0) return "redirect:/Message/photoGalleryUpdateOk";
		else return "redirect:/Message/photoGalleryUpdateNo?idx="+vo.getIdx();
	}
	
}
