package com.spring.springGroupS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.dao.PDSDAO;
import com.spring.springGroupS.vo.PDSVO;

@Service
public class PDSServiceImpl implements PDSService {
	@Autowired
	PDSDAO pdsDAO;

	@Override
	public int getTotRecCnt(String flag, String part, String search, String searchStr) {
		return pdsDAO.getTotRecCnt(flag, part, search, searchStr);
	}

	@Override
	public List<PDSVO> getPDSList(int startIndexNo, int pageSize, String part, String search, String searchStr) {
		return pdsDAO.getPDSList(startIndexNo, pageSize, part, search, searchStr);
	}
}
