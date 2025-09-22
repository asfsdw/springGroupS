package com.spring.springGroupS.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

//@Slf4j
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = {"/","h","index"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		// trace < debug < error < warn < info
		logger.info("info : Welcome home! The client locale is {}.", locale);
//		logger.warn("warn : Welcome home! The client locale is {}.", locale);
//		logger.error("error: Welcome home! The client locale is {}.", locale);
//		logger.debug("debug: Welcome home! The client locale is {}.", locale);
//		
//		System.out.println("=".repeat(60));
//		// lomvok에서 제공하는 slf4j 라이브러리 사용.
//		log.info("lombok info :");
//		log.warn("lombok warn :");
//		log.error("lombok error:");
//		log.debug("lombok debug:");
//		log.trace("lombok trace:");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	@PostMapping("/ImageUpload")
	public void imageUploadPost(MultipartFile upload, HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		// 확장자 제한처리(이미지파일(jpg,gif,png) + 동영상파일(mp4))
		String regExt = "(jpg|jpeg|gif|png|mp4|webm|ogv)";
		String ext = oFileName.substring(oFileName.lastIndexOf(".")+1);
		if(!ext.matches(regExt)) return;
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date)+"_"+oFileName;
		
		FileOutputStream fos = new FileOutputStream(new File(realPath, oFileName));
		byte[] bytes = upload.getBytes();
		fos.write(bytes);
		
		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath()+"/data/ckeditor/"+oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":\"1\",\"url\":\""+fileUrl+"\"}");
		
		fos.close();
	}
	
	//파일 통합(zip) 다운로드.
	@GetMapping("/FileDownAction")
	public void fileDownActionGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String path = request.getParameter("path");
		String file = request.getParameter("file");
		
		if(path.equals("pds")) path += "/temp/";
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+path);
		File downFile = new File(realPath+file);
		
		if(downFile.exists()) {
			String downLoadName = "";
			if(request.getHeader("user-agent").indexOf("MSIE") == -1) downLoadName = new String(file.getBytes("UTF-8"), "8859_1");
			else downLoadName = new String(file.getBytes("EUC-KR"), "8859_1");
			
			response.setHeader("Content-Disposition", "attachment;filename="+downLoadName);
			
			FileInputStream fis = new FileInputStream(downFile);
			ServletOutputStream sos = response.getOutputStream();
			
			byte[] bytes = new byte[2048];
			int size = 0;
			while((size = fis.read(bytes, 0, bytes.length)) != -1) {
				sos.write(bytes, 0, size);
			}
			sos.flush();
			sos.close();
			fis.close();
			
			downFile.delete();
		}
	}
}
