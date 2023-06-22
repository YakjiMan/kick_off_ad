<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>ȸ������ ����</title>
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
				alert("�̸��� �Է����ּ���.")
				$(".name").focus()
				return false;
			}
			if($(".mail").val() == ""){
				alert("�̸����� �Է����ּ���.")
				$(".Email").focus()
				return false;
			}
			if($(".nick").val() == ""){
				alert("�г��� �Է����ּ���.")
				$(".nick").focus()
				return false;
			}
			if(confirm("������ �����Ͻðڽ��ϱ�?") == false)
			{
				return false;
			}
			return true;
		}
		function DoSearch()
		{
			if($(".searcher").val() == "")
			{
				alert("�˻�� �Է����ּ���.")
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
<!-- main ���� -->
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
					<p>�̸�<p>
					<input type="text" name="user_name" class="name" value="<%= login_vo.getUser_name() %>">
					<p>�г���<p>
					<input type="text" name="user_nick" class="nick" value="<%= login_vo.getUser_nick() %>">
					<p>E-mail<p>
					<input type="text" name="user_mail" class="mail" value="<%= login_vo.getUser_mail() %>">
					<p>����<p>
					<select name="user_gender" class="gender">
						<option value="m" <%= login_vo.getUser_gender().equals("m") ? "selected" : "" %>>����</option>
						<option value="f" <%= login_vo.getUser_gender().equals("f") ? "selected" : "" %>>����</option>
					</select>
				</div>
			</div>
			<div class="modifyok">
				<input type="submit" name="modifyok" value="���� �Ϸ�">
			</div>
			<div class="modifyok">
				<input type="button" class="button" value="���" onclick="DoBack();">
			</div>
		</form>
		</div>
			<!-- main �� -->
<%@ include file="../include/footer.jsp" %>