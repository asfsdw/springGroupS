package com.spring.springGroupS.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springGroupS.common.Pagination;
import com.spring.springGroupS.service.PDSService;
import com.spring.springGroupS.vo.PDSVO;
import com.spring.springGroupS.vo.PageVO;

@SuppressWarnings("deprecation")
@Controller
@RequestMapping("/pds")
public class PDSController {
	@Autowired
	Pagination pagination;
	@Autowired
	PDSService pdsService;
	
	// 전체 자료글 리스트.
	@GetMapping("/PDSList")
	public String pdsListGet(Model model, PageVO pVO, PDSVO vo) {
		pVO.setSection("pds");
		pVO = pagination.pagination(pVO);
		
		List<PDSVO> vos = pdsService.getPDSList(pVO.getStartIndexNo(), pVO.getPageSize(), pVO.getPart(), "",  "");
		
		model.addAttribute("vos", vos);
		model.addAttribute("pVO", pVO);
		
		return "pds/pdsList";
	}
	
	// 자료글 쓰기.
	@GetMapping("/PDSInput")
	public String pdsInputGet(Model model, PageVO pVO) {
		pVO.setSection("pds");
		pVO = pagination.pagination(pVO);
		
		model.addAttribute("pVO", pVO);
		
		return "pds/pdsInput";
	}
	@PostMapping("PDSInput")
	public String pdsInputPost(Model model, MultipartHttpServletRequest mFile, PDSVO vo) {
		int res = pdsService.setPDSInput(mFile, vo);
		
		model.addAttribute("pdsVO", vo);
		
		if(res != 0) return "redirect:/Message/pdsInputOk";
		else return "redirect:/Message/pdsInputNo";
	}
	
	// 자료글 보기.
	@GetMapping("/PDSContent")
	public String pdsContentGet(Model model, PageVO pVO, int idx) {
		pVO.setSection("pds");
		pVO = pagination.pagination(pVO);
		
		PDSVO vo = pdsService.getPDSContent(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pVO", pVO);
		
		return "pds/pdsContent";
	}
	// 다운로드 횟수 증가.
	@ResponseBody
	@PostMapping("/DownNumCheck")
	public int downNumCheckPost(int idx) {
		return pdsService.setDownNumCheck(idx);
	}
	// 전체 다운로드.
	@GetMapping("/TotalDownload")
	public String totalDownload(HttpServletRequest request, int idx) throws IOException {
		// 다운로드 횟수 증가.
		pdsService.setDownNumCheck(idx);
		
		// 여러개의 파일을 하나로 통합(zip).
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		PDSVO vo = pdsService.getPDSContent(idx);
		String[] oFileNames = vo.getFName().split("/");
		String[] sFileNames = vo.getFsName().split("/");
		
		String zipPath = realPath+"temp/";
		String zipName = vo.getTitle()+".zip";
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(zipPath+zipName));
		
		byte[] bytes = new byte[2048];
		
		for(int i=0; i<sFileNames.length; i++) {
			fis = new FileInputStream(realPath+sFileNames[i]);
			fos = new FileOutputStream(zipPath+sFileNames[i]);
			
			int data = 0;
			while((data = fis.read(bytes, 0, bytes.length)) != -1) {
				fos.write(bytes, 0, data);
			}
			fos.flush();
			fos.close();
			fis.close();
			
			File copyFile = new File(zipPath+sFileNames[i]);
			fis = new FileInputStream(copyFile);
			zos.putNextEntry(new ZipEntry(oFileNames[i]));
			while((data = fis.read(bytes, 0, bytes.length)) != -1) {
				zos.write(bytes, 0, data);
			}
			zos.flush();
			zos.closeEntry();
			fis.close();
		}
		zos.close();
		return "redirect:/FileDownAction?path=pds&file="+java.net.URLEncoder.encode(zipName);
	}
	
	// 자료글 삭제.
	@ResponseBody
	@PostMapping("/DeleteCheck")
	public int deleteCheckPost(HttpServletRequest request, int idx, String fsName) {
		return pdsService.setDeleteCheck(request, idx, fsName);
	}
	
	// 자료글 찾기.
	@GetMapping("/PDSSearchList")
	public String pdsSearchListGet(Model model, PageVO pVO) {
		pVO.setSection("pds");
		pVO = pagination.pagination(pVO);
		
		model.addAttribute("pVO", pVO);
		
		return "pds/pdsSearchList";
	}
}
