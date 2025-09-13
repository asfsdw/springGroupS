package com.spring.springGroupS.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS.common.ProjectProvide;
import com.spring.springGroupS.service.GuestService;
import com.spring.springGroupS.service.MemberService;
import com.spring.springGroupS.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	@Autowired
	MemberService memberService;
	@Autowired
	ProjectProvide projectProvide;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@Autowired
	GuestService guestService;
	
	// 회원가입 폼 이동.
	@GetMapping("/MemberJoin")
	public String memberJoinGet(Model model) {
		return "member/memberJoin"; 
	}
	// 회원가입 가입처리.
	@PostMapping("/MemberJoin")
	public String memberJoinPost(MultipartFile fName, MemberVO vo) {
		// 아이디, 닉네임 중복체크.
		if(memberService.getMemberIdSerach(vo.getMid()) != null) return "redirect:/Message/memberIdCheckNo";
		if(memberService.getMemberNickNameSerach(vo.getNickName()) != null) return "redirect:/Message/memberNickNameCheckNo";
		
		// 비밀번호 암호화(BCryptPasswordEncoder).
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// 프로필 이미지 업로드하지 않았을 경우 noimage.
		if(fName.getOriginalFilename().equals("")) vo.setPhoto("noimage.jpg");
		// 프로필 이미지 등록.
		else vo.setPhoto(projectProvide.fileUpload(fName, vo.getMid(), "member"));
		
		// DB에 회원 정보 저장.
		int res = memberService.setMemberJoin(vo);
		
		if(res != 0) return "redirect:/Message/memberJoinOk";
		else return "redirect:/Message/memberJoinNo";
	}
	
	// 아이디 중복체크.
	@ResponseBody
	@PostMapping("/MemberIdCheck")
	public MemberVO memberIdCheckPost(String mid) {
		return memberService.getMemberIdSerach(mid);
	}
	// 닉네임 중복체크.
	@ResponseBody
	@PostMapping("/MemberNickNameCheck")
	public MemberVO memberNickNameCheckPost(String nickName) {
		return memberService.getMemberNickNameSerach(nickName);
	}
	
	// 이메일로 인증번호 발송.
	@ResponseBody
	@PostMapping("/MemberEmailCheck")
	public int memberEmailCheckPost(HttpSession session, String email) throws MessagingException {
		String emailKey = UUID.randomUUID().toString().substring(0, 8);
		
		// 세션에 인증번호 저장.
		session.setAttribute("sEmailKey", emailKey);
		
		// 메일 전송 메소드 불러오기.
		projectProvide.mailSend(email, "이메일 인증키입니다.", "이메일 인증키: "+emailKey);
		return 1;
	}
	// 인증번호 확인.
	@ResponseBody
	@PostMapping("/MemberEmailCheckOk")
	public int memberEmailCheckOkPost(HttpSession session, String checkKey) {
		// 세션에 저장한 인증번호와 비교.
		String emailKey = (String)session.getAttribute("sEmailKey");
		if(emailKey.equals(checkKey)) {
			session.removeAttribute("sEmailKey");
			return 1;
		}
		else return 0;
	}
	// 인증번호 제한시간(2분).
	@ResponseBody
	@PostMapping("/MemberEmailCheckNo")
	public void memberEmailCheckNoPost(HttpSession session) {
		session.removeAttribute("sEmeilKey");
	}
	
	// 로그인 폼 이동.
	@GetMapping("/MemberLogin")
	public String memberLoginGet(HttpServletRequest request) {
		// 쿠키에 로그인했던 아이디가 남아있을 경우 아이디창에 쿠키에 있는 아이디 불러오기.
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	// 로그인.
	@PostMapping("/MemberLogin")
	public String memberLoginPost(HttpSession session, HttpServletResponse response,
			@RequestParam(name="mid", defaultValue = "admin", required = false) String mid,
			@RequestParam(name="pwd", defaultValue = "1234", required = false) String pwd,
			@RequestParam(name="idSave", defaultValue = "", required = false) String idSave) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		MemberVO vo = memberService.getMemberIdSerach(mid);
		
		if(vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "우수회원";
			else if(vo.getLevel() == 2) strLevel = "정회원";
			else if(vo.getLevel() == 3) strLevel = "준회원";

			// 로그인 세션처리.
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("sStrLevel", strLevel);
			
			// 마지막 방문일 처리.
			session.setAttribute("sLastDate", vo.getLastDate());
			memberService.setLastDateUpdate(vo.getMid());
			
			// 오늘 날짜 세션 없으면 생성.
			if(session.getAttribute("sToday"+vo.getMid()) == null) session.setAttribute("sToday"+vo.getMid(), LocalDate.now().toString());
			// 첫 방문시 총 방문 횟수+1.
			if(vo.getVisitCnt() == 0) memberService.setVisitCnt(vo.getMid(), 1);
			
			int cnt = session.getAttribute("sCnt"+vo.getMid())== null ? 1 : (Integer)session.getAttribute("sCnt"+vo.getMid());
			
			// 준회원의 오늘 방문일 처리 하루 5회 제한.
			if((Integer)session.getAttribute("sLevel") == 3 && cnt < 6) {
				memberService.setTodayCnt(vo.getMid(), 1);
				cnt++;
			}
			
			// 최대 포인트 제한을 위한 cnt세션.
			// 오늘 날짜와 마지막 로그인 날짜가 다르면.
			if(!session.getAttribute("sToday"+vo.getMid()).equals(session.getAttribute("sLastDate").toString().substring(0, 10))) {
				// cnt세션 삭제.
				session.removeAttribute("sCnt"+vo.getMid());
				// 오늘 처음 방문시 총 방문 횟수+1.
				memberService.setVisitCnt(vo.getMid(), 1);
				// 오늘 날짜 세션 업데이트.
				session.setAttribute("sToday"+vo.getMid(), LocalDate.now().toString());
				// 오늘 방문 횟수 초기화.
				memberService.setTodayClear(vo.getMid(), 0);
			}
			
			// 정회원 이상 로그인 포인트 처리.
			if((Integer)session.getAttribute("sLevel") < 3) {
				// cnt가 6보다 작으면.
				if(cnt < 6) {
					// 포인트 10 적립, 오늘 방문 횟수+1.
					memberService.setPoint(vo.getMid(), 10);
					memberService.setTodayCnt(vo.getMid(), 1);
					cnt++;
				}
			}
			// 세션+mid로 세션에 cnt 저장.
			session.setAttribute("sCnt"+vo.getMid(), cnt);
			
			// 쿠키처리.
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				cookieMid.setPath("/");
				// 쿠키의 만료시간을 7일로 지정
				cookieMid.setMaxAge(60*60*24*7);
				response.addCookie(cookieMid);
			}
			else {
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cMid")) {
							cookies[i].setPath("/");
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
		}
		else return "redirect:/Message/memberLoginNo";
		return "redirect:/Message/memberLoginOk?mid="+vo.getMid();
	}
	
	// 멤버 등급 업.
	@GetMapping("/MemberLevelUp")
	public String memberLevelUpGet(HttpSession session, String mid) {
		MemberVO vo = memberService.getMemberIdSerach(mid);
		// 준회원이면.
		if(vo.getLevel() == 3) {
			// level = 2.
			memberService.setMemberLevelUp(vo.getMid(), 2);
			// 멤버 등급 세션 수정.
			session.setAttribute("sStrLevel", "정회원");
		}
		
		return "redirect:/Message/levelUp";
	}
	
	// 이름으로 아이디 찾기.
	@ResponseBody
	@PostMapping("/MemberIdFind")
	public List<MemberVO> memberIdFindPost(String email) {
		return memberService.getMemberIdFind(email);
	}
	
	// 이메일로 임시비밀번호 발송.
	@ResponseBody
	@PostMapping("/MemberTempPwd")
	public String memberTempPwdPost(String mid, String email) throws MessagingException {
		String tempPwd = UUID.randomUUID().toString().substring(0, 4);
		int res = memberService.setMemberTempPwd(mid, tempPwd);
		// 비밀번호를 임시비밀번호로 수정에 성공했을 때.
		if(res != 0) {
			projectProvide.mailSend(email, "임시비밀번호입니다.", "임시 비밀번호: "+tempPwd);
			return "1";
		}
		else return "0";
	}
	
	// 비밀번호 변경.
	@GetMapping("/MemberPwdCheck/{flag}")
	public String memberPwdCheckGet(Model model, @PathVariable String flag) {
		model.addAttribute("flag", flag);
		return "member/memberPwdCheck";
	}
	// 비밀번호 확인.
	@ResponseBody
	@PostMapping("/MemberPwdCheck")
	public String memberPwdCheckPost(String mid, String pwd) {
		MemberVO vo = memberService.getMemberIdSerach(mid);
		if(passwordEncoder.matches(pwd, vo.getPwd())) return "1";
		else return "0";
	}
	// 새 비밀번호 DB에 저장.
	@PostMapping("/MemberPwdChange")
	public String memberPwdChangePost(String mid, String newPwd) {
		newPwd = passwordEncoder.encode(newPwd);
		int res = memberService.setMemberTempPwd(mid, newPwd);
		if(res != 0) return "redirect:/Message/pwdChangeOk";
		else return "redirect:/Message/pwdChangeNo";
	}
	
	// 회원정보 수정 폼 이동.
	@GetMapping("/MemberUpdate")
	public String memberUpdateGet(Model model, String mid) {
		MemberVO vo = memberService.getMemberIdSerach(mid);
		model.addAttribute("vo", vo);
		return "member/memberUpdate";
	}
	// 회원정보 수정
	@PostMapping("/MemberUpdate")
	public String memberUpdatePost(HttpSession session, MultipartFile fName, MemberVO vo) {
		String nickName = session.getAttribute("sNickName").toString();

		if(memberService.getMemberNickNameSerach(vo.getNickName()) != null && !nickName.equals(vo.getNickName())) {
			return "redirect:/Message/memberNickNameCheckNo?mid="+vo.getMid();
		}
		
		// 프로필 사진 수정했을 때.
		if(fName.getOriginalFilename() != null && !fName.getOriginalFilename().equals("")) {
			if(!vo.getPhoto().equals("noimage.jpg")) projectProvide.fileDelete(vo.getPhoto(), "member");
			vo.setPhoto(projectProvide.fileUpload(fName, vo.getMid(), "member"));
		}
		
		int res = memberService.setmemberUpdate(vo);
		if(res != 0) {
			session.setAttribute("sNickName", vo.getNickName());
			return "redirect:/Message/memberUpdateOk";
		}
		else return "redirect:/Message/memberUpdateNo?mid="+vo.getMid();
	}
	
	// 멤버 전용방.
	@GetMapping("/MemberMain")
	public String memberMainGet(Model model, HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		String nickName = (String)session.getAttribute("sNickName");
		String strLevel = (String)session.getAttribute("sStrLevel");
		MemberVO mVO = memberService.getMemberIdSerach(mid);
		
		// 방명록에 올린 글의 수.
		int guestCnt = guestService.getMemberGuestCnt(mid, nickName, mVO.getName());
		
		model.addAttribute("strLevel", strLevel);
		model.addAttribute("guestCnt", guestCnt);
		model.addAttribute("mVO", mVO);
		
		return "member/memberMain";
	}
	
	// 회원 리스트.
	@GetMapping("/MemberList")
	public String memberListGet(Model model, HttpSession session,
			String flag,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			@RequestParam(name="level", defaultValue = "100", required = false) int level) {
		int totRecCnt = memberService.getTotRecCnt(flag);
		int totPage = (int)Math.ceil((double)totRecCnt/pageSize);
		int startIndexNo = (pag-1) * pageSize;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		List<MemberVO> vos = memberService.getMemberList(startIndexNo, pageSize, level);
		
		model.addAttribute("vos", vos);
		
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("totPage", totPage);
		model.addAttribute("blockSize", blockSize);
		model.addAttribute("curBlock", curBlock);
		model.addAttribute("lastBlock", lastBlock);
		
		return "member/memberList";
	}
	
	// 회원탈퇴.
	@ResponseBody
	@PostMapping("/MemberDelete")
	public String memberDeletePost(HttpSession session) {
		String mid = session.getAttribute("sMid").toString();
		int res = memberService.setMemberDelete(mid);
		System.out.println(res);
		if(res != 0) {
			session.removeAttribute("sMid");
			session.removeAttribute("sNickName");
			session.removeAttribute("sLevel");
			session.removeAttribute("sStrLevel");
			session.removeAttribute("sLastDate");
			session.removeAttribute("sEmailKey");
			session.removeAttribute("sToday"+mid);
			session.removeAttribute("sCnt"+mid);
			return "1";
		}
		else return "0";
	}
	// 로그아웃.
	@GetMapping("/MemberLogout")
	public String memberLogoutGet(HttpSession session) {
		String mid = (String)session.getAttribute("sMid");
		// invalidate로 전부 삭제해버리면 포인트 제한을 위한 세션까지 삭제되기 때문에 쓴 세션만 골라서 삭제한다.
		session.removeAttribute("sMid");
		session.removeAttribute("sNickName");
		session.removeAttribute("sLevel");
		session.removeAttribute("sStrLevel");
		session.removeAttribute("sLastDate");
		session.removeAttribute("sEmailKey");
		return "redirect:/Message/memberLogoutOk?mid="+mid;
	}
}