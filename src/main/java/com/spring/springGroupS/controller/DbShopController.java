package com.spring.springGroupS.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS.common.Pagination;
import com.spring.springGroupS.common.ProjectProvide;
import com.spring.springGroupS.service.DbShopService;
import com.spring.springGroupS.service.MemberService;
import com.spring.springGroupS.vo.DbCartVO;
import com.spring.springGroupS.vo.DbOptionVO;
import com.spring.springGroupS.vo.DbOrderVO;
import com.spring.springGroupS.vo.DbProductVO;
import com.spring.springGroupS.vo.MemberVO;

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

		List<DbProductVO> productVOS = dbShopService.getDbShopList(part, 0);	// 전체 상품리스트 가져오기
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
	
	/*  =========== 아래쪽은 사용자(고객) 처리 화면입니다.......  ====================================================================================== */

	// 등록된 상품 진열하기(보여주기) - 고객화면에 출력
	@GetMapping("/dbProductList")
	public String dbProductListGet(Model model, HttpServletRequest request,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="mainPrice", defaultValue = "0", required = false) int mainPrice){
		List<DbProductVO> subTitleVOS = dbShopService.getSubTitle();	// 소분류명을 가져온다.
		model.addAttribute("subTitleVOS", subTitleVOS);
		model.addAttribute("part", part);

		List<DbProductVO> productVOS = dbShopService.getDbShopList(part, mainPrice);	// 전체 상품리스트 가져오기
		model.addAttribute("productVOS", productVOS);
		model.addAttribute("price", mainPrice);
		
		return "dbShop/dbProductList";
	}
	
	// 진열된 상품클릭시 해당상품의 상세정보 보여주기(사용자(고객)화면에서 보여주기)
	@RequestMapping(value="/dbProductContent", method=RequestMethod.GET)
	public String dbProductContentGet(HttpServletRequest request, HttpServletResponse response, int idx, Model model) {
		DbProductVO productVO = dbShopService.getDbShopProduct(idx);			// 상품의 상세정보 불러오기
		List<DbOptionVO> optionVos = dbShopService.getDbShopOption(idx);	// 옵션의 모든 정보 불러오기
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVos", optionVos);
		
		return "dbShop/dbProductContent";
	}
	
	// 장바구니 담기 - 상품 상세정보보기창에서 '장바구니'버튼을 클릭시에 처리하는곳
	@RequestMapping(value="/dbProductContent", method=RequestMethod.POST)
	public String dbProductContentPost(DbCartVO vo, HttpSession session, String flag) {
		String mid = (String) session.getAttribute("sMid");
		// 같은 상품(옵션포함)을 주문했다면 새로운 항목으로 처리하지않고, 기존 상품의 수량만 구매수량만큼 증가처리한다.
		// 여러개의 상품을 구매했다면, optionName은 ','로 구분되어 넘어오게되고, DB에서 같은형식으로 저장처리되어 있다.(여러개의 같은품목을 구매시 배열에 담긴 문자열이 같다.(예:기본품목,리모콘)
		DbCartVO resVO = dbShopService.getDbCartProductOptionSearch(vo.getProductName(), vo.getOptionName(), mid);	// 지금 구매한 항목을 기존 구매 카트에서와 비교를 위해검색
		if(resVO != null) {	// 현재 구매상품이 기존 구매상품과 같은상품을 구매했을때만 이곳으로 들어온다. 즉, 이때 구매한 상품에 대하여 수량만 증가처리
			// 주문품목이 여러개를 구매했을경우, 수량과 같은 정보들(optonIdx,optionName,optoinPrice,optionNum)이 ','로 구분되어 DB에 저장되어 있다.(현재 구매후 넘어온 자료도 마찬가지이다.)
			String[] voOptionNums = vo.getOptionNum().split(",");			// 지금(현재) 구매한 장바구니의 수량을 가져와서 ','를 기준으로 분리 
			String[] resOptionNums = resVO.getOptionNum().split(",");	// 기존에 구매했었던 장바구니의 수량을 가져와서 ','를 기준으로 분리
			int[] nums = new int[99];	// 주문한 상품에 대한 수량을 누적하기위한 배열확보
			String strNums = "";		// 주문수량 변경후 다시 기존정보와 묶어주기위해서 문자열변수 선언
			for(int i=0; i<voOptionNums.length; i++) {	// 지금 주문한 상품(옵션)의 건수만큼 반복 비교처리
				nums[i] += (Integer.parseInt(voOptionNums[i]) + Integer.parseInt(resOptionNums[i]));	// 현재 구매한 수량과 기존에 구매했던 상품의 수량을 합산해서 배열에 저장
				strNums += nums[i] + ",";	// 구매상품이 1건이든 2건 이상이든, 기존상품 수량과의 구별을 위해 ','를 추가하고 있다.
			}
			strNums = strNums.substring(0,strNums.length()-1);	// 마지막 ','를 짤라낸다.
			
			vo.setOptionNum(strNums);	// 새롭게 정비한 수량을 다시 vo에 set시켜준다.
			dbShopService.dbShopCartUpdate(vo);	// 수량이 변경되었기에 기존 장바구니에서 지금 변경내역으로 update처리한다.
		}
		else {
			dbShopService.dbShopCartInput(vo);	// 기존 장바구니에 없는 새로운 항목이면 insert처리하면 된다.
		}
		
		// '장바구니담기'를 선택하던, '주문하기'를 선택하던 모두 '장바구니보기'창으로 넘긴다.
		return "redirect:/dbShop/dbCartList";
	}
	
	// 장바구니 보기
	@RequestMapping(value="/dbCartList", method=RequestMethod.GET)
	public String dbCartGet(HttpSession session, DbCartVO vo, Model model) {
		String mid = (String) session.getAttribute("sMid");
		List<DbCartVO> vos = dbShopService.getDbCartList(mid);	// idx오름차순으로 정리해서 가져왔다.
		
		if(vos.size() == 0) return "redirect:/Message/cartEmpty";
		
		model.addAttribute("cartListVos", vos);
		return "dbShop/dbCartList";
	}
	
	// 장바구니에서 주문 취소한 상품을 장바구니에서 삭제시켜주기
	@ResponseBody
	@PostMapping("/dbCartDelete")
	public int dbCartDeletePost(int idx) {
		return dbShopService.dbCartDelete(idx);
	}
	
	// 장바구니에서 '주문하기' 버튼을 클릭시에 처리할 부분
	@RequestMapping(value="/dbCartList", method=RequestMethod.POST)
	public String dbCartListPost(Model model, HttpServletRequest request, HttpSession session,
	@RequestParam(name="baesong", defaultValue="0", required=false) int baesong) {
		String mid = (String) session.getAttribute("sMid");
		
		// 주문한 상품에 대한 '고유번호'를 만들어준다.
		DbOrderVO maxIdx = dbShopService.getOrderMaxIdx();
		int idx = 1;
		if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
		
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;
		
		// 장바구니에서 구매를 위해 선택한 모든 항목들은 배열로 넘어온다.(상품을 주문할 제품에 해당하는 것들만 넘어온다. idxChecked는 구매한 항목의 장바구니 고유번호가 담겨있다.)
		String[] idxChecked = request.getParameterValues("idxChecked");
		
		DbCartVO cartVO = new DbCartVO();
		List<DbOrderVO> orderVos = new ArrayList<DbOrderVO>();
		
		// 구매한 각각의 상품을 주문vo(orderVO)에 담은후 vos에 추가처리한다. 모든 작업이 완료되면 주문정보(orderVos)세션에 담아준다.
		for(String strIdx : idxChecked) {
			cartVO = dbShopService.getCartIdx(Integer.parseInt(strIdx));	// 장바구니에 담겨서 구매 선택한 항목에 대하여 고유번호로 해당 상품 정보를 검색해온다.
			DbOrderVO orderVO = new DbOrderVO();	// 장바구니에서 구매한 상품정보를 '주문테이블'에 담아준다.
			orderVO.setProductIdx(cartVO.getProductIdx());
			orderVO.setProductName(cartVO.getProductName());
			orderVO.setMainPrice(cartVO.getMainPrice());
			orderVO.setThumbImg(cartVO.getThumbImg());
			orderVO.setOptionName(cartVO.getOptionName());
			orderVO.setOptionPrice(cartVO.getOptionPrice());
			orderVO.setOptionNum(cartVO.getOptionNum());
			orderVO.setTotalPrice(cartVO.getTotalPrice());
			orderVO.setCartIdx(cartVO.getIdx());
			orderVO.setBaesong(baesong);
			
			orderVO.setOrderIdx(orderIdx); 
			orderVO.setMid(mid);
			
			orderVos.add(orderVO);
		}
		session.setAttribute("sOrderVos", orderVos);	// 결제이후에도 주문한 상품에 대한 내역을 보기위해 세션에 담았다. 나중에 삭제처리한다.
		
		// 배송처리를 위한 현재 로그인한 아이디에 해당하는 고객의 정보를 member에서 가져온다.
		MemberVO memberVO = memberService.getMemberIdSerach(mid);
		model.addAttribute("memberVO", memberVO);
		
		return "dbShop/dbOrder";
	}
}