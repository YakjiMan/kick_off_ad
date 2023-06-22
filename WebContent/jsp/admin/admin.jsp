<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>회원관리</title>				
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/admin.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
<%@ include file="../include/header.jsp" %>
<script>
	window.onload = function()
	{
		$(".sidead").css({"display" : "none"});
	}
	function DoSearch()
	{
		if($(".searcher").val() == "")
		{
			alert("검색어를 입력해주세요.")
			return;
		}
		else
		{
			$("#top_search").submit();
		}
	}
</script>
<!-- main 시작 -->
<%
int pageno = 1;
try
{
	pageno = Integer.parseInt(request.getParameter("page"));
}
catch(Exception e){};

ListDTO dto = new ListDTO();

int list_count = 10;
//전체자료의 갯수를 조회한다.
int total = dto.GetUserTotal();
int max_page = total / list_count; //전체 페이지 갯수
if(total % list_count != 0) max_page += 1;

ArrayList<UserinfoVO> list = dto.GetUserList(list_count,pageno);


%>
<script>
	function ModifyPop(no)
	{
		var url  = "/kick_off_view/jsp/admin/admin_modify.jsp?no=" + no ;
		var name = "회원정보수정";
		
		window.open(url,name,"width=700,height=800,resizable=no,left=250,top=150");
	}
</script>
<div class="main">
	<h1 class="sitename" align="center">Kick off</h1>
	<div class="news_main">
		<div class="news_frame">
			<table style="border:1px solid #f4f4f4;">
				<tr style="text-align:center;">
					<td>회원번호</td>
					<td>아이디</td>
					<td>이름</td>
					<td>닉네임</td>
					<td>성별</td>
					<td>가입일자</td>
					<td>이메일</td>
					<td>회원등급</td>
					<td>탈퇴여부</td>
					<td>수정</td>
				</tr>
				<%
				for(UserinfoVO vo : list)
				{
					%>
					<tr style="text-align:center;">
						<td><%= vo.getUser_no() %></td>
						<td><%= vo.getUser_id() %></td>
						<td><%= vo.getUser_name() %></td>
						<td><%= vo.getUser_nick() %></td>
						<%
						if(vo.getUser_gender().equals("m"))
						{
							%>
							<td>남자</td>
							<%
						}
						else
						{
							%>
							<td>여자</td>
							<%
						}
						%>
						<td><%= vo.getUser_date() %></td>
						<td><%= vo.getUser_mail() %></td>
						<td><%= vo.getUser_grade() %></td>
						<td><%= vo.getUser_exit() %></td>
						<td><input type="button" onclick="ModifyPop(<%= vo.getUser_no() %>);" value="정보수정" class="search_button">
					</tr>
					<%
				}
				%>
			</table>
		</div>
	</div>
	<div class="page">
		<table>
			<tr>
				<td style="text-align:center;" colspan="2">
				<% 
				int StartBlock = ((pageno - 1) / 5)*5;
				StartBlock += 1;
				int EndBlock = StartBlock + 5 - 1;
				if(EndBlock > max_page)
				{
					EndBlock = max_page;
				}
				//이전 블럭 표시하기
				if(StartBlock > 5)
				{
					%>
					<a href="/kick_off_view/jsp/admin/admin.jsp?page=<%= StartBlock - 1 %>">이전</a>
					<%					
				}
				for(int page_no = StartBlock; page_no <= EndBlock; page_no += 1)
				{
					if(page_no == pageno)
					{
						%>
						<span class="page_on"><b><%= page_no %></b></span>&nbsp;
						<%
					}
					else
					{
						%>
						<a class="page_off" href="/kick_off_view/jsp/admin/admin.jsp?page=<%= page_no %>">
						<%= page_no %>
						</a>&nbsp;
						<%
					}
				}
				//다음 블럭 표시하기
				if(EndBlock < max_page)
				{
					%>
					<a href="/kick_off_view/jsp/admin/admin.jsp?page=<%= EndBlock + 1 %>">다음</a>
					<%				
				}
				%>
				</td>
			</tr>
		</table>
	</div>
</div>
<br>
<!-- main 종료 -->
<%@ include file="../include/footer.jsp" %>