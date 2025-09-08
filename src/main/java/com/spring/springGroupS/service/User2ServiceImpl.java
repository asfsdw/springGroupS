package com.spring.springGroupS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.dao.User2DAO;
import com.spring.springGroupS.vo.UserVO;

@Service
public class User2ServiceImpl implements User2Service {
	@Autowired
	User2DAO user2DAO;

	@Override
	public List<UserVO> getUserList() {
		return user2DAO.getUserList();
	}

	@Override
	public List<UserVO> getUserSearch(String mid) {
		return user2DAO.getUserSearch(mid);
	}

	@Override
	public UserVO getUser(String mid) {
		return user2DAO.getUser(mid);
	}

	@Override
	public int setUserInput(UserVO vo) {
		return user2DAO.setUserInput(vo);
	}

	@Override
	public int setUserDelete(int idx) {
		return user2DAO.setUserDelete(idx);
	}

	@Override
	public UserVO getUserIdxSerach(int idx) {
		return user2DAO.getUserIdxSerach(idx);
	}

	@Override
	public int setUserUpdate(UserVO vo) {
		return user2DAO.setUserUpdate(vo);
	}
}
