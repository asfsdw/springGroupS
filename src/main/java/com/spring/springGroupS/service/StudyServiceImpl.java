package com.spring.springGroupS.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS.dao.StudyDAO;
import com.spring.springGroupS.vo.UserVO;

@Service
public class StudyServiceImpl implements StudyService {
	@Autowired
	StudyDAO studyDAO;

	@Override
	public String[] getCityStringArr(String dodo) {
		String[] strArray = null;
		if(dodo.equals("서울")) {
			strArray = new String[] {
					"서초구","강남구","강서구","서대문구","관악구","동작구","마포구","송파구","노원구","영등포"
					};
		}
		else if(dodo.equals("경기")) {
			strArray = new String[] {
					"수원시","안양시","광명시","평택시","안성시","성남시","안산시","용인시","이천시","화성시"
			};
		}
		else if(dodo.equals("충북")) {
			strArray = new String[] {
					"청주시","충주시","제천시","단양군","증평군","옥천군","음성군","영동군","진천군","괴산군"
			};
		}
		else if(dodo.equals("충남")) {
			strArray = new String[] {
					"천안시","아산시","공주시","부여시","논산군","군산시","서산시","홍성군","금산군","태안군"
			};
		}
		return strArray;
	}

	@Override
	public ArrayList<String> getCityArrayList(String dodo) {
		ArrayList<String> vos = new ArrayList<String>();
		if(dodo.equals("서울")) {
			Collections.addAll(vos, "서초구","강남구","강서구","서대문구","관악구","동작구","마포구","송파구","노원구","영등포");
		}
		else if(dodo.equals("경기")) {
			Collections.addAll(vos, "수원시","안양시","광명시","평택시","안성시","성남시","안산시","용인시","이천시","화성시");
		}
		else if(dodo.equals("충북")) {
			Collections.addAll(vos, "청주시","충주시","제천시","단양군","증평군","옥천군","음성군","영동군","진천군","괴산군");
		}
		else if(dodo.equals("충남")) {
			Collections.addAll(vos, "천안시","아산시","공주시","부여시","논산군","군산시","서산시","홍성군","금산군","태안군");
		}
		return vos;
	}

	@Override
	public UserVO getUser(String mid) {
		return studyDAO.getUser(mid);
	}

	@Override
	public List<UserVO> getUserList() {
		return studyDAO.getUserList();
	}

	@Override
	public List<UserVO> getUserListLike(String mid) {
		return studyDAO.getUserListLike(mid);
	}
}
