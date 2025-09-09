package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.UserVO;

public interface StudyDAO {

	UserVO getUser(@Param("mid") String mid);

	List<UserVO> getUserList();

	List<UserVO> getUserListLike(@Param("mid") String mid);

}
