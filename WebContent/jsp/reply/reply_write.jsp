<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<%
String no = request.getParameter("no");
String reply_note = request.getParameter("reply_note");
UserinfoVO login_vo = (UserinfoVO)session.getAttribute("login");

if(login_vo == null)
{
	out.println("로그인 하지 않은 사용자입니다.");
	return;
}

ReplyVO vo = new ReplyVO();
vo.setPost_no(no);
vo.setUser_no(login_vo.getUser_no());
vo.setReply_note(reply_note);

ReplyDTO dto = new ReplyDTO();
dto.Insert(vo);

out.println("댓글을 등록하였습니다.");
%>