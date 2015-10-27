<%-- 
    Document   : asgnce2
    Created on : Feb 20, 2014, 11:43:24 AM
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
<%
String id=request.getParameter("id");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Assign CE2</title>
        <link href="style1.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            var text;
            function func2()
            {
                var id="<%=id%>";
                var city=document.getElementById("cityname");
                var cityname=city.options[city.selectedIndex].text;
                $.ajax({
                    type:"POST",
                    url:"asgncityce2",
                    dataType:"html",
                    data:{id:id,City:cityname,Country:text},
                    async:false,
                    success: function fdfd(data)
                    {
                        if(parseInt(data)==1)
                            {
                                alert("CE2 Assigned Successfully");
                                   window.location.href="admin_home.jsp";
                            }
                    else
                                document.getElementById("msg").innerHTML="Unable to Assign CE2";
                        
                            }
                            
                    
                    
                });
                
            }
            
            function func1()
            {
                var ty=document.getElementById("country");
                 text=ty.options[ty.selectedIndex].text;
                $.ajax({
                    type:"POST",
                    url:"getCityData",
                    dataType:"html",
                    data:{ctry:text},
                    async:false,
                    success: function fdfd(data)
                    {
                        document.getElementById("cityname").innerHTML=data;
                        
                    }
                    
                });
                
                  
               
            }
        </script>
    </head>
    <body>
        <table border="1">
            <tr>
                <td>EmployeeId</td>
                <td><%=id%></td>
            
            </tr>
            <tr>
                <td>Country</td>
                <td><select id="country" onchange="func1()">
                        <option></option>
                        <% 
                        Connect obj=new Connect();
                        Connection con=obj.conect();
                        PreparedStatement pstmt=con.prepareStatement("select distinct country from servicedCityDB");
                        ResultSet rs=pstmt.executeQuery();
                        while(rs.next())
                        {
                            out.println("<option>"+rs.getString(1)+"</option>");
                            
                        }
                        %>
                    </select>
            </tr>
            <tr>
                <td>City</td>
                <td><select id="cityname">
                        
                    </select></td>
            </tr>
            <tr><td colspan="2" align="center">
                    <input type="Button" value="Assign" onclick="func2()"/>
                </td></tr>
        </table>
                    <p id="msg"></p>
    </body>
</html>
