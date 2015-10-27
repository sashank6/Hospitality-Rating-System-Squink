<%-- 
    Document   : confirmuser
    Created on : Feb 28, 2014, 1:58:35 PM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String cnfcode=request.getParameter("cnfcode");
String username=request.getParameter("username");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    </head>
    <body>
        <%
        try
               {
        Connect obj=new Connect();
        Connection con=obj.conect();
        
        PreparedStatement pstmt=con.prepareCall("{call confirmuser(?,?)}");
        pstmt.setString(1, cnfcode);
        pstmt.setString(2,username);
        pstmt.execute();
        out.println("User email Validated Successfully");
               }
        catch(Exception e)
                               {
            out.println("Unable to validate user email");
        }
        
        
        %>
    </body>
</html>
