<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>회원가입</title>
		<link href="css/join.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	<script>
		var idck        = "n";
		var pwck        = "n";
		var mailck      = "n";
		var IsDuplicate = false;
		var IsCheckOK   = false;
		
		window.onload = function()
		{
			$(".sidead").css({"display" : "none"});
			
			$("#user_id").focus()
			
			$("#user_id").keyup(function(){
				userid = $(this).val();
				if(userid == "")
				{
					$("#id_check").html("아이디를 입력하세요.");
					return;
				}
				
				$.ajax({
					type : "get",
					url: "/kick_off_view/jsp/id/id_check.jsp?id=" + userid,
					dataType: "html",
					success : function(data) 
					{
						//alert(data);
						data = data.trim();
						ary = data.split(":");					
						$("#id_check").html(ary[1]);
						if(ary[0] == "00" || ary[0] == "02")
						{
							//아이디 입력 안됨/아이디 등록 가능
							IsDuplicate = false
							idck = "y";
						}					
						if(ary[0] == "01")
						{
							//중복된 아이디
							IsDuplicate = true;
						}	
					}			
				});
			});
			
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
					url: "/kick_off_view/jsp/pw/pw_check.jsp?pw=" + userpw + "&pwck=" + userpwck,
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
		function Dojoin()
		{
			if($("#user_id").val() == "" || $("#user_pw").val() == "" || $("#user_name").val() == "" || $("#user_nick").val() == "")
			{
				alert("필수사항을 모두 입력해주세요.")
				if($("#user_nick").val() == "")
				{
					$("#user_nick").focus();
				}
				if($("#user_name").val() == "")
				{
					$("#user_name").focus();
				}
				if($("#user_pw").val() == "")
				{
					$("#user_pw").focus();
				}
				if($("#user_id").val() == "")
				{
					$("#user_id").focus();
				}
				return;
			}
			if(mailck == "n")
			{
				alert("이메일 인증을 완료해주세요.")
				return;
			}
			if(idck == "n")
			{
				alert("중복된 아이디입니다.");
				return;
			}
			if(pwck == "n")
			{
				alert("비밀번호확인이 일치하지 않습니다.")
				return;
			}
			if(confirm("회원가입을 진행하시겠습니까?") == true && idck == "y" && pwck == "y" && mailck == "y")
			{
				$("#join").submit();
			}
			return;
		}
		function DoSend()
		{
			$.ajax({
				type : "get",
				url: "/kick_off_view/jsp/mail/send_mail.jsp?mail=" + $("#user_mail").val(),
				dataType: "html",
				success : function(data) 
				{
					data = data.trim()
					alert(data)
					return;
				}			
			});
		}
		function DoMailCheck()
		{
			$.ajax({
				type : "get",
				url: "/kick_off_view/jsp/mail/check_mail.jsp?code=" + $("#codenumber").val(),
				dataType: "html",
				success : function(data) 
				{
					data = data.trim()
					alert(data)
					mailck = "y"
					return;
				}			
			});
		}
	</script>
	<%@ include file="../include/header.jsp" %>
<!-- main 시작 -->

		<div class="main">
			<h1 class="sitename"><a href="index.jsp">Kick off</a></h1>
			<div class="loginbackground">
				<form class="join" name="join" method="post" id="join" action="/kick_off_view/jsp/join/joinok.jsp" >
				<table class="jointbl">
					<tr>
						<td>&nbsp;&nbsp;<b>아이디</b>
						<br>
						<input type="text" class="userid" name="userid" id="user_id" placeholder="&nbsp;&nbsp;아이디를 입력해주세요">
						<p id="id_check" class="span_msg">아이디를 입력해주세요.</p>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;<b>비밀번호</b>
						<br>
						<input type="password" class="userpw" name="userpw" id="user_pw" placeholder="&nbsp;&nbsp;비밀번호를 입력해주세요">
						</td>
					</tr>	
					<tr>
						<td>&nbsp;&nbsp;<b>비밀번호 확인</b>
						<br>
						<input type="password" class="userpwck" name="userpwck" id="user_pwck" placeholder="&nbsp;&nbsp;비밀번호를 입력해주세요">
						<p id="pw_check" class="span_msg">비밀번호를 입력해주세요.</p>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;<b>이름</b>
						<br>
						<input type="text" class="name" name="name" id="user_name" placeholder="&nbsp;&nbsp;이름을 입력해주세요">
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;<b>닉네임</b>
						<br>
						<input type="text" class="nickname" name="nickname" id="user_nick" placeholder="&nbsp;&nbsp;닉네임을 입력해주세요">
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;<b>성별</b>	
						<select class="gender" name="gender">
							<option value="m">남</option>
							<option value="f">여</option>
						</select>
						</td>
					</tr>
					<tr>
						<td>&nbsp;&nbsp;<b>E-mail</b>
						<br>
						<input type="text" class="email" name="mail" id="user_mail" placeholder="&nbsp;&nbsp;e-mail을 입력해주세요">
						<br>
						<input type="button" class="codenumber" name="codenumber" value="인증번호 받기" onclick="DoSend();">
						<br>
						<input type="text" class="codenumberck" name="codenumberck" id="codenumber" placeholder="&nbsp;&nbsp;인증번호를 입력해주세요">
						<br>
						<input type="button" class="codenumber" name="codenumber" value="인증하기" onclick="DoMailCheck();">
						<br>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<br>
							<input type="button" class="joinbutton" value="회원가입"  onclick="Dojoin();" >
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<br>
							<input type="button" class="joinbutton" value="취소"  onclick="javascript:document.location='/kick_off_view/jsp/index/index.jsp';" >
						</td>
					</tr>					
				</table>
				</form>		
			</div>
		</div>
		<br>
		<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>