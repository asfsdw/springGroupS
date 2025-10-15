package com.spring.springGroupS.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.dao.AdminDAO;
import com.spring.springGroupS.vo.ComplaintVO;
import com.spring.springGroupS.vo.InquiryReplyVO;
import com.spring.springGroupS.vo.InquiryVO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDAO adminDAO;
	
	@Override
	public int setMemberLevelSelectChange(String idxCheckedArray, int levelSelect) {
		String[] idxCheckedArrays = idxCheckedArray.split("/");
		int res = 0;
		
		for(String idx : idxCheckedArrays) {
			res = adminDAO.setMemberLevelSelectChange(Integer.parseInt(idx), levelSelect);
		}
		return res;
	}

	@Override
	public int memberDeleteGet(int idx) {
		return adminDAO.memberDeleteGet(idx);
	}

	@Override
	public int setBoardComplaintInput(ComplaintVO vo) {
		return adminDAO.setBoardComplaintInput(vo);
	}

	@Override
	public void setBoardTableComplaintOk(int partIdx) {
		adminDAO.setBoardTableComplaintOk(partIdx);
	}

	@Override
	public List<ComplaintVO> getComplaintList(int startIndexNo, int pageSize, String flag) {
		return adminDAO.getComplaintList(startIndexNo, pageSize, flag);
	}

	@Override
	public ComplaintVO getComplaintContent(int partIdx) {
		return adminDAO.getComplaintContent(partIdx);
	}

	@Override
	public List<ComplaintVO> getNewBoardList(String flag) {
		return adminDAO.getNewBoardList(flag);
	}

	@Override
	public int setComplaintDelete(String part, int partIdx) {
		return adminDAO.setComplaintDelete(part, partIdx);
	}

	@Override
	public int setComplaintPrgress(String part, int partIdx, String flag) {
		return adminDAO.setComplaintPrgress(part, partIdx, flag);
	}

	@Override
	public void setComplaintProgressOk(int idx, String flag) {
		adminDAO.setComplaintProgressOk(idx, flag);
	}

	@Override
	public int getTotRecCnt(String flag, String search, String searchStr) {
		return adminDAO.getTotRecCnt(flag, search, searchStr);
	}
	
	@Override
	public ArrayList<InquiryVO> getInquiryListAdmin(int startIndexNo, int pageSize, String part) {
		return adminDAO.getInquiryListAdmin(startIndexNo, pageSize, part);
	}

	@Override
	public InquiryVO getInquiryContent(int idx) {
		return adminDAO.getInquiryContent(idx);
	}

	@Override
	public InquiryReplyVO getInquiryReplyContent(int idx) {
		return adminDAO.getInquiryReplyContent(idx);
	}

	@Override
	public int setInquiryInputAdmin(InquiryReplyVO vo) {
		return adminDAO.setInquiryInputAdmin(vo);
	}

	@Override
	public void setInquiryUpdateAdmin(int inquiryIdx) {
		adminDAO.setInquiryUpdateAdmin(inquiryIdx);
	}
	
	@Override
	public int setInquiryReplyUpdate(InquiryReplyVO reVO) {
		return adminDAO.setInquiryReplyUpdate(reVO);
	}

	@Override
	public int setAdInquiryReplyDelete(int reIdx) {
		return adminDAO.setAdInquiryReplyDelete(reIdx);
	}

	@Override
	public void setAdInquiryDelete(int idx, String fSName, int reIdx) {
		adminDAO.setAdInquiryDelete(idx, fSName, reIdx);
	}

	@Override
	public int setInquiryReplyStatusUpdate(int inquiryIdx) {
		return adminDAO.setInquiryReplyStatusUpdate(inquiryIdx);
	}
}
