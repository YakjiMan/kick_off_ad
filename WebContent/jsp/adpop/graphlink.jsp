<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="kickoff.dto.*" %>
<%@ page import="kickoff.dao.*" %>
<%@ page import="kickoff.vo.*" %>
<%@ page import="java.util.*" %>
<script src="../../js/jquery-3.6.3.js"></script>
<% 
String ans_key = request.getParameter("ans_key");

pythonbrowse test = new pythonbrowse();

test.test(ans_key);
%>
<script>
window.onload = function()
{
	alert("¾È³ç");
}
</script>
