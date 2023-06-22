<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>Kick Off</title>
		<link href="css/index.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	</head>
	<script> 
	var today = new Date();
	
	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);

	var dateString = month+'월'+day+'일';
	var dateString2 = year + "-" + month + "-" + day;
//	console.log(dateString);
//	console.log(dateString2);
	//챔피언스리그 ajax 호출
	function rank1(){
		$.ajax
		({
			type:"get",
			url:"../rank/rank1_CL.jsp",
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
				for(const value of data.standings) //향상된 for문
				{
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
							item.team.tla =item.team.tla.replace("NAP","나폴리")
														.replace("LIV","리버풀 FC")
														.replace("FCP","포르투")
														.replace("CLU","클럽 브뤼허 KV")
														.replace("FCB","FC 바이에른 뮌헨")
														.replace("INT","FC 인터밀란")
														.replace("TOT","토트넘 핫스퍼 FC")
														.replace("SGE","아인트라흐트 프랑크푸르트	")
														.replace("CHE","첼시 FC")
														.replace("MIL","AC 밀란")
														.replace("RMA","레알 마드리드 CF")
														.replace("RBL","RB 라이프치히")
														.replace("MCI","맨체스터 시티 FC")
														.replace("BVB","보루시아 도르트문트")
														.replace("BEN","SL 벤피카")
														.replace("PSG","파리 생제르맹 FC");
							if(item.position == "1" || item.position == "2")
							{
								v1  = "<tr><td class='cell' id='otherWD'>"+value.group+"</td>"
								v1 += "<td id='otherWD'>"+item.position+"</td>"
				           		v1 += "<td class='name'>"+"<img src="+item.team.crest+">"+"&nbsp;&nbsp;&nbsp;"+item.team.tla+"</td>"
				           		v1 += "<td id='otherWD'>"+item.playedGames+"</td>"
				           		v1 += "<td id='otherWD'>"+item.points+"</td>"
				           		v1 += "<td id='otherWD'>"+item.won+"</td>"
				           		v1 += "<td id='otherWD'>"+item.draw+"</td>"
				           		v1 += "<td id='otherWD'>"+item.lost+"</td>"
				           		v1 += "</tr>"
				           		v += v1 ;		
							}
			           		$(".leaguedata").html(
			           				"<table class='leaguetable' border='1'>"
			               			+"<tr>"
			               			+"<th id='otherWD'>조</th>"
			    			  		+"<th id='other'>순위</th>"
			    			  		+"<th id='teamWD'>팀명</th>"
			    			  		+"<th id='other'>경기수</th>"
			    			  		+"<th id='otherWD'>승점</th>"
			    			  		+"<th id='otherWD'>승</th>"
			    			  		+"<th id='otherWD'>무</th>"
			    			  		+"<th id='otherWD'>패</th>"
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
	//라리가 호출
	function rank(mome)
	{
		
		switch(mome) {
	    case "3_PD":  $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
					$(".leaguemenu a:nth-child(2)").css({"font-weight":"bold","color":"#ffffff"});
			       	$(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
			       	$(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
			       	$(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
 			break;
	    case "4_SA":  $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
					$(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
			       	$(".leaguemenu a:nth-child(3)").css({"font-weight":"bold","color":"#ffffff"});
			       	$(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
			       	$(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
 			break;
	    case "5_BL1":  $(".leaguemenu a:nth-child(1)").css({"color":"#616161"});
					$(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
			       	$(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
			       	$(".leaguemenu a:nth-child(4)").css({"font-weight":"bold","color":"#ffffff"});
			       	$(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
 			break;
	    case "2_PL": $(".leaguemenu a:nth-child(1)").css({"font-weight":"bold","color":"#ffffff"});
					$(".leaguemenu a:nth-child(2)").css({"color":"#616161"});
			       	$(".leaguemenu a:nth-child(3)").css({"color":"#616161"});
			       	$(".leaguemenu a:nth-child(4)").css({"color":"#616161"});
			       	$(".leaguemenu a:nth-child(5)").css({"color":"#616161"});
 			break;
		}
		$.ajax
		({
               type:"get",
               url:"../rank/rank"+mome+".jsp",
               dataType:"json",
               success: function(data)
               {
               	console.log("통신성공");
               	var v  = "";
	           	$.each(data.standings[0].table, function(index, value)
	           	{
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
												  .replace("SAL","살레르니타나")
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
	           		if(value.position <11)
	           		{
	           			v1  = "<tr><td id='otherWD'>"+value.position+"</td>"
		           		v1 += "<td class='name'>"+"<img src="+value.team.crest+">"+"&nbsp;&nbsp;&nbsp;"+value.team.tla+"</td>"
		           		v1 += "<td id='otherWD'>"+value.playedGames+"</td>"
		           		v1 += "<td id='otherWD'>"+value.points+"</td>"
		           		v1 += "<td id='otherWD'>"+value.won+"</td>"
		           		v1 += "<td id='otherWD'>"+value.draw+"</td>"
		           		v1 += "<td id='otherWD'>"+value.lost+"</td>"
		           		v1 += "</tr>"
		           		v += v1 ;
	           		}
	           		$(".leaguedata").html(
           				"<table class='leaguetable' border='1'>"
               			+"<tr>"
    			  		+"<th id='other'>순위</th>"
    			  		+"<th id='teamWD'>팀명</th>"
    			  		+"<th id='other'>경기수</th>"
    			  		+"<th id='otherWD'>승점</th>"
    			  		+"<th id='otherWD'>승</th>"
    			  		+"<th id='otherWD'>무</th>"
    			  		+"<th id='otherWD'>패</th>"
    			  		+"</tr>"
    			  		+v+"</table>"); 
	           	 })
               }
       	});
	}
	
	function Season(mome,sDate,eDate)
	{
		let date_url = "../schedule/schedule_"+ mome +".jsp?fDate="+ sDate + "&eDate=" + eDate;
		$.ajax
		({
			type: "get",
			url: date_url,
			dataType:"json",
			success: function(data)
			{	
				
				var strHTML  = "";
				for(const value of data.matches)
				{
//					console.log(value.utcDate.replaceAll("-",".").substr(5,5));
//					console.log(value.homeTeam.name);
					/*프리미어*/
	           		value.homeTeam.tla= value.homeTeam.tla.replace("ARS","아스날 FC")
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
												  .replace("SAL","살레르니타나")
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
	           		/*프리미어*/
	           		value.awayTeam.tla= value.awayTeam.tla.replace("ARS","아스날 FC")
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
												  .replace("SAL","살레르니타나")
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
					if(value.homeTeam.name == null) { console.log("find null"); continue; };
					strHTML += "<tr><td class='date'id='date'>"+value.utcDate.replaceAll("-",".").substr(5,5)+"</td>"
					strHTML += "<td id='date'>"+value.utcDate.replaceAll("-",".").substr(11,5)+"</td>"
					strHTML += "<td class='home'>"+value.homeTeam.tla+"&nbsp;&nbsp;"
					strHTML += "<img src="+value.homeTeam.crest+"></td>"
					strHTML += "<td id='other'>"+((value.score.fullTime.home == null) ? "" : value.score.fullTime.home) +"&nbsp;"+((value.score.fullTime.home == null) ? "vs" : ":")+"&nbsp;"+((value.score.fullTime.away == null) ? "" : value.score.fullTime.away )+"</td>"
					strHTML += "<td class='away'><img src="+value.awayTeam.crest+">"
					strHTML += "&nbsp;&nbsp;"+value.awayTeam.tla+"</td></tr>"
				}
		
				const html_for_null = "<tr><td colspan='100' style='text-align:center; height:70px;'>일정이 없습니다</td></tr>";
				$(".chams").html(
						"<table class='chamstbl' border='1'>"
						+"<tr>"
						+"<th>날짜</th>"
						+"<th>시간</th>"
						+"<th colspan='3' id='playedgame'>경기</th>"
						+"</tr>"
						+ ((strHTML == "")? html_for_null : strHTML ) +"</table>"
				);
				 $(".date").each(function(){
					var tempString = $(this).text();
					var date_rows = $(".date").filter(function(){
						return $(this).text() == tempString; });

					if(date_rows.length > 1){
						date_rows.eq(0).attr("rowspan", date_rows.length);
						date_rows.not(":eq(0)").remove();
					}
				}); 
			}
		});
		switch(mome) {
	    case "PL":  $(".leaguemenu2 a:nth-child(1)").css({"font-weight":"bold","color":"#ffffff"});
					$(".leaguemenu2 a:nth-child(2)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(3)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(4)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(5)").css({"color":"#616161"});
	         break;
	    case "PD":  $(".leaguemenu2 a:nth-child(1)").css({"color":"#616161"});
					$(".leaguemenu2 a:nth-child(2)").css({"font-weight":"bold","color":"#ffffff"});
			       	$(".leaguemenu2 a:nth-child(3)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(4)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(5)").css({"color":"#616161"});
 			break;
	    case "SA":  $(".leaguemenu2 a:nth-child(1)").css({"color":"#616161"});
					$(".leaguemenu2 a:nth-child(2)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(3)").css({"font-weight":"bold","color":"#ffffff"});
			       	$(".leaguemenu2 a:nth-child(4)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(5)").css({"color":"#616161"});
 			break;
	    case "BL1":  $(".leaguemenu2 a:nth-child(1)").css({"color":"#616161"});
					$(".leaguemenu2 a:nth-child(2)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(3)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(4)").css({"font-weight":"bold","color":"#ffffff"});
			       	$(".leaguemenu2 a:nth-child(5)").css({"color":"#616161"});
 			break;
	    case "CL": $(".leaguemenu2 a:nth-child(1)").css({"color":"#616161"});
					$(".leaguemenu2 a:nth-child(2)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(3)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(4)").css({"color":"#616161"});
			       	$(".leaguemenu2 a:nth-child(5)").css({"font-weight":"bold","color":"#ffffff"});
 			break;
		}
	}
	
	$(document).ready(function(){
		$(".news_h2").html(
				"<h1>"+dateString+"&nbsp;&nbsp;&nbsp;리그 일정</h1>"	
		) 
		Season("PL",dateString2,dateString2);
		rank("2_PL");
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
	</script>
	<%@ include file="../include/header.jsp" %>
<%
ListDTO dto = new ListDTO();

ArrayList<PostVO> news  = dto.GetNewsList(6,1, "a", "r", "", "s_all");
ArrayList<PostVO> news2 = dto.GetNewsList(10,1, "a", "v", "", "s_all");
ArrayList<PostVO> main  = dto.GetNewsList(3,1, "a", "v", "", "s_all");
ArrayList<PostVO> video = dto.GetVideoList(4,1, "a", "a","r", "", "s_all");
ArrayList<PostVO> board = dto.GetBoardList(10,1, "a", "r", "", "s_all");
%>
	<!-- main 시작 -->
		<div class="main">
			<div class="section">
				<input type="radio" name="slide" id="slide01" checked>
				<input type="radio" name="slide" id="slide02">
				<input	 type="radio" name="slide" id="slide03">
				<div class="slidewrap">
					<ul class="slidelist">
						<!-- 슬라이드 영역 -->
						<%
						for(PostVO vo : main)
						{
							String title1 = vo.getPost_title();
							String title2 = vo.getPost_title();
							if(title1.length() > 20)
							{
								title1  = title1.substring(0,14);
								title1 += "<br>";
								title2  = title2.substring(14);
								title1 += title2;
							}
							%>
							<li class="slideitem">
							<a href="/kick_off_view/jsp/news/news_view.jsp?no=<%= vo.getPost_no() %>">
								<div class="textbox">
									<h3><%= title1 %></h3>
								</div>
								<img src="../../file/<%= vo.getPost_oname() %>">
							</a>
						</li>
							<%
						}
						%>
						<!-- 좌,우 슬라이드 버튼 -->
						<div class="slide-control">
							<div>
								<label for="slide03" class="left"></label>
								<label for="slide02" class="right"></label>
							</div>
							<div>
								<label for="slide01" class="left"></label>
								<label for="slide03" class="right"></label>
							</div>
							<div>
								<label for="slide02" class="left"></label>
								<label for="slide01" class="right"></label>
							</div>
						</div>
					</ul>
					<!-- 페이징 -->
					<ul class="slide-pagelist">
						<li><label for="slide01"></label></li>
						<li><label for="slide02"></label></li>
						<li><label for="slide03"></label></li>
					</ul>
				</div>
			</div>
			<div class="index_frame">
				<div class="news_list">
					<div class="news_h1">
						<h1>뉴스</h1>
					</div>
					<div class="news_detail">
						<a href="/kick_off_view/jsp/news/news.jsp">더보기+</a>
					</div>
					<table class="news_listtbl" >
					<%
					int index = 0;
					for(PostVO vo: news)
					{
						if(index%2==0)
						{
							%><tr><%
						}
						String title = vo.getPost_title();
						if(title.length() > 50)
						{
							title  = title.substring(0,50);
							title += "...";
						}
						%>
							<td>
								<table class="news_frame">
									<tr>
										<td rowspan="2">
											<a href="/kick_off_view/jsp/news/news_view.jsp?no=<%= vo.getPost_no() %>">
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
										<td><a href="/kick_off_view/jsp/news/news_view.jsp?no=<%= vo.getPost_no() %>"><%= title %></a></td>
									</tr>
								</table>
							</td>
						<%
						if(index%2==1)
						{
							%></tr><%
						}
						index++;
					}
					%>
					</table>
				</div>
					<div class="video_list">
						<div class="news_h1">
							<h1>영상</h1>
						</div>
						<div class="news_detail">
							<a href="/kick_off_view/jsp/video/video.jsp">더보기+</a>
						</div>
						<table>
							<tr>
								<td class="video_box">
								<%
								for(PostVO vo : video)
								{
									String title = vo.getPost_title();
									if(title.length() > 17)
									{
										title  = title.substring(0,17);
										title += "...";
									}
									%>
									<div class="video_frame">
										<a href="/kick_off_view/jsp/video/video_view.jsp?no=<%= vo.getPost_no() %>">
											<%
											if(vo.getPost_video().equals("") || vo.getPost_video() == null)
											{
												%>
												<img src="img/news2.jpg" class="video_thumbnail">
												<%
											}
											else
											{
												%>
												<img src="https://img.youtube.com/vi/<%= vo.getPost_video() %>/maxresdefault.jpg" class="video_thumbnail">
												<%
											}
											%>
										</a><br>
										<a href="/kick_off_view/jsp/video/video_view.jsp" class="video_title"><%= title %></a><br>
										<span class="video_date"><%= vo.getPost_date() %></span>
									</div>
									<%
								}
								%>
								</td>
							</tr>
						</table>
					</div>
					<div class="board_center">
						<table class="bottom">
							<tr>
								<td>
									<div class="news_h1">
										<h1>많이 본 뉴스</h1>
									</div>
									<div class="news_detail">
										<a href="/kick_off_view/jsp/news/news.jsp">더보기+</a>
									</div>
									<br><br><br>
									<table>
										<tr>
											<td  class="table_ul"> 
												<ul>
												<%
												for(PostVO vo : news2)
												{
													String title = vo.getPost_title();
													if(title.length() > 20)
													{
														title  = title.substring(0,20);
														title += "...";
													}
													%>
													<li><a href="/kick_off_view/jsp/news/news_view.jsp?no=<%= vo.getPost_no() %>"><%= title %></a></li>
													<%
												}
												%>
												</ul>
											</td>
										</tr>
									</table>
								</td>
								<td>
									<div class="news_h1">
										<h1>게시판</h1>
									</div>
									<div class="news_detail">
										<a href="/kick_off_view/jsp/board/board_list.jsp">더보기+</a>
									</div>
									<br><br><br>
									<table>
										<tr>
											<td  class="table_ul">
												<ul>
												<%
												for(PostVO vo : board)
												{
													String title = vo.getPost_title();
													if(title.length() > 20)
													{
														title  = title.substring(0,20);
														title += "...";
													}
													%>
													<li><a href="/kick_off_view/jsp/board/board_view.jsp?no=<%= vo.getPost_no() %>"><%= title %></a></li>
													<%
												}
												%>
												</ul>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</div>
					<div class="board_center">
						<table class="bottom">
							<tr>
								<td id="VT">
									<div class="news_h1" >
										<h1>순위</h1>
									</div>
									<div class="news_detail">
										<a href="/kick_off_view/jsp/rank/rank1.jsp">더보기+</a>
									</div>
									<br><br><br>
									<div class="leaguemenu">
										<a class="PLButton" onclick="rank('2_PL');">프리미어리그</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="laButton" onclick="rank('3_PD');">라리가</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="SAButton" onclick="rank('4_SA');">세리에 A</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="buButton" onclick="rank('5_BL1');">분데스리가</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="UEFAButton" onclick="rank1();">챔피언스리그</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
									<br>
									<div class="leaguedata">
									</div>
								</td>
								<td id="VT">
									<div class="news_h2">
									</div>
									<div class="news_detail">
										<a href="/kick_off_view/jsp/schedule/result_schedule.jsp">더보기+</a>
									</div>
									<br><br><br>
									<div class="leaguemenu2">
										<a class="PLButton" onclick="Season('PL',dateString2,dateString2);">프리미어리그</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="laButton" onclick="Season('PD',dateString2,dateString2);">라리가</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="SAButton" onclick="Season('SA',dateString2,dateString2);">세리에 A</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="buButton" onclick="Season('BL1',dateString2,dateString2);">분데스리가</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<a class="UEFAButton" onclick="Season('CL',dateString2,dateString2);">챔피언스리그</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									</div>
									<br>
									<div class="chams">
									</div>
								</td>
							</tr>
						</table>
					</div>
			 </div>
		</div>
		<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>