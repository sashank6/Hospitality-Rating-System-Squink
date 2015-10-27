<%-- 
    Document   : searchpropform
    Created on : Mar 1, 2014, 5:16:44 PM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style1.css" rel="stylesheet" type="text/css"/>
        <style type="text/css">
           #leftfloat
           {
               width:176px;
               float:left;
           }
           #rightfloat
           {
               float:left;
               position: absolute;
               width:1000px;
               border: 1px solid black;
               left:196px;
           }
           td
           {
               border:none;
           }
           #redf 
           {
               width:1000px;
           }
           #small
           {
               font-size:6px;
           }
           #big
           {
               font-size:26px;
           }
           #ascore
           {
               padding-top: 0px;
           }
        </style>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function getcat1()
            {
                 var caty=document.getElementById("cat");
                var catid=caty.options[caty.selectedIndex].value;
                if(catid==103||catid==104||catid==108||catid==109||catid==110||catid==111)
                    {
                    document.getElementById("klo").innerHTML= "<td align=\"center\"><b>Exotic</b></td>";
                    document.getElementById("klo1").innerHTML="<td><input type=\"range\" min=\"1\" max=\"10\" step=\"1\"  value=\"6\" id=\"exoticr\" onchange=\"document.getElementById('exotic').innerHTML=value\"/>&nbsp;&nbsp;&nbsp;<span id=\"exotic\">6</span></td>";
                     document.getElementById("klo2").innerHTML= "<td align=\"center\"><b>Indigenous Factor</b></td>";
                    document.getElementById("klo3").innerHTML="<td><input type=\"range\" min=\"1\" max=\"10\" step=\"1\"  value=\"6\" id=\"indir\" onchange=\"document.getElementById('exotic').innerHTML=value\"/>&nbsp;&nbsp;&nbsp;<span id=\"indi\">6</span></td>";
                   
                    }   
                    else
                        {
                             document.getElementById("klo").innerHTML= "";
                    document.getElementById("klo1").innerHTML="";
                     document.getElementById("klo2").innerHTML= "";
                    document.getElementById("klo3").innerHTML="";
                   
                        }
                    
       }
            function killer()
            {
                var ambi=document.getElementById("ambir").value;
                var serv=document.getElementById("servr").value;
                var cost=document.getElementById("costr").value;
                var qual=document.getElementById("quar").value;
                var caty=document.getElementById("cat");
                var catid=caty.options[caty.selectedIndex].value;
                var exotic=null,indi=null;
                 if(catid==103||catid==104||catid==108||catid==109||catid==110||catid==111)
                    {
                    exotic=document.getElementById("exoticr").value;
                    indi=document.getElementById("indir").value;
                    }
               
               
                $.ajax({
                    type:"POST",
                    dataType:"html",
                    async:false,
                    url:"processPropert",
                    data:{ambi:ambi,service:serv,cost:cost,quality:qual,catid:catid,exotic:exotic,indi:indi},
                    success: function golop(data)
                    {
                        alert(data);
                        document.getElementById("rightfloat").innerHTML=data;
                    }
                    
                    
                });
            }
            </script>
    <body>
        <div id="leftfloat">
        <table>
            <tr>
                <td align="center"><b>Ambience</b></td>
            </tr>
            <tr>
                <td><input type="range" min="1" max="10" step="1" value="6" id="ambir" onchange="document.getElementById('ambi').innerHTML=value"/>&nbsp;&nbsp;&nbsp;<span id="ambi">6</span></td>
            </tr>
            <tr>
                <td align="center"><b>Service</b></td>
            </tr>
            <tr>
                 <td><input type="range" min="1" max="10" step="1" value="6" id="servr" onchange="document.getElementById('service').innerHTML=value"/>&nbsp;&nbsp;&nbsp;<span id="service">6</span></td>
            </tr>
            <tr>
                <td align="center"><b>Cost</b></td>
            </tr>
            <tr>
                  <td><input type="range" min="1" max="10" step="1"  value="6" id="costr" onchange="document.getElementById('cost').innerHTML=value"/>&nbsp;&nbsp;&nbsp;<span id="cost">6</span></td>
            </tr>
               <tr>
                <td align="center"><b>Quality</b></td>
            </tr>
            <tr>
            
                <td><input type="range" min="1" max="10" step="1" value="6" id="quar" onchange="document.getElementById('quality').innerHTML=value"/>&nbsp;&nbsp;&nbsp;<span id="quality" >6</span></td>
                
                   
            </tr>
            <tr>
                <td align="center">
            <select id="cat" onchange="getcat1()">
                <%
                Connect obj=new Connect();
                Connection con=obj.conect();
                PreparedStatement pstmt=con.prepareStatement("select *from categorytable");
                ResultSet rs=pstmt.executeQuery();
                while(rs.next())
                {
                    out.println("<option value=\""+rs.getInt(1)+"\">"+rs.getString(2)+"</option>");
                    
                }
                %>
            </select></td>
            </tr>
            <tr id="klo">
                
            </tr>
            <tr id="klo1">
                
            </tr>
             <tr id="klo2">
                
            </tr>
             <tr id="klo3">
                
            </tr>
            <tr>
                <td align="center"> <input type="button" value="Search" onclick="killer()"/></td>
            </tr>
            
        </table>
           
        </div>
        <div id="rightfloat">
            
        </div>
</html>
