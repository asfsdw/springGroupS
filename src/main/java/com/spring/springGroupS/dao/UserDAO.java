package com.spring.springGroupS.dao;

import java.util.List;

import com.spring.springGroupS.vo.UserVO;

public interface UserDAO {

	List<UserVO> getUserList();

	UserVO getUser(String mid);
	
}
