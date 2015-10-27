<%-- 
    Document   : logout
    Created on : Feb 25, 2014, 10:56:50 PM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
    </head>
    <body>
        <%
        session.invalidate();
        %>
    </body>
</html>
