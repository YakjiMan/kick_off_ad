<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<%
String post_no = request.getParameter("post_no");
String reply_no = request.getParameter("reply_no");
String like_hate = request.getParameter("like_hate");

UserinfoVO login_vo = (UserinfoVO)session.getAttribute("login");

if(login_vo == null)
{
	out.println("로그인 후 이용하여 주시기 바랍니다.");
	return;
}

Like_HateVO vo = new Like_HateVO();
vo.setPost_no(post_no);
vo.setReply_no(reply_no);
vo.setLike_hate(like_hate);
vo.setUser_no(login_vo.getUser_no());

Like_HateDTO dto = new Like_HateDTO();

//게시글 좋아요,싫어요 동작
if(dto.PostCheckLH(vo).equals("n"))
{
	dto.InsertPostLH(vo);
}
else if(dto.PostCheckLH(vo).equals(like_hate))
{
	dto.DeletePostLH(vo);
}
else if(!dto.PostCheckLH(vo).equals(like_hate) && !dto.PostCheckLH(vo).equals("n"))
{
	dto.DeletePostLH(vo);
	dto.InsertPostLH(vo);
}
%>