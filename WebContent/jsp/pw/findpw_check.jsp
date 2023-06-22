<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
request.setCharacterEncoding("UTF-8");

String user_name = request.getParameter("user_name");
String user_id   = request.getParameter("user_id");

//id,name 일치하는 회원여부 확인
UserinfoDTO dto = new UserinfoDTO();
String    check = dto.CheckInfo(user_name, user_id);

if(check == null)
{
	out.print("일치하는 회원정보가 존재하지 않습니다.");
	return;
}

if(check.equals("exit"))
{
	out.print("탈퇴한 회원입니다.");
	return;
}

if(check.equals("ok"))
{
	out.print("ok");
	return;
}
%>