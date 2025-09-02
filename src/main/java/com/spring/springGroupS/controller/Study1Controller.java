package com.spring.springGroupS.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.springGroupS.vo.HoewonVO;

@Controller
@RequestMapping("/study1")
public class Study1Controller {
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
	@GetMapping("/mapping/Test1")
	public String Test1Get(HttpServletRequest request) {
		String mid = request.getParameter("mid");
		String pwd = request.getParameter("pwd");
		
		request.setAttribute("mid", mid);
		request.setAttribute("pwd", pwd);
		
		return "study1/mapping/test1";
	}
	@GetMapping("/mapping/Test2")
	public String Test2Get(Model model, String mid, String pwd) {
		model.addAttribute("mid", mid);
		model.addAttribute("pwd", pwd);
		return "study1/mapping/test2";
	}
	@GetMapping("/mapping/Test3")
	public String Test3Get(Model model,
			@RequestParam(name="mid") String id,
			@RequestParam(name="pwd") String passwd) {
		model.addAttribute("mid", id);
		model.addAttribute("pwd", passwd);
		return "study1/mapping/test3";
	}
	@GetMapping("/mapping/Test4")
	public String Test4Get(Model model,
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
		return "study1/mapping/test4";
	}
	@GetMapping("/mapping/Test5")
	public String Test5Get(Model model, String mid, String pwd, String name, String gender, int age) {
		model.addAttribute("mid", mid);
		model.addAttribute("pwd", pwd);
		model.addAttribute("name", name);
		model.addAttribute("gender", gender);
		model.addAttribute("age", age);
		return "study1/mapping/test5";
	}
	@GetMapping("/mapping/Test6")
	public String Test6Get(Model model, String mid, String pwd, String name, String gender, int age) {
		HoewonVO vo = new HoewonVO();
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setName(name);
		vo.setGender(gender);
		vo.setAge(age);
		model.addAttribute("vo", vo);
		return "study1/mapping/test6";
	}
	@GetMapping("/mapping/Test7")
	public String Test7Get(Model model, String mid, String pwd, String name, String gender, int age, HoewonVO vo) {
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setName(name);
		vo.setGender(gender);
		vo.setAge(age);
		model.addAttribute("vo", vo);
		return "study1/mapping/test7";
	}
	@GetMapping("/mapping/Test8")
	public String Test8Get(Model model, HoewonVO vo) {
		model.addAttribute("vo", vo);
		return "study1/mapping/test8";
	}
	@GetMapping("/mapping/Test9")
	public ModelAndView Test9Get(HoewonVO vo) {
		ModelAndView mv = new ModelAndView("study1/mapping/test9");
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
	@PostMapping("/mapping/Test33")
	public String Test33Post(Model model, HoewonVO vo) {
		// DB에 회원정보 입력(회원가입처리) 후.
		model.addAttribute("message", vo.getMid()+"님 회원가입되었습니다.");
		model.addAttribute("url", "study1/mapping/Test33");
		model.addAttribute("mid", vo.getMid());
		return "include/message";
	}
	@GetMapping("/mapping/Test33")
	public String Test33Get(Model model, String mid) {
		model.addAttribute("mid", mid);
		return "study1/mapping/test33";
	}
	@PostMapping("/mapping/Test34")
	public String Test34Post(Model model, HoewonVO vo) {
		model.addAttribute("message", "회원가입되었습니다.");
		model.addAttribute("url", "study1/mapping/Test34");
		model.addAttribute("vo", vo);
		return "include/message";
	}
	@GetMapping("/mapping/Test34")
	public String Test33Get(Model model, HoewonVO vo) {
		model.addAttribute("vo", vo);
		return "study1/mapping/test34";
	}
}
