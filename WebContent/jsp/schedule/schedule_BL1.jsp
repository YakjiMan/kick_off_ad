<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.net.*, java.io.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%
// 파라메타로 조회할 시즌을 받는다
String season = request.getParameter("season");
// 파라메타로 조회할 년월(월단위)를 받는다
String month = request.getParameter("month");
// 파라메타로 조회할 시작일과 종료일을 받는다
String datefrom = request.getParameter("fDate");
String dateto = request.getParameter("eDate");

// 모든 파라메타가 안넘어오면, 지금 시즌 1년 단위로 데이터를 불러온다
if( season == null && month == null && datefrom == null ) { datefrom = "2022-06-01"; dateto   = "2023-06-30"; }
if( season   == null ) { season   = ""; };
if( month    == null ) { month    = ""; };
if( datefrom == null ) { datefrom = ""; };
if( dateto   == null ) { dateto   = ""; };

// 세션에다가 값 저장해놓기 
String session_name = "SBL_" + month;
System.out.println("session name :" + session_name);
		String ln = (String)session.getAttribute(session_name);
		if(ln == null)
		{
			ln = "";
			System.out.println("API로 데이터를 수신합니다.");
			//매개변수 포함하여 api 주소 만들기
			String address = "https://api.football-data.org/v4/competitions/BL1/matches";
			// 파라메타가 안넘어오거나, 시작일, 종료일이 넘어왔으면
			if( datefrom.equals("") != true )
			{
				address += "?dateFrom=" + datefrom + "&dateTo=" + dateto;
			}
			// 시즌 선택이 넘어왔으면
			if( !season.equals("") )
			{
				address += "?dateFrom=20" + season + "-08-01" + "&dateTo=20" + ( season + 1 ) + "-05-31";
			}
			// 년월이 넘어오면
			if( !month.equals("") )
			{
				address += "?dateFrom=" + month + "-01" + "&dateTo=" + month + "-31";
			}
			
//			System.out.println("address : " + address);
			//객체 생성 및 url 연결
			URL url = new URL(address);
			URLConnection urlConn = url.openConnection();
			urlConn.setRequestProperty("X-Auth-token", "d5e1fe0b1f084179af33060ed794581f");
			///데이터 받아오기
			InputStreamReader inputStream = new InputStreamReader(urlConn.getInputStream(),"UTF-8");
			BufferedReader bufferRead = new BufferedReader(inputStream);
			//bufferedreader 최대까지 받아올수있도록 반복
			String str = null;		
			do
			{
				str = bufferRead.readLine();
				if( str != null ) ln += str;	
			}while(str != null);
			session.setAttribute(session_name,ln);
		}else{ System.out.println("API를 세션에서 받았습니다."); }
//		System.out.println(ln);
		out.print(ln);
%>