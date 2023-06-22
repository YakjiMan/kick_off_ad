<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>board_modify</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/board_modify.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
		<script src="../../summernote/summernote-lite.js"></script>
		<script src="../../summernote/lang/summernote-ko-KR.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
		<script>
			window.onload = function()
			{
				$("#title").focus();
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
			
			function Do_Submit()
			{
				$("#board_modify").submit();
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
				if(confirm("게시물을 수정하시겠습니까?") == false)
				{
					return false;
				}
				return true;
			}
			function DoBack()
			{
				if(confirm("수정을 취소하시겠습니까?") == false)
				{
					return;
				}
				window.history.back();
			}
		</script>
	</head>
	<%@ include file="../include/header.jsp" %>
	<%
	String no          = request.getParameter("no");
	String mcate       = request.getParameter("mcate");
	String pageno      = request.getParameter("page");
	String keyword     = request.getParameter("keyword");
	String sort        = request.getParameter("sort");
	String search_type = request.getParameter("search_type");
	
	PostDTO dto = new PostDTO();
	PostVO vo = dto.Read(no, true);

	%>
<!-- main 시작 -->
		<div class="main">
		<br>
		<form id="board_modify" enctype="multipart/form-data" method="post" action="/kick_off_view/jsp/board/board_modifyok.jsp?mcate=<%= mcate %>" onsubmit="return DoSubmit();">
		<input type="hidden" name="no" value="<%= no %>"> 
		<input type="hidden" name="oname" value="<%= vo.getPost_oname() %>">
		<input type="hidden" name="pname" value="<%= vo.getPost_pname() %>">
		<table class="top_level_table">
			<tr>
				<td>
					<table class="small_table1">
						<tr>
							<td class="board_title"><a href="/kick_off_view/jsp/board/board_list.jsp?no=1">자유게시판</a></td>
						</tr>
					</table>
					<hr class="horizon">
					<table class="title_write_table">
						<tr class="id_line">
							<td><h4>제목 :</h4></td>
							<td>
								<input class="title_write_box" id="title" name="title" type="text" value="<%= vo.getPost_title() %>">
							</td>
							<td class="writer_name_table_data"><h4>작성자 : <%= vo.getUser_nick() %></h4></td>
						</tr>
					</table>
					<textarea id="summernote" name="note"><%= vo.getPost_note() %></textarea>
					<div class="file_button"><input type="file" id="attach" name="attach"></div>
					<%
					if(vo.getPost_oname() != null)
					{
						%>
						기존 첨부파일 : <a href="/kick_off_view/jsp/board/board_down.jsp?no=<%= no %>"><%= vo.getPost_oname() %></a>
						<%
					}
					else
					{
						%>
						등록된 첨부파일이 없습니다.
						<%
					}
					%>
					<div class="registration_button"><a href="javascript:Do_Submit();">수정</a></div>
					<div class="cancel_button"><a href="javascript:DoBack();" class="button_text">취소</a></div>
				</td>
			</tr>
		</table>
		</form>
		<br>						
		</div>
	<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>