<%-- 
    Document   : viewRegion
    Created on : Feb 26, 2014, 12:12:53 AM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String citycode=request.getParameter("citycode");
%>
<!DOCTYPE html>
<html>
    <head>
        <link href="style1.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
    </head>
    <body>
        <table border="1">
            <th>Areas Serviced</th>
        <%
        Connect obj=new Connect();
        Connection con=null;
        con=obj.conect();
        PreparedStatement pstmt=con.prepareStatement("select areasserviced from cityregiondb_"+citycode);
        ResultSet rs=pstmt.executeQuery();
        while(rs.next())
        {
            out.println("<tr>");
            out.println("<td>"+rs.getString(1)+"</td>");
            out.println("</tr>");
            
        }
        
                %>
                </table>
    </body>
</html>