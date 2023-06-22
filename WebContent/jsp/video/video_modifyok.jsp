<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<title>등록완료</title>
		<link href="../hfcss/header.css" rel="stylesheet" type="text/css">
		<link href="../hfcss/footer.css" rel="stylesheet" type="text/css">
		<link href="css/video_writeok.css" rel="stylesheet" type="text/css">
		<script src="../../js/jquery-3.6.3.js"></script>
	</head>
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
	<%@ include file="../include/header.jsp" %>
<!-- main 시작 -->

<%@ page import="java.io.*" %>    
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<!-- 컨텐츠 출력 되는곳 -------------------------- -->
<%
String dir = application.getRealPath("");
int cutter = dir.indexOf(".metadata");
dir  = dir.substring(0,cutter);
dir  = dir.replace("\\","\\\\");
dir += "kick_off\\\\WebContent\\\\file";
String uploadPath = dir;
//업로드가 가능한 최대 파일 크기를 지정한다.
int size = 10 * 1024 * 1024;

MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"EUC-KR",new DefaultFileRenamePolicy());

request.setCharacterEncoding("EUC-KR");

String no      = multi.getParameter("no");
String title   = multi.getParameter("title");
String source  = multi.getParameter("source");
String note    = multi.getParameter("note");
String mcate   = multi.getParameter("mcate");
String scate   = multi.getParameter("scate");
String pageno  = multi.getParameter("pageno");
String video   = multi.getParameter("video");
String pname   = multi.getParameter("pname");
String oname   = multi.getParameter("oname");

//유튜브 주소 수정
video = video.replace("https://youtu.be/", "");

//첨부파일이 있으면 추가한다.
//업로드된 파일명을 얻는다.
Enumeration files = multi.getFileNames();
if(files != null)
{
	String fileid = (String) files.nextElement();
	String filename = (String) multi.getFilesystemName("attach");
	if(filename != null)
	{
		oname = filename;
		pname = UUID.randomUUID().toString();

		//파일 이름 변경
		String orgName = uploadPath + "\\" + oname;
		String newName = uploadPath + "\\" + pname;		

		File srcFile    = new File(orgName);
		File targetFile = new File(newName);
		//srcFile.renameTo(targetFile);
		
		out.println("원래 파일명 : " + orgName + "<br>");
		out.println("바뀐 파일명 : " + newName + "<br>");
	}
}
System.out.println("title = " + title);
System.out.println("source = " + source);
System.out.println("note = " + note);
System.out.println("mcate = " + mcate);
System.out.println("scate = " + scate);
System.out.println("pageno = " + pageno);
System.out.println("pname = " + pname);
System.out.println("oname = " + oname);

PostVO vo = new PostVO();
vo.setPost_no(no);
vo.setUser_no(login_vo.getUser_no());
vo.setPost_title(title);
vo.setPost_source(source);
vo.setPost_note(note);
vo.setPost_type("v");
vo.setPost_mcate(mcate);
vo.setPost_scate(scate);
vo.setPost_video(video);
vo.setPost_pname(pname);
vo.setPost_oname(oname);

PostDTO dto = new PostDTO();
dto.VideoUpdate(vo);

response.sendRedirect("/kick_off_view/jsp/video/video_view.jsp?no=" + no);
%>
		<!-- main 끝 -->
<%@ include file="../include/footer.jsp" %>