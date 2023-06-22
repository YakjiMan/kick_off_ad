<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.dao.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<script src="../../js/jquery-3.6.3.js"></script>
<% 
String no = request.getParameter("no");

if( no == null || no.equals("") ) { return; }

PostDTO post   = new PostDTO();
ad_listDTO dto = new ad_listDTO();
pop_upDTO popDTO = new pop_upDTO();
ArrayList<analyze1VO> word_list1  = popDTO.Read1(no);
PostVO vo = popDTO.Read(no);

ArrayList<ad_managerVO> list = dto.GetList();

pythonbrowse test = new pythonbrowse();

%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>분석팝업1</title>	
	</head>			
<style>
	@import url('https://fonts.googleapis.com/css2?family=Hahmlet&display=swap');
	
	body
	{
		background-color:#0c0c0c;
		color:#FFFFFF;
		font-family: 'Hahmlet', serif;
	}
	
	.side_ad_div
	{
		padding:auto;
		background-color:#0c0c0c;
		width:100%; 
	}
	
	table
	{
		border-collapse:collapse;
		border:1px solid white;
		width:100%;
	}
	
	th
	{
		padding:10px 3px;
		border:1px solid white;
		color:white;
	}
	
	td
	{
		text-align:center;
		border:1px solid white;
		color:white;
	}
	
	.title
	{
		font-size:20px;
	}
	
	.data_img
	{
		width:460px;
		height:100%;
		object-fit: cover;
	}
	
	.left_div
	{
		margin: 0 0 0 0;
		width:450px;
	}
	
	.rifgt_div
	{
		
	}
	.pybutton
	{
		width:150px;
		height:50px;
		cursor:pointer;
		background-color:#cccccc;
		color:black;
		font-weight:800;
		font-size:15pt;
		padding:1px 9px 4px 9px;
		border:1px solid white;
		text-align:center;
		
	}
</style>
<script>
window.onload = function()
{	
	$("#tap1,#tap2,#tap3,#tap4,#tap5").click(function(){
		var tapID = $(this).attr("id");
		
		$("#tap_table1,#tap_table2,#tap_table3,#tap_table4,#tap_table5").css("display","none");
		switch(tapID)
		{
			case "tap1" : $("#tap_table1").toggle();
				break;
			case "tap2" : $("#tap_table2").toggle();
				break;
			case "tap3" : $("#tap_table3").toggle();
				break;
			case "tap4" : $("#tap_table4").toggle();
				break;
			case "tap5" : $("#tap_table5").toggle();
				break;
		}
	});
	
	$("#tap1,#tap2,#tap3,#tap4,#tap5")
	.mouseover(function(){
		$(this).css("background-color","black");
	})
	.mouseout(function(){
		$(this).css("background-color","black");
	});
	
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	
	$("#click_pop").click(function(){
		var tapID = $(this).attr("id");
		
		$("#mini_pop").css("display","none")
		{
			$("#mini_pop").toggle();
		}
	});
	
	$("#click_pop")
	.mouseover(function(){
		$(this).css("background-color","black");
	})
	.mouseout(function(){
		$(this).css("background-color","black");
	});
	
	$("#mini_pop").mouseleave(function(){
		$(this).toggle();
	});

}
</script>
<body>
	<div class="side_ad_div">
		<table>
			<tr>
				<th width="30%" class="title">연관성영역</th>
				<th width="35%" class="title">긍부정영역</th>
				<th class="title">선정광고</th>
			</tr>
			<tr>
				<td style="vertical-align:top;width:464px;">
					<table>
						<tr>
							<th>게시물 긍부정</th>
							<td><%= vo.getPost_posneg() %></td>
						</tr>
						<tr>
							<th>긍부정 퍼센트</th>
							<td><%= vo.getPost_percent() %> %</td>
						</tr>
						<tr>
							<th colspan="2">문장별 긍부정</th>
						</tr>
						<tr>
							<td colspan="2">
								<table>
									<tr>
										<td colspan="4">
											<table border="1">
												<tr>
													<td class="data_img"><img class="data_img" src="../../python/pos_neg/pos_neg_fig/<%= vo.getPost_figname() %>"></td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
				<td style="vertical-align: top;">
					<div class="left_div">
						<table>
							<tr>
								<th>빈도수</th>
								<th>단  어</th>
								<th>연관단어</th>
								<th>단어와 연관단어의 유사도</th>
							</tr>
							<%
							ad_managerVO ad_vo = null;
							String ad_key = "";
							String ans_key = "";
							String ans_per = "";
							String find_ad_key = "";
							
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
										if( count == 0 ){	// 빈도 단어로 검색
											ad_key = item.getMorph_origin_key();
										}else{	// 연관단어로 검색
											ad_key = object.getMorph_relation_key();
										}
										System.out.println("검색할 키워드 : " + ad_key);
										int ad_no = popDTO.Find_ad(ad_key);	// 검색 할 키워드로 광고를 검색한다
										if( ad_no > 0 ){
											ad_vo = popDTO.Read_ad(ad_no);
											if( ad_vo == null) return;
											flag = 1;
											find_ad_key = item.getMorph_origin_key();
											System.out.println(find_ad_key + "("+ad_key+")로 광고가 검색되었습니다.\nflag : " + flag );
										} // 광고 번호가 넘어오면 광고가 검색된것 : 광고 번호로 광고 vo객체를 생성
										// 광고 객체가 생성되었으면 플래그를 변경
									}
							%>		<tr id="click_pop"> <%
									String style = "";
									if( count == 0 )
									{
										
										if( flag == 1 && item.getMorph_origin_key().equals(ad_key) ) {
											ans_key = item.getMorph_origin_key();
											ans_per = "";
											style = "style='background-color:silver; color:black;'";
										}	%>
										<td rowspan="5"><%= item.getAnal_count() %></td>
										<td rowspan="5" <%= style %>><%= item.getMorph_origin_key() %></td> <%
										style = "";
									}
									if( flag == 1 && object.getMorph_relation_key().equals(ad_key) ) {
										style = "style='background-color:silver; color:black;'";
										ans_key = object.getMorph_relation_key();
										ans_per = object.getSim().substring(0,6);
									}
							%>
										<td <%= style %>><%= object.getMorph_relation_key() %></td>
										<td <%= style %>><%= object.getSim().substring(0,6) %></td>
									</tr>	<%
									count++;
								}
//								if( flag != 0 )	{ break; }
							}
								%>
						</table>
					</div>
				</td>
				<td>
					<%
						String[] keyword = null;
						if(ad_vo != null)
						{
							keyword = ad_vo.getAd_keyword().split(",");
						}
					%>
					<div class="right_div">
<%-- 						<table width="100%">
							<%
							for(ad_managerVO LVO : list)
							{
								String keyword[] = (LVO.getAd_keyword()).split(",");
							%>
							<tr>
								<td><%= keyword[0] %></td><td rowspan="5"><%= LVO.getAd_name() %></td>
							</tr>
							<tr>
								<td><%= keyword[1] %></td>
							</tr>
							<tr>
								<td><%= keyword[2] %></td>
							</tr>
							<tr>
								<td><%= keyword[3] %></td>
							</tr>
							<tr>
								<td><%= keyword[4] %></td>
							</tr>
							<%
							}
							%>
						</table> --%>
						<%
						if( keyword != null && ad_vo.getAd_name() != null)
						{
							String style = "style='height:200px; font-weight:bold; font-size:15pt;'";
						%>
							<table width="100%">
								<tr>
									<th>연관단어</th>
									<th>유사도</th>
								</tr>
								<tr>
									<td><%= ans_key %></td>
									<td><%= ans_per %></td>
								</tr>
							</table>
							<br><br>
							<table width="100%">
								<tr>
									<th>설정키워드</th><th>광고이름</th>
								</tr>
								<tr>
									<td <%= style %>><%= ans_key %></td>
									<td rowspan="5" <%= style %>><%= ad_vo.getAd_name() %></td>
								</tr>
							</table>
							<br><br>
							<script>
							function OpenGraph()
							{
								if(confirm("그래프 페이지로 이동하시겠습니까?") == false)
								{
									return;
								}
								$.ajax({
									type    : "get",
									url     : "/kick_off_view/jsp/adpop/graphlink.jsp?ans_key=<%= find_ad_key %>" ,
									dataType: "html",
									success : function(data) 
									{	
										// 통신이 성공적으로 이루어졌을때 이 함수를 타게된다.
										return;
									}
								});
							}
							</script>
							<input type="button" class="pybutton" onclick="OpenGraph();" value="그래프보기">
						<%
						}else
						{
						%>
							<table style="display:none;" width="100%">
								<tr>
									<td></td><td rowspan="5"></td>
								</tr>
								<tr>
									<td></td>
								</tr>
								<tr>
									<td></td>
								</tr>
								<tr>
									<td></td>
								</tr>
								<tr>
									<td></td>
								</tr>
							</table>
						<%
						}
						%>
					</div>
				</td>
			</tr>
		</table>
	</div>
</body>