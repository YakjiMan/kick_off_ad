<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.util.*" %> 
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%
String no = request.getParameter("no");
if( no == null || no.equals("") )
{
	response.sendRedirect("/kick_off_view/jsp/index/index.jsp");
	return;
}

PostDTO dto = new PostDTO();
PostVO vo = dto.Read(no, false);
String post_pname = vo.getPost_pname();
String post_oname = vo.getPost_oname();

//첨부파일을 하드디스크에서 읽어서 브라우저에 전송한다.
String uploadPath = "D:\\GIY\\java\\study\\kick_off\\WebContent\\download";
String fileName = uploadPath + "\\" + post_pname;
//out.println(fileName);

//브라우저에 파일명을 보낸다.
post_oname = URLEncoder.encode(post_oname,"utf-8");
//System.out.println(fname);
response.setContentType("application/octet-stream");   
response.setHeader("Content-Disposition","attachment; filename=" + post_oname);

File file = new File(fileName);
FileInputStream fileIn = new FileInputStream(file);
ServletOutputStream ostream = response.getOutputStream();

byte[] outputByte = new byte[4096];
//copy binary contect to output stream
while(fileIn.read(outputByte, 0, 4096) != -1)
{
	ostream.write(outputByte, 0, 4096);
}
fileIn.close();
ostream.flush();
ostream.close();
%>