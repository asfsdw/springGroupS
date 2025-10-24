package com.spring.springGroupS.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Component;

/*
cron 사용방법(숫자) 정해진시간수행: '초 분 시 일 월 년', 매번수행: '초/숫자...'
*/
@Component
public class SpringGroupScheduler {
	@Autowired
	JavaMailSender mailSender;
	
	/*
	// 5초에 한 번씩 수행.
	@Scheduled(cron = "0/5 * * * * *")
	public void schedulerRun1() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd / HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("5초에 한 번씩 수행합니다.");
		System.out.println(strToday);
	}
	
	// 5분에 한 번씩 수행.
	@Scheduled(cron = "5 * * * * *")
	public void schedulerRun2() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd / HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("5분에 한 번씩 수행합니다.");
		System.out.println(strToday);
	}
	
	// 매일 한 번씩 정해진 시간에 자동으로 메일 보내기.
	@Scheduled(cron = "0 35 10 * * *")
	public void schedulerRun3() throws MessagingException {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strToday = sdf.format(today);
		System.out.println("매일밤 10시 40분에 메일을 전송합니다." + strToday);
		
		String email = "gouga117@gmail.com";
		String title = "신제품 안내 메일";
		String content = "겨울 신상품 안내 메일입니다.";
		
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		messageHelper.setTo(email);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
		content = content.replace("\n", "<br>");
		content += "<br><hr><h3>신상품</h3><hr><br>";
		content += "<p><img src=\"cid:main.jpg\" width='500px'></p>";
		content += "<p><a href='http://192.168.50.53:9090/springGroupS/' class='btn btn-info'>방문하기</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);
		
		FileSystemResource file = new FileSystemResource("D:\\springGroup\\springframework\\works\\springGroupS\\src\\main\\webapp\\resources\\images\\main.jpg");
		messageHelper.addInline("main.jpg", file);
		
		mailSender.send(message);
	}
	*/
}
