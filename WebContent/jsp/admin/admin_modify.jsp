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
String no = request.getParameter("no");

if(no == null || no.equals(""))
{
	return;
}

UserinfoDTO dto = new UserinfoDTO();
UserinfoVO  vo  = dto.Read(no);
%>
<script>
	window.onload = function()
	{
		$(".sidead").css({"display" : "none"});
	}
	function DoModify()
	{
		if(confirm("회원정보를 수정하시겠습니까?") == false)
		{
			return false;
		}
		return true;
	}
	
	function DoCancel()
	{
		if(confirm("회원정보 수정을 취소하시겠습니까?") == false)
		{
			return;
		}
		window.close();
	}
</script>
<div class="main">
	<h1 class="sitename" align="center">회원정보수정</h1>
	<div class="news_main">
		<div class="news_frame">
			<form id="write" method="post" action="/kick_off_view/jsp/admin/admin_modifyok.jsp" onsubmit="return DoModify();">
			<input type="hidden" name="user_no" value="<%= no %>">
			<table style="border:1px solid #f4f4f4;">
				<tr style="text-align:center;">
					<td>회원번호</td>
					<td><%= vo.getUser_no() %></td>
				</tr>
				<tr>
					<td>가입일자</td>
					<td><%= vo.getUser_date() %>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="user_id" value="<%= vo.getUser_id() %>"></td>
				</tr>
				<tr>
					<td>이름</td>
					<td><input type="text" name="user_name" value="<%= vo.getUser_name() %>"></td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td><input type="text" name="user_nick" value="<%= vo.getUser_nick() %>"></td>
				</tr>
				<tr>
					<td>성별</td>
					<td>
						<select name="user_gender">
							<option value="m" <%= vo.getUser_gender().equals("m") ? "selected" : "" %>>남자</option>
							<option value="f" <%= vo.getUser_gender().equals("f") ? "selected" : "" %>>여자</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="text" name="user_mail" value="<%= vo.getUser_mail() %>"></td>
				</tr>
				<tr>
					<td>회원등급</td>
					<td>
						<select name="user_grade">
							<option value="1" <%= vo.getUser_grade().equals("1") ? "selected" : "" %>>1 : 일반회원</option>
							<option value="2" <%= vo.getUser_grade().equals("2") ? "selected" : "" %>>2 : 기자</option>
							<option value="3" <%= vo.getUser_grade().equals("3") ? "selected" : "" %>>3 : 관리자</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>탈퇴여부</td>
					<td>
						<select name="user_exit">
							<option value="n" <%= vo.getUser_exit().equals("n") ? "selected" : "" %>>n : 탈퇴안함</option>
							<option value="y" <%= vo.getUser_exit().equals("y") ? "selected" : "" %>>y : 탈퇴함</option>
						</select>
					</td>
				</tr>
			</table>
			<div align="center">
				<input class="button" type="submit" value="수정완료">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<input class="button" type="button" value="취소" onclick="DoCancel();">
			</div>
			</form>
		</div>
	</div>
</div>
<br>
<!-- main 종료 -->
