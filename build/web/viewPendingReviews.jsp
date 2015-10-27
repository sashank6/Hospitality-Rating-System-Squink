<%-- 
    Document   : viewPendingReviews
    Created on : Feb 26, 2014, 2:38:44 PM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String username=null;
try
               {
 String type=(String)session.getAttribute("usertype");
username=(String)session.getAttribute("username");
  if(Integer.parseInt(type)!=3)
            response.sendRedirect("ce2_home.jsp");
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
        <link href="style1.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
        Connect obj=new Connect();
        Connection con=obj.conect();
        PreparedStatement pstmt=con.prepareStatement("select city from ce2service where id=?");
        pstmt.setLong(1,Long.parseLong(username));
        ResultSet rs=pstmt.executeQuery();
        String citycode=null;
        while(rs.next())
                       {
            citycode=rs.getString(1);
            
        }
        pstmt.close();
        pstmt=con.prepareStatement("select pid,name,address,clientrating from citypendingpropdb_"+citycode+" where aasignedce_2=? and status<>3");
        pstmt.setLong(1,Long.parseLong(username));
        rs=pstmt.executeQuery();
        
        %>
        <table>
            <th>Name</th><th>Address</th><th>Client Rating</th><th>Action</th>
  <%
            while(rs.next())
          {
                out.println("<tr>");
                String pid1=rs.getString(1);
                out.println("<td><a href=\"pendingProperty.jsp?pid="+rs.getString(1)+"&citycode="+citycode+"\">"+rs.getString(2)+"</a></td>");
                out.println("<td>"+rs.getString(3)+"</td>");
                out.println("<td>"+rs.getInt(4)+"</td>");
                out.println("<td><a href=\"giveReport.jsp?pid="+pid1+"&citycode="+citycode+"\">Approve</a>&nbsp;&nbsp;<a href=\"changestatusprop.jsp?pid="+pid1+"&citycode="+citycode+"&status=1\">Visiting Today</a>&nbsp;&nbsp;<a href=\"changestatusprop.jsp?pid="+pid1+"&citycode="+citycode+"&status=2\">Reject</a></td>");
                out.println("</tr>");
                
          }
        rs.close();
%>
        </table>
        
    </body>
</html>
