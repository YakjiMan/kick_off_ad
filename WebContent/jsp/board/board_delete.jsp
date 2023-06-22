<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %> 
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>board_delete</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/board_write.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
		
		<script src="../../summernote/summernote-lite.js"></script>
		<script src="../../summernote/lang/summernote-ko-KR.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
</head>
<%@ include file="../include/header.jsp" %>
<%
String no     = request.getParameter("no");
String pageno = request.getParameter("page");
String mcate  = request.getParameter("mcate");
if( no == null || no.equals("") )
{
	response.sendRedirect("/kick_off_view/jsp/board/board_list.jsp");
	return;
}

PostDTO dto = new PostDTO();
dto.Delete(no);
%>
<script>
	alert("게시물을 삭제하였습니다");
	document.location = "/kick_off_view/jsp/board/board_list.jsp?page=<%= pageno %>&mcate=<%= mcate %>";
</script>
<%@ include file="../include/footer.jsp" %>