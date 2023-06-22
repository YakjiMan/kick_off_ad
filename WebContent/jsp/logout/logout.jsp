<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
session.setAttribute("login", null);

response.sendRedirect("/kick_off_view/jsp/index/index.jsp");
%>