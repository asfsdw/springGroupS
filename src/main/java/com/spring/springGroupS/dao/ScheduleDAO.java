package com.spring.springGroupS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS.vo.ScheduleVO;

public interface ScheduleDAO {

	List<ScheduleVO> getScheduleList(@Param("mid") String mid, @Param("ym") String ym);

	List<ScheduleVO> getScheduleMenu(@Param("mid") String mid, @Param("ymd") String ymd);

	int setScheduleInputOk(@Param("vo") ScheduleVO vo);

	int setDelCheck(@Param("idx") int idx);

}
