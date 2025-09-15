package com.spring.springGroupS.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.dao.AdminDAO;

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
}
