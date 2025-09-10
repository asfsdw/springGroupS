package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberIdSerach(@Param("mid") String mid);

	MemberVO getMemberNickNameSerach(@Param("nickName") String nickName);

	List<MemberVO> getMemberIdFind(@Param("name") String name);

	int setMemberTempPwd(@Param("mid") String mid, @Param("tempPwd") String tempPwd);

}
