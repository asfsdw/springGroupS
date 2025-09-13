package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberIdSerach(@Param("mid") String mid);

	MemberVO getMemberNickNameSerach(@Param("nickName") String nickName);

	List<MemberVO> getMemberIdFind(@Param("email") String email);

	int setMemberTempPwd(@Param("mid") String mid, @Param("tempPwd") String tempPwd);

	int setMemberJoin(@Param("vo") MemberVO vo);

	void setLastDateUpdate(@Param("mid") String mid);

	void setPoint(@Param("mid") String mid, @Param("point") int point);

	void setVisitCnt(@Param("mid") String mid, @Param("i") int i);

	void setTodayCnt(@Param("mid") String mid, @Param("i") int i);

	int setMemberLevelUp(@Param("mid") String mid, @Param("level") int level);

	void setTodayClear(@Param("mid") String mid, @Param("i") int i);

	int setmemberUpdate(@Param("vo") MemberVO vo);

	int setMemberDelete(@Param("mid") String mid);

	List<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("level") int level);

	int getTotRecCnt(@Param("flag") String flag);

	List<MemberVO> getNewMemberList(@Param("flag") String flag);

}
