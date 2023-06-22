<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %> 
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>게시판 글쓰기</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/board_write.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
		
		<script src="../../summernote/summernote-lite.js"></script>
		<script src="../../summernote/lang/summernote-ko-KR.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	</head>
	<script>
		window.onload = function()
		{
			$("#title_write_box").focus();
		}
		
		$(document).ready(function() {
			//여기 아래 부분
			$('#summernote').summernote({
				  height: 300,                 // 에디터 높이
				  minHeight: null,             // 최소 높이
				  maxHeight: null,             // 최대 높이
				  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
				  lang: "EUC-KR",					// 한글 설정
				  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
		          
			});
		});
		
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
		
		function DoSubmit()
		{
			if($("#title").val() == "" || $("#title").val() == null)
			{
				alert("제목을 입력해주세요.");
				$("#title").focus();
				return false;
			}
			if($("#summernote").val() == "" || $("#summernote").val() == null)
			{
				alert("내용을 입력해주세요.");
				$("#summernote").focus();
				return false;
			}
			if(confirm("게시물을 등록하시겠습니까?") == false)
			{
				return false;
			}
			
			$("#board_write").submit();
		}
		function DoBack()
		{
			if(confirm("작성을 취소하시겠습니까?") == false)
			{
				return;
			}
			window.history.back();
		}
	</script>
<%@ include file="../include/header.jsp" %>
<%
if( login_vo == null)
{
	response.sendRedirect("/kick_off_view/jsp/login/login.jsp");
	return;
}

String pageno      = request.getParameter("page");
String mcate       = request.getParameter("mcate");
String sort        = request.getParameter("sort");
String search_type = request.getParameter("search_type");

%>
		
<!-- main 시작 -->
<div class="main">
<br>
	<form id="board_write" enctype="multipart/form-data" method="post" action="/kick_off_view/jsp/board/board_writeok.jsp?page=<%= pageno %>&mcate=<%= mcate %>">
	<table class="top_level_table">
		<tr>
			<td>
				<table class="main_title_table">
					<tr>
						<td class="board_title"><a href="/kick_off_view/jsp/board/board_list.jsp?no=1">자유게시판</a></td>
						
					</tr>
				</table>
				<hr class="horizon">
				<table class="title_write_table">
					<tr>
						<td>
							<%
							if(login_vo != null)
							{
								if(Integer.parseInt(login_vo.getUser_grade()) == 3)
								{
									%>
									<select class="top_sort" id="top_sort" name="mcate">
										<option value="n">공지글</option>
										<option value="f" selected>일반글</option>
									</select>
									<%
								}
								else
								{
									%>
									<input type="hidden" name="mcate" value="f">
									<%
								}
							}
							%>
						</td>
					</tr>
					<tr class="id_line">
						<td><h4>제목 :</h4></td>
						<td>
							<input type="text" class="title_write_box" id="title" name="title">
						</td>
						<td class="writer_name_table_data"><h4>작성자 : <%= login_vo.getUser_nick() %></h4></td>
					</tr>
				</table>
				<div>
					<textarea id="summernote" name="note"></textarea>
				</div>
				<div class="file_button"><input type="file" id="attach" name="attach"></div>
				<div class="registration_button"><a href="javascript:DoSubmit();">등록</a></div>
				<div class="cancel_button"><a href="javascript:DoBack();" class="button_text">취소</a></div>
			</td>
		</tr>
	</table>
	</form>
<br>						
</div>
<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>