package com.spring.springGroupS.vo;

import lombok.Data;

@Data
public class BMIVO {
	private String name;
	private double height;
	private double weight;
	
	private double BMI;
	private String res;
	
	private double low;
	private double normal;
	private double high;
}
