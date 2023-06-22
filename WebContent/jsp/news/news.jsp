<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>뉴스게시판</title>				
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/news.css" rel="stylesheet" type="text/css">
		<script src="../js/jquery-3.6.3.js"></script>
	</head>
<%@ include file="../include/header.jsp" %>
<% 
String mcate = request.getParameter("mcate");
if(mcate == null || mcate == "") mcate = "a";

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
int list_count = 10;
//전체자료의 갯수를 조회한다.
int total = dto.GetTotal("n",mcate, keyword, search_type);
int max_page = total / list_count; //전체 페이지 갯수
if(total % list_count != 0) max_page += 1;
//목록조회
ArrayList<PostVO> list = dto.GetNewsList(list_count,pageno,mcate,sort,keyword,search_type);
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
		document.location = "/kick_off_view/jsp/news/news.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=r";
	}
	function SortP()
	{
		document.location = "/kick_off_view/jsp/news/news.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=p";
	}
	function SortV()
	{
		document.location = "/kick_off_view/jsp/news/news.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=v";
	}
	
	function NewsSearch()
	{
		$("#news_list").submit();
	}

	function Side_Pop()
	{
		var url  = "/kick_off_view/jsp/adpop/pop_up1.jsp;"
		var name = "분석정보";
		
		window.open(url,name,"width=1350,height=900,resizable=no,left=250,top=150");
	}
	
</script>
	
<!-- main 시작 -->
		<div class="main">
			<div class="sidead">
				<img src="../../adimg/domino(h).png" width="200px" height="600px" onclick="Side_Pop()">
			</div>
			<div class="news_frame">
				<form id="news_list" name="news_list" method="get" action="/kick_off_view/jsp/news/news.jsp">
				<input type="hidden" name="mcate" value="<%= mcate %>">
				<input type="hidden" name="sort" value="<%= sort %>">
				<div class="news_tabtitle"><a href="/kick_off_view/jsp/news/news.jsp" class="tabtitle_text">뉴스</a></div>
				<%
				if(keyword != null && !keyword.equals(""))
				{
					%>
					<div class="keyword">"<%= keyword %>" 에 대한 검색결과</div>
					<br><br>
					<%
				}
				%>
				<div class="news_tab">
					<a href="/kick_off_view/jsp/news/news.jsp?mcate=p" class="<%= mcate.equals("p") ? "tab_on" : "tab" %>" id="mcate_p">프리미어리그</a>&nbsp;&nbsp; | &nbsp; 
					<a href="/kick_off_view/jsp/news/news.jsp?mcate=l" class="<%= mcate.equals("l") ? "tab_on" : "tab" %>" id="mcate_l">라리가</a>&nbsp;&nbsp; | &nbsp; 
					<a href="/kick_off_view/jsp/news/news.jsp?mcate=s" class="<%= mcate.equals("s") ? "tab_on" : "tab" %>" id="mcate_s">세리에A</a> &nbsp;&nbsp; | &nbsp;
					<a href="/kick_off_view/jsp/news/news.jsp?mcate=b" class="<%= mcate.equals("b") ? "tab_on" : "tab" %>" id="mcate_b">분데스리가</a>&nbsp;&nbsp; | &nbsp;
					<a href="/kick_off_view/jsp/news/news.jsp?mcate=c" class="<%= mcate.equals("c") ? "tab_on" : "tab" %>" id="mcate_c">챔피언스리그</a>
				</div>
				<%
				try
				{
					if(Integer.parseInt(login_vo.getUser_grade()) > 1)
					{
						%>
						<div class="write_button">
							<span onclick="javascript:document.location='/kick_off_view/jsp/news/news_write.jsp?mcate=<%= mcate %>&sort=<%= sort %>&page=<%= pageno %>'" class="write">글쓰기</span>
						</div>
						<%
					}
				}
				catch(Exception e){}
				%>
				<div><hr class="line"></div>
				<div>
					<div class="<%= sort.equals("r") ? "sort_on" : "sort" %>" id="sort_r" onclick="SortR();">최신순</div>
					<div class="<%= sort.equals("p") ? "sort_on" : "sort" %>" id="sort_p" onclick="SortP();">인기순</div>
					<div class="<%= sort.equals("v") ? "sort_on" : "sort" %>" id="sort_v" onclick="SortV();">많이본순</div>
				</div>
				<div><hr class="line"></div>
				<div id="Pop"></div>
				<div class="midad">
					<img src="../../adimg/nene(w).jpg" onclick="DoPopOpen()">
				</div>
				<div class="news_main">
					<table>
					<%
					for(PostVO vo : list)
					{
						String title = vo.getPost_title();
						if(title.length() > 30)
						{
							title  = title.substring(0,30);
							title += "...";
						}
						
						String note = vo.getPost_note();
						if(note.contains(keyword) && !keyword.equals(""))
						{
							int size = note.indexOf(keyword);
							if(size > 50) 
							{
								if(note.length() > 50 && size + 35 < note.length())
								{
									note  = note.substring(size-15,size+35);
									note += "...";
								}
								else if(note.length() > 50 && size + 35 > note.length())
								{
									note  = note.substring(size-15);
								}
							}
							else
							{
								if(note.length() > 50)
								{
									note  = note.substring(0,50);
									note += "...";
								}
							}
						}
						else
						{
							if(note.length() > 50)
							{
								note  = note.substring(0,50);
								note += "...";
							}
						}
						
						//출처 자르기
						String source  = vo.getPost_source();
						if(source.length() > 14)
						{
							source  = source.substring(0,14);
							source += "";
						}
						
						//검색 키워드 하이라이트 
						if(keyword != null && !keyword.equals(""))
						{
							if(search_type.equals("s_all"))
							{
								title = title.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
								note  = note.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
							}
							else if(search_type.equals("s_post_title"))
							{
								title = title.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
							}
							else
							{
								note  = note.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
							}
						}
						
						%>
						<tr>
							<td rowspan="5" class="thumframe">
								<a href="/kick_off_view/jsp/news/news_view.jsp?no=<%= vo.getPost_no() %>&mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= pageno %>">
								<%
								if(vo.getPost_oname().equals("") || vo.getPost_oname() == null)
								{
									%>
									<img src="../../img/news2.jpg" class="thumbnail">
									<%
								}
								else
								{
									%>
									<img src="../../file/<%= vo.getPost_oname() %>" class="thumbnail">
									<%
								}
								%>
								</a>
							</td>
						</tr>								
						<tr>
							<td class="title_td">
								<b>
									<a href="/kick_off_view/jsp/news/news_view.jsp?no=<%= vo.getPost_no() %>&mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= pageno %>" class="news_title">
										<%= title %>
									</a>
								</b>
							</td>
							<td class="view_td">조회수 : <%= vo.getPost_view() %> &nbsp;&nbsp;&nbsp;좋아요 : <%= vo.getLike_count() %></td>
						</tr>
						<tr>
							<td class="text_td"><%= note %></td>
						</tr>
						<tr>
							<td class="date_td"><%= vo.getPost_date() %></td>
						</tr>
						<tr>
							<td class="date_td">출처 : <%= source %></td>
						</tr>
						<%
					}
					%>
					</table>
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
								<a href="/kick_off_view/jsp/news/news.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= StartBlock - 1 %>">이전</a>
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
									<a class="page_off" href="/kick_off_view/jsp/news/news.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= page_no %>">
									<%= page_no %>
									</a>&nbsp;
									<%
								}
							}
							//다음 블럭 표시하기
							if(EndBlock < max_page)
							{
								%>
								<a href="/kick_off_view/jsp/news/news.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= EndBlock + 1 %>">다음</a>
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
					<span class="search_button" onclick="NewsSearch();">검색</span>
				</div>
				</form>
			</div>
		</div>
		<br><br>	
		<!-- main 끝 -->
		
<%@ include file="../include/footer.jsp" %>