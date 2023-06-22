<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %> 
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%
String no     = request.getParameter("no");
String blind  = request.getParameter("blind");
String pageno = request.getParameter("pageno");

PostVO vo = new PostVO();
PostDTO dto = new PostDTO();
dto.Blind(vo);

response.sendRedirect("/kick_off_view/jsp/board/board_view.jsp?no=" + vo.getPost_no());
%>