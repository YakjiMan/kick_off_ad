<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<%
String post_no = request.getParameter("no");

PostDTO dto = new PostDTO();
PostVO vo = dto.Read(post_no, false);

dto.Blind(vo);

out.println("블라인드가 처리되었습니다.");
%>