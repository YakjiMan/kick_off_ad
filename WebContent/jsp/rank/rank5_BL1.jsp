<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="java.net.*, java.io.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%
	//세션에다가 값 저장해놓기 
	String ln = "";
	
	ln = (String)session.getAttribute("BL1STANDING");
	if(ln == null)
	{
		System.out.println("API로 데이터를 수신합니다.");
		ln = "";
		
		//매개변수 포함하여 api 주소 만들기
		String address="https://api.football-data.org/v4/competitions/BL1/standings";
	
		//객체 생성 및 url 연결
		URL url = new URL(address); //url 객채 생성
		URLConnection urlConn = url.openConnection(); //url 객체 얻기
		urlConn.setRequestProperty("X-Auth-token", "d5e1fe0b1f084179af33060ed794581f"); //인증 키 header값 입력
	
		//데이터 받아오기
		InputStreamReader inputStream = new InputStreamReader(urlConn.getInputStream(),"UTF-8");
		BufferedReader bufferRead = new BufferedReader(inputStream);
		
		//bufferedreader 최대까지 받아올수있도록 반복
		String str = null;		
		do
		{
			str = bufferRead.readLine();
			if( str != null ) ln += str;
		}while(str != null);
		
		session.setAttribute("BL1STANDING",ln);
	}else
	{
		System.out.println("API를 세션에서 받았습니다.");
	}
	
	
	out.print(ln);
	/*
	JSONParser jsonParser = new JSONParser();
	JSONObject jsonObject = (JSONObject)jsonParser.parse(ln);
	
	out.print(jsonObject);
	//오브젝트 배열
	JSONObject filtersObject = (JSONObject)jsonObject.get("filters");
	JSONObject areaObject = (JSONObject)jsonObject.get("area");
	JSONObject competitionObject = (JSONObject)jsonObject.get("competition");
	JSONObject seasonObject = (JSONObject)jsonObject.get("season");
	

	
	//스탠딩 배열
	JSONArray standingsArray = (JSONArray)jsonObject.get("standings");
	for(int i=0;i<standingsArray.size();i++){
		JSONObject first = (JSONObject)standingsArray.get(i);
		String stage = first.get("stage").toString();
		String type = first.get("type").toString();
		
	//테이블 배열	
		JSONArray tableArray = (JSONArray)first.get("table");
		for(int j=0;j<tableArray.size();j++){
				JSONObject second = (JSONObject)tableArray.get(j);
				String position = second.get("position").toString();
				//내부오브젝트 
				JSONObject teamObject = (JSONObject)second.get("team");
				
				String playedGames = second.get("playedGames").toString();
				String won = second.get("won").toString();
				String form = second.get("form").toString();
				String draw = second.get("draw").toString();
				String lost = second.get("lost").toString();
				String points = second.get("points").toString();
				String goalsFor = second.get("goalsFor").toString();
				String goalsAgainst = second.get("goalsAgainst").toString();
				String goalDifference = second.get("goalDifference").toString();				
				
				
			 }
			 
		
		
	} */
%>