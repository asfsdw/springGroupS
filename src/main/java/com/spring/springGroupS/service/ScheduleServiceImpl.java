package com.spring.springGroupS.service;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.springGroupS.dao.ScheduleDAO;
import com.spring.springGroupS.vo.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	ScheduleDAO scheduleDAO;

	@Override
	public void getScheduleList() {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		
		// 오늘날짜 저장변수설정
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
		
		Calendar calView = Calendar.getInstance();
		int yy = request.getParameter("yy")==null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm")==null ? calView.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
		
		if(mm < 0) {
			mm = 11;
		  yy--;
		}
		if(mm > 11) {
			mm = 0;
			yy++;
		}
		calView.set(yy, mm, 1);
		
		int startWeek = calView.get(Calendar.DAY_OF_WEEK);							// 해당년월일의 요일값을 가져온다.
		int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);	// 해당월의 마지막 일자를 가져온다.
		
		// 화면에 보여줄 '이전년/이전월/다음년/다음월' 변수 처리
		int prevYear = yy;
		int prevMonth = mm - 1;
		int nextYear = yy;
		int nextMonth = mm + 1;
		
		if(prevMonth == -1) {
			prevMonth = 11;
			prevYear--;
		}
		if(nextMonth == 12) {
			nextMonth = 0;
			nextYear++;
		}
		
		// 이전달력과 다음달력을 위한 변수
		Calendar calPre = Calendar.getInstance();
		calPre.set(prevYear, prevMonth, 1);
		int preLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		Calendar calNext = Calendar.getInstance();
		calNext.set(nextYear, nextMonth, 1);
		int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);
		
		// 개별 일정을 DB에서 가져와 담아주기
		HttpSession session = request.getSession();
		String mid = session.getAttribute("sMid").toString();
		String ym = "";
		
		int intMM = mm+1;
		if(intMM >= 1 && intMM <= 9) ym = yy + "-0"+intMM;
		else ym = yy+"-"+intMM;
		
		List<ScheduleVO> vos = scheduleDAO.getScheduleList(mid, ym);
		
		request.setAttribute("toYear", toYear);
		request.setAttribute("toMonth", toMonth);
		request.setAttribute("toDay", toDay);
		
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		
		request.setAttribute("prevYear", prevYear);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		
		request.setAttribute("preLastDay", preLastDay);
		request.setAttribute("nextStartWeek", nextStartWeek);
		
		request.setAttribute("vos", vos);
	}

	@Override
	public List<ScheduleVO> getScheduleMenu(String mid, String ymd) {
		return scheduleDAO.getScheduleMenu(mid, ymd);
	}

	@Override
	public int setScheduleInputOk(ScheduleVO vo) {
		return scheduleDAO.setScheduleInputOk(vo);
	}

	@Override
	public int setDelCehck(int idx) {
		return scheduleDAO.setDelCheck(idx);
	}
	
}
