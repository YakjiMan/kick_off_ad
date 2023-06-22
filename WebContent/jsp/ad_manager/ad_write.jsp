<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<%
String no = request.getParameter("no");
ad_managerVO vo   = new ad_managerVO();
ad_managerDTO dto = new ad_managerDTO();
%> 
<!DOCTYPE html>
<html>
	<head>
	<meta charset="EUC-KR">
	<title>ad_write</title>
	<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
	<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
	<link href="css/ad_write.css" rel="stylesheet" type="text/css">
	<script src="../../js/jquery-3.6.3.js"></script>
	<script>
	window.onload = function()
	{
		$("#ad_name").focus();
	}
	
	function DoSave()
	{
		if($("#ad_name").val() == "")
		{
			alert("광고이름을 입력하세요");
			$("#ad_name").focus();
			return false;
		}
		if($("#ad_keyword").val() == "")
		{
			alert("광고키워드를 입력하세요");
			$("#ad_keyword").focus();
			return false;
		}
		if($("#w_image").val() == "")
		{
			alert("가로 이미지를 첨부하세요");
			$("#w_image").focus();
			return false;
		}
		if($("#h_image").val() == "")
		{
			alert("세로 이미지를 첨부하세요");
			$("#h_image").focus();
			return false;
		}	
		if(confirm("작성된 광고내용을 저장하시겠습니까?") == false)
		{
			return false;	
		}
		return true;
	}	
</script>
	<style>	
	  @import url('https://fonts.googleapis.com/css2?family=Hahmlet&display=swap');
</style>
	</head>
	<body class="main_body">
		<div class="main_box">
			<div class="main_title" onclick="location.href='ad_write.jsp'">
				광고 등록
			</div>
			<form enctype="multipart/form-data" method="post" id="ad_reg" action="ad_writeok.jsp?no=<%= no %>" onsubmit="return DoSave();">
				<input type="submit" class="ad_reg" name="ad_reg" value="등록">
				<hr class="horizon">
				<table class="main_table">
					<tr>
						<td class="title_td">광고이름</td>
						<td><input type="text" id="ad_name" name="ad_name" style="width:95%"></td>
					</tr>
					<tr>
						<td class="title_td">광고키워드</td>
						<td><input type="text" id="ad_keyword" name="ad_keyword" style="width:95%"></td>
					</tr>
					<tr>
						<td class="title_td">가로 광고이미지 첨부</td>
						<td><input type="file" id="w_image" name="w_image" style="width:95%"></td>
					</tr>
					<tr>
						<td class="title_td">세로 광고이미지 첨부</td>
						<td><input type="file" id="h_image" name="h_image" style="width:95%"></td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>