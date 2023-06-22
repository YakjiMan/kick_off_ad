<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.net.*, java.io.*"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%
	//세션에다가 값 저장해놓기 
	String ln = "";
	
	ln = (String)session.getAttribute("CLSTANDING");
	if(ln == null)
	{
		System.out.println("API로 데이터를 수신합니다.");
		ln = "";
		
		//매개변수 포함하여 api 주소 만들기
		String address="https://api.football-data.org/v4/competitions/CL/standings";
	
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
		
		session.setAttribute("CLSTANDING",ln);
	}else
	{
		System.out.println("API를 세션에서 받았습니다.");
	}
	
	
	out.print(ln);
	
%>