package com.spring.springGroupS.service;

import java.util.List;

import com.spring.springGroupS.vo.ScheduleVO;

public interface ScheduleService {

	void getScheduleList();

	List<ScheduleVO> getScheduleMenu(String mid, String ymd);

	int setScheduleInputOk(ScheduleVO vo);

	int setDelCehck(int idx);

}
