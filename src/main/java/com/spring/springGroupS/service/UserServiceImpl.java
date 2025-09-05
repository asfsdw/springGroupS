package com.spring.springGroupS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.dao.UserDAO;
import com.spring.springGroupS.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	UserDAO userDAO;

	@Override
	public List<UserVO> getUserList() {
		return userDAO.getUserList();
	}

	@Override
	public UserVO getUser(String mid) {
		return userDAO.getUser(mid);
	}

}
