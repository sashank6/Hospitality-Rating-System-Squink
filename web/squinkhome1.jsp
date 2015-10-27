<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

    <link rel="stylesheet" href="style1.css" type="text/css"></link>
    <style type="text/css">
        a
{
    text-decoration: none;
    color:white;
}
#menu11:hover
{
    background-color: white;
    color:black;
}
#menu11 a:hover
{
    color:black;
}

    </style>
    <script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
   var cityname,country;
            var lat,lon;
            function showPosition(position)
  {
 displayLocation(position.coords.latitude,position.coords.longitude);	
  }
            function displayLocation(latitude,longitude){
        var request = new XMLHttpRequest();
        lat=latitude;
        lon=longitude;
        var method = 'GET';
        var url = 'http://maps.googleapis.com/maps/api/geocode/json?latlng='+latitude+','+longitude+'&sensor=true';
        var async = false;
           
        request.open(method, url, async);
        request.onreadystatechange = function(){
          if(request.readyState == 4 && request.status == 200){
            var data = eval('('+request.responseText+')');
	var i=0;
	for(;;i++)
	{
            var address = data.results[0].address_components[i];
	if(address.types[0]=="locality")
		break;
	}
                    
	cityname=data.results[0].address_components[i].long_name;
        i=0;
        for(;;i++)
	{
            var address = data.results[0].address_components[i];
	if(address.types[0]=="country")
		break;
	}
         country=data.results[0].address_components[i].long_name;
        document.getElementById("cityname").innerHTML=cityname+", "+country;
       setfda();
          }
        };
        request.send();
      };

var count=0;
var path="bkimages/";
function change()
{
	var temp=path+count+".jpg";
	count++;
	count=count%4;
	document.getElementById("test1").src=temp;

}
var x;
function searchbyname()
{
    var name=document.getElementById("str-name").value;
    window.location="displayresults.jsp?q="+name+"&cityname="+cityname+"&lat="+lat+"&lon="+lon;
    
}
function setfda()
{
    
    $.ajax({
        type:"POST",
        url:"setLocation",
        async:true,
        dataType:"html",
        data:{cityname:cityname,lat:lat,lon:lon,ctry:country}
     
        
        
    });
    
}
window.onload=function()
{
	x=setInterval(function(){change();},3000);
                     if (navigator.geolocation)
                             {
                                 navigator.geolocation.watchPosition(showPosition);
                               }
                  
}
</script>

</head>

<body>
<div>
<div id="topbar">
    <span id="text">You are at &nbsp;<span id="cityname"></span></span><div style="font-family:font1;margin-left: 1220px; margin-top: -20px;"><a href="LoginPage.jsp">Sign In</a></div>
</div>
<div id="menubar">
<div id="menu1"><div style="padding-left:20px;">Squink</div></div>
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Search Places</div>
</div>
<div id="menu11">
    <div align="center" style="margin-top:2.5px;"><a href="offers.jsp">Check Offers</a></div>
</div>
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Planning a Trip</div>
</div>
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Happenings</div>
</div>
<div id="menu11">
    <div align="center" style="margin-top:2.5px; "><a href="whysquink.jsp">Why Squink?</a></div>
</div>
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Contact Us</div>
</div>

</div>
</div>
<div id="maincontent">

<img src="img/1920/1.jpg" style="height:100%; width:100%" id="test1"/>

</div>
<div id="searchbar">
<div style="opacity:1; font-family:font1; font-weight:900; margin-left:30px; margin-top:5px">
Search by Name<br/>
<input type="text" id="str-name" size="50" placeholder="Search by Name" height="20" style="font-family:font1; font-weight:900"/>
<div id="go1" onclick="searchbyname()">&nbsp;Go</div>
</div>

</div>
</body>
</html>
