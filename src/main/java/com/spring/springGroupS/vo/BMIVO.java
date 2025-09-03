package com.spring.springGroupS.vo;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class BMIVO {
	private String name;
	private double height;
	private double weight;
	
	private double BMI;
	private String res;
}
