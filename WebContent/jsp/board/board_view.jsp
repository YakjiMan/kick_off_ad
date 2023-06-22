<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>�Խñ� ����</title>
	<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
	<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
	<link href="css/board_view.css" rel="stylesheet" type="text/css">
	<script src="../../js/jquery-3.6.3.js"></script>
</head>
<%@ include file="../include/header.jsp" %>
<%
	String no     = request.getParameter("no");
	String mcate  = request.getParameter("mcate");
	if(mcate == null || mcate == "") mcate = "f";
	String sort   = request.getParameter("sort");
	String pageno = request.getParameter("page");
	String type    = request.getParameter("type");
	String keyword = request.getParameter("keyword");
	String search_type = request.getParameter("search_type");
	String oname = request.getParameter("oname");
	
	if(no == null || no.equals(""))
	{
		response.sendRedirect("/kick_off_view/jsp/board/board_list.jsp");
		return;
	}
	
	PostDTO dto = new PostDTO();
	PostVO  vo  = dto.Read(no, true);
	//##############################################################################
	ad_listDTO DTO = new ad_listDTO();
	pop_upDTO popDTO = new pop_upDTO();
	ad_managerDTO adDTO = new ad_managerDTO();
	ArrayList<analyze1VO> word_list1  = popDTO.Read1(no);
	PostVO VO = popDTO.Read(no);

	ArrayList<ad_managerVO> list = DTO.GetList();
	
	ad_managerVO ad_vo = null;
	String ad_key = "";

	int flag = 0;
	// �� ����Ʈ �ݺ�
	for( analyze1VO item : word_list1 )
	{
		int count = 0;
		// ���� �ܾ� ����Ʈ �ݺ�
		ArrayList<analyze2VO> word_list2  = popDTO.Read2(item.getAnal_no());
		for( analyze2VO object : word_list2 )
		{
			// ��Ī�� ������ ã�� ��������
			if( flag == 0 )
			{
				if( count == 0 )
				{	// �� �ܾ�� �˻�
					ad_key = item.getMorph_origin_key();
				}else
				{	// �����ܾ�� �˻�
					ad_key = object.getMorph_relation_key();
				}
				System.out.println("�˻��� Ű���� : " + ad_key);
				
				int ad_no = popDTO.Find_ad(ad_key);	// �˻� �� Ű����� ������ �˻��Ѵ�
				if( ad_no > 0 )
				{
					ad_vo = popDTO.Read_ad(ad_no);
					
					if( ad_vo == null) return;
					flag = 1;
					System.out.println(ad_key+"�� ������ �˻��Ǿ����ϴ�.\nflag : " + flag );
					System.out.println("������ȣ : " + ad_vo );
				} // ���� ��ȣ�� �Ѿ���� ������ �˻��Ȱ� : ���� ��ȣ�� ���� vo��ü�� ����
				// ���� ��ü�� �����Ǿ����� �÷��׸� ����
			}
			count++;
			String style = "";
			if( count == 0 )
			{
				if( flag == 1 && item.getMorph_origin_key().equals(ad_key) ) 
				{
					style = "style='background-color:silver; color:black;'";
				}	style = "";
			}
			if( flag == 1 && object.getMorph_relation_key().equals(ad_key) ) 
			{
				style = "style='background-color:silver; color:black;'";
			}
		}
		
	//if( flag != 0 )	{ break; }
	}
%>
<script>
	window.onload = function()
	{
		Like_Hate();
		ReplyList();
	}
	
	function AttachDown()
	{
		if(confirm("������ �ٿ�ε� �Ͻðڽ��ϱ�?") == true)
		{
			alert("������ �ٿ�޽��ϴ�");
		}
		else
		{
			return false;
		}
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
		
	function Like_Hate()
	{
		$.ajax({
			type : "get",
			url: "/kick_off_view/jsp/board/post_like_hate.jsp?no=<%= no %>",
			dataType: "html",
			success : function(data) 
			{
				$("#like_hate").html(data);
			}			
		});
	}
	function DoLike()
	{
		$.ajax({
			type    : "post",
			url     : "/kick_off_view/jsp/board/like_hateOnOff.jsp",
			data    : 
			{
				post_no : "<%= no %>",
				like_hate : "l"
			},
			dataType: "html",
			success : function(data) 
			{	
				// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				data = data.trim();
				if(data != "")
				{
					alert(data);
				}
				Like_Hate();
			}
		});
	}
	function DoHate()
	{
		$.ajax({
			type    : "post",
			url     : "/kick_off_view/jsp/board/like_hateOnOff.jsp",
			data    : 
			{
				post_no : "<%= no %>",
				like_hate : "h"
			},
			dataType: "html",
			success : function(data) 
			{	
				// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				data = data.trim();
				if(data != "")
				{
					alert(data);
				}
				Like_Hate();
			}
		});
	}
	
	function ReplyList()
	{
		$.ajax({
			type : "get",
			url: "/kick_off_view/jsp/reply/reply.jsp?no=<%= no %>",
			dataType: "html",
			success : function(data) 
			{
				$("#reply_list").html(data);
			}			
		});
	}
	function AddReply()
	{
		if($("#reply_note").val() == "")
		{
			alert("����� �Է��ϼ���");
			$("#reply_note").focus();
			return;
		}
		if(confirm("����� ����Ͻðڽ��ϱ�?") == true)
		{
			$.ajax({
				type    : "post",
				url     : "/kick_off_view/jsp/reply/reply_write.jsp",
				data    : 
				{
					no : "<%= no %>",
					reply_note : $("#reply_note").val()
				},
				dataType: "html",
				success : function(data) 
				{	
					// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
					data = data.trim();
					alert(data)
					ReplyList();
				}
			});
		}
	}
	function DeleteReply(reply_no)
	{
		if(confirm("�ش� ����� �����Ͻðڽ��ϱ�?") == false)
		{
			return;
		}
		$.ajax({
			type    : "get",
			url     : "/kick_off_view/jsp/reply/reply_delete.jsp?reply_no=" + reply_no,
			dataType: "html",
			success : function(data) 
			{	
				// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				ReplyList();
			}
		});
	}
	function DoBlind()
	{
		if("<%= vo.getPost_blind() %>" == "n")
		{
			if(confirm("�ش� �Խù��� �����ε��Ͻðڽ��ϱ�?") == false)
			{
				return;
			}
		}
		else
		{
			if(confirm("�ش� �Խù��� �����ε� ���� �Ͻðڽ��ϱ�?") == false)
			{
				return;
			}
		}
		$.ajax({
			type    : "get",
			url     : "/kick_off_view/jsp/board/blindok.jsp?no=" + <%= no %>,
			dataType: "html",
			success : function(data) 
			{	
				// ����� ���������� �̷�������� �� �Լ��� Ÿ�Եȴ�.
				data = data.trim()
				alert(data)
				location.reload();
			}
		});
	}
	
	function Side_Pop()
	{
		var url  = "/kick_off_view/jsp/adpop/pop_up1.jsp?no=<%= no %>";
		var name = "�м�����";
		
		window.open(url,name,"width=1350,height=900,resizable=no,left=250,top=150");
	}
	</script>
<!-- main ���� -->
		<div class="main">
		<%
		if(ad_vo != null)
		{
			ad_managerVO advo = adDTO.Read(ad_vo.getAd_no(), true);
			%>
			<div class="sidead">
				<img src="../../adimg/<%= advo.getH_image_fname() %>" width="200px" height="600px" onclick="Side_Pop()">
			</div>
			<%
		}else
		{
			%>
			<div style="display:none;" class="sidead">
				<img src="../../adimg/" width="200px" height="600px" onclick="Side_Pop()">
			</div>
			<%
		}
		%>
		<br>
		<div class="board_frame">
		<table class="top_level_table">
			<tr>
				<td>
					<table class="main_title_table">
						<tr>
							<td class="board_title" width="80%"><a href="/kick_off_view/jsp/board/board_list.jsp?no=1">�����Խ���</a></td>
							<td>
								<%
								if(login_vo != null)
								{
									if(Integer.parseInt(login_vo.getUser_grade()) == 3)
									{
										%>
										<table>
											<tr>
												<%
												if(vo.getPost_blind().equals("n"))
												{
													%>
													<td>
														<img src="../../img/manager1.png" class="blind_icon" onclick="DoBlind();">
													</td>
													<%
												}
												else
												{
													%>
													<td>
														<img src="../../img/manager2.png" class="blind_icon" onclick="DoBlind();">
													</td>
													<%
												}
												%>
											</tr>
										</table>
										<%
									}
								}
								%>
							</td>
						</tr>
					</table>
					<table class="post_title_table">
						<tr class="board_list_title">
							<td class="title"><%= vo.getPost_title() %></td>
							<td align="right"><%= vo.getPost_date() %></td>
						</tr>
					</table>
					<table class="privacy_table">
						<tr class="id_line">
							<td align="left">�ۼ��� : <%= vo.getUser_nick() %></td>
							<td align="right">��ȸ�� : <%= vo.getPost_view() %></td>
						</tr>
					</table>
					<br><br><br>
					<table>
						<tr>
							<td height="250px">
								<%
								String note = vo.getPost_note();
								note = note.replace("<p>","");
								note = note.replace("</p>","");
								note = note.replace("\n","\n<br>");	
								out.println(note);
								%>
							</td>
						</tr>
					</table>
					<div class="emo_frame">
						<div id="like_hate"></div>
					</div>	
					÷������ : <a href="/kick_off_view/jsp/board/board_down.jsp?no=<%= no %>" onclick="return AttachDown();"><%= vo.getPost_oname() %></a>   
					<table class="reply_table">
						<tr>
							<td class="table_data_reply">&nbsp;���(<%= vo.getReply_count() %>)</td>
							<td class="table_data_tree_button">
							<%
							if(login_vo != null)
							{
								if(login_vo.getUser_no().equals(vo.getUser_no()) || login_vo.getUser_grade().equals("3"))
								{
								%>
								<input type="button" class="middle_modify_button" value="����" onclick="location.href='/kick_off_view/jsp/board/board_modify.jsp?no=<%= no %>&type=<%= type %>&page=<%= pageno %>&mcate=<%= mcate %>&oname=<%= vo.getPost_oname() %>'">
								<input type="button" class="middle_delete_button" value="����" onclick="alert('�����Ͻðڽ��ϱ�?');location.href='/kick_off_view/jsp/board/board_delete.jsp?no=<%= no %>&page=<%= pageno %>&mcate=<%= mcate %>&type=<%= type %>'">
								<input type="button" class="middle_list_button" value="���" onclick="location.href='/kick_off_view/jsp/board/board_list.jsp?page=<%= pageno %>&mcate=<%= mcate %>'">
								<%
								}
							}else
							{
								%>
								<input type="button" class="middle_list_button1" value="���" onclick="location.href='/kick_off_view/jsp/board/board_list.jsp?page=<%= pageno %>&mcate=<%= mcate %>'">
								<%
							}
							%>
								
							</td>
						</tr>
					</table>
					<div id="reply_list"></div>
					<br>
				</td>
			</tr>
		</table>
		</div>
		<br>
		</div>
<!-- main �� -->

<%@ include file="../include/footer.jsp" %>