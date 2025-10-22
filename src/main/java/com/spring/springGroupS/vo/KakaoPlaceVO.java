package com.spring.springGroupS.vo;

import lombok.Data;

@Data
public class KakaoPlaceVO {
	private int idx;
	private int addressIdx;
	private double latitude;
	private double longitude;
	private String place ;
	private String content;
	
	private String address;
}
