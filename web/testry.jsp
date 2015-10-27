<%-- 
    Document   : testry
    Created on : Mar 1, 2014, 8:53:49 PM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="squink.*"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
            var ct=0;
            var g=new Array();
            <% 
            Connect obj=new Connect();
            Connection con=obj.conect();
            PreparedStatement pstmt=con.prepareStatement("select id from employeedb");
            ResultSet rs=pstmt.executeQuery();
            while(rs.next())
                               {
            %>
                g[ct++]=<%=rs.getLong(1)%>
                    <%
                                       }
            %>
                alert(g[0]+" "+g[1]+" "+g[2]);
        </script>
    </head>
    <body>
        
    </body>
</html>
