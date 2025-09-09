package com.spring.springGroupS.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberIdSerach(@Param("mid") String mid);

	MemberVO getMemberNickNameSerach(@Param("nickName") String nickName);

}
