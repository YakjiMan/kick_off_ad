<%@ page language="java" pageEncoding="EUC-KR"%>
<%@ page import="kickoff.vo.*" %>
<%@ page import="kickoff.dto.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>

<%
//text/html; charset=EUC-KR
String no = request.getParameter("no");
if(no == null || no.equals(""))
{
	response.sendRedirect("/kick_off_view/jsp/board/index.jsp");
	return;
}

PostDTO dto = new PostDTO();
PostVO vo = dto.Read(no, false);
String oname  = vo.getPost_oname();
String pname    = vo.getPost_pname();

//첨부파일을 하드디스크에서 읽어서 브라우저에 전송한다.

String uploadPath = "D:\\SHS\\java\\kickoff\\kick_off\\WebContent\\file\\";
String fileName   = uploadPath + "\\" + pname;
out.println(fileName);

//브라우저에 파일명을 보낸다.
oname = URLEncoder.encode(oname,"utf-8");
response.setContentType("application/octet-stream");   
response.setHeader("Content-Disposition","attachment; filename=" + oname);

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