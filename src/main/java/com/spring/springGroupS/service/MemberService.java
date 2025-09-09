package com.spring.springGroupS.service;

import com.spring.springGroupS.vo.MemberVO;

public interface MemberService {

	MemberVO getMemberIdSerach(String mid);

	MemberVO getMemberNickNameSerach(String nickName);

}
