<%-- 
    Document   : admin_home
    Created on : Jan 7, 2014, 8:22:42 PM
    Author     : Sashank
--%>

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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Home</title>
    </head>
    <body>
        <a href="addEmployee.jsp">Add Employee</a>
        <a href="listEmployee.jsp">View Employees</a>
        <a href="addCity.jsp">Add  City</a>
        <a href="assignce2.jsp">Assign CE2</a>
        <a href="viewCities.jsp">View Cities Serviced</a>
        <a href="addCategory.jsp">Add Category</a>
        <a href="viewCategories.jsp">View Categories</a>
        <a href="logout.jsp">logout</a>
    </body>
</html>
