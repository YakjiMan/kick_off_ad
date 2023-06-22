<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<%
String no = request.getParameter("no");
UserinfoVO login_vo = (UserinfoVO)session.getAttribute("login");
%>
<div><hr class="line"></div>
<div class="reply">
	<%
	ReplyDTO dto = new ReplyDTO();
	ArrayList<ReplyVO> list = dto.GetList(no);
	for(ReplyVO vo : list)
	{
		%>
		<table>	
			<tr>
				<td class="reply_name"><%= vo.getUser_nick() %></td>
				<td class="reply_date" colspan="2">(<%= vo.getReply_date() %>)</td>
			</tr>
			<tr>
				<td class="reply_text"><%= vo.getReply_note() %></td>
				<%
				if(login_vo != null)
				{
					if(login_vo.getUser_no().equals(vo.getUser_no()) || login_vo.getUser_grade().equals("3"))
					{
						%>
						<td class="reply_delete"><input type="button" value="삭제" class="rdelete_button" onclick="DeleteReply(<%= vo.getReply_no() %>);"></td>
						<%
					}
				}
				%>
			</tr>
			<tr><td colspan="100"><hr class="reply_line"></td></tr>
		</table>
		<%
	}
	%>
</div>
<div><hr class="line"></div>
<div class="reply">
	<%
	if(login_vo != null)
	{
		%>
		<table>
			<tr>
				<td align="center"><%= login_vo.getUser_nick() %></td>
				<td align="center"><input type="text" placeholder="내용을 입력해주세요" class="reply_textwrite" id="reply_note"></td>
				<td align="center"><input type="button" value="입력" class="reply_button" onclick="AddReply();">
			</tr>
		</table>
		<%
	}
	%>
</div>