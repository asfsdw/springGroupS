package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.GuestVO;

public interface GuestDAO {

	List<GuestVO> getGuestList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	int setGuestInput(@Param("vo") GuestVO vo);

	int getTotRecCnt(@Param("flag") String flag);

	int setGuestDelete(@Param("idx") int idx);

	int getMemberGuestCnt(@Param("mid") String mid, @Param("nickName") String nickName, @Param("name") String name);

	List<GuestVO> getNewGuestList(@Param("flag") String flag);

}
