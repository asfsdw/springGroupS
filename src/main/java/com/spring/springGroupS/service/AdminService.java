package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.ComplaintVO;

public interface AdminService {
	
	int setMemberLevelSelectChange(String idxCheckedArray, int levelSelect);

	int memberDeleteGet(int idx);

	int setBoardComplaintInput(ComplaintVO vo);

	void setBoardTableComplaintOk(int partIdx);

	List<ComplaintVO> getComplaintList(int startIndexNo, int pageSize);

	ComplaintVO getComplaintContent(int partIdx);

	List<ComplaintVO> getNewBoardList(String flag);

	int setComplaintDelete(String part, int partIdx);

	int setComplaintPrgress(String part, int partIdx, String flag);

	void setComplaintProgressOk(int idx, String flag);
	
}
