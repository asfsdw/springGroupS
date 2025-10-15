package com.spring.springGroupS.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.springGroupS.vo.ComplaintVO;
import com.spring.springGroupS.vo.InquiryReplyVO;
import com.spring.springGroupS.vo.InquiryVO;

public interface AdminService {
	
	int setMemberLevelSelectChange(String idxCheckedArray, int levelSelect);

	int memberDeleteGet(int idx);

	int setBoardComplaintInput(ComplaintVO vo);

	void setBoardTableComplaintOk(int partIdx);

	List<ComplaintVO> getComplaintList(int startIndexNo, int pageSize, String flag);

	ComplaintVO getComplaintContent(int partIdx);

	List<ComplaintVO> getNewBoardList(String flag);

	int setComplaintDelete(String part, int partIdx);

	int setComplaintPrgress(String part, int partIdx, String flag);

	void setComplaintProgressOk(int idx, String flag);

	int getTotRecCnt(String flag, String search, String searchStr);
	
	ArrayList<InquiryVO> getInquiryListAdmin(int startIndexNo, int pageSize, String part);

	InquiryVO getInquiryContent(int idx);

	InquiryReplyVO getInquiryReplyContent(int idx);

	int setInquiryInputAdmin(InquiryReplyVO vo);

	void setInquiryUpdateAdmin(int inquiryIdx);

	int setInquiryReplyUpdate(InquiryReplyVO reVO);

	int setAdInquiryReplyDelete(int reIdx);

	void setAdInquiryDelete(int idx, String fSName, int reIdx);

	int setInquiryReplyStatusUpdate(int inquiryIdx);
	
}
