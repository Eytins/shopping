<%@page contentType="image/jpeg" %>

<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<jsp:useBean id="image" scope="page" class="com.zte.shopping.util.MakeCheckCode">
</jsp:useBean>
<%
    String str = image.getCode(0,0,response.getOutputStream());
    session.setAttribute("checkCode",str);
%>