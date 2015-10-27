<%-- 
    Document   : ce1propertystatus
    Created on : Feb 28, 2014, 11:28:14 PM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="squink.*"%>
<%@page import="java.sql.*"%>
<%
String username=null;
try
               {
    username=(String)session.getAttribute("username");
    String type=(String)session.getAttribute("usertype");
    if(Integer.parseInt(type)!=2)
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
        <link rel="stylesheet" href="style1.css" type="text/css"/>
       
    </head>
    <body>
        <%
        Connect obj=new Connect();
        Connection con=obj.conect();
        PreparedStatement pstmt=con.prepareStatement("select count(*) from ce1_"+username);
        int count=0;
        ResultSet rs=pstmt.executeQuery();
        while(rs.next())
            count=rs.getInt(1);
        pstmt.close();
        rs.close();
        String[][] data=new String[count+1][count+1];
        pstmt=con.prepareStatement("select *from ce1_"+username);
        rs=pstmt.executeQuery();
        int ct=0;
        while(rs.next())
                       {
            data[ct][0]=rs.getString(1);
            data[ct++][1]=rs.getString(2);
            
            
        }
        pstmt.close();
        rs.close();
        %>
        <table>
            <th>Name</th><th>Client Rating</th><th>Assigned CE2</th><th>Status</th>
        <%
        for(int i=0;i<ct;i++)
                       {
            out.println("<tr>");
            pstmt=con.prepareStatement("select name,clientrating,aasignedce_2,status from citypendingpropdb_"+data[i][1]+" where pid=\'"+data[i][0]+"\'");
            rs=pstmt.executeQuery();
            while(rs.next())
                               {
                out.println("<td>"+rs.getString(1)+"</td><td>"+rs.getInt(2)+"</td>");
                out.println("<td><a href=\"viewEmployee.jsp?id="+rs.getLong(3)+"\">"+rs.getLong(3)+"</a></td>");
                int status;
                status=rs.getInt(4);
                if(status==0)
                    out.println("<td>Pending</td>");
                else
                    if(status==1)
                        out.println("<td>Under CE2 Review</td>");
                else
                    if(status==2)
                        out.println("<td>Not Approved</td>");
                else
                    if(status==3)
                        out.println("<td>Approved</td>");
                
            }
            pstmt.close();
            rs.close();
        }
        con.close();
        %>
        </table>
        <%
        
        %>
    </body>
</html>
