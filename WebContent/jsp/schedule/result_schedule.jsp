 <%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>헤더</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/result_schedule.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
	<script>
	var today = new Date();
	
	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);

	var dateString = month+'월'+day+'일';
	var dateString2 = year + "-" + month + "-" + day;
	function mainseason(mome,fDate,eDate)	//시즌일정 조회 
	{
		 // 셀렉트에서 시즌 년월이 선택되었을때 그 값을 불러옴
		/* obj = $("#selectBox"); */
		// API주소와 토큰이 있는 schedule_CL.jsp를 호출함
		let date_url = "/kick_off_view/jsp/schedule/schedule_"+ mome +".jsp?fDate="+ fDate + "&eDate=" + eDate;
		console.log(date_url);
		// 시즌 년월 선택값이 있으면
		/* if( $(obj).val() != "" )
		{
			// 호출 주소에 파라메타를 추가함
			date_url += "?month=" + $(obj).val();
		}  */
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
							strHTML += "<tr>"
							strHTML += "<td id='date'>"+value.utcDate.replaceAll("-",".").substr(11,5)+"</td>"
							strHTML += "<td class='home'>"+value.homeTeam.tla+"&nbsp;&nbsp;"
							strHTML += "<img src="+value.homeTeam.crest+"></td>"
							strHTML += "<td>"+((value.score.fullTime.home == null) ? "" : value.score.fullTime.home) +"&nbsp;"+((value.score.fullTime.home == null) ? "vs" : ":")+"&nbsp;"+((value.score.fullTime.away == null) ? "" : value.score.fullTime.away )+"</td>"
							strHTML += "<td class='away'><img src="+value.awayTeam.crest+">"
							strHTML += "&nbsp;&nbsp;"+value.awayTeam.tla+"</td></tr>"
					}
				const html_for_null = "<tr><td colspan='100'>일정이 없습니다</td></tr>";
				switch(mome){
				 case "CL2" :$(".chams").html(
								"<p class='mainname'>챔피언스 리그  <a href='schedule1.jsp?mcate=CLSC'>+</a></p>"
								+"<table class='chamstbl' border='1'>"
								+"<tr>"
								+"<th>시간</th>"
								+"<th colspan='3' class='matchname'>경기</th>"
								+"</tr>"
								+ ((strHTML == "")? html_for_null : strHTML ) +"</table>"
							);
				 			break;
				 case "PL" :$(".PL").html(
							"<p class='mainname'>프리미어 리그  <a href='schedule1.jsp?mcate=PLSC'>+</a></p>"
							+"<table class='chamstbl' border='1'>"
							+"<tr>"
							+"<th>시간</th>"
							+"<th colspan='3' class='matchname'>경기</th>"
							+"</tr>"
							+ ((strHTML == "")? html_for_null : strHTML ) +"</table>"
						);
			 			break;
				 case "PD" :$(".La").html(
							"<p class='mainname'>라리가  <a href='schedule1.jsp?mcate=PDSC'>+</a></p>"
							+"<table class='chamstbl' border='1'>"
							+"<tr>"
							+"<th>시간</th>"
							+"<th colspan='3' class='matchname'>경기</th>"
							+"</tr>"
							+ ((strHTML == "")? html_for_null : strHTML ) +"</table>"
						);
			 			break;
				 case "SA" :$(".SA").html(
							"<p class='mainname'>세리에 A <a href='schedule1.jsp?mcate=SASC'>+</a></p>"
							+"<table class='chamstbl' border='1'>"
							+"<tr>"
							+"<th>시간</th>"
							+"<th colspan='3' class='matchname'>경기</th>"
							+"</tr>"
							+ ((strHTML == "")? html_for_null : strHTML ) +"</table>"
						);
			 			break;
				 case "BL1" :$(".bn").html(
							"<p class='mainname'>분데스리가 <a href='schedule1.jsp?mcate=BL1SC'>+</a></p>"
							+"<table class='chamstbl' border='1'>"
							+"<tr>"
							+"<th>시간</th>"
							+"<th colspan='3' class='matchname'>경기</th>"
							+"</tr>"
							+ ((strHTML == "")? html_for_null : strHTML ) +"</table>"
						);
			 			break;
							}
					{
						
					}
				
				
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
	}	
	
	$(document).ready(function(){
		mainseason("PL",dateString2,dateString2);
		mainseason("PD",dateString2,dateString2);
		mainseason("SA",dateString2,dateString2);
		mainseason("BL1",dateString2,dateString2);
		mainseason("CL2",dateString2,dateString2);
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
<!-- main 시작 -->
		<div class="main">
		<br><br><br><br><br>
		<!-- 여기부터 내용넣기 -->
		<div class="schedule_frame">
		<div class="scheduledate">
			<h2>금일 리그 일정</h2>
		</div>
		<div class="all">
			<div class="PL">
			</div>
			<div class="La">
			</div>
			<div class="SA">
			</div>
			<div class="bn">
			</div>
			<div class="chams">
			</div>
		</div>
		<div class="info_frame">
			<div class="info">
				<p><b>kick off</b>에서 제공하는 일정, 결과, 기록 등의 데이터는 '제공처'의 사정에 따라 지연되거나 잘못 표시될 수 있습니다.</p>
				<p><b>kick off</b>는 그에 따른 스포츠 데이터의 정확성 및 신뢰성을 담보하지 않습니다. 궁금하신 사항은 고객센터를 통해서 문의해주시기 바랍니다.</p>
			</div>
		</div>
		<br><br><br>
		</div>
		<!-- 여기부터 내용넣기 -->
		</div>
		<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>