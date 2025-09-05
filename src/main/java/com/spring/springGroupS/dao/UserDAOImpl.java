package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.springGroupS.vo.UserVO;

@Repository("userDAO")
public class UserDAOImpl implements UserDAO {
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<UserVO> getUserList() {
		List<UserVO> vos = sqlSession.selectList("userNS.getUserList");
		return vos;
	}

	@Override
	public UserVO getUser(String mid) {
		UserVO vo = sqlSession.selectOne("userNS.getUser", mid);
		return vo;
	}
}
