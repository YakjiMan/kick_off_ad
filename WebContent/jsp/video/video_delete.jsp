<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>등록완료</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/video_delete.css" rel="stylesheet" type="text/css">
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
<%
String mcate  = request.getParameter("mcate");
String scate  = request.getParameter("scate");
String sort   = request.getParameter("sort");
String pageno = request.getParameter("page");
String no = request.getParameter("no");

if(no == null || no.equals(""))
{
	response.sendRedirect("/kick_off_view/jsp/index/index.jsp");
	return;
}

PostDTO dto = new PostDTO();
dto.Delete(no);
%>
<script>
	alert("게시물이 삭제되었습니다.");
	document.location = "/kick_off_view/jsp/video/video.jsp?page=<%= page %>&sort=<%= sort %>&mcate=<%= mcate %>";
</script>
		<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>