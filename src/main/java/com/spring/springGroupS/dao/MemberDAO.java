package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberIdSerach(@Param("mid") String mid);

	MemberVO getMemberNickNameSerach(@Param("nickName") String nickName);

	List<MemberVO> getMemberIdFind(@Param("name") String name);

	int setMemberTempPwd(@Param("mid") String mid, @Param("tempPwd") String tempPwd);

	int setMemberJoin(@Param("vo") MemberVO vo);

	void setLastDateUpdate(@Param("mid") String mid);

	void setPoint(@Param("mid") String mid, @Param("point") int point);

	void setVisitCnt(@Param("mid") String mid, @Param("i") int i);

	void setTodayCnt(@Param("mid") String mid, @Param("i") int i);

	void setMemberLevelUp(@Param("mid") String mid, @Param("i") int i);

}
