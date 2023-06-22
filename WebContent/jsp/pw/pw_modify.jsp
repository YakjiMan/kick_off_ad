<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>비밀번호 변경</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/pw_modifyok.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	<script>
		var IsCheckOK   = false;
		var pwck        = "n"
		window.onload = function()
		{
			$(".sidead").css({"display" : "none"});
			
			$("#user_pwck").keyup(function(){
				userpwck = $(this).val();
				userpw   = $("#user_pw").val();
				if(userpwck == "")
				{
					$("#pw_check").html("비밀번호를 입력하세요.");
					return;
				}
				
				$.ajax({
					type : "get",
					url: "pw_check.jsp?pw=" + userpw + "&pwck=" + userpwck,
					dataType: "html",
					success : function(data) 
					{
						//alert(data);
						data = data.trim();
						ary = data.split(":");					
						$("#pw_check").html(ary[1]);
						if(ary[0] == "00" || ary[0] == "02")
						{
							//비밀번호 입력 안됨/비밀번호 확인 불일치
							IsCheckOK = false;
						}					
						if(ary[0] == "01")
						{
							//비밀번호확인 일치
							IsCheckOK = true
							pwck = "y";
						}	
					}			
				});
			});
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
		function ModifyPW()
		{
			if(confirm("비밀번호를 변경하시겠습니까?") == false)
			{
				return;
			}
			if($("#password").val() == "")
			{
				alert("기존 비밀번호를 입력해주세요.")
				return;
			}
			if($("#user_pw").val() == "")
			{
				alert("새 비밀번호를 입력해주세요.")
				return;
			}
			if(pwck == "n")
			{
				alert("비밀번호가 일치하지 않습니다.")
				return;
			}
			if($(".password").val() == $("#user_pw").val())
			{
				alert("기존 비밀번호는 사용할 수 없습니다.")
				return;
			}
			$("#modify").submit();
		}
		function DoBack()
		{
			window.history.back();
		}
	</script>
	<%@ include file="../include/header.jsp" %>
<%
request.setCharacterEncoding("EUC-KR");

String user_name = request.getParameter("user_name");
String user_id   = request.getParameter("user_id");
%>
<!-- main 시작 -->
		<div class="main">
		<form class="member_pwmodfiy" id="modify" name="modify" method="post" action="/kick_off_view/jsp/pw/pw_modifyok.jsp">
		<input type="hidden" name="user_id" value="<%= user_id %>">
		<input type="hidden" name="user_name" value="<%= user_name %>">
			<div class="profileimg">
				<img class="userimg2" src="../../img/user.png">
				<br>
				<p><%= user_name %><p>				
			</div>
			<div class="profileframe">
				<div class="profiletext">
					<p>비밀번호 변경</p>
					<hr>
					<p>현재 비밀번호<p>
					<input type="password" name="old_pw" class="password" placeholder="현재 비밀번호 입력">
					<p>새 비밀번호<p>
					<input type="password" name="new_pw" id="user_pw" class="user_pw" placeholder="새 비밀번호 입력">
					<p>새 비밀번호 확인<p>
					<input type="password" name="pwck" id="user_pwck" class="user_pwck" placeholder="새 비밀번호 입력">
					<span id="pw_check" class="span_msg">비밀번호를 입력해주세요.</span>
				</div>
			</div>
			<div class="pwmodifyok">
				<input type="button" class="button" name="pwmodifyok" value="변경 완료" onclick="ModifyPW();">
			</div>
			<div class="pwmodifyok">
				<input type="button" class="button" value="취소" onclick="DoBack();">
			</div>
		</form>
		</div>
		
<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>
