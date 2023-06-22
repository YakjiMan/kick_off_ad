<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>통합검색탭</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/searchpage.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	
	<%@ include file="../include/header.jsp" %>
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
</script>
<%
String tsearch_note = request.getParameter("tsearch_note");
String search_type  = request.getParameter("search_type");

ListDTO dto = new ListDTO();

int news_count  = dto.GetTotal("n", "a", tsearch_note, "s_all");
int video_count = dto.GetTotal("v", "a", tsearch_note, "s_all");
int board_count = dto.GetTotal("b", "a", tsearch_note, "s_all");

ArrayList<PostVO> news  = dto.GetNewsList(3,1, "a", "r", tsearch_note, "s_all");
ArrayList<PostVO> video = dto.GetVideoList(3,1, "a", "a","r", tsearch_note, "s_all");
ArrayList<PostVO> board = dto.GetBoardList(3,1, "a", "r", tsearch_note, "s_all");

%>

<!-- main 시작 -->
	<div class="main">
		<!-- 여기부터 내용넣기 -->
		<div class="searchtap">
			<br><br>
			<table class="titletag">
				<tr>
					<td>"<%= tsearch_note %>" 의 검색결과입니다.</td>
				</tr>
			</table>
			<div class="newspage">
				<br>
				<table class="titletag">
					<tr>
						<td>뉴스 &nbsp;&nbsp;총 '<%= news_count %>' 건의 검색결과</td>
						<td><a href="/kick_off_view/jsp/news/news.jsp?keyword=<%= tsearch_note %>&search_type=<%= search_type %>">더보기+</a></td>
					</tr>
				</table>
				<hr>
				<%
				for(PostVO vo : news)
				{
					String title = vo.getPost_title();
					if(title.length() > 30)
					{
						title  = title.substring(0,30);
						title += "...";
					}
					
					String note = vo.getPost_note();
					if(note.contains(tsearch_note))
					{
						int size = note.indexOf(tsearch_note);
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
					
					//검색 키워드 하이라이트 
					if(tsearch_note != null && !tsearch_note.equals(""))
					{
						title = title.replaceFirst(tsearch_note,"<font color=red>" + tsearch_note + "</font>");
						note  = note.replaceFirst(tsearch_note,"<font color=red>" + tsearch_note + "</font>");
					}					
					%>
					<table class="writertap">
						<tr>
							<td><%= vo.getUser_name() %></td>
							<td>|</td>
							<td><%= vo.getPost_date() %></td>
						</tr>
					</table>
					<table class="searchlist">
						<tr>	
							<td class="searchtitle">
								<a href="/kick_off_view/jsp/news/news_view.jsp?no=<%= vo.getPost_no() %>" ><%= title %></a>
							</td>
							<td rowspan="2" class="searchimage">
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
							</td>
						</tr>
						<tr>
							<td class="searchtext">	
								<%= note %>
							</td>
						</tr>
					</table>
					<hr class="b1">
					<%
				}
				%>
			</div>
			<div class="videopage">
				<br><br>
				<table class="titletag">
					<tr>
						<td>영상 &nbsp;&nbsp;총 '<%= video_count %>' 건의 검색결과</td>
						<td><a href="/kick_off_view/jsp/video/video.jsp?keyword=<%= tsearch_note %>&search_type=<%= search_type %>">더보기+</a></td>
					</tr>
				</table>
				<hr>
				<%
				for(PostVO vo : video)
				{
					String title = vo.getPost_title();
					if(title.length() > 30)
					{
						title  = title.substring(0,30);
						title += "...";
					}
					
					String note = vo.getPost_note();
					if(note.contains(tsearch_note))
					{
						int size = note.indexOf(tsearch_note);
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
					//검색 키워드 하이라이트 
					if(tsearch_note != null && !tsearch_note.equals(""))
					{
						title = title.replaceFirst(tsearch_note,"<font color=red>" + tsearch_note + "</font>");
						note  = note.replaceFirst(tsearch_note,"<font color=red>" + tsearch_note + "</font>");
					}	
					%>
					<table class="writertap">
						<tr>
							<td><%= vo.getUser_name() %></td>
							<td>|</td>
							<td><%= vo.getPost_date() %></td>
						</tr>
					</table>
					<table class="searchlist">
						<tr>	
							<td class="searchtitle">
								<a href="/kick_off_view/jsp/video/video_view.jsp?no=<%= vo.getPost_no() %>" ><%= title %></a>
							</td>
							<td rowspan="2" class="searchimage">
								<%
								if(vo.getPost_video().equals("") || vo.getPost_video() == null)
								{
									%>
									<img src="img/news2.jpg" class="thumbnail">
									<%
								}
								else
								{
									%>
									<img src="https://img.youtube.com/vi/<%= vo.getPost_video() %>/maxresdefault.jpg" class="img">
									<%
								}
								%>
							</td>
						</tr>
						<tr>
							<td class="searchtext">	
								<%= note %>
							</td>
						</tr>
					</table>
					<hr class="b1">
					<%
				}
				%>
			</div>
			<div class="boardpage">
				<br><br>
				<table class="titletag">
					<tr>
						<td>게시판 &nbsp;&nbsp;총 '<%= board_count %>' 건의 검색결과</td>
						<td><a href="/kick_off_view/jsp/board/board_list.jsp?keyword=<%= tsearch_note %>&search_type=<%= search_type %>">더보기+</a></td>
					</tr>
				</table>
				<hr>
				<%
				for(PostVO vo : board)
				{
					String title = vo.getPost_title();
					if(title.length() > 30)
					{
						title  = title.substring(0,30);
						title += "...";
					}
					
					String note = vo.getPost_note();
					if(note.contains(tsearch_note))
					{
						int size = note.indexOf(tsearch_note);
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
					//검색 키워드 하이라이트 
					if(tsearch_note != null && !tsearch_note.equals(""))
					{
						title = title.replaceFirst(tsearch_note,"<font color=red>" + tsearch_note + "</font>");
						note  = note.replaceFirst(tsearch_note,"<font color=red>" + tsearch_note + "</font>");
					}	
					%>
					<table class="writertap">
						<tr>
							<td><%= vo.getUser_name() %></td>
							<td>|</td>
							<td><%= vo.getPost_date() %></td>
						</tr>
					</table>
					<table class="searchlist">
						<tr>	
							<td class="searchtitle">
								<a href="/kick_off_view/jsp/board/board_view.jsp?no=<%= vo.getPost_no() %>" ><%= title %></a>
							</td>
						</tr>
						<tr>
							<td class="searchtext"><%= note %></td>
						</tr>
					</table>
					<hr class="b1">
					<%
				}
				%>
				<br><br><br><br><br><br>
			</div>
		</div>
		<!-- 여기부터 내용넣기 -->
	</div>
<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>
	