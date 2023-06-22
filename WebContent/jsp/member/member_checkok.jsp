<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>수정완료</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/member_checkok.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	<script>
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

<%@ page import="java.io.*" %>    
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<%
request.setCharacterEncoding("EUC-KR");

String name   = request.getParameter("user_name");
String id     = request.getParameter("user_id");
String user_pw = request.getParameter("user_pw");


UserinfoDTO dto = new UserinfoDTO();
dto.DBOpen();
String sql = "";
sql  = "select user_no from userinfo ";
sql += "where user_pw=md5('" + dto._R(user_pw) + "') ";
dto.RunQuery(sql);
if(dto.GetNext() == false)
{
%>
	<script>
		alert("비밀번호가 일치하지 않습니다.")
		window.history.back();
	</script>
<%
	dto.DBClose();
	return;
}
dto.DBClose();

%>
<%
response.sendRedirect("/kick_off_view/jsp/member/member_info.jsp");
%>
		<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>