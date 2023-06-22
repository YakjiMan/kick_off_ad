<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>    
<%
String code   = request.getParameter("code");
String check  = (String)session.getAttribute("checkkey");

if(code == null || code.equals(""))
{
	out.println("인증번호를 입력해주세요.");
	return;
}

if(!check.equals(code))
{
	out.println("인증번호가 일치하지 않습니다.");
}
else
{
	out.println("인증이 완료되었습니다.");
}
%>