<%-- 
    Document   : confirm
    Created on : Feb 26, 2014, 11:53:13 AM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String code=request.getParameter("cnfcode");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <%
        Connect obj=new Connect();
        Connection con=obj.conect();
        con.setAutoCommit(false);
        PreparedStatement pstmt=con.prepareStatement("select count(*) from confirmation where cnf=?");
        pstmt.setString(1, code);
        ResultSet rs=pstmt.executeQuery();
        int df=-1;
        while(rs.next())
                       {
            df=rs.getInt(1);
        }
        pstmt.close();
        if(df==0)
                       {
            out.println("Invalid Confimation Code");
        }
        else
            if(df==1)
            {
                try
                                               {
                pstmt=con.prepareStatement("select id from confirmation where cnf=?");
                pstmt.setString(1,code);
                String username=null;
                rs=pstmt.executeQuery();
                while(rs.next())
                                       {
                    username=rs.getString(1);
                }
                pstmt.close();
                rs.close();
                pstmt=con.prepareStatement("update loginDB set status=1 where username=?");
                pstmt.setString(1, username);
                pstmt.executeUpdate();
                pstmt.close();
                pstmt=con.prepareStatement("delete from confirmation where CNF=?");
                pstmt.setString(1, code);
                pstmt.executeUpdate();
                con.commit();
                out.println("Your Account has been confirmed successfully");
                               }
                catch(Exception e)
                                               {
                    con.rollback();
                    out.println("There was an error please check");
                }
            }
        
        %>
    </body>
</html>
