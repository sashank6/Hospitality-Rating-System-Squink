<%-- 
    Document   : ce2_home
    Created on : Feb 26, 2014, 2:34:15 PM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try
               {
 String type=(String)session.getAttribute("usertype");
  if(Integer.parseInt(type)!=3)
            response.sendRedirect("LoginPage.jsp");
 }
catch(Exception e)
               {
    response.sendRedirect("LoginPage.jsp");
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <a href="viewPendingReviews.jsp">View Pending Reviews</a>
    </body>
</html>
