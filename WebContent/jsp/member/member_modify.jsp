<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>회원정보 수정</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/member_modify.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	<script>
		window.onload = function()
		{
			$(".sidead").css({"display" : "none"});
		}
		function DoModify(){
			if($(".name").val() == ""){
				alert("이름를 입력해주세요.")
				$(".name").focus()
				return false;
			}
			if($(".mail").val() == ""){
				alert("이메일을 입력해주세요.")
				$(".Email").focus()
				return false;
			}
			if($(".nick").val() == ""){
				alert("닉네임 입력해주세요.")
				$(".nick").focus()
				return false;
			}
			if(confirm("정보를 수정하시겠습니까?") == false)
			{
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
			window.history.back();
		}
	</script>
	<%@ include file="../include/header.jsp" %>
<!-- main 시작 -->
		<div class="main">
		<form class="member_modfiy" name="modify" method="post" action="/kick_off_view/jsp/member/member_modifyok.jsp" onsubmit="return DoModify();">
			<input type="hidden" name="user_no" value="<%= login_vo.getUser_no() %>">
			<div class="profileimg">
				<img class="userimg2" src="../../img/user.png">
				<br>
				<%= login_vo.getUser_name() %>
			</div>
			<div class="profileframe">
				<div class="profiletext">
					<p>이름<p>
					<input type="text" name="user_name" class="name" value="<%= login_vo.getUser_name() %>">
					<p>닉네임<p>
					<input type="text" name="user_nick" class="nick" value="<%= login_vo.getUser_nick() %>">
					<p>E-mail<p>
					<input type="text" name="user_mail" class="mail" value="<%= login_vo.getUser_mail() %>">
					<p>성별<p>
					<select name="user_gender" class="gender">
						<option value="m" <%= login_vo.getUser_gender().equals("m") ? "selected" : "" %>>남자</option>
						<option value="f" <%= login_vo.getUser_gender().equals("f") ? "selected" : "" %>>여자</option>
					</select>
				</div>
			</div>
			<div class="modifyok">
				<input type="submit" name="modifyok" value="수정 완료">
			</div>
			<div class="modifyok">
				<input type="button" class="button" value="취소" onclick="DoBack();">
			</div>
		</form>
		</div>
			<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>