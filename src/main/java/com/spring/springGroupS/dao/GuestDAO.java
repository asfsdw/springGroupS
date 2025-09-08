package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.GuestVO;

public interface GuestDAO {

	List<GuestVO> getGuestList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	int setGuestInput(@Param("vo") GuestVO vo);

	int getTotRecCnt();

	int setGuestDelete(@Param("idx") int idx);

}
