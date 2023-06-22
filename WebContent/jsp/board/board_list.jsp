<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %> 
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>게시판</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/board_list.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	<%@ include file="../include/header.jsp" %>
	<%
	String mcate = request.getParameter("mcate");
	
	String type = request.getParameter("type");
	if(mcate == null || mcate == "") type = "b";

	String keyword = request.getParameter("keyword");
	if(keyword == null) keyword = "";
	
	String search_type = request.getParameter("search_type");
	if(search_type == null) search_type = "";
	
	String sort = request.getParameter("sort");
	if(sort == null || sort == "") sort = "r";
	
	int pageno = 1;
	try
	{
		pageno = Integer.parseInt(request.getParameter("page"));
	}
	catch(Exception e){};

	ListDTO dto = new ListDTO();
	
	int common_count = 10; //일반게시글 갯수
	int notice_count = 3;  //공지게시글 갯수
	
	//전체자료의 갯수를 조회한다.
	int total = dto.GetTotal("b","f", keyword, search_type);
	//System.out.println("total = " + total);   == 6
	int max_page = total / common_count; //전체 페이지 갯수
	//System.out.println("common_count = " + common_count);   == 10
	if(total % common_count != 0) max_page += 1;
	//System.out.println("max_page = " + max_page);   == 1
	
	//목록조회
	ArrayList<PostVO> clist = dto.GetBoardList(common_count,pageno,"f",sort,keyword,search_type);
	ArrayList<PostVO> nlist = dto.GetBoardList(notice_count,1,"n","r","","");
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
			document.location = "/kick_off_view/jsp/board/board_list.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=r";
		}
		function SortP()
		{
			document.location = "/kick_off_view/jsp/board/board_list.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=p";
		}
		function SortV()
		{
			document.location = "/kick_off_view/jsp/board/board_list.jsp?mcate=<%= mcate %>&search_type=<%= search_type %>&keyword=<%= keyword %>&sort=v";
		}
		
		function BoardSearch()
		{
			$("#board_list").submit();
		}
		
		function Side_Pop()
		{
			var url  = "/kick_off_view/jsp/adpop/pop_up1.jsp;"
			var name = "분석정보";
			
			window.open(url,name,"width=1350,height=900,resizable=no,left=250,top=150");
		}

	</script>
	<div class="main">
	<div class="sidead">
		<img src="../../adimg/domino(h).png" width="200px" height="600px" onclick="Side_Pop()">
	</div>
	<br>
	<div class="board_frame">
	<form method="get" id="board_list" name="board_list" action="/kick_off_view/jsp/board/board_list.jsp">
		<input type="hidden" name="mcate" value="<%= mcate %>">
		<input type="hidden" name="sort" value="<%= sort %>">
	<table class="top_level_table">
		<tr>
			<td>
				<table class="small_table">
					<tr>
						<td class="board_title"><a href="/kick_off_view/jsp/board/board_list.jsp">자유게시판</a></td>
					</tr>
				</table>
				<%
				if(keyword != null && !keyword.equals(""))
				{
					%>
					<br>
					<div class="keyword">"<%= keyword %>" 에 대한 검색결과</div>
					<br>
					<%
				}
				%>
				<hr class="horizon">
				<table class="select_table">
					<tr>
						<td>
							<div>
								<div class="<%= sort.equals("r") ? "sort_on" : "sort" %>" id="sort_r" onclick="SortR();">최신순</div>
								<div class="<%= sort.equals("p") ? "sort_on" : "sort" %>" id="sort_p" onclick="SortP();">인기순</div>
								<div class="<%= sort.equals("v") ? "sort_on" : "sort" %>" id="sort_v" onclick="SortV();">많이본순</div>
							</div>
		                </td>
		                <%
						if(login_vo != null)
						{
							if(Integer.parseInt(login_vo.getUser_grade()) >= 1)
							{
								%>
								<td>
									<input type="button" class="write_button" value="글쓰기" onclick="location.href='/kick_off_view/jsp/board/board_write.jsp?sort=<%= sort %>&page=<%= pageno %>&mcate=<%= mcate %>'">
								</td>
								<%
							}
						}
						%>
					</tr>
				</table>
				<hr class="horizon">
				<div id="Pop"></div>
				<div class="midad">
					<img src="../../adimg/yogiyo(w).png" onclick="DoPopOpen()">
				</div>
				<table class="column_table">
					<tr class="column">
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
						<th>좋아요</th>
						<th>조회수</th>
					</tr>
					<%
					for(PostVO vo : nlist)
					{
						String title = vo.getPost_title();
						if( title.length() > 22)
						{
							title = title.substring(0,22);
							title += "...";
						}
						%>
						<tr>
							<td class="manager_column"><%= vo.getPost_no() %></td>
							<td>&nbsp;<a href="/kick_off_view/jsp/board/board_view.jsp?no=<%= vo.getPost_no() %>&mcate=n&type=<%= type %>&page=<%= pageno %>&search_type=<%= search_type %>&keyword=<%= keyword %>"><%= vo.getPost_title() %></a><a class="board_list">(<%= vo.getReply_count() %>)</a></td>
							<td class="manager_column"><%= vo.getUser_nick() %></td>
							<td class="manager_column"><%= vo.getPost_date() %></td>
							<td align="center">&nbsp;</td>
							<td align="center">&nbsp;</td>
						</tr>
						<%
					}
					%>
					<tr><td colspan="100"><hr class="horizon"></td></tr>
					<%
					PostVO vo = new PostVO();
					
						for(PostVO cvo : clist)
						{
							String title = cvo.getPost_title();
							if( title.length() > 22)
							{
								title = title.substring(0,22);
								title += "...";
							}
							
							String note = cvo.getPost_note();
							if(note.length() > 20)
							{
								note  = note.substring(0,20);
								note += "...";
							}
							//검색 키워드 하이라이트 
							if(keyword != null && !keyword.equals(""))
							{
								title = title.replaceFirst(keyword,"<font color=red>" + keyword + "</font>");
							}
							
							if(cvo.getPost_blind().equals("y"))
							{
								%>
								<tr>
									<td class="board_text"><%= cvo.getPost_no() %></td>
									<%
									String mLink = "/kick_off_view/jsp/board/board_view.jsp";
									mLink += "?no=" + cvo.getPost_no();
									mLink += "&mcate=f";
									mLink += "&type=" + type;
									mLink += "&page=" + pageno;
									mLink += "&search_type=" + search_type;
									mLink += "&keyword=" + keyword;
									if(login_vo != null && login_vo.getUser_grade().equals("3"))
									{
										%>
										<td>&nbsp;<a href="<%= mLink %>"><%= title %>(블라인드됨)</a><a class="board_list">(<%= cvo.getReply_count() %>)</a></td>
										<%
									}
									else
									{
										title = "블라인드 처리된 게시물입니다.";
										%>
										<td>&nbsp;<a href="javascript:alert('게시물을 조회 할 수 없습니다.')"><%= title %></a><a class="board_list"></a></td>
										<%
									}
									%>
									<td class="board_text"><%= cvo.getUser_nick() %></td>
									<td class="board_text"><%= cvo.getPost_date() %></td>
									<td class="board_text"><%= cvo.getLike_count() %></td>
									<td class="board_text"><%= cvo.getPost_view() %></td>
								</tr>
								<%								
							}
							else
							{
								String mLink = "/kick_off_view/jsp/board/board_view.jsp";
								mLink += "?no=" + cvo.getPost_no();
								mLink += "&mcate=f";
								mLink += "&type=" + type;
								mLink += "&page=" + pageno;
								mLink += "&search_type=" + search_type;
								mLink += "&keyword=" + keyword;
								%>
								<tr>
									<td class="board_text"><%= cvo.getPost_no() %></td>
									<td>&nbsp;<a href="<%= mLink %>"><%= title %></a><a class="board_list">(<%= cvo.getReply_count() %>)</a></td>
									<td class="board_text"><%= cvo.getUser_nick() %></td>
									<td class="board_text"><%= cvo.getPost_date() %></td>
									<td class="board_text"><%= cvo.getLike_count() %></td>
									<td class="board_text"><%= cvo.getPost_view() %></td>
								</tr>
								<%
							}
						}
					
					%>
				</table>
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
								<a href="/kick_off_view/jsp/board/board_list.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= StartBlock - 1 %>">이전</a>
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
									<a class="page_off" href="/kick_off_view/jsp/board/board_list.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= page_no %>">
									<%= page_no %>
									</a>&nbsp;
									<%
								}
							}
							//다음 블럭 표시하기
							if(EndBlock < max_page)
							{
								%>
								<a href="/kick_off_view/jsp/board/board_list.jsp?mcate=<%= mcate %>&sort=<%= sort %>&search_type=<%= search_type %>&keyword=<%= keyword %>&page=<%= EndBlock + 1 %>">다음</a>
								<%				
							}
							%>
							</td>
						</tr>
					</table>
				</div>
				<table class="post_search">
					<tr>
						<td>
							<select class="select" name="search_type">                                                                                                             
				                <option <%= search_type.equals("s_post_title") ? "selected" : "" %> value="s_post_title">제목</option>
								<option <%= search_type.equals("s_post_note") ? "selected" : "" %> value="s_post_note">내용</option>
								<option <%= search_type.equals("s_all") ? "selected" : "" %> value="s_all">제목+내용</option>        
							</select>
							<input class="search_text" type="text" id="search1" name="keyword" value="<%= keyword %>">                                                     
							<input class="search_button" type="submit" value="검색" onclick="BoardSearch();">  
						</td>
					</tr>
				</table> 	
			</td>
		</tr>
	</table>
	</form> 
	</div>  
	<br>	
	</div>
	
<%@ include file="../include/footer.jsp" %>
	