<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>ȸ������</title>				
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
			alert("�˻�� �Է����ּ���.")
			return;
		}
		else
		{
			$("#top_search").submit();
		}
	}
</script>
<!-- main ���� -->
<%
int pageno = 1;
try
{
	pageno = Integer.parseInt(request.getParameter("page"));
}
catch(Exception e){};

ListDTO dto = new ListDTO();

int list_count = 10;
//��ü�ڷ��� ������ ��ȸ�Ѵ�.
int total = dto.GetUserTotal();
int max_page = total / list_count; //��ü ������ ����
if(total % list_count != 0) max_page += 1;

ArrayList<UserinfoVO> list = dto.GetUserList(list_count,pageno);


%>
<script>
	function ModifyPop(no)
	{
		var url  = "/kick_off_view/jsp/admin/admin_modify.jsp?no=" + no ;
		var name = "ȸ����������";
		
		window.open(url,name,"width=700,height=800,resizable=no,left=250,top=150");
	}
</script>
<div class="main">
	<h1 class="sitename" align="center">Kick off</h1>
	<div class="news_main">
		<div class="news_frame">
			<table style="border:1px solid #f4f4f4;">
				<tr style="text-align:center;">
					<td>ȸ����ȣ</td>
					<td>���̵�</td>
					<td>�̸�</td>
					<td>�г���</td>
					<td>����</td>
					<td>��������</td>
					<td>�̸���</td>
					<td>ȸ�����</td>
					<td>Ż�𿩺�</td>
					<td>����</td>
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
							<td>����</td>
							<%
						}
						else
						{
							%>
							<td>����</td>
							<%
						}
						%>
						<td><%= vo.getUser_date() %></td>
						<td><%= vo.getUser_mail() %></td>
						<td><%= vo.getUser_grade() %></td>
						<td><%= vo.getUser_exit() %></td>
						<td><input type="button" onclick="ModifyPop(<%= vo.getUser_no() %>);" value="��������" class="search_button">
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
				//���� ���� ǥ���ϱ�
				if(StartBlock > 5)
				{
					%>
					<a href="/kick_off_view/jsp/admin/admin.jsp?page=<%= StartBlock - 1 %>">����</a>
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
				//���� ���� ǥ���ϱ�
				if(EndBlock < max_page)
				{
					%>
					<a href="/kick_off_view/jsp/admin/admin.jsp?page=<%= EndBlock + 1 %>">����</a>
					<%				
				}
				%>
				</td>
			</tr>
		</table>
	</div>
</div>
<br>
<!-- main ���� -->
<%@ include file="../include/footer.jsp" %>