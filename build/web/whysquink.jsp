<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">




<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<style type="text/css">
@font-face
{
	font-family:font1;
	src:url(Varela-Regular.ttf);
}
body
{
	margin:auto auto;
	width:1366px;
	height:613.5px;
}
#topbar
{
	
	height:40px;
	width:100%;
	background-color:black;
	color:white;
}
#text
{
	
	font-family:font1;
	font-size:25px;
	margin-left:480px;
	
	
}

#menu1
{
	background-color:teal;
	color:white;
	height:70px;
	width:15%;
	font-family:font1;
	font-size:45px;
	font-weight:900;
	float:left;
	margin-top:-40px;
	-webkit-box-shadow: 0px 0px 5px 1px #004040;
	z-index:1;
	
	
	
	
}
#menu2
{
	background-color:yellow;
	color:crimson;
	height:100px;
	width:33.25%;
	font-family:font1;
	font-size:45px;
	float:left;
	
	
	
}
@font-face
{
	font-family:font2;
	src:url(DURALITH.ttf);
}
#menu11
{
	background-color:#CC7699;
	color:white;
	height:30px;
	font-family:font1;
	width:14.165%;
	float:left;
	z-index:0;
}
#maincontent
{
	margin-top:30px;
	margin-left:0px;
	height:100%;
	width:100%;
	background: url(img2.jpg) no-repeat center center;
	font-family:font1;
	font-weight:900;
	opacity:0.8;
	background-size: cover;
	
	
}
#searchbar
{
	position:absolute;
	margin-left:660px;
	margin-top:-500px;
	-webkit-box-shadow:  0px 0px 4px 2px teal;
	height:100px;
	width:450px;
	background-color:white;
	opacity:0.6;
	border-radius:5px;
}
a
{
    text-decoration: none;
    color:white;
}

</style>


</head>

<body>
<div>
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
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Happenings</div>
</div>
<div id="menu11" style="background-color:white; color: black;">
<div align="center" style="margin-top:2.5px;" >Why Squink?</div>
</div>
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Contact Us</div>
</div>

</div>
</div>
<div id="maincontent">
<br/><br/>
<div style="color:black; opacity:1"><br/><br/>
<h1 style="margin-left:40px;">Why Squink?</h1>
<br/>
<h3 style="margin-left:40px; text-align:justify; margin-right:90px;"> Because we want you to explore 'The Best' places around you.</h3>
</div>

</div>

</body>
</html>
