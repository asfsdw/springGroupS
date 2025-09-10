package com.spring.springGroupS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller()
public class MessageController {
	@RequestMapping(value = "/Message/{msgFlag}", method = RequestMethod.GET)
	public String MessageGet(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "", required = false) String idx) {
		if(msgFlag.equals("hoewonInputOk")) {
			model.addAttribute("message", mid+"님 회원가입되었습니다.");
			model.addAttribute("url", "study1/mapping/Test35?mid="+mid);
		}
		else if(msgFlag.equals("hoewonInputNo")) {
			model.addAttribute("message", "회원가입에 실패했습니다.");
			model.addAttribute("url", "study1/mapping/Menu");
		}
		else if(msgFlag.equals("userInputOk")) {
			model.addAttribute("message", mid+"님 회원가입되었습니다.");
			model.addAttribute("url", "dbTest2/UserList");
		}
		else if(msgFlag.equals("userInputNo")) {
			model.addAttribute("message", "회원가입에 실패했습니다.");
			model.addAttribute("url", "dbTest2/UserList");
		}
		else if(msgFlag.equals("userDeleteOk")) {
			model.addAttribute("message", "회원이 삭제되었습니다.");
			model.addAttribute("url", "dbTest2/UserList");
		}
		else if(msgFlag.equals("userDeleteNo")) {
			model.addAttribute("message", "회원삭제에 실패했습니다.");
			model.addAttribute("url", "dbTest2/UserList");
		}
		else if(msgFlag.equals("userUpdateOk")) {
			model.addAttribute("message", mid+"님의 회원 정보가 수정되었습니다.");
			model.addAttribute("url", "/dbTest2/UserList");
		}
		else if(msgFlag.equals("userUpdateNo")) {
			model.addAttribute("message", "회원 정보 수정에 실패했습니다.");
			model.addAttribute("url", "/dbTest2/UserUpdate?idx="+idx);
		}
		else if(msgFlag.equals("userSearchNo")) {
			model.addAttribute("message", "찾으시는 "+mid+"회원이 존재하지 않습니다.");
			model.addAttribute("url", "/dbTest2/UserList");
		}
		else if(msgFlag.equals("guestInputOk")) {
			model.addAttribute("message", "방명록이 작성되었습니다.");
			model.addAttribute("url", "/guest/GuestList");
		}
		else if(msgFlag.equals("guestInputNo")) {
			model.addAttribute("message", "방명록 작성에 실패했습니다.");
			model.addAttribute("url", "/guest/GuestInput");
		}
		else if(msgFlag.equals("guestDeleteOk")) {
			model.addAttribute("message", "방명록이 삭제되었습니다.");
			model.addAttribute("url", "/guest/GuestList");
		}
		else if(msgFlag.equals("guestDeleteNo")) {
			model.addAttribute("message", "방명록 삭제에 실패했습니다.");
			model.addAttribute("url", "/guest/GuestList");
		}
		else if(msgFlag.equals("adminOk")) {
			model.addAttribute("message", "관리자 인증되었습니다.");
			model.addAttribute("url", "/guest/GuestList");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("message", "관리자 전용 메뉴입니다.");
			model.addAttribute("url", "/guest/GuestList");
		}
		else if(msgFlag.equals("adminLogout")) {
			model.addAttribute("message", "관리자님 로그아웃되었습니다.");
			model.addAttribute("url", "/guest/GuestList");
		}
		else if(msgFlag.equals("mailSendOk")) {
			model.addAttribute("message", "메일이 전송되었습니다.");
			model.addAttribute("url", "/study1/mail/MailForm");
		}
		else if(msgFlag.equals("fileUploadOk")) {
			model.addAttribute("message", "파일이 업로드되었습니다.");
			model.addAttribute("url", "/study1/fileUpload/FileUploadForm");
		}
		else if(msgFlag.equals("fileUploadNo")) {
			model.addAttribute("message", "파일 업로드에 실패했습니다.");
			model.addAttribute("url", "/study1/fileUpload/FileUploadForm");
		}
		return "include/message";
	}
}
