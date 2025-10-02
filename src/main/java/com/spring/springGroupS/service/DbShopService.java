package com.spring.springGroupS.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS.vo.DbOptionVO;
import com.spring.springGroupS.vo.DbProductVO;

public interface DbShopService {

	List<DbProductVO> getCategoryMain();

	List<DbProductVO> getCategoryMiddle();

	List<DbProductVO> getCategorySub();

	DbProductVO getCategoryMainOne(String categoryMainCode, String categoryMainName);

	int setCategoryMainInput(DbProductVO vo);

	DbProductVO getCategoryMiddleOne(DbProductVO vo);

	int setCategoryMainDelete(String categoryMainCode);

	int setCategoryMiddleInput(DbProductVO vo);

	DbProductVO getCategorySubOne(DbProductVO vo);

	int setCategoryMiddleDelete(String categoryMiddleCode);

	List<DbProductVO> getCategoryMiddleName(String categoryMainCode);

	int setCategorySubInput(DbProductVO vo);

	DbProductVO getCategoryProductName(DbProductVO vo);

	int setCategorySubDelete(String categorySubCode);

	List<DbProductVO> getCategorySubName(String categoryMainCode, String categoryMiddleCode);

	int mainImgToSubImgSave(MultipartFile file, DbProductVO vo);

	List<DbProductVO> getSubTitle();

	List<DbProductVO> getDbShopList(String part);

	DbProductVO getDbShopProduct(int idx);

	List<DbOptionVO> getDbShopOption(int idx);

	DbProductVO getCategoryProductNameOne(String productName);

	DbProductVO getCategoryProductNameOneVO(DbProductVO imsiVO);

	List<DbProductVO> getCategoryProductNameAjax(String categoryMainCode, String categoryMiddleCode, String categorySubCode);

	DbProductVO getProductInfor(String productName);

	List<DbOptionVO> getOptionList(int productIdx);

	int getOptionSame(int productIdx, String optionName);

	int setDbOptionInput(DbOptionVO vo);

	int setOptionDelete(int idx);

}
