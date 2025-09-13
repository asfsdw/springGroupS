package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.GuestVO;

public interface GuestService {

	List<GuestVO> getGuestList(int startIndexNo, int pageSize);

	int setGuestInput(GuestVO vo);

	int getTotRecCnt(String flag);

	int setGuestDelete(int idx);

	int getMemberGuestCnt(String mid, String nickName, String name);

	List<GuestVO> getNewGuestList(String flag);

}
