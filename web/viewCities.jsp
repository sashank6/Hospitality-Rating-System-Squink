<%-- 
    Document   : viewCities
    Created on : Feb 22, 2014, 3:17:30 PM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="style1.css" rel="stylesheet" type="text/css"/>
        <style type="text/css">
            #tfg
            {
                position:absolute;
                top:0px;
                left:500px;
                width:700px;
                
            }
        </style>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function getData(data)
            {
                data=data.toLowerCase();
                data=data.charAt(0).toUpperCase() + data.slice(1);
                var url = "http://en.wikipedia.org/wiki/"+data;
var title = url.split("/");
title = title[title.length - 1];


$.getJSON("http://en.wikipedia.org/w/api.php?action=parse&page=" + title + "&prop=text&section=0&format=json&callback=?", function (data) {
    for (text in data.parse.text) {
        var text = data.parse.text[text].split("<p>");
        var pText = "";

        for (p in text) {
         
            text[p] = text[p].split("<!--");
            if (text[p].length > 1) {
                text[p][0] = text[p][0].split(/\r\n|\r|\n/);
                text[p][0] = text[p][0][0];
                text[p][0] += "</p> ";
            }
            text[p] = text[p][0];

           
            if (text[p].indexOf("</p>") == text[p].length - 5) {
                var htmlStrip = text[p].replace(/<(?:.|\n)*?>/gm, '') 
                var splitNewline = htmlStrip.split(/\r\n|\r|\n/); 
                for (newline in splitNewline) {
                    if (splitNewline[newline].substring(0, 11) != "Cite error:") {
                        pText += splitNewline[newline];
                        pText += "\n";
                    }
                }
            }
        }
        pText = pText.substring(0, pText.length - 2); 
        pText = pText.replace(/\[\d+\]/g, ""); 
        document.getElementById("tfg").innerHTML = pText
    }
});
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <table border="1">
            <th>City name</th><th>Country</th><th>Action</th>
        <%
        Connect obj=new Connect();
        Connection con=obj.conect();
        PreparedStatement pstmt=con.prepareStatement("select cityname,country,citycode from servicedCityDB");
        ResultSet  rs=pstmt.executeQuery();
        while(rs.next())
         {
            out.println("<tr>");
            out.println("<td onclick=getData(\'"+rs.getString(1)+"\')>"+rs.getString(1)+"</td>");
            out.println("<td>"+rs.getString(2)+"</td>");
            out.println("<td><a href=\"addRegion.jsp?citycode="+rs.getString(3)+"\">Add Region</a>/<a href=\"viewRegion.jsp?citycode="+rs.getString(3)+"\">View Regions</a></td>");
            out.println("</tr>");
            
        }
        
        
        %>
        </table>
        <p id="tfg">
            
        </p>
    </body>
</html>
