<%-- 
    Document   : assignce2
    Created on : Feb 20, 2014, 10:50:35 AM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try
  {
    String type=(String)session.getAttribute("usertype");
    if(Integer.parseInt(type)!=1)
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
        <link href="style1.css" rel="stylesheet" type="text/css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
    </head>
    <body>
        <table border="1">
        <%
        Connect obj=new Connect();
        Connection con=obj.conect();
        char datap=0;
      PreparedStatement pstmt=con.prepareStatement("select id,city,country from employeeDB where id not in(select id from CE2service) and dept=?");
      pstmt.setString(1, "CE2");
      ResultSet rs=pstmt.executeQuery();
      while(rs.next())
      {
          datap=1;
          out.println("<tr>");
          out.println("<td><a href=\"viewEmployee.jsp?id="+rs.getLong(1)+"\">"+rs.getLong(1)+"</td>");
          out.println("<td>"+rs.getString(2)+"</td>");
          out.println("<td>"+rs.getString(3)+"</td>");
          out.println("<td><a href=\"asgnce2.jsp?id="+rs.getLong(1)+"\">Assign</td>");
          out.println("</tr>");
      }           
       con.close(); 
       
        %>
        </table>
        <%
        if(datap==0)
      {
           out.println("<p>No  employees available for assignement</p>");
       }
        %>
        
    </body>
</html>
