<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="../include/header.jsp" %>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<%
String id = request.getParameter("user_id");
String pw = request.getParameter("user_pw");

if(id.equals("") || id == null || pw.equals("") || pw == null)
{
	response.sendRedirect("login.jsp");
	return;
}

UserinfoDTO dto = new UserinfoDTO();
UserinfoVO vo   = dto.Login(id, pw);
if(vo == null)
{
	%>
	<script>
		alert("아이디 또는 비밀번호가 일치하지 않거나 탈퇴한 회원입니다.");
		document.location = "login.jsp";
	</script>
	<%
}
else
{
	session.setAttribute("login", vo);
	response.sendRedirect("/kick_off_view/jsp/index/index.jsp");
}
%>
	
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<%@ include file="../include/footer.jsp" %>