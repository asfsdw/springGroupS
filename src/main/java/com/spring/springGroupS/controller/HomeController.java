package com.spring.springGroupS.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = {"/","h","index"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		// trace < debug < error < warn < info
		logger.info("info : Welcome home! The client locale is {}.", locale);
		logger.warn("warn : Welcome home! The client locale is {}.", locale);
		logger.error("error: Welcome home! The client locale is {}.", locale);
		logger.debug("debug: Welcome home! The client locale is {}.", locale);
		
		System.out.println("=".repeat(60));
		// lomvok에서 제공하는 slf4j 라이브러리 사용.
		log.info("lombok info :");
		log.warn("lombok warn :");
		log.error("lombok error:");
		log.debug("lombok debug:");
		log.trace("lombok trace:");
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
}
