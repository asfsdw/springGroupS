package com.spring.springGroupS.vo;

import lombok.Data;

@Data
public class GuestVO {
	private int idx;
	private String name;
	private String content;
	private String email;
	private String homePage;
	private String vDate;
	private String hostIP;
	
	private int newCount;
}
