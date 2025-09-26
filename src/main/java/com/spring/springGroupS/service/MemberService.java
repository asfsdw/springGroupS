package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.MemberLoginStatVO;
import com.spring.springGroupS.vo.MemberVO;

public interface MemberService {

	MemberVO getMemberIdSerach(String mid);

	MemberVO getMemberNickNameSerach(String nickName);

	List<MemberVO> getMemberIdFind(String email);

	int setMemberTempPwd(String mid, String tempPwd);

	int setMemberJoin(MemberVO vo);

	void setLastDateUpdate(String mid);

	void setPoint(String mid, int point);

	void setVisitCnt(String mid, int i);

	void setTodayCnt(String mid, int i);

	int setMemberLevelUp(int idx, int level);

	void setTodayClear(String mid, int i);

	int setmemberUpdate(MemberVO vo);

	int setMemberDelete(String mid);

	List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level);

	int getTotRecCnt(String flag);

	List<MemberVO> getNewMemberList(String flag);

	List<MemberLoginStatVO> getMemberStatList();

}
