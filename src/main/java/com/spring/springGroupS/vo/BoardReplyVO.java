package com.spring.springGroupS.vo;

import lombok.Data;

@Data
public class BoardReplyVO {
	private int idx;
	private int boardIdx;
	private int ref;
	private int re_step;
	private int re_order;
	private String mid;
	private String nickName;
	private String content;
	private String wDate;
	private String hostIP;
	
	private String flag;
	
	private int replyCnt;
}
