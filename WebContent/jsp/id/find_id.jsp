<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>아이디 찾기</title>
		<link href="css/find_id.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	<script>
		window.onload = function()
		{
			$(".sidead").css({"display" : "none"});
		}
		function DoSearch()
		{
			if($(".searcher").val() == "")
			{
				alert("검색어를 입력해주세요.")
				return;
			}
			else
			{
				$("#top_search").submit();
			}
		}
		function DoBack()
		{
			document.location = "/kick_off_view/jsp/index/index.jsp";
		}
		function SendID()
		{
			if(confirm("아이디를 전송하시겠습니까?") == false)
			{
				return;
			}
			if($("#user_name").val() == "")
			{
				alert("이름을 입력해주세요.")
				$("#user_name").focus()
				return;
			}
			if($("#user_mail").val() == "")
			{
				alert("이메일을 입력해주세요.")
				$("#user_mail").focus()
				return;
			}
			$.ajax({
				type : "post",
				url: "/kick_off_view/jsp/mail/findid_mail.jsp",
				data    : 
				{
					user_name : $("#user_name").val(),
					user_mail : $("#user_mail").val()
				},
				dataType: "html",
				success : function(data) 
				{
					data = data.trim()
					alert(data);
				}			
			});
			document.location = "/kick_off_view/jsp/login/login.jsp";
		}
	</script>
<%@ include file="../include/header.jsp" %>
<!-- main 시작 -->
		<div class="main">
			<h1 class="sitename"><a href="/kick_off_view/jsp/index/index.jsp">Kick off</a></h1>
			<div class="loginbackground">
				<form class="login" name="login" method="post" action="/kick_off_view/jsp/mail/findid_mail.jsp" >
				<table class="logintbl">
					<tr>
						<td>&nbsp;&nbsp;이름
						<br><br>
						<input type="text" class="userid" name="user_name" id="user_name" placeholder="이름을 입력해주세요.">
						<br><br>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;E-mail
						<br><br>
						<input type="text" class="userpw" name="user_mail" id="user_mail" placeholder="e-mail을 입력해주세요.">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<br>
							<input type="button" class="button" value="아이디 전송"  onclick="SendID();" >
							<br><br>
							<input type="button" class="button" value="취소" onclick="DoBack();">
						</td>
					</tr>					
				</table>
				</form>		
				<table class="tap">
					<tr>
						<td><a href="/kick_off_view/jsp/pw/find_pw.jsp">비밀번호 찾기</a></td>
						<td>&nbsp;|&nbsp;</td>
						<td><a href="/kick_off_view/jsp/join/join.jsp">회원가입</a></td>
					</tr>
				</table>
			</div>
		</div>
		<br>
		<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>