package com.spring.springGroupS.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS.common.Pagination;
import com.spring.springGroupS.common.ProjectProvide;
import com.spring.springGroupS.service.DbShopService;
import com.spring.springGroupS.service.MemberService;
import com.spring.springGroupS.vo.DbOptionVO;
import com.spring.springGroupS.vo.DbProductVO;

@Controller
@RequestMapping("/dbShop")
public class DbShopController {
	
	@Autowired
	DbShopService dbShopService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	Pagination pagination;
		
	@Autowired
	ProjectProvide javaclassProvide;
	
	// 대/중/소분류 등록폼/리스트폼 보기
	@RequestMapping(value = "/dbCategory", method = RequestMethod.GET)
	public String adminMainGet(Model model) {
		List<DbProductVO> mainVOS = dbShopService.getCategoryMain();			// 대분류 리스트
		List<DbProductVO> middleVOS = dbShopService.getCategoryMiddle();	// 중분류 리스트
		List<DbProductVO> subVOS = dbShopService.getCategorySub();				// 소분류 리스트
		
		model.addAttribute("mainVOS", mainVOS);
		model.addAttribute("middleVOS", middleVOS);
		model.addAttribute("subVOS", subVOS);
		return "admin/dbShop/dbCategory";
	}
	
	// 대분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categoryMainInput", method = RequestMethod.POST)
	public int categoryMainInputPost(DbProductVO vo) {
		int res = 0;
		// 현재 기존에 생성된 대분류명이 있는지 체크.....
		DbProductVO productVO = dbShopService.getCategoryMainOne(vo.getCategoryMainCode(), vo.getCategoryMainName());
		if(productVO != null) return res;
		
		res = dbShopService.setCategoryMainInput(vo);
		return res;
	}
	
	// 대분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categoryMainDelete", method = RequestMethod.POST)
	public int categoryMainDeletePost(DbProductVO vo) {
		int res = 0;
		// 현재 대분류를 참조하고 있는 중분류가 있는지 체크.....
		DbProductVO middleVO = dbShopService.getCategoryMiddleOne(vo);
		if(middleVO != null) return res;
		
		res = dbShopService.setCategoryMainDelete(vo.getCategoryMainCode());
		return res;
	}
	
	// 중분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categoryMiddleInput", method = RequestMethod.POST)
	public int categoryMiddleInputPost(DbProductVO vo) {
		int res = 0;
		// 현재 기존에 생성된 중분류명이 있는지 체크.....
		DbProductVO productVO = dbShopService.getCategoryMiddleOne(vo);
		
		if(productVO != null) return res;
		
		res = dbShopService.setCategoryMiddleInput(vo);
		return res;
	}
	
	// 중분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categoryMiddleDelete", method = RequestMethod.POST)
	public int categoryMiddleDeletePost(DbProductVO vo) {
		System.out.println("::::vo : " + vo);
		int res = 0;
	  // 현재 중분류를 참조하고 있는 소분류가 있는지 체크.....
		DbProductVO subVO = dbShopService.getCategorySubOne(vo);
		System.out.println("subVO : " + subVO);
		if(subVO != null) return res;
		
		res = dbShopService.setCategoryMiddleDelete(vo.getCategoryMiddleCode());
		return res;
	}
	
	// 대분류 선택하면 중분류항목 가져오기
	@ResponseBody
	@RequestMapping(value = "/categoryMiddleName", method = RequestMethod.POST)
	public List<DbProductVO> categoryMiddleNamePost(String categoryMainCode) {
		return dbShopService.getCategoryMiddleName(categoryMainCode);
	}
	
	// 소분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categorySubInput", method = RequestMethod.POST)
	public int categorySubInputPost(DbProductVO vo) {
		int res = 0;
		// 현재 기존에 생성된 소분류명이 있는지 체크.....
		DbProductVO productVO = dbShopService.getCategorySubOne(vo);
		if(productVO != null) return res;
		
		res = dbShopService.setCategorySubInput(vo);
		return res;
	}
	
	// 소분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categorySubDelete", method=RequestMethod.POST)
	public int categorySubDeletePost(DbProductVO vo) {
		int res = 0;
		// 소분류 하위항목(상품명)이 있는지 체크...
		DbProductVO categoryProdectVO = dbShopService.getCategoryProductName(vo);		// 삭제할 소분류항목에 상품이 있는지 검색처리
		if(categoryProdectVO != null) return 0;
		
		res = dbShopService.setCategorySubDelete(vo.getCategorySubCode());	//  소분류항목 삭제처리
		return res;
	}
	
	// 상품 등록시, 중분류 선택시에 소분류항목명을 가져오기
	@ResponseBody
	@RequestMapping(value = "/categorySubName", method = RequestMethod.POST)
	public List<DbProductVO> categorySubNamePost(String categoryMainCode, String categoryMiddleCode) {
		return dbShopService.getCategorySubName(categoryMainCode, categoryMiddleCode);
	}
	
	// 상품 등록을 위한 폼 보기..
	@GetMapping("/dbProduct")
	public String dbProductGet(Model model) {
		List<DbProductVO> mainVos = dbShopService.getCategoryMain();
		model.addAttribute("mainVos", mainVos);
		return "admin/dbShop/dbProduct";
	}
	
	// 상품 등록 처리하기
	@RequestMapping(value = "/dbProduct", method=RequestMethod.POST)
	public String dbProductPost(MultipartFile file, HttpServletRequest request, DbProductVO vo) {
		// main이미지 저장후, content(ckeditor)에 이미지파일 업로드시에 ckeditor폴더에서 'dbShop/product'폴더로 복사처리...후~ 처리된 내용을 DB에 저장하기
		int res = dbShopService.mainImgToSubImgSave(file, vo);
		
		if(res != 0) return "redirect:/Message/dbProductInputOk";
		return "redirect:/Message/dbProductInputNo";
	}
	
	// 등록된 모든 상품 리스트 보기(관리자화면에서...)
	@RequestMapping(value = "/dbShopList", method = RequestMethod.GET)
	public String dbShopListGet(Model model,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part){
		List<DbProductVO> subTitleVOS = dbShopService.getSubTitle();	// 소분류명을 가져온다.
		model.addAttribute("subTitleVOS", subTitleVOS);
		model.addAttribute("part", part);

		List<DbProductVO> productVOS = dbShopService.getDbShopList(part);	// 전체 상품리스트 가져오기
		model.addAttribute("productVOS", productVOS);
		
		return "admin/dbShop/dbShopList";
	}
	// 관리자화면에서 진열된 상품을 클릭하였을경우에 해당 상품의 상세내역 보여주기
	@RequestMapping(value = "/dbShopContent", method = RequestMethod.GET)
	public String dbShopContentGet(Model model, int idx) {
		DbProductVO productVO = dbShopService.getDbShopProduct(idx);			// 상품 1건의 정보를 불러온다.
		List<DbOptionVO> optionVOS = dbShopService.getDbShopOption(idx);	// 해당 상품의 모든 옵션 정보를 가져온다.
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		 
		return "admin/dbShop/dbShopContent";
	}
	
	// 옵션 등록창 보여주기
	@RequestMapping(value = "/dbOption", method = RequestMethod.GET)
	public String dbOptionGet(Model model,
			@RequestParam(name="productName", defaultValue = "", required=false) String productName
		) {
		if(productName.equals("")) {
			List<DbProductVO> mainVos = dbShopService.getCategoryMain();
			model.addAttribute("mainVos", mainVos);
		}
		else {
			DbProductVO imsiVO = dbShopService.getCategoryProductNameOne(productName);
			DbProductVO productVO = dbShopService.getCategoryProductNameOneVO(imsiVO);
			model.addAttribute("productVO", productVO);
		}
		return "admin/dbShop/dbOption";
	}

	// 소분류 선택시에 해당 상품명(모델명)을 가져오기
	@ResponseBody
	@RequestMapping(value = "/categoryProductName", method = RequestMethod.POST)
	public List<DbProductVO> categoryProductNameGet(String categoryMainCode, String categoryMiddleCode, String categorySubCode) {
		return dbShopService.getCategoryProductNameAjax(categoryMainCode, categoryMiddleCode, categorySubCode);
	}
	
	// 옵셥보기에서 상품선택 콤보상자에서 상품을 선택시 해당 상품의 정보를 보여준다.
	@ResponseBody
	@RequestMapping(value = "/getProductInfor", method = RequestMethod.POST)
	public DbProductVO getProductInforGet(String productName) {
		return dbShopService.getProductInfor(productName);
	}
	
	// 옵셥보기에서 '옵션보기'버튼 클릭시 해당 상품의 옵션리스트를 보여준다.
	@ResponseBody
	@RequestMapping(value = "/getOptionList", method = RequestMethod.POST)
	public List<DbOptionVO> getOptionListPost(int productIdx) {
		return dbShopService.getOptionList(productIdx);
	}
	
	// 옵션에 기록한 내용들을 등록처리하기
	@RequestMapping(value = "/dbOption", method = RequestMethod.POST)
	public String dbOptionPost(Model model, DbOptionVO vo, String[] optionName, int[] optionPrice) {
		int res = 0;
		for(int i=0; i<optionName.length; i++) {
			int optionCnt = dbShopService.getOptionSame(vo.getProductIdx(), optionName[i]);
			if(optionCnt != 0) continue;
			
			// 동일한 옵션이 없다면 vo에 현재 옵션 이름과 가격을 set시킨후 옵션테이블에 등록처리한다.
			vo.setProductIdx(vo.getProductIdx());
			vo.setOptionName(optionName[i]);
			vo.setOptionPrice(optionPrice[i]);
			
			res = dbShopService.setDbOptionInput(vo);
		}
		model.addAttribute("tempFlag", vo.getProductName());
		if(res != 0) return "redirect:/Message/dbOptionInputOk";
		else return "redirect:/Message/dbOptionInputNo";
	}
	
	//옵션 등록창에서 옵션리스트를 확인후 필요없는 옵션항목을 삭제처리..
	@ResponseBody
	@RequestMapping(value="/optionDelete", method = RequestMethod.POST)
	public int optionDeletePost(int idx) {
		return dbShopService.setOptionDelete(idx);
	}
}