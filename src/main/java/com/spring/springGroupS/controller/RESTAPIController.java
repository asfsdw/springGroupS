package com.spring.springGroupS.controller;

import java.awt.Point;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/restAPI")
public class RESTAPIController {
	// REST Controller를 이용한 처리.
	@GetMapping("/RESTAPI1/{message}")
	public String RESTAPI1Get(@PathVariable String message) {
		System.out.println(message);
		return "message: "+message;
	}
	// 객체 넘기기.
	@RequestMapping(value = "/RESTAPI2", method = RequestMethod.GET)
	public Point RESTAPI2Get() {
		Point p = new Point(123, 567);
		System.out.println(p);
		return p;
	}
}
