package com.spring.springGroupS.service;

import org.springframework.stereotype.Service;

import com.spring.springGroupS.vo.BMIVO;
import com.spring.springGroupS.vo.SungjukVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class Study1Service {
	public void getAopServiceTest1() {
		log.info("getAopServiceTest1 메소드입니다.\n");
	}

//	public int getAopServiceTest2() {
//		int tot = 0;
//		for(int i=1; i<=100; i++) {
//			tot += i;
//		}
//		log.info("getAopServiceTest2 메소드입니다.\n for(1~100까지의 합): "+tot+"\n");
//		return tot;
//	}
	// 수행시간 재기용으로 return값 없는 버전.
	public void getAopServiceTest2() {
		int tot = 0;
		for(int i=1; i<=100; i++) {
			tot += i;
		}
		log.info("getAopServiceTest2 메소드입니다.\n for(1~100까지의 합): "+tot+"\n");
	}

	public void getAopServiceTest3() {
		int tot = 0, i = 1;
		while(i <= 100) {
			tot += i;
			i++;
		}
		log.info("getAopServiceTest3 메소드입니다.\n while(1~100까지의 합): "+tot+"\n");
	}
	
	public void getAopServiceTest52() {
		int tot = 0;
		for(int i=1; i<=100; i++) {
			tot += i;
		}
		log.info("getAopServiceTest52 메소드입니다.\n for(1~100까지의 합): "+tot+"\n");
	}
	
	public void getAopServiceTest53() {
		int tot = 0, i = 1;
		while(i <= 100) {
			tot += i;
			i++;
		}
		log.info("getAopServiceTest53 메소드입니다.\n while(1~100까지의 합): "+tot+"\n");
	}

	// 비만도 확인.
	public double getBMI(BMIVO vo) {
		double res = 0.0;
		// 체중 / cm를 m로 변경한 값을 제곱한 수치.
		res = vo.getWeight()/Math.pow((vo.getHeight()/100), 2);
		// 소숫점 첫째자리까지 출력
		res = Math.round(res*10)/10.0;
		return res;
	}

	// 학점계산.
	public void setSungjuk(SungjukVO vo) {
		int tot = vo.getKor()+vo.getEng()+vo.getMat();
		double avg = tot / 3.0;
		String grade = "";
		
		if(avg >= 90) grade = "A";
		else if(avg >= 80) grade = "B";
		else if(avg >= 70) grade = "C";
		else if(avg >= 60) grade = "D";
		else grade = "F";
		
		vo.setTot(tot);
		vo.setAvg(avg);
		vo.setGrade(grade);
	}

}
