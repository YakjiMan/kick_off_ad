<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>    
<%
String pw   = request.getParameter("pw");
String pwck = request.getParameter("pwck");

if(pw == null || pw.equals(""))
{
	out.println("00:비밀번호를 입력하세요.");
	return;
}

if(!pwck.equals(pw))
{
	out.println("01:비밀번호와 일치하지 않습니다.");
}
else
{
	out.println("02:비밀번호와 일치합니다.");
}
%>