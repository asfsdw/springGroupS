package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.PDSVO;

public interface PDSService {

	int getTotRecCnt(String flag, String part, String search, String searchStr);

	List<PDSVO> getPDSList(int startIndexNo, int pageSize, String part, String search, String searchStr);

}
