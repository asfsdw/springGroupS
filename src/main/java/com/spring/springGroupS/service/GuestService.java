package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.GuestVO;

public interface GuestService {

	List<GuestVO> getGuestList(int startIndexNo, int pageSize);

	int setGuestInput(GuestVO vo);

	int getTotRecCnt();

	int setGuestDelete(int idx);

}
