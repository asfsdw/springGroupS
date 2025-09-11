package com.spring.springGroupS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.dao.GuestDAO;
import com.spring.springGroupS.vo.GuestVO;

@Service
public class GuestServiceImpl implements GuestService {
	@Autowired
	GuestDAO guestDAO;

	@Override
	public List<GuestVO> getGuestList(int startIndexNo, int pageSize) {
		return guestDAO.getGuestList(startIndexNo, pageSize);
	}

	@Override
	public int setGuestInput(GuestVO vo) {
		return guestDAO.setGuestInput(vo);
	}

	@Override
	public int getTotRecCnt() {
		return guestDAO.getTotRecCnt();
	}

	@Override
	public int setGuestDelete(int idx) {
		return guestDAO.setGuestDelete(idx);
	}

	@Override
	public int getMemberGuestCnt(String mid, String nickName, String name) {
		return guestDAO.getMemberGuestCnt(mid, nickName, name);
	}
}
