<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>회원관리</title>				
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Hahmlet&display=swap');
	body
	{
		background-color:#0c0c0c;
		color:#FFFFFF;
		font-family: 'Hahmlet', serif;
	}
	td
	{
		font-weight:600;
		text-aligh:left;
		margin:10px 5px 10px 5px;
		height:25px;
		
	}
	table
	{
		width:70%;
		height:auto;
		margin:15px auto 0 auto;
		background-color:#353535;
		padding:15px;
		text-align:center;
	}
	input
	{
		height:25px;
		margin-top:15px;
	}
	select
	{
		width:50%;
		height:30px;
		margin-top:15px;
	}
	.button
	{
		width:80px;
		cursor:pointer;
		background-color:black;
		color:white;
		font-weight:650;
		padding:1px 9px 4px 9px;
		border:1px solid white;
	}
</style>
<!-- main 시작 -->
<%
request.setCharacterEncoding("EUC-KR");

String no = request.getParameter("user_no");
String name = request.getParameter("user_name");
String nick = request.getParameter("user_nick");
String id = request.getParameter("user_id");
String gender = request.getParameter("user_gender");
String mail = request.getParameter("user_mail");
String grade = request.getParameter("user_grade");
String exit = request.getParameter("user_exit");

if(no == null || no.equals(""))
{
	return;
}

UserinfoVO vo = new UserinfoVO();
vo.setUser_no(no);
vo.setUser_name(name);
vo.setUser_nick(nick);
vo.setUser_id(id);
vo.setUser_gender(gender);
vo.setUser_mail(mail);
vo.setUser_grade(grade);
vo.setUser_exit(exit);

UserinfoDTO dto = new UserinfoDTO();
dto.AdminUpdate(vo);
%>
<script>
	window.onload = function()
	{
		alert("수정이 완료되었습니다.")
		window.close();
	}
</script>
