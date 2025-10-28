package com.spring.springGroupS.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
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
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.spring.springGroupS.service.Study2Service;
import com.spring.springGroupS.vo.ChartVO;
import com.spring.springGroupS.vo.CrawlingVO;
import com.spring.springGroupS.vo.CrimeVO;
import com.spring.springGroupS.vo.DbPayMentVO;
import com.spring.springGroupS.vo.KakaoAddressVO;
import com.spring.springGroupS.vo.KakaoPlaceVO;
import com.spring.springGroupS.vo.QrCodeVO;
import com.spring.springGroupS.vo.TransactionVO;
import com.spring.springGroupS.vo.UserVO;

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
	
	// 카카오맵 연습.
	@GetMapping("/kakao/KakaoMapForm")
	public String kakaoMapGet() {
		return "study2/kakao/kakaoMapForm";
	}
	@ResponseBody
	@PostMapping("/kakao/KakaoMapForm")
	public int kakaoMapPost(KakaoAddressVO vo) {
		int res = 0;
		KakaoAddressVO voSearch = study2Service.getKakaoAddressSearch(vo.getAddress());
		if(voSearch == null) res = study2Service.setKakaoAddressInput(vo);
		return res;
	}
	@GetMapping("/kakao/KakaoMap1")
	public String kakaoMap1Get() {
		return "study2/kakao/kakaoMap1";
	}
	// DB에 저장된 장소로 이동하기.
	@GetMapping("/kakao/KakaoMap2")
	public String kakaoMap2Get(Model model,
			@RequestParam(name = "address",defaultValue = "", required = false) String address) {
		KakaoAddressVO vo = study2Service.getKakaoAddressSearch(address);
		List<KakaoAddressVO> vos = study2Service.getKakaoAddressList();
		
		model.addAttribute("vos", vos);
		model.addAttribute("vo", vo);
		model.addAttribute("address", address);
		
		return "study2/kakao/kakaoMap2";
	}
	// DB에 저장된 장소 삭제.
	@ResponseBody
	@PostMapping("/kakao/KakaoAddressDelete")
	public int kakaoAddressDeletePost(String address) {
		return study2Service.setKakaoAddressDelete(address);
	}
	@GetMapping("/kakao/KakaoMap3")
	public String kakaoMap3Get(Model model, 
			@RequestParam(name = "address",defaultValue = "", required = false) String address) {
		model.addAttribute("address", address);
		return "study2/kakao/kakaoMap3";
	}
	// 카카오맵 MyDB에 저장된 지명 주변지역 검색하여 좌표 보여주기
	@GetMapping("/kakao/kakaoEx5")
	public String kakaoEx5Get(Model model,
			@RequestParam(name="address", defaultValue = "", required = false) String address
		) {
		// System.out.println("address : " + address);
		KakaoAddressVO vo = new KakaoAddressVO();
		
		List<KakaoAddressVO> addressVos = study2Service.getKakaoAddressList();
		System.out.println("addressVos : " + addressVos);
		if(address.equals("")) {
			vo.setAddress("청주그린컴퓨터");
			vo.setLatitude(36.63508163115122);
			vo.setLongitude(127.45948750459904);
			vo.setIdx(2);
		}
		else {
			vo = study2Service.getKakaoAddressSearch(address);
		}
		model.addAttribute("addressVos", addressVos);
		model.addAttribute("vo", vo);
		
		return "study2/kakao/kakaoEx5";
	}
	// 카카오맵에서 선택한 지역을 MyDB에 저장
	@ResponseBody
	@PostMapping("/kakao/kakaoEx5")
	public int kakaoEx5Post(KakaoPlaceVO vo) {
		return study2Service.setKakaoPlaceInput(vo);
	}
	// Kakaomap(KakaoDB에 저장된 장소와 주변 표시)
	@GetMapping("/kakao/kakaoEx6")
	public String kakaoEx6Get(Model model,
			@RequestParam(name="idx", defaultValue = "2", required = false) int idx		// '청주그린컴퓨터'가 db에 'idx=14'번이다.
		) {
		KakaoAddressVO centerVO = study2Service.getKakaoAddressSearchIdx(idx);	// 중심좌표
		List<KakaoAddressVO> addressVos = study2Service.getKakaoAddressList();	// 콤보상사에 출력될 지역들
		
		List<KakaoPlaceVO> vo = study2Service.getKakaoAddressPlaceSearch(idx);	// 지도에 표시될 주변관광지
		String json = new Gson().toJson(vo);	// JSON 객체로 바꿔서 넘겨준다.
		
		model.addAttribute("addressVos", addressVos);
		model.addAttribute("voJson", json);
		model.addAttribute("centerVO", centerVO);
		model.addAttribute("idx", idx);
		return "study2/kakao/kakaoEx6";
	}

	// 날씨 API.
	@GetMapping("/weather/WeatherForm")
	public String weatherFormGet(Model model) {
		List<KakaoAddressVO> jiyukVos = study2Service.getKakaoAddressList();
		model.addAttribute("jiyukVos", jiyukVos);
		return "study2/weather/weatherForm";
	}
	
	//QR Code 연습 폼
	@GetMapping("/qrCode/QrCodeForm")
	public String qrCodeCreateGet() {
		return "study2/qrCode/qrCodeForm";
	}
	//QR Code 생성하기
	@ResponseBody
	@PostMapping("/qrCode/qrCodeCreate")
	public String qrCodeCreatePost(HttpServletRequest request, HttpSession session, QrCodeVO vo) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		vo.setFlag(0);
		vo.setMid((String) session.getAttribute("sMid"));
		return study2Service.setQrCodeCreate(realPath, vo);
	}
	//QR Code 개인정보 QR 코드로 생성하기 폼보기
	@GetMapping("/qrCode/qrCodeEx1")
	public String qrCodeEx1Get() {
		return "study2/qrCode/qrCodeEx1";
	}
	// QR Code 개인정보 QR 코드 생성
	@ResponseBody
	@PostMapping("/qrCode/qrCodeEx1")
	public String qrCodeEx1Post(HttpServletRequest request, QrCodeVO vo) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		vo.setFlag(1);
		return study2Service.setQrCodeCreate(realPath, vo);
	}
	//QR Code 소개사이트 주소 생성하기 폼보기
	@GetMapping("/qrCode/qrCodeEx2")
	public String qrCodeEx2Get() {
		return "study2/qrCode/qrCodeEx2";
	}
	// QR Code 소개사이트 주소 생성하기
	@ResponseBody
	@PostMapping("/qrCode/qrCodeEx2")
	public String qrCodeEx2Post(HttpServletRequest request, QrCodeVO vo, HttpSession session) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		vo.setFlag(2);
		vo.setMid((String) session.getAttribute("sMid"));
		return study2Service.setQrCodeCreate(realPath, vo);
	}
	//QR Code 티켓예매 폼보기
	@GetMapping("/qrCode/qrCodeEx3")
	public String qrCodeEx3Get() {
		return "study2/qrCode/qrCodeEx3";
	}
	//QR Code 티켓예매 생성하기
	@ResponseBody
	@PostMapping("/qrCode/qrCodeEx3")
	public String qrCodeEx3Post(HttpServletRequest request, QrCodeVO vo) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		vo.setFlag(3);
		return study2Service.setQrCodeCreate(realPath, vo);
	}
	//QR Code 티켓예매 폼보기(DB저장 검색)
	@GetMapping("/qrCode/qrCodeEx4")
	public String qrCodeEx4Get() {
		return "study2/qrCode/qrCodeEx4";
	}
	@ResponseBody
	@PostMapping(value = "/qrCode/qrCodeEx4")
	public String qrCodeEx4Post(HttpServletRequest request, QrCodeVO vo) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		vo.setFlag(4);
		return study2Service.setQrCodeCreate(realPath, vo);
	}
	//QR Code명 검색하기(DB저장 검색)
	@ResponseBody
	@RequestMapping(value = "/qrCode/qrCodeSearch", method = RequestMethod.POST)
	public QrCodeVO qrCodeSearchPost(String qrCode) {
		return study2Service.getQrCodeSearch(qrCode);
	}
	
	//썸네일 연습 폼보기
	@RequestMapping(value = "/thumbnail/ThumbnailForm", method = RequestMethod.GET)
	public String thumbnailFormGet() {
		return "study2/thumbnail/thumbnailForm";
	}
	// 썸네일 연습 사진처리
	@ResponseBody
	@PostMapping("/thumbnail/ThumbnailForm")
	public String thumbnailFormPost(MultipartFile file, HttpSession session, HttpServletRequest request) {
		String mid = (String) session.getAttribute("sMid");
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/thumbnail/");
		return study2Service.setThumbnailCreate(file, mid, realPath);
	}
	//썸네일 전체 리스트 이미지 보기
	@RequestMapping(value = "/thumbnail/ThumbnailResult", method = RequestMethod.GET)
	public String thumbnailResultGet(Model model, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/thumbnail/");
		String[] files = new File(realPath).list();
		
		model.addAttribute("files", files);
		model.addAttribute("fileCount", (files.length / 2));
		
		return "study2/thumbnail/thumbnailResult";
	}
	//썸네일 이미지 삭제처리(1개파일삭제)
	@ResponseBody
	@RequestMapping(value = "/thumbnail/ThumbnailDelete", method = RequestMethod.POST)
	public int thumbDeletePost(HttpServletRequest request, String file) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/thumbnail/");
		
		int res = 0;
		File sName = new File(realPath + file);
		File fName = new File(realPath + file.substring(2));
		if(fName.exists()) {
			sName.delete();
			fName.delete();
			res = 1;
		}
		return res;
	}
	//썸네일 이미지 삭제처리(전체파일삭제)
	@ResponseBody
	@RequestMapping(value = "/thumbnail/ThumbnailDeleteAll", method = RequestMethod.POST)
	public int thumbnailDeleteAllPost(HttpServletRequest request, String file) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/thumbnail/");
		
		int res = 0;
		File targetFolder = new File(realPath);
		if(!targetFolder.exists()) return res;
		
		File[] files = targetFolder.listFiles();
		
		if(files.length != 0) {
			for(File f : files) {
				if(!f.isDirectory()) f.delete();
			}
			res = 1;
		}
		return res;
	}
	
	// 결제처리 연습하기 폼.
 @RequestMapping(value = "/payment/payment", method = RequestMethod.GET)
 public String paymentGet() {
 	return "study2/payment/payment";
 }
 
 // 결제처리 연습하기 폼처리.
 @RequestMapping(value = "/payment/payment", method = RequestMethod.POST)
 public String paymentPost(Model model, HttpSession session, DbPayMentVO vo) {
 	session.setAttribute("sPayMentVO", vo);
 	model.addAttribute("vo", vo);
 	return "study2/payment/sample";
 }
 
	// 결제처리완료후 확인하는 폼...
	@RequestMapping(value = "/payment/paymentOk", method = RequestMethod.GET)
	public String paymentOkGet(Model model, HttpSession session) {
		DbPayMentVO vo = (DbPayMentVO) session.getAttribute("sPayMentVO");
		model.addAttribute("vo", vo);
		session.removeAttribute("sPayMentVO");
		return "study2/payment/paymentOk";
	}
	
	// 에러페이지 연습.
	@GetMapping("/error/ErrorForm")
	public String errorFormGet() {
		return "study2/error/errorForm";
	}
	@GetMapping("/error/ErrorMessage")
	public String errorMessageGet() {
		return "study2/error/errorMessage";
	}
	@GetMapping("/error/Error400")
	public String error400Get() {
		return "study2/error/error400";
	}
	@GetMapping("/error/Error404")
	public String error404Get() {
		return "study2/error/error404";
	}
	@GetMapping("/error/Error405")
	public String error405Post() {
		return "study2/error/error405";
	}
	@GetMapping("/error/Error500")
	public String error500Post() {
		return "study2/error/error500";
	}
	@GetMapping("/error/ErrorJSP")
	public String errorJSPGet() {
		return "study2/error/errorJSP";
	}
	@GetMapping("/error/ErrorArithmetic")
	public String errorArithmeticGet() {
		return "study2/error/errorArithmetic";
	}
	@GetMapping("/error/ErrorNullPoint")
	public String errorNullPointGet() {
		return "study2/error/errorNullPoint";
	}
	@GetMapping("/error/ErrorNumberFormat")
	public String errorNumberFormatGet() {
		return "study2/error/errorNumberFormat";
	}
	@GetMapping("/error/ErrorTest400")
	public String errorTest400Get(UserVO vo) {
		int idx = vo.getIdx();
		System.out.println(idx);
		return "study2/error/errorForm";
	}
	@PostMapping("/error/ErrorTest405")
	public String errorTest400Post() {
		return "study2/error/errorForm";
	}
	@GetMapping("/error/ErrorTest500")
	public String errorTest500Post(UserVO vo) {
		//String su = "010";
		String su = "O1O";
		int intSu = Integer.parseInt(su);
		System.out.println(intSu);
		/*
		int su = 100;
		System.out.println(su/0);
		*/
		/*
		int midLength = vo.getMid().length();
		System.out.println(midLength);
		*/
		return "study2/error/errorForm";
	}
	
	@GetMapping("/crawling/Jsoup")
	public String jsoupGet() {
		return "study2/crawling/jsoup";
	}
	@ResponseBody
	@PostMapping("/crawling/Jsoup")
	public ArrayList<String> jsoupPost(String url, String selector) throws IOException{
		Connection conn = Jsoup.connect(url);
		
		Document document = conn.get();
		//System.out.println(document);
		
		Elements selects = document.select(selector);
		System.out.println(selects);
		
		ArrayList<String> vos = new ArrayList<String>();
		int i = 1;
		for(Element select : selects) {
			//System.out.println(select.text());
			vos.add(i+": "+select.html().replace("data-", ""));
			i++;
		}
		
		return vos;
	}
	@ResponseBody
	@PostMapping("/crawling/Jsoup2")
	public ArrayList<CrawlingVO> jsoup2Post(String url, CrawlingVO crawlingVO) throws IOException{
		Connection conn = Jsoup.connect(url);
		
		Document document = conn.get();
		
		Elements selects = document.select(crawlingVO.getItem1());
		ArrayList<String> titleVOS = new ArrayList<String>();
		for(Element select : selects) {
			titleVOS.add(select.html());
		}
		
		selects = document.select(crawlingVO.getItem2());
		ArrayList<String> imgVOS = new ArrayList<String>();
		for(Element select : selects) {
			imgVOS.add(select.html().replace("data-", ""));
		}
		
		selects = document.select(crawlingVO.getItem3());
		ArrayList<String> jonalVOS = new ArrayList<String>();
		for(Element select : selects) {
			jonalVOS.add(select.html());
		}
		System.out.println(titleVOS.size());
		System.out.println(imgVOS.size());
		System.out.println(jonalVOS.size());
		
		ArrayList<CrawlingVO> vos = new ArrayList<CrawlingVO>();
		CrawlingVO vo = null;
		for(int i=0; i<imgVOS.size(); i++) {
			vo = new CrawlingVO();
			vo.setItem1(titleVOS.get(i));
			vo.setItem2(imgVOS.get(i));
			vo.setItem3(jonalVOS.get(i));
			
			vos.add(vo);
		}
		System.out.println("도달함");
		return vos;
	}
}
