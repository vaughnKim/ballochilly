package com.ballochilly.res.common;

import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.velocity.VelocityEngineUtils;

public class BallochillyMailer extends Authenticator {

	static BallochillyMailer instance = null;
	
	private BallochillyMailer(){}
	
	public static BallochillyMailer getInstance(){
		return instance == null ? new BallochillyMailer():instance;
	}
	
	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		// TODO Auto-generated method stub
		return new PasswordAuthentication("ballochillymaster", "jywntbpxuwqpqzqc");
	}

	/***
	 * 받을대상 배열과 'EmailTemplate.vm' 파일 내 EL Tag로 바인딩 할 값들을 
	 * 넘겨주면 EmailTemplate.vm 파일 내용을 바인딩 값 변환하여 메일로 전송한다.
	 * 
	 * @param velocityEngine - Autowired 로 생성된 객체 넘겨 줄 것
	 * @param receiver - 받을 대상 이메일을 배열로 만들어 넘겨 줄 것
	 * @param properties - velocity 에서 El Tag로 binding 할 값들 map 형식으로 줄 것
	 */
	public void sendMail(VelocityEngine velocityEngine, String[] receiver, Map<String, Object> properties){
		
		//String[] receiver = {"windoger@gmail.com", "seorab81@gmail.com", "yangjunho1012@gmail.com"};
		
		// 정보를 담기 위한 객체  
		Properties p = new Properties();  
		 
		// SMTP 서버의 계정 설정  
		// Naver와 연결할 경우 네이버 아이디 지정  
		// Google과 연결할 경우 본인의 Gmail 주소  
		p.put("mail.smtp.user", "ballochillymaster");  
		  
		// SMTP 서버 정보 설정  
		// 네이버일 경우 smtp.naver.com  
		// Google일 경우 smtp.gmail.com  
		p.put("mail.smtp.host", "smtp.gmail.com");  
		      
		// 아래 정보는 네이버와 구글이 동일하므로 수정하지 마세요.  
		p.put("mail.smtp.port", "465");  
		p.put("mail.smtp.starttls.enable", "true");  
		p.put("mail.smtp.auth", "true");  
		p.put("mail.smtp.debug", "true");  
		p.put("mail.smtp.socketFactory.port", "465");  
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");  
		p.put("mail.smtp.socketFactory.fallback", "false");  
		  
	
		try {  
		    Session ses = Session.getInstance(p, this);  
		  
		    String htmlContent = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "EmailTemplate.vm", "UTF-8", properties);
//		    String htmlContent = new String(htmlContent1.getBytes(), "UTF-8"); 
		    // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.  
		    ses.setDebug(true);  
		    System.out.println(htmlContent);
		    
		    // 메일의 내용을 담기 위한 객체  
		    MimeMessage msg = new MimeMessage(ses);  
		    
		    MimeMessageHelper helper = new MimeMessageHelper(msg, true);
		    msg.setContent(htmlContent, "text/html; charset=UTF-8");

		    helper.setSubject("ballochilly를 이용해주셔서 감사합니다.");
//			helper.setText(htmlContent, true);
//			helper.setFrom("mookjja@gmail.com");
		    helper.setFrom("ballochillymaster@gmail.com");
			helper.setTo(receiver);
		    
			final MimeMessage fMsg = msg;
			
		    // 발송하기  
			 new Thread(new Runnable() {
					@Override
					public void run() {

						try {
							Transport.send(fMsg);  
						} catch (Exception e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
				}).start();
		          
		} catch (Exception mex) {  
		   mex.printStackTrace();  
		    return;  
		}  
		
	}
}
