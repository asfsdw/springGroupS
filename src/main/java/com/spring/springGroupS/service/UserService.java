package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.UserVO;

public interface UserService {

	List<UserVO> getUserList();

	UserVO getUser(String mid);
	
}
