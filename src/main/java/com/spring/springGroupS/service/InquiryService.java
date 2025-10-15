package com.spring.springGroupS.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS.vo.InquiryReplyVO;
import com.spring.springGroupS.vo.InquiryVO;

public interface InquiryService {
	List<InquiryVO> getInquiryList(int startIndexNo, int pageSize, String part, String mid);

	void setInquiryInput(MultipartFile file, InquiryVO vo);

	InquiryVO getInquiryView(int idx);

	InquiryReplyVO getInquiryReply(int idx);

	int setInquiryUpdate(MultipartFile file, InquiryVO vo);

	int setInquiryDelete(int idx, String fSName);
}
