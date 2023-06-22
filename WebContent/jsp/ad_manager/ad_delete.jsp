<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%
String ad_no = request.getParameter("no");

ad_managerDTO dto = new ad_managerDTO();
dto.Delete(ad_no);
%>
<script>
	alert("게시물을 삭제하였습니다");
	document.location = "ad_main.jsp";
</script>