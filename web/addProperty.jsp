<%-- 
    Document   : addProperty
    Created on : Feb 19, 2014, 11:36:48 AM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link href="style1.css" rel="stylesheet" type="text/css"/>
        <title>Add Property</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function datasrc()
            {
                var name=document.getElementById("name").value;
               
                var temp1=document.getElementById("city");
                var city=temp1.options[temp1.selectedIndex].value;
                var desc=document.getElementById("desc").value;
                var crating=document.getElementById("crating").value;
                var addr=document.getElementById("addr").value;
                var temp2=document.getElementById("rcode");
                var rcode=temp2.options[temp2.selectedIndex].value;
                $.ajax({
                    type:"POST",
                    url:"addPendingProp",
                    dataType:"html",
                    async:false,
                    data:{name:name,citycode:city,desc:desc,rating:crating,address:addr,rcode:rcode,type:1}
                    ,
                    success: function cool(data)
                    {
                        alert(data);
                    }
                    
                });
                
                
            }
            function getRegionData()
            {
                var temp=document.getElementById("city");
                var citycode=temp.options[temp.selectedIndex].value;
                $.ajax({
                    type:"POST",
                    url:"getRegionCode",
                    dataType:"html",
                    async:true,
                    data:{citycode:citycode},
                    success:function cool(data)
                    {
                        document.getElementById("rcode").innerHTML=data;
                    }
                    
                    
                    
                });
            }
            function getData()
            {
                var ctry=document.getElementById("ctry");
                var ctdata=ctry.options[ctry.selectedIndex].value;
              
               var t= $.ajax({
                    type:"POST",
                    url:"getCityData",
                    dataType:"html",
                    data:{ctry:ctdata},
                    async:false,
                    success: function cool(data)
                    {
                        
                document.getElementById("city").innerHTML=data;
                    }
                    
                    
                    
                });
                
                
            }
        </script>
    </head>
    <body>
        <table border="1" id="clcl">
            <tr>
                <td>Name</td>
                <td><input type="text" id="name"/></td>
            </tr>
            <tr>
                <td>Country</td>
                <td>
                    <select id="ctry" onchange="getData()">
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
                    rs.close();
                    pstmt.close();
                    %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>City</td>
                <td><select id="city" onchange="getRegionData()">
                        
                    </select>
                </td>
            </tr>
            <tr>
                <td>Region</td>
                <td><select id="rcode">
                        
                    </select>
                </td>
            </tr>
            <tr>
                <td>Description</td>
                <td><textarea id="desc" cols="50" rows="10"></textarea>
            </tr>
            <tr>
                <td>Client Rating</td>
                <td><input type="text" id="crating"/></td>
            </tr>
            <tr>
                <td>Address</td>
                <td><textarea id="addr" cols="30" rows="5"></textarea></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="button" value="Submit" onclick="datasrc()"/></td>
            </tr>
            
        </table>
        
    </body>
</html>
