package com.spring.springGroupS.controller;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.springGroupS.common.ARIAUtil;
import com.spring.springGroupS.common.SecurityUtil;
import com.spring.springGroupS.service.Study1Service;
import com.spring.springGroupS.service.StudyService;
import com.spring.springGroupS.vo.BMIVO;
import com.spring.springGroupS.vo.HoewonVO;
import com.spring.springGroupS.vo.MailVO;
import com.spring.springGroupS.vo.SiteInfoVO;
import com.spring.springGroupS.vo.SiteInforVO;
import com.spring.springGroupS.vo.SungjukVO;
import com.spring.springGroupS.vo.UserVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/study1")
public class Study1Controller {
	@Autowired
	Study1Service study1Service;
	
	@Autowired
	StudyService studyService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@GetMapping("/0901/Test1")
	public String getTest1() {
		return "study1/0901/test1";
	}
	@GetMapping("/0901/Test2")
	public String getTest2() {
		return "study1/0901/test2";
	}
	// @GetMapping 없는 버전을 사용할 때.
	@RequestMapping(value = "/mapping/Menu", method = RequestMethod.GET)
	public String MenuGet() {
		return "study1/mapping/menu";
	}
	
	// Query String 방식.
	@GetMapping("/mapping/Test01")
	public String Test01Get(HttpServletRequest request) {
		String mid = request.getParameter("mid");
		String pwd = request.getParameter("pwd");
		
		request.setAttribute("mid", mid);
		request.setAttribute("pwd", pwd);
		
		return "study1/mapping/test01";
	}
	@GetMapping("/mapping/Test02")
	public String Test02Get(Model model, String mid, String pwd) {
		model.addAttribute("mid", mid);
		model.addAttribute("pwd", pwd);
		return "study1/mapping/test02";
	}
	@GetMapping("/mapping/Test03")
	public String Test03Get(Model model,
			@RequestParam(name="mid") String id,
			@RequestParam(name="pwd") String passwd) {
		model.addAttribute("mid", id);
		model.addAttribute("pwd", passwd);
		return "study1/mapping/test03";
	}
	@GetMapping("/mapping/Test04")
	public String Test04Get(Model model,
			@RequestParam(name="mid") String id,
			@RequestParam(name="pwd") String passwd,
			@RequestParam(name="name", defaultValue = "손님", required = false) String name,
			@RequestParam(name="sex") int sex
			) {
		String gender = "";
		if(sex == 1 || sex == 3) gender = "남자";
		else if(sex == 2 || sex == 4) gender ="여자";
		else gender = "그 외";
		
		model.addAttribute("mid", id);
		model.addAttribute("pwd", passwd);
		model.addAttribute("name", name);
		model.addAttribute("gender", gender);
		return "study1/mapping/test04";
	}
	@GetMapping("/mapping/Test05")
	public String Test05Get(Model model, String mid, String pwd, String name, String gender, int age) {
		model.addAttribute("mid", mid);
		model.addAttribute("pwd", pwd);
		model.addAttribute("name", name);
		model.addAttribute("gender", gender);
		model.addAttribute("age", age);
		return "study1/mapping/test05";
	}
	@GetMapping("/mapping/Test06")
	public String Test06Get(Model model, String mid, String pwd, String name, String gender, int age) {
		HoewonVO vo = new HoewonVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setName(name);
		vo.setGender(gender);
		vo.setAge(age);
		model.addAttribute("vo", vo);
		return "study1/mapping/test06";
	}
	@GetMapping("/mapping/Test07")
	public String Test07Get(Model model, String mid, String pwd, String name, String gender, int age, HoewonVO vo) {
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setName(name);
		vo.setGender(gender);
		vo.setAge(age);
		model.addAttribute("vo", vo);
		return "study1/mapping/test07";
	}
	@GetMapping("/mapping/Test08")
	public String Test08Get(Model model, HoewonVO vo) {
		model.addAttribute("vo", vo);
		return "study1/mapping/test08";
	}
	@GetMapping("/mapping/Test09")
	public ModelAndView Test09Get(HoewonVO vo) {
		ModelAndView mv = new ModelAndView("study1/mapping/test09");
		mv.addObject("vo", vo);
		return mv;
	}
	
	// Path Variable 방식.
	@GetMapping("/mapping/Test21/{mid}/{pwd}")
	public String Test21Get(Model model, @PathVariable String mid, @PathVariable String pwd) {
		model.addAttribute("mid", mid);
		model.addAttribute("pwd", pwd);
		return "study1/mapping/test21";
	}
	@GetMapping("/mapping/Test22/{id}/{passwd}")
	public String Test22Get(Model model, @PathVariable String id, @PathVariable String passwd) {
		model.addAttribute("mid", id);
		model.addAttribute("pwd", passwd);
		return "study1/mapping/test22";
	}
	@GetMapping("/mapping/{passwd}/Test23/{id}")
	public String Test23Get(Model model, @PathVariable String id, @PathVariable String passwd) {
		model.addAttribute("mid", id);
		model.addAttribute("pwd", passwd);
		return "study1/mapping/test23";
	}
	@GetMapping("/mapping/{passwd}/{temp}/Test24/{id}")
	public String Test24Get(Model model, @PathVariable String id, @PathVariable String passwd) {
		model.addAttribute("mid", id);
		model.addAttribute("pwd", passwd);
		return "study1/mapping/test24";
	}
	@GetMapping("/mapping/Test25/{mid}/{temp1}/{temp2}/{pwd}/{name}/{temp}/{gender}/{age}")
	public String Test25Get(Model model, HoewonVO vo) {
		model.addAttribute("vo", vo);
		return "study1/mapping/test25";
	}
	
	// post 방식.
	@RequestMapping(value = "/mapping/Test31", method = RequestMethod.POST)
	public String Test31Post(Model model, HoewonVO vo) {
		model.addAttribute("vo", vo);
		return "study1/mapping/test31";
	}
	@PostMapping("/mapping/Test32")
	public String Test32Post(Model model, HoewonVO vo) {
		model.addAttribute("vo", vo);
		return "study1/mapping/test32";
	}
	// 메시지 경유.
	@PostMapping("/mapping/Test33")
	public String Test33Post(Model model, HoewonVO vo) {
		// DB에 회원정보 입력(회원가입처리) 후.
		model.addAttribute("message", vo.getMid()+"님 회원가입되었습니다.");
		model.addAttribute("url", "study1/mapping/Test33");
		model.addAttribute("mid", vo.getMid());
		return "include/message";
	}
	@GetMapping("/mapping/Test33")
	public String Test33Get(Model model, String mid, HoewonVO vo) {
		vo.setMid(mid);
		
		model.addAttribute("vo", vo);
		return "study1/mapping/test33";
	}
	// 새로고침할 때마다 DB에 저장된다.
	@PostMapping("/mapping/Test34")
	public String Test34Post(Model model, HoewonVO vo) {
		System.out.println("이곳은 회원 정보를 DB에 저장처리하고 있습니다.");
		
		model.addAttribute("message", "회원가입되었습니다.");
		model.addAttribute("vo", vo);
		return "study1/mapping/test34";
	}
	// 메시지 컨트롤러로 보낸다.
	@PostMapping("/mapping/Test35")
	public String Test35Post(Model model, HoewonVO vo) {
		// 회원하이디의 첫글자가 'a'로 시작하는 회원만 가입처리하도록 한다.
		if(vo.getMid().substring(0, 1).equals("a")) {
			System.out.println("이곳은 회원 정보를 DB에 저장처리하고 있습니다.");
			
			return "redirect:/Message/hoewonInputOk?mid="+vo.getMid();
		}
		else return "redirect:/Message/hoewonInputNo";
	}
	@GetMapping("/mapping/Test35")
	public String Test35Get(Model model, HoewonVO vo) {
		model.addAttribute("vo", vo);
		return "study1/mapping/test35";
	}
	
	// AOP 연습
	@GetMapping("/aop/AOPMenu")
	public String AOPMenuGet() {
		log.info("AOPMenu 컨트롤러입니다.");
		return "study1/aop/aopMenu";
	}
	@GetMapping("/aop/Test1")
	public String aopTest1Get() {
		log.info("aopTest1 컨트롤러입니다.");
		
		study1Service.getAopServiceTest1();
		
		return "study1/aop/aopMenu";
	}
	@GetMapping("/aop/Test2")
	public String aopTest2Get() {
		log.info("aopTest2 컨트롤러입니다.");
		
		study1Service.getAopServiceTest2();
		
		return "study1/aop/aopMenu";
	}
	@GetMapping("/aop/Test3")
	public String aopTest3Get() {
		log.info("aopTest3 컨트롤러입니다.");
		
		study1Service.getAopServiceTest3();
		
		return "study1/aop/aopMenu";
	}
	@GetMapping("/aop/Test4")
	public String aopTest4Get() {
		log.info("aopTest4 컨트롤러입니다.");
		
		study1Service.getAopServiceTest52();
		study1Service.getAopServiceTest53();
		
		return "study1/aop/aopMenu";
	}
	@GetMapping("/aop/Test5")
	public String aopTest5Get() {
		log.info("aopTest5 컨트롤러입니다.");
		
		study1Service.getAopServiceTest1();
		study1Service.getAopServiceTest2();
		study1Service.getAopServiceTest3();
		study1Service.getAopServiceTest52();
		study1Service.getAopServiceTest53();
		
		return "study1/aop/aopMenu";
	}
	
	// XML 값 주입 연습
	@GetMapping("/xml/XMLMenu")
	public String xmlXMLMenuGet() {
		return "study1/xml/xmlMenu";
	}
	// 성적관련.
	@GetMapping("/xml/Test1")
	public String xmlTest1Get(Model model) {
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("xml/sungjuk.xml");
		List<SungjukVO> vos = new ArrayList<SungjukVO>();
		SungjukVO vo = null;
		
		for(int i=1; i<=ctx.getBeanDefinitionCount(); i++) {
			vo = ctx.getBean("vo"+i, SungjukVO.class);
			study1Service.setSungjuk(vo);
			vos.add(vo);
		}
		
		model.addAttribute("vos", vos);
		ctx.close();
		return "study1/xml/test1";
	}
	// JDBC 정보확인1.
	@GetMapping("/xml/Test2")
	public String xmlTest2Get(Model model) {
		AbstractApplicationContext context = new GenericXmlApplicationContext("xml/siteInfo.xml");
		SiteInfoVO vo = context.getBean("info", SiteInfoVO.class);
		model.addAttribute("vo", vo);
		context.close();
		return "study1/xml/test2";
	}
	// 비만도관련.
	@GetMapping("/xml/Test3")
	public String xmlTest3Get(Model model) {
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("xml/bmi.xml");
		List<BMIVO> vos = new ArrayList<BMIVO>();
		BMIVO vo = null;
		
		for(int i=1; i<=ctx.getBeanDefinitionCount()-1; i++) {
			vo = ctx.getBean("vo"+i, BMIVO.class);
			vo.setBMI(study1Service.getBMI(vo));
			
			// bmi 계산 결과
			String bmiRes = "";
			if(vo.getBMI() < vo.getLow()) bmiRes = "저체중";
			else if(vo.getBMI() <= vo.getNormal()) bmiRes = "정상";
			else bmiRes = "과체중";
			vo.setRes(bmiRes);
			
			vos.add(vo);
		}
		
		
		model.addAttribute("vos", vos);
		ctx.close();
		return "study1/xml/test3";
	}
	//JDBC 정보확인2.
	@GetMapping("/xml/Test4")
	public String xmlTest4Get(Model model) {
		AbstractApplicationContext context = new GenericXmlApplicationContext("xml/siteInfoProperties.xml");
		SiteInforVO vo = context.getBean("info", SiteInforVO.class);
		model.addAttribute("vo", vo);
		context.close();
		return "study1/xml/test4";
	}
	
	// REST API
	@GetMapping("/restAPI/RESTAPIForm")
	public String RESTAPIGet() {
		return "study1/restAPI/restAPIForm";
	}
	@GetMapping("/restAPI/Test1/{message}")
	public String RestAPITest1Get(@PathVariable String message) {
		System.out.println(message);
		return "message: "+message;
	}
	@ResponseBody
	@GetMapping("/restAPI/Test2/{message}")
	public String RestAPITest2Get(@PathVariable String message) {
		System.out.println(message);
		return "message: "+message;
	}
	
	// AJAX
	@GetMapping("/ajax/AJAXForm")
	public String AJAXFormGet() {
		return "study1/ajax/ajaxForm";
	}
	@ResponseBody
	@PostMapping("/ajax/AJAXTest1")
	public int AJAXTest1Post(int item) {
		return item;
	}
	@ResponseBody
	@PostMapping("/ajax/AJAXTest2")
	public String AJAXTest2Post(String item) {
		return item;
	}

	// AJAX Object
	@GetMapping("/ajax/AJAXObjectForm")
	public String AJAXObjectFormGet() {
		return "study1/ajax/ajaxObjectForm";
	}
	// 일반배열로 보내기.
	@ResponseBody
	@PostMapping("/ajax/AJAXObject1")
	public String[] AJAXObject1Post(String dodo) {
		return studyService.getCityStringArr(dodo);
	}
	// 객체배열(arrayList<String>)로 보내기.
	@ResponseBody
	@PostMapping("/ajax/AJAXObject2")
	public ArrayList<String> AJAXObject2Post(String dodo) {
		return studyService.getCityArrayList(dodo);
	}
	// 객체배열(map<Objcet, Object>)로 보내기.
	@ResponseBody
	@PostMapping("/ajax/AJAXObject3")
	public Map<Object, Object> AJAXObject3Post(String dodo) {
		ArrayList<String> vos = studyService.getCityArrayList(dodo);
		Map<Object, Object> map = new HashMap<Object, Object>();
		map.put("city", vos);
		return map;
	}
	// mid 검색해서 보내주기.
	@PostMapping("/ajax/AJAXMidSearch")
	public String AJAXMidSearchPost(Model model, UserVO vo, String mid) {
		vo = studyService.getUser(mid);
		model.addAttribute("vo", vo);
		return "study1/ajax/ajaxObjectForm";
	}
	// mid 검색해서 보내주기(ajax).
	@ResponseBody
	@PostMapping("/ajax/AJAXMidSearch2")
	public UserVO AJAXMidSearch2Post(String mid) {
		return studyService.getUser(mid);
	}
	// mid 검색해서 보내주기(vos ajax).
	@ResponseBody
	@PostMapping("/ajax/AJAXMidSearch3")
	public List<UserVO> AJAXMidSearch3Post() {
		return studyService.getUserList();
	}
	// mid 검색해서 보내주기(like).
	@ResponseBody
	@PostMapping("/ajax/AJAXMidSearch4")
	public List<UserVO> AJAXMidSearch4Post(String mid) {
		return studyService.getUserListLike(mid);
	}
	
	// 암호화.
	@GetMapping("/password/PasswordForm")
	public String PasswordFormGet() {
		return "study1/password/passwordForm";
	}
	@ResponseBody
	@PostMapping(value="/password/SHA256", produces="application/text; charset=utf8")
	public String SHA256Post(String pwd) {
		String salt = UUID.randomUUID().toString().substring(0, 8);
		SecurityUtil security = new SecurityUtil();
		String encPwd = security.encryptSHA256(salt + pwd);
		pwd = "salt: "+salt+" / 암호화된 비밀번호: "+encPwd;
		return pwd;
	}
	@ResponseBody
	@PostMapping(value="/password/ARIA", produces="application/text; charset=utf8")
	public String ARIAPost(String pwd) throws InvalidKeyException, UnsupportedEncodingException {
		String salt = UUID.randomUUID().toString().substring(0, 8);
		
		String encPwd = ARIAUtil.ariaEncrypt(salt + pwd);
		String decPwd = ARIAUtil.ariaDecrypt(encPwd);
		
		pwd = "salt: "+salt+" / 암호화된 비밀번호: "+encPwd+" / 복호화된 비밀번호: "+decPwd.substring(8);
		return pwd;
	}
	@ResponseBody
	@PostMapping(value="/password/SSC", produces="application/text; charset=utf8")
	public String SSCPost(String pwd) throws InvalidKeyException, UnsupportedEncodingException {
		String encPwd = passwordEncoder.encode(pwd);
		
		pwd = "암호화된 비밀번호: "+encPwd;
		return pwd;
	}
	// 메일 인증 연습용 폼 이동.
	@GetMapping("/mail/MailForm")
	public String MailFormGet() {
		return "study1/mail/mailForm";
	}
	// 메일 보내기.
	@PostMapping("/mail/MailForm")
	public String MailFormPost(MailVO vo, HttpServletRequest request) throws MessagingException {
		String toMail = vo.getToMail();
		String title = vo.getTitle();
		String content = vo.getContent();
		
		// 메일 전송을 위한 객체: MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		
		// 메시지 보관함에 저장되는 content 변수 안에 발신자가 보여주고 싶은 정보를 추가한다.
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>springGroup에서 보냅니다.</h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p><a href='http://192.168.50.53:9090/springGroupS/' class='btn btn-info'>방문하기</a></p>";
		content += "<hr>";
		// true: 예약처리 안 하고 바로 보내겠다.
		messageHelper.setText(content, true);
		
		FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/main.jpg"));
		// 이미지파일 이름, 경로
		messageHelper.addInline("main.jpg", file);
		
		// 첨부파일 보내기.
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/02.jpg"));
		messageHelper.addAttachment("02.jpg", file);
		file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/03.jpg"));
		messageHelper.addAttachment("03.jpg", file);
		
		// 메일 전송.
		mailSender.send(message);
		
		return "redirect:/Message/mailSendOk";
	}
	
	// 파일 업로드 연습용 폼 이동.
	@GetMapping("/fileUpload/FileUploadForm")
	public String fileUploadFormGet() {
		return "study1/fileUpload/fileUploadForm";
	}
	@PostMapping("/fileUpload/FileUploadForm")
	public String fileUploadFormPost(MultipartFile fName, String mid) {
		int res = studyService.setFileUpload(fName, mid);
		if(res != 0) return "redirect:/Message/fileUploadOk"; 
		else return "redirect:/Message/fileUploadNo";
	}
}
