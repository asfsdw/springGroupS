package com.spring.springGroupS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.dao.MemberDAO;
import com.spring.springGroupS.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDAO memberDAO;
	
	@Override
	public MemberVO getMemberIdSerach(String mid) {
		return memberDAO.getMemberIdSerach(mid);
	}

	@Override
	public MemberVO getMemberNickNameSerach(String nickName) {
		return memberDAO.getMemberNickNameSerach(nickName);
	}

	@Override
	public List<MemberVO> getMemberIdFind(String name) {
		return memberDAO.getMemberIdFind(name);
	}

	@Override
	public int setMemberTempPwd(String mid, String tempPwd) {
		return memberDAO.setMemberTempPwd(mid, tempPwd);
	}

}
