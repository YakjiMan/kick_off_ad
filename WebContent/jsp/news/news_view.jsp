<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>뉴스 글보기</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/news_view.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	
	<%@ include file="../include/header.jsp" %>
<%
	String mcate  = request.getParameter("mcate");
	String sort   = request.getParameter("sort");
	String pageno = request.getParameter("page");
	String no = request.getParameter("no");
	String keyword = request.getParameter("keyword");
	String search_type = request.getParameter("search_type");
	
	if(mcate == null || mcate == "") mcate = "p";
	if(keyword == null) keyword = "";
	if(sort == null || sort == "") sort = "r";
	if(search_type == null) search_type = "";
	if(pageno == null) pageno = "1";
	
	if(no == null || no.equals(""))
	{
		response.sendRedirect("/kick_off_view/jsp/news/news.jsp");
		return;
	}
	
	PostDTO dto = new PostDTO();
	PostVO  vo  = dto.Read(no, true);
	
	
	
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

ad_listDTO DTO = new ad_listDTO();
pop_upDTO popDTO = new pop_upDTO();
ad_managerDTO adDTO = new ad_managerDTO();
ArrayList<analyze1VO> word_list1  = popDTO.Read1(no);
PostVO VO = popDTO.Read(no);

ArrayList<ad_managerVO> list = DTO.GetList();

ad_managerVO ad_vo = null;
String ad_key = "";

int flag = 0;
// 빈도 리스트 반복
for( analyze1VO item : word_list1 )
{
	int count = 0;
	// 유사 단어 리스트 반복
	ArrayList<analyze2VO> word_list2  = popDTO.Read2(item.getAnal_no());
	for( analyze2VO object : word_list2 )
	{
		// 매칭된 광고를 찾지 못했으면
		if( flag == 0 )
		{
			if( count == 0 )
			{	// 빈도 단어로 검색
				ad_key = item.getMorph_origin_key();
			}else
			{	// 연관단어로 검색
				ad_key = object.getMorph_relation_key();
			}
			System.out.println("검색할 키워드 : " + ad_key);
			
			int ad_no = popDTO.Find_ad(ad_key);	// 검색 할 키워드로 광고를 검색한다
			if( ad_no > 0 )
			{
				ad_vo = popDTO.Read_ad(ad_no);
				
				if( ad_vo == null) return;
				flag = 1;
				System.out.println(ad_key+"로 광고가 검색되었습니다.\nflag : " + flag );
				System.out.println("광고번호 : " + ad_vo );
			} // 광고 번호가 넘어오면 광고가 검색된것 : 광고 번호로 광고 vo객체를 생성
			// 광고 객체가 생성되었으면 플래그를 변경
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
	function Like_Hate()
	{
		$.ajax({
			type : "get",
			url: "/kick_off_view/jsp/news/post_like_hate.jsp?no=<%= no %>",
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
			url     : "/kick_off_view/jsp/news/like_hateOnOff.jsp",
			data    : 
			{
				post_no : "<%= no %>",
				like_hate : "l"
			},
			dataType: "html",
			success : function(data) 
			{	
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
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
			url     : "/kick_off_view/jsp/news/like_hateOnOff.jsp",
			data    : 
			{
				post_no : "<%= no %>",
				like_hate : "h"
			},
			dataType: "html",
			success : function(data) 
			{	
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				data = data.trim();
				if(data != "")
				{
					alert(data);
				}
				Like_Hate();
			}
		});
	}
	function DoDelete()
	{
		if(confirm("게시물을 삭제하시겠습니까?") == false)
		{
			return;
		}
		document.location = "/kick_off_view/jsp/news/news_delete.jsp?no=<%= no %>&mcate=<%= mcate %>&pageno=<%= pageno %>&sort=<%= sort %>&keyword=<%= keyword %>&search_type=<%= search_type %>";
	}
	function DoBack()
	{
		document.location = "/kick_off_view/jsp/news/news.jsp?no=<%= no %>&mcate=<%= mcate %>&pageno=<%= pageno %>&sort=<%= sort %>&keyword=<%= keyword %>&search_type=<%= search_type %>"
	}
	function DoModify()
	{
		document.location = "/kick_off_view/jsp/news/news_modify.jsp?no=<%= no %>&mcate=<%= mcate %>&pageno=<%= pageno %>&sort=<%= sort %>&keyword=<%= keyword %>&search_type=<%= search_type %>"
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
			alert("댓글을 입력하세요");
			$("#reply_note").focus();
			return;
		}
		if(confirm("댓글을 등록하시겠습니까?") == true)
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
					// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
					data = data.trim();
					alert(data)
					ReplyList();
				}
			});
		}
	}
	function DeleteReply(reply_no)
	{
		if(confirm("해당 댓글을 삭제하시겠습니까?") == false)
		{
			return;
		}
		$.ajax({
			type    : "get",
			url     : "/kick_off_view/jsp/reply/reply_delete.jsp?reply_no=" + reply_no,
			dataType: "html",
			success : function(data) 
			{	
				// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
				ReplyList();
			}
		});
	}
	
	function Side_Pop()
	{
		var url  = "/kick_off_view/jsp/adpop/pop_up1.jsp?no=<%= no %>";
		var name = "분석정보";
		
		window.open(url,name,"width=1350,height=900,resizable=no,left=250,top=150");
	}
	</script>
	
<!-- main 시작 -->
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
			<div class="news_frame">
				<div class="news_tabtitle"><a href="/kick_off_view/jsp/news/news.jsp" class="tabtitle_text">뉴스</a></div>
				<div class="news_tab">
					<p class="<%= vo.getPost_mcate().equals("p") ? "tab_on" : "tab" %>" id="mcate_p">프리미어리그</p>&nbsp;&nbsp; | &nbsp; 
					<p class="<%= vo.getPost_mcate().equals("l") ? "tab_on" : "tab" %>" id="mcate_l">라리가</p>&nbsp;&nbsp; | &nbsp; 
					<p class="<%= vo.getPost_mcate().equals("c") ? "tab_on" : "tab" %>" id="mcate_c">챔피언스리그</p>&nbsp;&nbsp; | &nbsp;
					<p class="<%= vo.getPost_mcate().equals("b") ? "tab_on" : "tab" %>" id="mcate_b">분데스리가</p>&nbsp;&nbsp; | &nbsp;
					<p class="<%= vo.getPost_mcate().equals("s") ? "tab_on" : "tab" %>" id="mcate_s">세리에A</p> 
				</div>
				<div class="title"><%= vo.getPost_title() %></div>
				<div class="date">작성일 : <%= vo.getPost_date() %></div>
				<div class="date">출처 : <%= vo.getPost_source() %></div>
				<div class="view">조회수 : <%= vo.getPost_view() %></div>
				<div class="img_frame">
					<%
					if(vo.getPost_oname().equals("") || vo.getPost_oname() == null)
					{
						%>
						<img src="../../img/news2.jpg" class="img">
						<%
					}
					else
					{
						%>
						<img src="/kick_off_view/file/<%= vo.getPost_oname() %>" class="img">
						<%
					}
					%>
				</div>
				<div>
					<%= vo.getPost_note() %>
				</div>
				<div class="writer">작성자 : <%= vo.getUser_name() %></div>
				<div class="emo_frame">
					<div id="like_hate"></div>
				</div>
				<%
				if(login_vo != null)
				{
					if(login_vo.getUser_grade().equals("3") || login_vo.getUser_no().equals(vo.getUser_no()))
					{
						%>
						<div><a href="javascript:DoDelete();" class="delete_button">글삭제</a></div>
						<%
					}
					if(login_vo.getUser_no().equals(vo.getUser_no()))
					{
						%>
						<div><a href="javascript:DoModify();" class="modify_button">글수정</a></div>
						<%
					}
				}
				%>
				<div class="nav_list"><a href="javascript:DoBack();" class="nav_list">목록</a></div>
				<div></div>
				<div class="reply_count">댓글 (<%= vo.getReply_count() %>)</div>
				<div id="reply_list"></div>
			</div>
		</div>
		<!-- main 끝 -->
		
<%@ include file="../include/footer.jsp" %>