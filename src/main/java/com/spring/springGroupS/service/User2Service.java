package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.UserVO;

public interface User2Service {

	List<UserVO> getUserList();

	List<UserVO> getUserSearch(String mid);

	UserVO getUser(String mid);

	int setUserInput(UserVO vo);

	int setUserDelete(int idx);

	UserVO getUserIdxSerach(int idx);

	int setUserUpdate(UserVO vo);

}
