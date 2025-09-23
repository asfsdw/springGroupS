package com.spring.springGroupS.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springGroupS.vo.PDSVO;
import com.spring.springGroupS.vo.ReviewVO;

public interface PDSService {

	int getTotRecCnt(String flag, String part, String search, String searchStr);

	List<PDSVO> getPDSList(int startIndexNo, int pageSize, String part, String search, String searchStr);

	int setPDSInput(MultipartHttpServletRequest mFile, PDSVO vo);

	PDSVO getPDSContent(int idx);

	int setDownNumCheck(int idx);

	int setDeleteCheck(HttpServletRequest request, int idx, String fsName);

	List<ReviewVO> getReviewList(int idx, String part);

}
