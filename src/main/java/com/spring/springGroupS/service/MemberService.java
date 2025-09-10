package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.MemberVO;

public interface MemberService {

	MemberVO getMemberIdSerach(String mid);

	MemberVO getMemberNickNameSerach(String nickName);

	List<MemberVO> getMemberIdFind(String name);

	int setMemberTempPwd(String mid, String tempPwd);

}
