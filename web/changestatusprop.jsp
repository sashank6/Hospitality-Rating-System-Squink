<%-- 
    Document   : changepropstatus
    Created on : Mar 1, 2014, 1:33:50 PM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%
String citycode,pid,status;
citycode=request.getParameter("citycode");
pid=request.getParameter("pid");
status=request.getParameter("status");

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    </head>
    <body>
        <%
         Connect obj=new Connect();
        Connection con=obj.conect();
        PreparedStatement pstmt=con.prepareStatement("update citypendingpropdb_"+citycode+" set status=? where pid=?");
        pstmt.setInt(1, Integer.parseInt(status));
        pstmt.setString(2,pid);
        pstmt.execute();
        con.close();
        
        %>
        
    </body>
</html>
