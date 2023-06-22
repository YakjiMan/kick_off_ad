<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>마이페이지</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/login.css" rel="stylesheet" type="text/css">
		<link href="css/member_check.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	<script>
		window.onload = function()
		{
			$(".sidead").css({"display" : "none"});
		}
		function Dologin()
		{
			if($(".userid").val() == ""){
				alert("아이디를 입력해주세요.")
				$(".userid").focus();
				return false;
			}
			if($(".userpw").val() == ""){
				alert("비밀번호를 입력해주세요.")
				$(".userpw").focus();
				return false;
			}
			return true;
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
	</script>
	
<%@ include file="../include/header.jsp" %>
<!-- main 시작 -->
		<div class="main">
			<h1 class="sitename"><a href="/kick_off_view/jsp/index/index.jsp">비밀번호 확인</a></h1>
			<div class="loginbackground">
				<form class="login" name="login" method="post" action="/kick_off_view/jsp/member/member_checkok.jsp" >
				<table class="logintbl">
					<tr>
						<td>&nbsp;&nbsp;PASSWORD
						<br><br>
						<input type="password" class="userpw" name="user_pw" placeholder="비밀번호를 입력하세요">
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<br>
							<input type="submit" class="button" value="확인"  onclick="return Dologin();" >
							<br><br>
							<input type="button" class="button" value="취소" onclick="DoBack();">
						</td>
					</tr>					
				</table>
				</form>		
			</div>
		</div>
		<br>
		<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>