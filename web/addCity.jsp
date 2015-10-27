<%-- 
    Document   : addCity
    Created on : Feb 19, 2014, 3:54:44 PM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try
  {
    String type=(String)session.getAttribute("usertype");
    if(Integer.parseInt(type)!=1)
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
     <link href="style1.css" rel="stylesheet" type="text/css"/>
<title>AddCity</title>
<script type="text/javascript" src="jquery.js"></script>
</head>
<body>
<script type="text/javascript" language="javascript">
var ctrv=false,cityv=false;
function validate()
{
cityv=false;ctrv=false;
var fg=new RegExp(/^[A-Za-z]{5,50}$/);
var cityname=document.getElementById("city").value;
if(fg.test(cityname))
cityv=true;
else
cityv=false;
var fg1=document.getElementById("ctry");
var fg2=fg1.options[fg1.selectedIndex].value;
if(fg2=="")
ctrv=false;
else
ctrv=true;
var cityfact=document.getElementById("cityfact").value;

if(ctrv&&cityv)
    {
        $.ajax({
            type:"POST",
            url:"addCity",
            dataType:"html",
            async:false,
            data:{ctry:fg2,cityname:cityname,cityfact:cityfact},
            success: function disk(data)
            {
                alert(data);
                document.getElementById("msg").innerHTML=data;
              
            }
            
            
        });
    }
}
</script>
<table border='1'>
<tr>
<td>Country</td>
<td><select id=ctry>
<option value=" "></option>
  <option value="India">India</option>
  <option value="China">China</option>
  <option value="Indonesia">Indonesia</option>
  <option value="Singapore">Singapore</option>
</select></td>
</tr>
<tr>
<td>City</td>
<td><input type="Text" name="City" id="city"/></td>
</tr>
<tr>
    <td>
        City Factor
    </td>
    <td>
        <input type="text" name="cityfact" id="cityfact"/>
    </td>
</tr>
</table>
<button type="button" onclick="validate()">Add </button>
<a href="admin_home.jsp">Go Back</a>
<p id="msg"></p>
</body>
</html>