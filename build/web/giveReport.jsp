<%-- 
    Document   : giveReport
    Created on : Feb 26, 2014, 3:26:25 PM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
/*
try
               {
 String type=(String)session.getAttribute("usertype");
  if(Integer.parseInt(type)!=3)
            response.sendRedirect("LoginPage.jsp");
 }
catch(Exception e)
               {
    response.sendRedirect("LoginPage.jsp");
}*/
%>
<%
String citycode=request.getParameter("citycode");
String pid=request.getParameter("pid");
session.setAttribute("citycode", citycode);
session.setAttribute("pid", pid);

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style1.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function func1()
            {
                var g=document.getElementById("imagelen");
                var img=g.options[g.selectedIndex].text;
                img=parseInt(img);
                var tg="<input type=\"file\" name=\"file\"/>";
                var ty=tg;
                for(var i=1;i<img;i++)
                    ty=ty+tg;
                document.getElementById("imageblock").innerHTML=ty;
            }
        </script>
    </head>
    <body>
        <form method="POST" action="addApprovedProperty" enctype="multipart/form-data">
        <table>
            <tr>
                <td>Name</td>
                <td><input type="text" name="name"/></td>

            </tr>
            <tr>
                <td>Description</td>
                <td><textarea rows="4" cols="20" name="Desc"> </textarea></td>       
            </tr>
            <tr>
                <td>latitude</td>
                <td><input type="text" name="latitude"/></td>
            </tr>
            <tr>
                <td>longitude</td>
                <td><input type="text" name="long"/></td>
            </tr>
            <tr>
                <td>Address</td>
                <td><textarea rows="4" cols="20" name="address"> </textarea></td>
            </tr>
            <tr>
                <td>Category</td>
                <td><select id="category" name="category">
                        <%
                        Connect obj=new Connect();
                        Connection con=obj.conect();
                        PreparedStatement pstmt=con.prepareStatement("select *from categorytable");
                        ResultSet rs=pstmt.executeQuery();
                        while(rs.next())
                       {
                            out.println("<option value=\""+rs.getInt(1)+"\">"+rs.getString(2)+"</option>");
                            
                        }
                        pstmt.close();
                      
                        rs.close();
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>aScore factor</td>
                <td><input name="ambi" type="text"/></td>
            </tr>
            <tr>
                <td>Premium Factor</td>
                 <td><input name="serv" type="number" min="0" max="2"/></td>
            </tr>
            <tr>
                <td>Daily Quota</td>
                <td><input name="cost" type="text" /></td>
            </tr>
            <tr>
                <td>Price Range</td>
                 <td><input name="qual" type="text" /></td>
            </tr>
            <tr>
                <td>
                    Number of Images
                </td>
                <td>
                    <select id="imagelen" onchange="func1()" name="imagelen">
                        <%
                        for(int i=1;i<10;i++)
                            out.println("<option>"+i+"</option>");
                        %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Region</td>
                <td><select name="rcode">
                        <%
                        pstmt=con.prepareStatement("select * from cityregiondb_"+citycode);
                        rs=pstmt.executeQuery();
                        while(rs.next())
                                                       {
                            out.println("<option value=\""+rs.getString(1)+"\">"+rs.getString(2)+"</option>");
                        }
                        %>
                    </select>
            </tr>
           
        </table>
       <div id="imageblock">
                
                  <input type="file" name="file"/>
       </div>
                    <input type="submit" value="submit"/>
        </form>
    </body>
</html>
