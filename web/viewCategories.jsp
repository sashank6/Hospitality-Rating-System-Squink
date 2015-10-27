<%-- 
    Document   : viewCategories
    Created on : Feb 28, 2014, 10:55:08 PM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="squink.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="style1.css"/>
    </head>
    <body>
        <table>
            <th>Category Name</th>
        <%
        Connect obj=new Connect();
        Connection con=obj.conect();
        PreparedStatement pstmt=con.prepareStatement("select catname from categorytable");
        ResultSet rs=pstmt.executeQuery();
        while(rs.next())
                       {
            out.println("<tr><td>"+rs.getString(1)+"</td></tr>");
        }
        con.close();
        %>
        </table>
    </body>
</html>
