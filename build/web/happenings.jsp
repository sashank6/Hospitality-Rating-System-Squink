<%-- 
    Document   : happenings
    Created on : Mar 19, 2014, 7:37:00 AM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="style1.css" type="text/css" rel="stylesheet"></link>
        <title>Happenings</title>
    </head>
    <body>
       <div id="topbar">
    <span id="text">You are at <span id="cityname"><%=(String)session.getAttribute("cityname")%>, <%=(String)session.getAttribute("ctry")%> </span></span>
</div>
<div id="menubar">
    <div id="menu1"><div style="padding-left:20px;"><a href="squinkhome1.jsp">Squink</a></div></div>
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Search Places</div>
</div>
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Check Offers</div>
</div>
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Planning a Trip</div>
</div>
<div id="menu11" style="background-color:white; color:black;">
<div align="center" style="margin-top:2.5px;">Happenings</div>
</div>
<div id="menu11" >
<div align="center" style="margin-top:2.5px;" >Why Squink?</div>
</div>
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Contact Us</div>
</div>

 </body>
</html>
