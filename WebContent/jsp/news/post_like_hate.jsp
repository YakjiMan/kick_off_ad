<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<%
String post_no = request.getParameter("no");
if(post_no.equals("") || post_no == null) post_no = "";

UserinfoVO login_vo = (UserinfoVO)session.getAttribute("login");
if(login_vo == null) login_vo = null;

Like_HateDTO dto = new Like_HateDTO();

String like_count = dto.PostLike(post_no);
String hate_count = dto.PostHate(post_no);

if(login_vo != null)
{
	Like_HateVO vo = new Like_HateVO();
	vo.setPost_no(post_no);
	vo.setUser_no(login_vo.getUser_no());
	%>
	<div class="good">
		<table>
			<tr>
				<%
				vo.setLike_hate("l");
				if(!dto.PostCheckLH(vo).equals("l"))
				{
					%>
					<td onclick="DoLike();"><img src="../../img/like_off.png" class="like"></td>
					<%
				}
				else
				{
					%>
					<td onclick="DoLike();"><img src="../../img/like_on.png" class="like"></td>
					<%
				}
				%>
			</tr>
			<tr>
				<td class="emo_number"><%= like_count %></td>
			</tr>
			<tr>
				<td class="emo_name">좋아요</td>
			</tr>
		</table>
	</div>
	<div class="bad">
		<table>
			<tr>
				<%
				vo.setLike_hate("h");
				if(!dto.PostCheckLH(vo).equals("h"))
				{
					%>
					<td onclick="DoHate();"><img src="../../img/hate_off.png" class="hate"></td>
					<%
				}
				else
				{
					%>
					<td onclick="DoHate();"><img src="../../img/hate_on.png" class="hate"></td>
					<%
				}
				%>
			</tr>
			<tr>
				<td class="emo_number"><%= hate_count %></td>
			</tr>
			<tr>
				<td class="emo_name">싫어요</td>
			</tr>
		</table>
	</div>
	<%
}
else
{
	%>
	<div class="good">
	<table>
		<tr>
			<td onclick="DoLike();"><img src="../../img/like_off.png" class="like"></td>
		</tr>
		<tr>
			<td class="emo_number"><%= dto.PostLike(post_no) %></td>
		</tr>
		<tr>
			<td class="emo_name">좋아요</td>
		</tr>
	</table>
	</div>
	<div class="bad">
		<table>
			<tr>
				<td onclick="DoHate();"><img src="../../img/hate_off.png" class="hate"></td>
			</tr>
			<tr>
				<td class="emo_number"><%= dto.PostHate(post_no) %></td>
			</tr>
			<tr>
				<td class="emo_name">싫어요</td>
			</tr>
		</table>
	</div>
<%
}
%>