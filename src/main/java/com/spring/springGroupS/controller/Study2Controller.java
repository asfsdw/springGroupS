package com.spring.springGroupS.controller;

import java.util.List;
import java.util.UUID;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.springGroupS.service.Study2Service;
import com.spring.springGroupS.vo.ChartVO;
import com.spring.springGroupS.vo.CrimeVO;
import com.spring.springGroupS.vo.TransactionVO;

@Controller
@RequestMapping("/study2")
public class Study2Controller {
	@Autowired
	Study2Service study2Service;
	
	// 랜덤 연습 폼.
	@GetMapping("/random/RandomForm")
	public String randomFormGet() {
		return "study2/random/randomForm";
	}
	@ResponseBody
	@PostMapping("/random/RandomCheck")
	public String randomCheckPost(int flag) {
		// (최대값-최소값+1)+최소값
		if(flag == 1) return ((int)(Math.random()*(99999999-10000000+1))+10000000)+"";
		else if(flag == 2) return UUID.randomUUID()+"";
		else if(flag == 3) return RandomStringUtils.randomAlphanumeric(64);
		return "";
	}
	
	// 달력 연습 폼.
	@GetMapping("/calendar/Calendar")
	public String calendarGet() {
		study2Service.getCalendar();
		return "study2/calendar/calendar";
	}
	
	// 백앤드 연습 폼.
	@GetMapping("/validator/Validator")
	public String validatorGet(Model model) {
		List<TransactionVO> vos = study2Service.getUserList();
		
		model.addAttribute("vos", vos);
		
		return "study2/validator/validator";
	}
	@ResponseBody
	@PostMapping(value = "/validator/Validator", produces="application/text; charset=utf8")
	public String validatorPost(@Validated TransactionVO vo, BindingResult bind) {
		String errorMessage = "";
		if(bind.hasFieldErrors()) {
			List<ObjectError> bindArr = bind.getAllErrors();
			for(ObjectError error : bindArr) {
				errorMessage = error.getDefaultMessage();
			}
		}
		else {
			int res = study2Service.setValidatorOk(vo);
			if(res != 0) return "회원가입되었습니다.";
			else return "회원가입에 실패했습니다.";
		}
		return errorMessage;
	}
	@ResponseBody
	@PostMapping("/validator/VlidatorUserDelete")
	public int vlidatorUserDeletePost(int idx) {
		return study2Service.setValidatorDeleteOk(idx);
	}
	
	// 트랜잭션 연습 폼.
	@GetMapping("/transaction/TransactionForm")
	public String transactionFormGet(Model model) {
		List<TransactionVO> vos = study2Service.getTransactionList();
		List<TransactionVO> vos2 = study2Service.getTransactionList2();
		
		model.addAttribute("vos", vos);
		model.addAttribute("vos2", vos2);
		
		return "study2/transaction/transactionForm";
	}
	// 트랜잭션 회원가입 각각.
	@Transactional
	@RequestMapping(value = "/transaction/TransactionForm", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String transactionFormPost(Model model, @Validated TransactionVO vo, BindingResult bind) {
		if(bind.hasFieldErrors()) {
			return "redirect:/Message/TransactionUserInputNo";
		}
		else {
			study2Service.setTransactionUser1Input(vo);
			study2Service.setTransactionUser2Input(vo);
			return "redirect:/Message/TransactionUserInputOk";
		}
	}
	// 트랜잭션 회원가입 한번에.
	@Transactional
	@ResponseBody
	@RequestMapping(value = "/transaction/transaction2", method = RequestMethod.POST, produces="application/text; charset=utf8")
	public String transaction2Post(@Validated TransactionVO vo, BindingResult bindingResult, Model model) {
		System.out.println("error : " + bindingResult.hasErrors());
		
		if(bindingResult.hasFieldErrors()) {
			List<ObjectError> errorList = bindingResult.getAllErrors();
			System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
			
			String temp = "";
			for(ObjectError error : errorList) {
				temp = error.getDefaultMessage();
				System.out.println("temp : " + temp);
			}
			return temp;
		}
		
		return study2Service.setTransactionUserTotalInput(vo) + "";
	}
	
	// 공공데이터(API) 연습 폼.
	@GetMapping("dataAPI/DataAPIForm")
	public String dataAPIForm() {
		return "study2/dataAPI/dataAPIForm";
	}
	@ResponseBody
	@PostMapping("/dataAPI/SaveCrimeCheck")
	public void saveCrimeCheckPost(CrimeVO vo) {
		study2Service.setSaveCrimeCheck(vo);
	}
	@ResponseBody
	@PostMapping("/dataAPI/DeleteCrimeCheck")
	public int deleteCrimeCheckPost(int year) {
		return study2Service.setDeleteCrimeCheck(year);
	}
	@ResponseBody
	@PostMapping("/dataAPI/LoadCrimeCheck")
	public List<CrimeVO> loadCrimeCheckPost(int year) {
		return study2Service.getLoadCrimeCheck(year);
	}
	@ResponseBody
	@PostMapping("/dataAPI/PoliceCheck")
	public CrimeVO policeCheckPost(Model model, int year, String police) {
		return study2Service.getPoliceCheck(year, police);
	}
	
	//차트연습폼 보기
	@GetMapping("/chart/ChartForm")
	public String chartFormGet(Model model, ChartVO vo,
			@RequestParam(name="part", defaultValue = "barVChart", required = false) String part){
		model.addAttribute("part", part);
		model.addAttribute("vo", vo);
		return "study2/chart/chartForm";
	}
	@PostMapping("/chart/googleChart1")
	public String googleChart1Post(Model model, ChartVO vo,
			@RequestParam(name="part", defaultValue = "barVChart", required = false) String part){
		model.addAttribute("part", part);
		model.addAttribute("vo", vo);
		return "study2/chart/chartForm";
	}
}
