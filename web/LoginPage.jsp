<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->

<%
try
  {
    String type=(String)session.getAttribute("usertype");
    String cityname=null,lat=null,lon=null;
    
    try
                       {
  cityname=(String)session.getAttribute("cityname");
  lat=(String)session.getAttribute("lat");
 lon=(String)session.getAttribute("lon");
        
    }
    catch(Exception e)
                       {
        
    }
    //out.println(type);
    
    if(Integer.parseInt(type)==1)
        response.sendRedirect("admin_home.jsp");
    else
        if(Integer.parseInt(type)==2)
            response.sendRedirect("ce1_home.jsp");
    else
        if(Integer.parseInt(type)==3)
            response.sendRedirect("ce2_home.jsp");
    else
        if(Integer.parseInt(type)==4)
                       {
            if(cityname.equals(null))
                response.sendRedirect("userhome.jsp");
            else
                response.sendRedirect("userhome.jsp?cityname="+cityname+"&lat="+lat+"&lon="+lon);
                       }
            
}
catch(Exception e)
               {
    
}
%>
<!DOCTYPE html>
<html>
    <head>
        <link href="style1.css" rel="stylesheet" type="text/css"/>
        <title>Squink Login Page</title>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            var cityname;
            function showPosition(position)
  {
 displayLocation(position.coords.latitude,position.coords.longitude);	
  }
            function displayLocation(latitude,longitude){
        var request = new XMLHttpRequest();

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
        document.getElementById("message").textContent=cityname;
        window.location="userhome.jsp?cityname="+cityname+"&lat="+latitude+"&lon="+longitude;
          }
        };
        request.send();
      };
            function validate()
            {
                var username=document.getElementById("username").value;
                var pass=document.getElementById("pass").value;
               
               if(username.length==0||pass.length==0)
                    document.getElementById("message").textContent="Username/Password cannot be empty";
                else
                    {
                      
                    
                    validate1(username,pass);
                    
                    }
            }
            function validate1(username,pass)
            {
           
                var x=$.ajax({
                    type:"POST",
                    url:"uservalidate",
                    data:{user:username,pass:pass},
                    async:false,
                    dataType:"html"
                }).responseText;
               alert(x);
                x=parseInt(x);
                if(x==2)
                    document.getElementById("message").textContent="Account Locked";
                else
                    if(x==3)
                        document.getElementById("message").textContent="Invalid Username/Password";
                else
                    if(x==1)
                        window.location="LoginPage.jsp";
                else
                    if(x==4)
                        {
                            document.getElementById("message").textContent="Please wait while we track your current location";
                             if (navigator.geolocation)
                             {
                                 navigator.geolocation.watchPosition(showPosition);
                               }
                               
                        }
                
            }
        </script>
        <style type="text/css">
            table, td, th
{
border:none;
padding:5px 10px;
font-family: font1;
color:white;
}
#holocast
{
    margin-left: 500px;
    margin-top: 140px;
    background-color: teal;
    height: 300px;
    width:400px;
    border-radius: 5px;
}
a
{
    color:black;
}

        </style>
    </head>
    <body>
        <div id="holocast">
            <br/>
            <br/>
            <br/><br/>
            <table border="1" align="center">
            <tr>
                <td>Username</td>
                <td><input type="text" id="username"/></td>
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password" id="pass"/></td>
            </tr>
            <tr style="border:none;">
                <td style="border:none;"><input type="button" value="Login" onclick="validate()"/>
                <td style="border:none;"><a href="userRegistration.jsp">User Registration</a></td>
            </tr>
        </table>
        <p id="message"></p>
        </div>
    </body>
</html>
