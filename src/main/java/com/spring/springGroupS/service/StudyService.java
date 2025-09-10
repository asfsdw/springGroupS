package com.spring.springGroupS.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS.vo.UserVO;

public interface StudyService {

	String[] getCityStringArr(String dodo);

	ArrayList<String> getCityArrayList(String dodo);

	UserVO getUser(String mid);

	List<UserVO> getUserList();

	List<UserVO> getUserListLike(String mid);

	int setFileUpload(MultipartFile fName, String mid);

}
