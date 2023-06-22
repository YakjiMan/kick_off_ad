<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>마이페이지</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/member_info.css" rel="stylesheet" type="text/css">
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
	function DoExit(no)
	{
		if(confirm("탈퇴하시겠습니까?") == false)
		{
			return;
		}
		$.ajax({
			type : "get",
			url: "/kick_off_view/jsp/member/member_exit.jsp?no=" + no,
			dataType: "html",
			success : function(data) 
			{
				alert(data)
				document.location = "index.jsp";
			}			
		});
	}
	function DoLogout()
	{
		if(confirm("로그아웃 하시겠습니까?") != true) return;
		document.location = "/kick_off_view/jsp/logout/logout.jsp";
	}
	</script>
	<%@ include file="../include/header.jsp" %>
<!-- main 시작 -->
		<div class="main">
			<div class="profileimg">
				<img class="userimg2" src="../../img/user.png">
				<p><%= login_vo.getUser_name() %> 님</p>
			</div>
			<div class="profileframe">
			<%
				String info = "";
				info += "?user_name=" + login_vo.getUser_name();
				info += "&user_id=" + login_vo.getUser_id();
			%>
				<div class="profiletext">
					<a href="/kick_off_view/jsp/member/member_modify.jsp">회원정보 수정
					<b class="gt">&gt;</b></a>
					<hr>
					<br>
					<a href="/kick_off_view/jsp/pw/pw_modify.jsp<%= info %>">비밀번호 변경
					<b class="gt">&gt;</b></a>
					<hr>
					<br><br><br><br><br>
					<a href="javascript:DoLogout();">로그아웃
					<b class="gt">&gt;</b></a>
					<hr>
					<br>
					<a href="javascript:DoExit(<%= login_vo.getUser_no() %>);">회원탈퇴
					<b class="gt">&gt;</b></a>
					<hr>
				</div>
			</div>
		</div>
			
<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>
	