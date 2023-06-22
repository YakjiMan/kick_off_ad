<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>    
<%
String id   = request.getParameter("id");


if(id == null || id.equals(""))
{
	out.println("00:아이디를 입력하세요.");
	return;
}

UserinfoDTO dto = new UserinfoDTO();
if(dto.CheckID(id) == true)
{
	out.println("01:중복된 아이디 입니다.");
}
else
{
	out.println("02:사용 가능한 아이디 입니다.");
}
%>