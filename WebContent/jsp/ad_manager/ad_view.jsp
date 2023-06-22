<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<%
String ad_no = request.getParameter("no");

ad_managerDTO dto = new ad_managerDTO();
ad_managerVO vo   = dto.Read(ad_no,true);
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="EUC-KR">
	<title>ad_view</title>
	<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
	<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
	<link href="css/ad_view.css" rel="stylesheet" type="text/css">
	<script src="../../js/jquery-3.6.3.js"></script>
<script>

</script>
	<style>	
		  @import url('https://fonts.googleapis.com/css2?family=Hahmlet&display=swap');
	</style>
	</head>
	<body class="main_body">
		<div class="main_box">
			<div class="main_title" onclick="location.href='ad_main.jsp'">
				kickoff 광고 관리 페이지
			</div>
			<form method="get" id="ad_registration" action="ad_write.jsp">
				<input type="button" class="ad_modify" name="ad_modify" value="수정" onclick="location.href='ad_modify.jsp?no=<%= ad_no %>'">
				<input type="button" class="ad_delete" name="ad_delete" value="삭제" onclick="location.href='ad_delete.jsp?no=<%= ad_no %>'">
			</form>
			<hr class="horizon">
			<table class="view_table">
				<tr>
					<td class="title_td">광고이름 : </td>
					<td class="ad_td"><%= vo.getAd_name() %> </td>
				</tr>
				<tr>
					<%
						String name = vo.getAd_keyword();
						if( name.length() > 200)
						{
							name = name.substring(0,220);
							name += "........";
						}
					%>
					<td class="title_td">광고 키워드 :</td>
					<td class="ad_td1"><%= name %></td>
				</tr>
				<tr>
					<td class="title_td">가로 광고 이미지 </td>
					<td class="ad_td"><img src="../../adimg/<%= vo.getW_image_fname() %>" class="w_img"></td>
				</tr>
				<tr>
					<td class="title_td">세로 광고 이미지 </td>
					<td class="ad_td"><img src="../../adimg/<%= vo.getH_image_fname() %>" class="h_img"></td>
				</tr>
			</table>
			 
		</div>
		
	</body>
</html>