<%-- 
    Document   : pendingProperty
    Created on : Feb 26, 2014, 3:00:04 PM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String pid=request.getParameter("pid");
String citycode=request.getParameter("citycode");
%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="style1.css" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    </head>
    <body>
        <table>
            <%
            Connect obj=new Connect();
            Connection con=obj.conect();
            PreparedStatement pstmt=con.prepareStatement("select name,regioncode,descp,address from citypendingpropdb_"+citycode+" where pid=?");
            pstmt.setString(1, pid);
            ResultSet rs=pstmt.executeQuery();
            while(rs.next())
                               {
                out.println("<tr>");
                out.println("<td>Name</td>");
                out.println("<td>"+rs.getString(1)+"</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Region Name</td>");
                PreparedStatement pstmt1=con.prepareStatement("select areasserviced from cityregiondb_"+citycode+"  where regioncode=? ");
                pstmt1.setString(1, rs.getString(2));
                ResultSet rs1=pstmt1.executeQuery();
                String areaname=null;
                while(rs1.next())
                {
                    areaname=rs1.getString(1);
                }
                rs1.close();
                pstmt1.close();
                out.println("<td>"+areaname+"</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Description</td>");
                out.println("<td>"+rs.getString(3)+"</td>");
                out.println("</tr>");
                out.println("<tr>");
                out.println("<td>Address</td>");
                out.println("<td>"+rs.getString(4)+"</td>");
                out.println("</tr>");
                
            }
            pstmt.close();
            rs.close();
            %>
        </table>
    </body>
</html>
