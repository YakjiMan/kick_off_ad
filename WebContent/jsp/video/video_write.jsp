<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">	
		<title>영상 글쓰기</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/video_write.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
		<script src="../../summernote/summernote-lite.js"></script>
		<script src="../../summernote/lang/summernote-ko-KR.js"></script>
		<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
	</head>
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
		function DoSubmit()
		{
			$("#write").submit();
		}
		function DoSave()
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
			return true;
		}
	</script>
	<%@ include file="../include/header.jsp" %>
<% 
	String mcate  = request.getParameter("mcate");
	String scate  = request.getParameter("scate");
	String sort   = request.getParameter("sort");
	String pageno = request.getParameter("page");
%>
<!-- main 시작 -->
		<div class="main">
			<div class="video_frame">
				<form id="write" enctype="multipart/form-data" method="post" action="/kick_off_view/jsp/video/video_writeok.jsp" onsubmit="return DoSave();">
				<div class="tab"><a href="/kick_off_view/jsp/video/video.jsp" class="tabtitle_text">영상</a></div>
				<div><hr class="line"></div>
				<div align="center">
					<table>
						<tr>
							<td style="font-size:20pt; font-weight:500;">제목 : </td>
							<td><input type="text" placeholder="제목을 입력해주세요." class="textbox" id="title" name="title"></td>
							<td>
								<select class="select" name="mcate">
									<option value="p" <%= mcate.equals("p") ? "selected" : "" %>>EPL</option>
									<option value="l" <%= mcate.equals("l") ? "selected" : "" %>>라리가</option>
									<option value="c" <%= mcate.equals("c") ? "selected" : "" %>>챔피언스리그</option>
									<option value="b" <%= mcate.equals("b") ? "selected" : "" %>>분데스리가</option>
									<option value="s" <%= mcate.equals("s") ? "selected" : "" %>>세리에A</option>
								</select>
							</td>
							<td>
								<select class="select" name="scate">
									<option value="h" <%= scate.equals("h") ? "selected" : "" %>>H/L</option>
									<option value="g" <%= scate.equals("g") ? "selected" : "" %>>골장면</option>
									<option value="i" <%= scate.equals("i") ? "selected" : "" %>>인터뷰</option>
								</select>
							</td>
							<td class="username">작성자 : <%= login_vo.getUser_name() %></td>
						</tr>
						<tr>
							<td style="font-size:15pt; font-weight:500;">출처 : </td>
							<td><input type="text" placeholder="출처를 입력해주세요." class="textbox" id="title" name="source"></td>
						</tr>
						<tr>
							<td style="font-size:15pt; font-weight:500;">영상주소 : </td>
							<td><input type="text" placeholder="영상주소를 입력해주세요." class="textbox" id="title" name="video"></td>
						</tr>
					</table>
				</div>
				<textarea id="summernote" name="note"></textarea>
				<div class="file_button"><input type="file" id="attach" name="attach"></div>
				<div class="okbutton"><a href="javascript:DoSubmit();" class="button_text">등록</a></div>
				<div class="clebutton"><a href="/kick_off_view/jsp/video/video.jsp?mcate=<%= mcate %>&scate=<%= scate %>&sort=<%= sort %>&page=<%= pageno %>" class="button_text">취소</a></div>
				</form>
			</div>
		</div>
		
<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>

	