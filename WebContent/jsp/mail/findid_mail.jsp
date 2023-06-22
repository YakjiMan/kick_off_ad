<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Session"%>
<%@page import="mail.SMTPAuthenticator"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="javax.mail.*" %>
<%@page import="java.util.Properties"%>
<%@page import="java.util.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("UTF-8");

String user_name = request.getParameter("user_name");
String user_mail = request.getParameter("user_mail");

//일치하는 아이디 찾기
UserinfoDTO dto = new UserinfoDTO();
String user_id  = dto.FindID(user_name, user_mail);
if(user_id == null)
{
	out.print("일치하는 아이디가 존재하지 않습니다.");
	return;
}
if(user_id.equals("y"))
{
	out.print("탈퇴한 회원입니다.");
	return;
}


String from    = "na_falen@naver.com";
String to      = user_mail;
String subject = "kickoff 회원아이디 입니다.";
String content = "회원님의 ID는 ";
content += "<br><br><b>" + user_id + "</b> &nbsp;&nbsp; 입니다.";
content += "<br><br> 감사합니다.";
// 입력값 받음

Properties p = new Properties(); // 정보를 담을 객체

p.put("mail.smtp.host","smtp.naver.com"); // 네이버 SMTP

p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");
// SMTP 서버에 접속하기 위한 정보들

try{
    SMTPAuthenticator auth = new SMTPAuthenticator();
    Session           ses  = Session.getInstance(p, auth);
    
    ses.setDebug(true);
    
    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
    msg.setSubject(subject); // 제목
    
    Address fromAddr = new InternetAddress(from);
    msg.setFrom(fromAddr); // 보내는 사람
    
    Address toAddr = new InternetAddress(to);
    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
    
    msg.setContent(content, "text/html;charset=EUC-KR"); // 내용과 인코딩
    
    Transport.send(msg); // 전송
} catch(Exception e){
    e.printStackTrace();
    out.print("전송에 실패했습니다.");
    // 오류 발생시 뒤로 돌아가도록
    return;
}

out.print("아이디가 전송되었습니다.");
// 성공 시
%>