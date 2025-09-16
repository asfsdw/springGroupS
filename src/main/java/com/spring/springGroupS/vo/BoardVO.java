package com.spring.springGroupS.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int idx;
	private String mid;
	private String nickName;
	private String title;
	private String content;
	private String hostIP;
	private String openSW;
	private int readNum;
	private int good;
	private String wDate;
	private String complaint;
	
	private int hourDiff;	// 새글 알림을 위해 24시간인지 확인하기 위한 변수.
	private int dateDiff;	// 날짜 출력을 위해 0, 1, …출력.
	private int replyCnt; // 게시글의 달린 댓글 갯수 가져오는 변수.
	private int newCount; // 7일 내에 올라온 게시글 수.
}
