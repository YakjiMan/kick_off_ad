<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %> 
<%
ad_managerVO vo   = new ad_managerVO();
ad_managerDTO dto = new ad_managerDTO();
ad_listDTO DTO    = new ad_listDTO();

ArrayList<ad_managerVO> list = DTO.GetList();
%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="EUC-KR">
	<title>ad_main</title>
	<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
	<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
	<link href="css/ad_main.css" rel="stylesheet" type="text/css">
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
				kickoff ���� ���� ������
			</div>
			<form method="get" id="ad_registration" action="ad_write.jsp">
				<input type="button" class="ad_registration" name="ad_registration" value="�������" onclick="location.href='ad_write.jsp'">
			</form>
			<hr class="horizon">
			<div id="Pop" class="Pop">
				<div>
					<table>
						<tr>
							<td class="pop_td">���� Ű���� ������ �м�</td>
						</tr>
						<tr>
							<td></td>
						</tr>
					</table>
				</div>
   				<input type="button" class="pop_button" value="�ݱ�" onclick="DoPopClose()">
			</div>
			<table class="main_table">
				<tr class="main_tr">
					<td class="title_td">no</td>
					<td class="title_td1">�����̸�</td>
					<td class="title_td2">�������</td>
				</tr>
				<% 
				for(ad_managerVO VO : list)
				{
					String name = VO.getAd_name();
					if( name.length() > 22)
					{
						name = name.substring(0,22);
						name += "...";
					}
				%>
				<tr class="main_tr">
					<td class="main_td"><%= VO.getAd_no() %></td>
					<td class="main_td1"><a class="a_tag" href="ad_view.jsp?no=<%= VO.getAd_no() %>"><%= VO.getAd_name() %></a></td>
					<td class="main_td2"><img class="side_img" src="../../adimg/<%= VO.getW_image_fname() %>" onclick="location.href='ad_view.jsp?no=<%= VO.getAd_no() %>'"></td>
				</tr>
				<%
				}
				%>
			</table>
		</div>
	</body>
</html>