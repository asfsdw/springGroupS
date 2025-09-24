package com.spring.springGroupS.vo;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

import lombok.Data;

@SuppressWarnings("deprecation")
@Data
public class TransactionVO {
	private int idx;
	@NotEmpty(message = "아이디가 공백입니다.")
	@NotBlank(message = "아이디가 공백입니다.")
	@Size(min=3, max=20, message = "아이디 길이 오류(아이디는 3~20자 내로 입력해주세요.")
	private String mid;
	
	@Size(min=2, max=20, message = "이름 길이 오류(이름은 2~20자 내로 입력해주세요.")
	private String name;
	
	@Range(min=18, max=99, message = "나이는 18~99살 이내만 가입할 수 있습니다.")
	private int age;
	
	private String address;
	
	private String job;
}
