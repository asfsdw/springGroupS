package com.spring.springGroupS.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS.common.ProjectProvide;
import com.spring.springGroupS.dao.DbShopDAO;
import com.spring.springGroupS.vo.DbCartVO;
import com.spring.springGroupS.vo.DbOptionVO;
import com.spring.springGroupS.vo.DbOrderVO;
import com.spring.springGroupS.vo.DbProductVO;

@Service
public class DbShopServiceImpl implements DbShopService {

	@Autowired
	DbShopDAO dbShopDAO;
	@Autowired
	ProjectProvide projectProvide;

	@Override
	public List<DbProductVO> getCategoryMain() {
		return dbShopDAO.getCategoryMain();
	}

	@Override
	public List<DbProductVO> getCategoryMiddle() {
		return dbShopDAO.getCategoryMiddle();
	}

	@Override
	public List<DbProductVO> getCategorySub() {
		return dbShopDAO.getCategorySub();
	}

	@Override
	public DbProductVO getCategoryMainOne(String categoryMainCode, String categoryMainName) {
		return dbShopDAO.getCategoryMainOne(categoryMainCode, categoryMainName);
	}

	@Override
	public int setCategoryMainInput(DbProductVO vo) {
		return dbShopDAO.setCategoryMainInput(vo);
	}

	@Override
	public DbProductVO getCategoryMiddleOne(DbProductVO vo) {
		return dbShopDAO.getCategoryMiddleOne(vo);
	}

	@Override
	public int setCategoryMainDelete(String categoryMainCode) {
		return dbShopDAO.setCategoryMainDelete(categoryMainCode);
	}

	@Override
	public int setCategoryMiddleInput(DbProductVO vo) {
		return dbShopDAO.setCategoryMiddleInput(vo);
	}

	@Override
	public DbProductVO getCategorySubOne(DbProductVO vo) {
		return dbShopDAO.getCategorySubOne(vo);
	}

	@Override
	public int setCategoryMiddleDelete(String categoryMiddleCode) {
		return dbShopDAO.setCategoryMiddleDelete(categoryMiddleCode);
	}

	@Override
	public List<DbProductVO> getCategoryMiddleName(String categoryMainCode) {
		return dbShopDAO.getCategoryMiddleName(categoryMainCode);
	}

	@Override
	public int setCategorySubInput(DbProductVO vo) {
		return dbShopDAO.setCategorySubInput(vo);
	}

	@Override
	public DbProductVO getCategoryProductName(DbProductVO vo) {
		return dbShopDAO.getCategoryProductName(vo);
	}

	@Override
	public int setCategorySubDelete(String categorySubCode) {
		return dbShopDAO.setCategorySubDelete(categorySubCode);
	}

	@Override
	public List<DbProductVO> getCategorySubName(String categoryMainCode, String categoryMiddleCode) {
		return dbShopDAO.getCategorySubName(categoryMainCode, categoryMiddleCode);
	}

	@Override
	public int mainImgToSubImgSave(MultipartFile file, DbProductVO vo) {
		int res = 0;
    // 메인 이미지 업로드 작업처리
    try {
      String originalFilename = file.getOriginalFilename();
      if(originalFilename != null && originalFilename != "") {
      	String saveFileName = projectProvide.saveFileName(originalFilename);
        // 메인 이미지파일을 서버 파일시스템에 업로드 처리하는 메소드 호출
        projectProvide.writeFile(file, saveFileName, "dbShop/product");
        vo.setFSName(saveFileName);
      }
      else return res;
    } catch (IOException e) {
      e.printStackTrace();
    }

    // ckeditor에서 올린 이미지파일을 'ckeditor'에서 'dbShop/product'폴더로 복사한다.
    //             0         1         2         3         4         5
    //             012345678901234567890123456789012345678901234567890
    // <img alt="" src="/springGroupS/data/ckeditor/211229124318_4.jpg"
    // <img alt="" src="/springGroupS/data/dbShop/product/211229124318_4.jpg"
    String content = vo.getContent();
    if(content.indexOf("src=\"/") == -1) return 0;

    HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
    String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/");

    int position = 33;
    String nextImg = content.substring(content.indexOf("src=\"/") + position);
    boolean sw = true;

    while(sw) {
      String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
      String copyFilePath = "";
      String oriFilePath = uploadPath + "ckeditor/" + imgFile;

      copyFilePath = uploadPath + "dbShop/product/" + imgFile;

      projectProvide.fileCopyCheck(oriFilePath, copyFilePath);

      if(nextImg.indexOf("src=\"/") == -1) sw = false;
      else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
    }
    vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/dbShop/product/"));

    // 고유번호 idx값 만들기(상품코드 만들때 필요함)
    int maxIdx = 1;
    DbProductVO maxVO = dbShopDAO.getProductMaxIdx();
    if(maxVO != null) maxIdx = maxVO.getIdx() + 1;
    
    vo.setIdx(maxIdx);
    vo.setProductCode(vo.getCategoryMainCode()+vo.getCategoryMiddleCode()+vo.getCategorySubCode()+maxIdx);	// 상품코드 만들기
    res = dbShopDAO.setDbProductInput(vo);
    return res;
	}

	@Override
	public List<DbProductVO> getSubTitle() {
		return dbShopDAO.getSubTitle();
	}

	@Override
	public List<DbProductVO> getDbShopList(String part, int mainPrice) {
		return dbShopDAO.getDbShopList(part, mainPrice);
	}

	@Override
	public DbProductVO getDbShopProduct(int idx) {
		return dbShopDAO.getDbShopProduct(idx);
	}

	@Override
	public List<DbOptionVO> getDbShopOption(int idx) {
		return dbShopDAO.getDbShopOption(idx);
	}

	@Override
	public DbProductVO getCategoryProductNameOne(String productName) {
		return dbShopDAO.getCategoryProductNameOne(productName);
	}

	@Override
	public DbProductVO getCategoryProductNameOneVO(DbProductVO imsiVO) {
		return dbShopDAO.getCategoryProductNameOneVO(imsiVO);
	}

	@Override
	public List<DbProductVO> getCategoryProductNameAjax(String categoryMainCode, String categoryMiddleCode, String categorySubCode) {
		return dbShopDAO.getCategoryProductNameAjax(categoryMainCode, categoryMiddleCode, categorySubCode);
	}

	@Override
	public DbProductVO getProductInfor(String productName) {
		return dbShopDAO.getProductInfor(productName);
	}

	@Override
	public List<DbOptionVO> getOptionList(int productIdx) {
		return dbShopDAO.getOptionList(productIdx);
	}

	@Override
	public int getOptionSame(int productIdx, String optionName) {
		return dbShopDAO.getOptionSame(productIdx, optionName);
	}

	@Override
	public int setDbOptionInput(DbOptionVO vo) {
		return dbShopDAO.setDbOptionInput(vo);
	}

	@Override
	public int setOptionDelete(int idx) {
		return dbShopDAO.setOptionDelete(idx);
	}

	@Override
	public DbCartVO getDbCartProductOptionSearch(String productName, String optionName, String mid) {
		return dbShopDAO.getDbCartProductOptionSearch(productName, optionName, mid);
	}

	@Override
	public void dbShopCartUpdate(DbCartVO vo) {
		dbShopDAO.dbShopCartUpdate(vo);
	}

	@Override
	public void dbShopCartInput(DbCartVO vo) {
		dbShopDAO.dbShopCartInput(vo);
	}

	@Override
	public List<DbCartVO> getDbCartList(String mid) {
		return dbShopDAO.getDbCartList(mid);
	}

	@Override
	public int dbCartDelete(int idx) {
		return dbShopDAO.dbCartDelete(idx);
	}

	@Override
	public DbOrderVO getOrderMaxIdx() {
		return dbShopDAO.getOrderMaxIdx();
	}

	@Override
	public DbCartVO getCartIdx(int idx) {
		return dbShopDAO.getCartIdx(idx);
	}
	
}
