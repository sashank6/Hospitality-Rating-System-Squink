<%-- 
    Document   : listEmployee
    Created on : Feb 11, 2014, 10:58:13 AM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

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
        <title>Employee List</title>
    </head>
    <body>
        <%
        Connect obj=new Connect();
        Connection con=obj.conect();
        PreparedStatement pstmt=con.prepareStatement("select id,firstname,lastname,dept from employeeDB order by id");
        ResultSet rs=pstmt.executeQuery();
        
        %>
        <table border="1">
            <th>Employee ID</th><th>First Name</th><th>Last Name</th><th>Department</th>
            <%
            while(rs.next())
            {
                out.println("<tr>");
                int id=rs.getInt(1);
                out.println("<td><a href=\"viewEmployee.jsp?id="+id+"\">"+id+"</td>");
                out.println("<td>"+rs.getString(2)+"</td>");
                out.println("<td>"+rs.getString(3)+"</td>");
                out.println("<td>"+rs.getString(4)+"</td></tr>");
                
                
            }
        con.close();
            %>
        </table>
    </body>
</html>
