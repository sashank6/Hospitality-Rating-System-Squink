<%-- 
    Document   : userhome
    Created on : Feb 28, 2014, 9:54:44 AM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String lat=null,lon=null,cityname=null;
try
               {
lat=request.getParameter("lat");
if(lat!=null)
session.setAttribute("lat", lat);
lon=request.getParameter("lon");
if(lon!=null)
session.setAttribute("lon", lon);
cityname=request.getParameter("cityname");
if(cityname!=null)
session.setAttribute("cityname", cityname);
}
catch(Exception e)
               {
 
   lat=(String)session.getAttribute("lat");

    lon=(String)session.getAttribute("lon");

    cityname=(String)session.getAttribute("cityname");
    
}
if(lat==null)
  lat=(String)session.getAttribute("lat");   
if(lon==null)
   lon=(String)session.getAttribute("lon");
if(cityname==null)
    cityname=(String)session.getAttribute("cityname");

%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <style type="text/css">
            #search
            {
                text-align: center;
               padding-top:35px;
               padding-bottom: 35px;
                position:absolute;
                width:150px;
                font-family: arial;
              
                background-color: crimson;
                color:white;
                left:500px;
                top:200px;
            }
            a
            {
                text-decoration: none;
                color:white;
            }
        </style>
    </head>
    <body>
        <%
        out.println("Welcome User, your current location is "+(String)session.getAttribute("cityname"));
        
        %>
        <span id="search"><a href="searchpropform.jsp">Search</a></span>
    </body>
</html>
