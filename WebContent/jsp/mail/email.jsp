<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>헤더</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/email.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	<script>

		function Doyes()
		{
			if($(".input").val() == ""){
				alert("인증번호를 입력해주세요.")
				$(".input").focus();
				return;
			}
			if($(".input").val() != ""){
				$(".emailck").submit();
				return;
			}
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
	</script>
	<%@ include file="../include/header.jsp" %>
<!-- main 시작 -->
		<div class="main">
			<div class="email">
				<img src="img/email.png" class="emailimg">
				<p class="email1">E-mail 인증</p>
				<p class="email2">이메일 인증을 위한 화면입니다.<br>
					등록된 이메일로 전송된 인증코드를 입력해주세요.
			</div>
			<form class="emailck" name="emailck" method="post" action="/kick_off_view/jsp/pw/pw_modify.jsp" >
				<div class="emailinput">
					<input type="text" name="e-mail" class="input" placeholder="인증번호를 입력해주세요.">
				</div>
				<div class="submit">
					<input type="button" name="success" class="submitbutton" value="인증 완료" onclick="Doyes();">
				</div>
			</form>
		</div>
		<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>
	