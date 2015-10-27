
<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%-- 
    Document   : createTrigger
    Created on : Mar 3, 2014, 1:08:34 AM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        Connect obj=new Connect();
        Connection con=obj.conect();
       PreparedStatement cs=con.prepareStatement("create or replace trigger testjsp1 after update on cityapprovedproperty_c1039 for each row begin if"+" "+"new.rate <=0 then new.status:=0; end if; end;");
       cs.execute();
        
        %>
    </body>
</html>
