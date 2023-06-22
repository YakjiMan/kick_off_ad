<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>프리미어</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/rank.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
	//시작시 실행
	$(document).ready(function(){
		rank2('2_PL');
	});
	//챔피언스리그 ajax 호출
	function rank1(){
		$.ajax
		({
			type:"get",
			url:"rank1_CL.jsp",
			dataType:"json",
			success: function(data)
			{	
				$(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
				$(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
               	$(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
               	$(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
               	$(".leaguemenu a:nth-child(5)").css({"font-weight":"bold","color":"#ffffff"});
				console.log("통신성공");
				var v  = "";
//				$.each(data.standings, function(index, value){
				for(const value of data.standings) //향상된 for문
				{
					//data.standings배열 원소가 8개
					//data.standings -> value (각 그룹) value.table -> 배열 원소가 4개
					//GROUP_A
						for(const item of value.table)
						{
							   value.group = value.group.replace("GROUP_A","A")
														.replace("GROUP_B","B")
														.replace("GROUP_C","C")
														.replace("GROUP_D","D")
														.replace("GROUP_E","E")
														.replace("GROUP_F","F")
														.replace("GROUP_G","G")
														.replace("GROUP_H","H");
							item.team.name = item.team.name.replace("SSC Napoli","나폴리")   
														   .replace("Liverpool FC","리버풀 FC")
														   .replace("AFC Ajax","아약스") 
														   .replace("Rangers FC","레인저스 FC")
														   .replace("FC Porto","포르투")   
														   .replace("Club Brugge KV","클럽 브뤼허 KV")
														   .replace("Bayer 04 Leverkusen","바이어 04 레버쿠젠") 
														   .replace("Club Atl?tico de Madrid","아틀렌티코 마드리드")
														   .replace("FC Bayern M?nchen","FC 바이에른 뮌헨")   
														   .replace("FC Internazionale Milano","FC 인터밀란")
														   .replace("FC Barcelona","FC 바르셀로나") 
														   .replace("FC Viktoria Plze?","FC 빅토리아 플젠")
														   .replace("Tottenham Hotspur FC","토트넘 핫스퍼 FC")   
														   .replace("Eintracht Frankfurt","아인트라흐트 프랑크푸르트")
														   .replace("Sporting Clube de Portugal","스포르팅 CP") 
														   .replace("Olympique de Marseille","올랭피크 드 마르세유")
														   .replace("Chelsea FC","첼시 FC")   
														   .replace("AC Milan","AC 밀란")
														   .replace("FC Red Bull Salzburg","FC 레드불 잘츠부르크") 
														   .replace("GNK Dinamo Zagreb","GNK 디나모 자그레브")
														   .replace("Real Madrid CF","레알 마드리드 CF")   
														   .replace("RB Leipzig","RB 라이프치히")
														   .replace("FK Shakhtar Donetsk","FC 샤흐타르 도네츠크") 
														   .replace("Celtic FC","셀틱 FC")
														   .replace("Manchester City FC","맨체스터 시티 FC")   
														   .replace("Borussia Dortmund","보루시아 도르트문트")
														   .replace("Sevilla FC","세비야 FC") 
														   .replace("FC København","FC 코펜하겐")
														   .replace("Sport Lisboa e Benfica","SL 벤피카")   
														   .replace("Paris Saint-Germain FC","파리 생제르맹 FC")
														   .replace("Juventus FC","유벤투스 FC") 
														   .replace("Maccabi Haifa FC","마카비 하이파 FC");
							
							v1  = "<tr><td class='cell'>"+value.group+"</td>"
							v1 += "<td>"+item.position+"</td>"
			           		v1 += "<td class='name'>"+"<img src="+item.team.crest+">"+"&nbsp;&nbsp;&nbsp;"+item.team.name+"</td>"
			           		v1 += "<td>"+item.playedGames+"</td>"
			           		v1 += "<td>"+item.points+"</td>"
			           		v1 += "<td>"+item.won+"</td>"
			           		v1 += "<td>"+item.draw+"</td>"
			           		v1 += "<td>"+item.lost+"</td>"
			           		v1 += "<td>"+item.goalsFor+"</td>"
			           		v1 += "<td>"+item.goalsAgainst+"</td>"
			           		v1 += "<td>"+item.goalDifference+"</td>"
			           		v += v1 ;
			           		
			           		$(".leaguename").html("<span>챔피언스리그</span>"
			           				+"<p>2023 시즌 팀 순위</p>");
			           		
			           		$(".leaguedata").html(
			           				"<table class='leaguetable' border='1'>"
			               			+"<tr>"
			               			+"<th>조</th>"
			    			  		+"<th>순위</th>"
			    			  		+"<th>팀</th>"
			    			  		+"<th>경기수</th>"
			    			  		+"<th>승점</th>"
			    			  		+"<th>승</th>"
			    			  		+"<th>무</th>"
			    			  		+"<th>패</th>"
			    			  		+"<th>득점</th>"
			    			  		+"<th>실점</th>"
			    			  		+"<th>득점차</th>"
			    			  		+"</tr>"
			    			  		+v+"</table>");
			           		
			           		$(".cell").each(function(){
								var tempString = $(this).text();
								var cell_rows = $(".cell").filter(function(){
									return $(this).text() == tempString;
								});
								if(cell_rows.length > 1){
									cell_rows.eq(0).attr("rowspan", cell_rows.length);
									cell_rows.not(":eq(0)").remove();
								}
							});
						}
					
				}
				
			}
		});
	}	
	//프리미어리그 ajax 호출
	function rank2(mome){
		$.ajax
		({
               type:"get",
               url:"rank"+mome+".jsp",
               dataType:"json",
               success: function(data)
               {
            	switch(mome) {
           	    case "2_PL": $(".leaguemenu a:nth-child(1)").css({"font-weight":"bold","color":"#ffffff"});
           					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
           			     	 $(".leaguename").html("<span>프리미어리그</span>"
      	           				+"<p>2023 시즌 팀 순위</p>");
            			break;
           	    case "3_PD": $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
           					 $(".leaguemenu a:nth-child(2)").css({"font-weight":"bold","color":"#ffffff"});
           			       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
           			      	 $(".leaguename").html("<span>라리가</span>"
        	           				+"<p>2023 시즌 팀 순위</p>");
            			break;
           	    case "4_SA": $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
           					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
           			         $(".leaguemenu a:nth-child(3)").css({"font-weight":"bold","color":"#ffffff"});
           			         $(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
           			         $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
           			         $(".leaguename").html("<span>세리에 A</span>"
        	           				+"<p>2023 시즌 팀 순위</p>");
            			break;
           	    case "5_BL1":$(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
           					 $(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
           			       	 $(".leaguemenu a:nth-child(4)").css({"font-weight":"bold","color":"#ffffff"});
           			       	 $(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
           			         $(".leaguename").html("<span>분데스리가</span>"
        	           				+"<p>2023 시즌 팀 순위</p>");
            			break;
           		}
               	console.log("통신성공");
               	var v  = "";
	           	$.each(data.standings[0].table, function(index, value){
	           		
	           		/*프리미어*/
	           		value.team.tla= value.team.tla.replace("ARS","아스날 FC")
												  .replace("MCI","맨체스터 시티 FC")
												  .replace("NEW","뉴캐슬 유나이티드 FC")
												  .replace("TOT","토트넘 홋스퍼 FC")
												  .replace("MUN","맨체스터 유나이티드 FC")
												  .replace("BHA","브라이튼 앤 호브 알비온 FC")
												  .replace("AVL","아스톤 빌라 FC")
												  .replace("LIV","리버풀 FC")
												  .replace("BRE","브렌트포드 FC")
												  .replace("FUL","풀럼 FC")
												  .replace("CHE","첼시 FC")
												  .replace("CRY","크리스탈 팰리스 FC")
												  .replace("LEE","리즈 유나이티드 FC")
												  .replace("WOL","울버햄튼 원더러스 FC")
												  .replace("WHU","웨스트햄 유나이티드 FC")
												  .replace("EVE","에버턴 FC")
												  .replace("NOT","노팅엄 포레스트 FC")
												  .replace("BOU","AFC 본머스")
												  .replace("LEI","레스터 시티 FC")
												  .replace("SOU","사우샘프턴 FC")
					/*라리가	*/					  .replace("FCB","FC 바르셀로나")
												  .replace("RMA","레알 마드리드")
												  .replace("ATL","클루브 아틀레티코 데 마드리드")
												  .replace("RSO","레알 소시에다드")
												  .replace("BET","레알 베티스 발롬피에")
												  .replace("VIL","비야레알 CF")
												  .replace("ATH","아틀레틱 클루브")
												  .replace("RAY","라요 바예카노")
												  .replace("CEL","CA 오사수나")
												  .replace("OSA","RC 셀타 데 비고")
												  .replace("GIR","지로나 FC")
												  .replace("MAL","RCD 마요르카")
												  .replace("SEV","세비야 FC")
												  .replace("GET","헤타페 CF")
												  .replace("CAD","카디스 CF")
												  .replace("VDD","레알 바야돌리드")
												  .replace("VAL","발렌시아 CF")
												  .replace("ESP","RCD 에스파뇰")
												  .replace("ALM","UD 알메리아")
												  .replace("ELC","엘체 CF")
					/*세리에A*/					  .replace("NAP","SSC 나폴리")
												  .replace("LAZ","SS 라치오")
												  .replace("MIL","AC 밀란")
												  .replace("INT","AS 로마")
												  .replace("ROM","FC 인터밀란")
												  .replace("ATA","아탈란타 BC")
												  .replace("JUV","유벤투스 FC")
												  .replace("BOL","볼로냐 FC 1909")
												  .replace("FIO","ACF 피오렌티나")
												  .replace("TOR","토리노 FC")
												  .replace("UDI","우디네세 칼초")
												  .replace("SAS","US 사수올로 칼초")
												  .replace("MON","몬자")
												  .replace("EMP","엠폴리 FC")
												  .replace("SAL","스포티바 살레르니타나")
												  .replace("USL","US 레체")
												  .replace("SPE","스페지아")
												  .replace("HVE","엘라스 베로나 FC")
												  .replace("SAM","UC 삼프도리아")
												  .replace("CRE","US 크레모네세")
					/*분데스*/					  .replace("FCB","FC 바이에른 뮌헨")
												  .replace("BVB","보루시아 도르트문트")
												  .replace("UNB","FC 우니온 베를린")
												  .replace("SCF","SC 프라이부르크")
												  .replace("RBL","RB 라이프치히")
												  .replace("SGE","아인트라흐트 프랑크푸르트")
												  .replace("B04","TSV 바이어 04 레버쿠젠")
												  .replace("M05","FSV 마인츠 05")
												  .replace("WOB","VfL 볼프스부르크")
												  .replace("BMG","보루시아 묀헨글라트바흐")
												  .replace("SVW","SV 베르더 브레멘")
												  .replace("FCA","FC 아우크스부르크")
												  .replace("KOE","FC 쾰른")
												  .replace("BOC","VfL 보훔")
												  .replace("TSG","TSG 1899 호펜하임")
												  .replace("BSC","헤르타 BSC")
												  .replace("S04","FC 샬케 04")
												  .replace("VFB","VfB 슈투트가르트");
	           		
	           		v1  = "<tr><td>"+value.position+"</td>"
	           		v1 += "<td class='name'>"+"<img src="+value.team.crest+">"+"&nbsp;&nbsp;&nbsp;"+value.team.tla+"</td>"
	           		v1 += "<td>"+value.playedGames+"</td>"
	           		v1 += "<td>"+value.points+"</td>"
	           		v1 += "<td>"+value.won+"</td>"
	           		v1 += "<td>"+value.draw+"</td>"
	           		v1 += "<td>"+value.lost+"</td>"
	           		v1 += "<td>"+value.goalsFor+"</td>"
	           		v1 += "<td>"+value.goalsAgainst+"</td>"
	           		v1 += "<td>"+value.goalDifference+"</td>"
	           		v += v1 ;
	           		             		
	           		
	           		
	           		$(".leaguedata").html(
	           				"<table class='leaguetable' border='1'>"
	               			+"<tr>"
	    			  		+"<th>순위</th>"
	    			  		+"<th>팀</th>"
	    			  		+"<th>경기수</th>"
	    			  		+"<th>승점</th>"
	    			  		+"<th>승</th>"
	    			  		+"<th>무</th>"
	    			  		+"<th>패</th>"
	    			  		+"<th>득점</th>"
	    			  		+"<th>실점</th>"
	    			  		+"<th>득점차</th>"
	    			  		+"</tr>"
	    			  		+v+"</table>"); 
	           	 })
               }
       	});
    }
	</script>
	<%@ include file="../include/header.jsp" %>
<!-- main 시작 -->
		<div class="main">
		<div class="rank_frame">
			<div class="leaguemenu">
				<a class="PLButton" onclick="rank2('2_PL');">프리미어리그</a>&nbsp;|&nbsp;
				<a class="laButton" onclick="rank2('3_PD');">라리가</a>&nbsp;|&nbsp;
				<a class="SAButton" onclick="rank2('4_SA');">세리에 A</a>&nbsp;|&nbsp;
				<a class="buButton" onclick="rank2('5_BL1');">분데스리가</a>&nbsp;|&nbsp;
				<a class="UEFAButton" onclick="rank1();">챔피언스리그</a>
			</div>
			<hr>
			<div class="leaguename">
			</div>
			<div class="leaguedata">
			</div>
		</div>
		</div>
		
<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>
	