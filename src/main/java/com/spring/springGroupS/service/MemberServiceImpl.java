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
	public List<MemberVO> getMemberIdFind(String email) {
		return memberDAO.getMemberIdFind(email);
	}

	@Override
	public int setMemberTempPwd(String mid, String tempPwd) {
		return memberDAO.setMemberTempPwd(mid, tempPwd);
	}

	@Override
	public int setMemberJoin(MemberVO vo) {
		return memberDAO.setMemberJoin(vo);
	}

	@Override
	public void setLastDateUpdate(String mid) {
		memberDAO.setLastDateUpdate(mid);
	}

	@Override
	public void setPoint(String mid, int point) {
		memberDAO.setPoint(mid, point);
	}

	@Override
	public void setVisitCnt(String mid, int i) {
		memberDAO.setVisitCnt(mid, i);
	}

	@Override
	public void setTodayCnt(String mid, int i) {
		memberDAO.setTodayCnt(mid, i);
	}

	@Override
	public void setMemberLevelUp(String mid, int i) {
		memberDAO.setMemberLevelUp(mid, i);
	}

	@Override
	public void setTodayClear(String mid, int i) {
		memberDAO.setTodayClear(mid, i);
	}

	@Override
	public int setmemberUpdate(MemberVO vo) {
		return memberDAO.setmemberUpdate(vo);
	}

	@Override
	public int setMemberDelete(String mid) {
		return memberDAO.setMemberDelete(mid);
	}

	@Override
	public List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
		return memberDAO.getMemberList(startIndexNo, pageSize, level);
	}

	@Override
	public int getTotRecCnt() {
		return memberDAO.getTotRecCnt();
	}

}
