<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %> 
<%
String user_no = request.getParameter("no");

UserinfoDTO dto = new UserinfoDTO();
dto.UserExit(user_no);

session.setAttribute("login", null);

out.println("Å»Åð°¡ ¿Ï·áµÇ¾ú½À´Ï´Ù.");
%>