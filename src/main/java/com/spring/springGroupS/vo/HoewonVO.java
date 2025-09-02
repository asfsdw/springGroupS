package com.spring.springGroupS.vo;

import lombok.Data;

//@Getter
//@Setter
//@ToString
//@AllArgsConstructor	// VO에 넘긴 모든 필드를 읽어온다.
//@NoArgsConstructor	// 기본생성자.
//@Builder	// toString에서 원하는 갯수만 출력하는 것.
@Data	// get, setter, toString 같은 것들을 전부 합친 것. boot에서는 생성자로 값을 넣을 때 toString 때문에 에러가 나서 안 쓴다.
public class HoewonVO {
	private String mid;
	private String pwd;
	private String name;
	private String gender;
	private int age;
	
	private String nickName;
	private String strGender;
}
