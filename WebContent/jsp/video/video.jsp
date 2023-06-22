<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>영상 게시판</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/video.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
<% 
String mcate = request.getParameter("mcate");
if(mcate == null || mcate == "") mcate = "a";

String scate = request.getParameter("scate");
if(scate == null || scate == "") scate = "a";

String keyword = request.getParameter("keyword");
if(keyword == null) keyword = "";

String sort = request.getParameter("sort");
if(sort == null || sort == "") sort = "r";

String search_type = request.getParameter("search_type");
if(search_type == null) search_type = "";

int pageno = 1;
try
{
	pageno = Integer.parseInt(request.getParameter("page"));
}
catch(Exception e){};


ListDTO dto = new ListDTO();
//페이지에 가져올 게시물의 갯수를 정한다
int list_count = 12;
//전체자료의 갯수를 조회한다.
int total = dto.GetVideoTotal(mcate,scate, keyword, search_type);
int max_page = total / list_count; //전체 페이지 갯수
if(total % list_count != 0) max_page += 1;
//목록조회
ArrayList<PostVO> list = dto.GetVideoList(list_count,pageno,mcate,scate,sort,keyword,search_type);
%>
<script>
	
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
	
	function SortR()
	{
		document.location = "/kick_off_view/jsp/video/video.jsp?mcate=<%= mcate %>&scate=<%= scate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=r";
	}
	function SortP()
	{
		document.location = "/kick_off_view/jsp/video/video.jsp?mcate=<%= mcate %>&scate=<%= scate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=p";
	}
	function SortV()
	{
		document.location = "/kick_off_view/jsp/video/video.jsp?mcate=<%= mcate %>&scate=<%= scate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=v";
	}
	function Scate()
	{
		$("#video_list").submit();
	}
	function VideoSearch()
	{
		$("#video_list").submit();
	}
	
	function Side_Pop()
	{
		var url  = "/kick_off_view/jsp/adpop/pop_up1.jsp;"
		var name = "분석정보";
		
		window.open(url,name,"width=1350,height=900,resizable=no,left=250,top=150");
	}
</script>
<%@ include file="../include/header.jsp" %>
<!-- main 시작 -->
		<div class="main">
		<div class="sidead">
			<img src="../../adimg/domino(h).png" width="200px" height="600px" onclick="Side_Pop()">
		</div>
			<div class="video_frame">
			<form id="video_list" name="video_list" method="get" action="/kick_off_view/jsp/video/video.jsp">
				<input type="hidden" name="mcate" value="<%= mcate %>">
				<input type="hidden" name="sort" value="<%= sort %>">
				<div class="video_tabtitle"><a href="/kick_off_view/jsp/video/video.jsp" class="tabtitle_text">영상</a></div>
				<%
				if(keyword != null && !keyword.equals(""))
				{
					%>
					<div class="sort_on">"<%= keyword %>" 에 대한 검색결과</div>
					<br><br>
					<%
				}
				%>
				<div class="video_tab">
					<a href="video.jsp?mcate=p" class="<%= mcate.equals("p") ? "tab_on" : "tab" %>" id="mcate_p">프리미어리그</a>&nbsp;&nbsp; | &nbsp; 
					<a href="video.jsp?mcate=l" class="<%= mcate.equals("l") ? "tab_on" : "tab" %>" id="mcate_l">라리가</a>&nbsp;&nbsp; | &nbsp; 
					<a href="video.jsp?mcate=s" class="<%= mcate.equals("s") ? "tab_on" : "tab" %>" id="mcate_s">세리에A</a> &nbsp;&nbsp; | &nbsp;
					<a href="video.jsp?mcate=b" class="<%= mcate.equals("b") ? "tab_on" : "tab" %>" id="mcate_b">분데스리가</a>&nbsp;&nbsp; | &nbsp;
					<a href="video.jsp?mcate=c" class="<%= mcate.equals("c") ? "tab_on" : "tab" %>" id="mcate_c">챔피언스리그</a>
				</div>
				<%
				try
				{
					if(Integer.parseInt(login_vo.getUser_grade()) > 1)
					{
						%>
						<div class="write_button">
							<span onclick="javascript:document.location='/kick_off_view/jsp/video/video_write.jsp?mcate=<%= mcate %>&scate=<%= scate %>&sort=<%= sort %>&page=<%= pageno %>'" class="write">글쓰기</span>
						</div>
						<%
					}
				}
				catch(Exception e){}
				%>
				<div class="category_frame">
					<select class="category" onchange="Scate();" name="scate" id="scate">
						<option value="a" <%= scate.equals("a") ? "selected" : "" %>>전체</option>
						<option value="h" <%= scate.equals("h") ? "selected" : "" %>>H/L</option>
						<option value="g" <%= scate.equals("g") ? "selected" : "" %>>골장면</option>
						<option value="i" <%= scate.equals("i") ? "selected" : "" %>>인터뷰</option>
					</select>
				</div>
				<div><hr class="line"></div>
				<div>
					<div class="<%= sort.equals("r") ? "sort_on" : "sort" %>" id="sort_r" onclick="SortR();">최신순</div>
					<div class="<%= sort.equals("p") ? "sort_on" : "sort" %>" id="sort_p" onclick="SortP();">인기순</div>
					<div class="<%= sort.equals("v") ? "sort_on" : "sort" %>" id="sort_v" onclick="SortV();">많이본순</div>
				</div>
				<div><hr class="line"></div>
				<div id="Pop"></div>	
				<div class="midad"><img src="../../adimg/navernow(w).png" onclick="DoPopOpen()"></div>
				<%
				for(PostVO vo : list)
				{
					String title = vo.getPost_title();
					if(title.length() > 17)
					{
						title  = title.substring(0,17);
						title += "...";
					}
					//검색 키워드 하이라이트 
					if(keyword != null && !keyword.equals(""))
					{
						title = title.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
					}	
					%>
					<div class="post_frame">
						<a href="/kick_off_view/jsp/video/video_view.jsp?no=<%= vo.getPost_no() %>&mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= pageno %>">
							<%
							if(vo.getPost_video().equals("") || vo.getPost_video() == null)
							{
								%>
								<img src="img/news2.jpg" class="img">
								<%
							}
							else
							{
								%>
								<img src="https://img.youtube.com/vi/<%= vo.getPost_video() %>/maxresdefault.jpg" class="img">
								<%
							}
							%>
						</a><br>
						<a href="/kick_off_view/jsp/video/video_view.jsp" class="post_title"><%= title %></a><br>
						<span class="post_date">등록일 : <%= vo.getPost_date() %></span><br>
						<span class="post_date">조회수 : <%= vo.getPost_view() %></span><br>
						<span class="post_date">좋아요 : <%= vo.getLike_count() %></span>
					</div>
					<%
				}
				%>
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
								<a href="/kick_off_view/jsp/video/video.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= StartBlock - 1 %>">이전</a>
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
									<a class="page_off" href="/kick_off_view/jsp/video/video.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= page_no %>">
									<%= page_no %>
									</a>&nbsp;
									<%
								}
							}
							//다음 블럭 표시하기
							if(EndBlock < max_page)
							{
								%>
								<a href="/kick_off_view/jsp/video/video.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= EndBlock + 1 %>">다음</a>
								<%				
							}
							%>
							</td>
						</tr>
					</table>
				</div>
				<div class="post_search">
					<select class="select" name="search_type">
						<option <%= search_type.equals("s_post_title") ? "selected" : "" %> value="s_post_title">제목</option>
						<option <%= search_type.equals("s_post_note") ? "selected" : "" %> value="s_post_note">내용</option>
						<option <%= search_type.equals("s_all") ? "selected" : "" %> value="s_all">제목+내용</option>
					</select>
					<input type="text" size="30" placeholder="내용을 입력해주세요." class="search_text" name="keyword" value="<%= keyword %>">
					<span class="search_button" onclick="VideoSearch();">검색</span>
				</div>
				</form>
			</div>
		</div>
		<!-- main 끝 -->
		
<%@ include file="../include/footer.jsp" %>
	