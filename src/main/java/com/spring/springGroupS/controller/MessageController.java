package com.spring.springGroupS.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springGroupS.vo.PageVO;

@Controller()
public class MessageController {
	@RequestMapping(value = "/Message/{msgFlag}", method = RequestMethod.GET)
	public String MessageGet(Model model, HttpSession session, PageVO pVO,
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
		else if(msgFlag.equals("memberIdCheckNo")) {
			model.addAttribute("message", "이미 사용중인 아이디입니다.\\n아이디를 확인 후, 다시 회원가입해주세요.");
			model.addAttribute("url", "/member/MemberJoin");
		}
		else if(msgFlag.equals("memberNickNameCheckNo")) {
			model.addAttribute("message", "이미 사용중인 닉네임입니다.\\n닉네임을 확인 후, 다시 회원가입해주세요.");
			model.addAttribute("url", "/member/MemberJoin");
		}
		else if(msgFlag.equals("memberNickCheckNo")) {
			model.addAttribute("message", "이미 사용중인 닉네임입니다.\\n닉네임을 확인 후, 다시 수정해주세요.");
			model.addAttribute("url", "/member/MemberUpdate?mid="+mid);
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("message", "회원가입에 성공했습니다.");
			model.addAttribute("url", "/member/MemberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("message", "회원가입에 실패했습니다.");
			model.addAttribute("url", "/member/MemberJoin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("message", mid+"님 로그인 되었습니다.");
			model.addAttribute("url", "/member/MemberMain");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("message", "로그인에 실패했습니다.");
			model.addAttribute("url", "/member/MemberLogin");
		}
		else if(msgFlag.equals("memberLogoutOk")) {
			model.addAttribute("message", mid+"님 로그아웃 되었습니다.");
			model.addAttribute("url", "/member/MemberLogin");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("message", "관리자 전용 메뉴입니다.");
			model.addAttribute("url", "/member/MemberMain");
		}
		else if(msgFlag.equals("levelNo")) {
			model.addAttribute("message", "등급이 부족합니다.");
			model.addAttribute("url", "/member/MemberMain");
		}
		else if(msgFlag.equals("loginNo")) {
			model.addAttribute("message", "로그인 해주세요.");
			model.addAttribute("url", "/member/MemberLogin");
		}
		else if(msgFlag.equals("pwdChangeOk")) {
			session.invalidate();
			model.addAttribute("message", "비밀번호가 변경되었습니다.");
			model.addAttribute("url", "/member/MemberLogin");
		}
		else if(msgFlag.equals("pwdChangeNo")) {
			model.addAttribute("message", "비밀번호가 변경되지 않았습니다.\\n다시 시도해주세요.");
			model.addAttribute("url", "/member/MemberPwdCheck");
		}
		else if(msgFlag.equals("levelUp")) {
			model.addAttribute("message", "정회원이 되셨습니다.");
			model.addAttribute("url", "/member/MemberMain");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("message", "정보가 수정되었습니다.");
			model.addAttribute("url", "/member/MemberMain");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("message", "정보 수정에 실패했습니다.");
			model.addAttribute("url", "/member/MemberUpdate?mid="+mid);
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("message", "게시글이 작성되었습니다.");
			model.addAttribute("url", "/board/BoardList");
		}
		else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("message", "게시글 작성에 실패했습니다.");
			model.addAttribute("url", "/board/BoardInput");
		}
		else if(msgFlag.equals("boardUpdateOk")) {
			model.addAttribute("message", "게시글을 수정했습니다.");
			model.addAttribute("url", "/board/BoardContent?idx="+idx+"&pag="+pVO.getPag()+"&pageSize="+pVO.getPageSize());
		}
		else if(msgFlag.equals("boardUpdateNo")) {
			model.addAttribute("message", "게시글 수정에 실패했습니다.");
			model.addAttribute("url", "/board/BoardUpdate?idx="+idx+"&pag="+pVO.getPag()+"&pageSize="+pVO.getPageSize());
		}
		return "include/message";
	}
}
