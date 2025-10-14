package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.DbBaesongVO;
import com.spring.springGroupS.vo.DbCartVO;
import com.spring.springGroupS.vo.DbOptionVO;
import com.spring.springGroupS.vo.DbOrderVO;
import com.spring.springGroupS.vo.DbProductVO;

public interface DbShopDAO {

	List<DbProductVO> getCategoryMain();

	List<DbProductVO> getCategoryMiddle();

	List<DbProductVO> getCategorySub();

	DbProductVO getCategoryMainOne(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMainName") String categoryMainName);

	int setCategoryMainInput(@Param("vo") DbProductVO vo);

	DbProductVO getCategoryMiddleOne(@Param("vo") DbProductVO vo);

	int setCategoryMainDelete(@Param("categoryMainCode") String categoryMainCode);

	int setCategoryMiddleInput(@Param("vo") DbProductVO vo);

	DbProductVO getCategorySubOne(@Param("vo") DbProductVO vo);

	int setCategoryMiddleDelete(@Param("categoryMiddleCode") String categoryMiddleCode);

	List<DbProductVO> getCategoryMiddleName(@Param("categoryMainCode") String categoryMainCode);

	int setCategorySubInput(@Param("vo") DbProductVO vo);

	DbProductVO getCategoryProductName(@Param("vo") DbProductVO vo);

	int setCategorySubDelete(@Param("categorySubCode") String categorySubCode);

	List<DbProductVO> getCategorySubName(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMiddleCode") String categoryMiddleCode);

	DbProductVO getProductMaxIdx();

	int setDbProductInput(@Param("vo") DbProductVO vo);

	List<DbProductVO> getSubTitle();

	List<DbProductVO> getDbShopList(@Param("part") String part, @Param("mainPrice") int mainPrice);

	DbProductVO getDbShopProduct(@Param("idx") int idx);

	List<DbOptionVO> getDbShopOption(@Param("idx") int idx);

	DbProductVO getCategoryProductNameOne(@Param("productName") String productName);

	DbProductVO getCategoryProductNameOneVO(@Param("imsiVO") DbProductVO imsiVO);

	List<DbProductVO> getCategoryProductNameAjax(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMiddleCode") String categoryMiddleCode, @Param("categorySubCode") String categorySubCode);

	DbProductVO getProductInfor(@Param("productName") String productName);

	List<DbOptionVO> getOptionList(@Param("productIdx") int productIdx);

	int getOptionSame(@Param("productIdx") int productIdx, @Param("optionName") String optionName);

	int setDbOptionInput(@Param("vo") DbOptionVO vo);

	int setOptionDelete(@Param("idx") int idx);

	DbCartVO getDbCartProductOptionSearch(@Param("productName") String productName, @Param("optionName") String optionName, @Param("mid") String mid);

	void dbShopCartUpdate(@Param("vo") DbCartVO vo);

	void dbShopCartInput(@Param("vo") DbCartVO vo);

	List<DbCartVO> getDbCartList(@Param("mid") String mid);

	int dbCartDelete(@Param("idx") int idx);

	DbOrderVO getOrderMaxIdx();

	DbCartVO getCartIdx(@Param("idx") int idx);

	void setDbOrder(@Param("vo") DbOrderVO vo);

	void setDbCartDeleteAll(@Param("cartIdx") int cartIdx);

	void setDbBaesong(@Param("baesongVO") DbBaesongVO baesongVO);

	void setMemberPointPlus(@Param("point") int point, @Param("mid") String mid);

	int getTotalBaesongOrder(@Param("orderIdx") String orderIdx);

	List<DbBaesongVO> getOrderBaesong(@Param("orderIdx") String orderIdx);

	int getTotRecCnt(@Param("mid") String mid);

	List<DbBaesongVO> getMyOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

}
