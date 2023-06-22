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
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("EUC-KR");
//인증 번호 생성기
StringBuffer temp = new StringBuffer();
Random rnd = new Random();
for(int i=0;i<10;i++)
{
    int rIndex = rnd.nextInt(3);
    switch (rIndex) {
    case 0:
        // a-z
        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
        break;
    case 1:
        // A-Z
        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
        break;
    case 2:
        // 0-9
        temp.append((rnd.nextInt(10)));
        break;
    }
}
String keynumber = temp.toString();
session.removeAttribute("checkkey");
session.setAttribute("checkkey", keynumber);
session.setMaxInactiveInterval(15*60);

String from = "na_falen@naver.com";
String to = request.getParameter("mail");
if(to == null || to.equals(""))
{
	out.print("메일을 입력해주세요.");
	return;
}
String subject = "kickoff 이메일 인증번호 입니다.";
String content = "인증번호는 ";
content += "<br><br><b>" + keynumber + "</b> &nbsp;&nbsp; 입니다.";
content += "<br><br> 인증번호를 입력하여 회원가입을 진행해주세요.";
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
    Session ses = Session.getInstance(p, auth);
    
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

out.print("인증번호가 전송되었습니다.");
// 성공 시
%>