

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try
               {
String usertype=(String)session.getAttribute("usertype");

if(Integer.parseInt(usertype)==4)
       {
    String pid=request.getParameter("pid");
    String citycode=request.getParameter("citycode");
String catid=request.getParameter("catid");
int cat=0;
if(catid!=null)
       {
cat=Integer.parseInt(catid);
}

%>
<!DOCTYPE html>
<html>
<head>
<style>
table,th,td
{
border:1px solid black;
border-collapse:collapse;
padding:10px 30px;

}
</style>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
var likef;
function testa(a)
{
	likef=a;
}
function senddata()
{
    var ambi=document.getElementById("ambi1").value;
    var cost=document.getElementById("cost1").value;
    var serv=document.getElementById("serv").value;
    var qual=document.getElementById("qual").value;
    var exotic=0,indi=0;
<%
if(cat==103||cat==104||cat==108||cat==109||cat==110||cat==111)
       {
    %>
               exotic=document.getElementById("exo").value;
               indi=document.getElementById("ind").value;
               
    
<%
}
%>
    var pid="<%=pid%>";
var citycode="<%=citycode%>";
var cat="<%=cat%>";
alert(pid+" "+citycode+" "+ambi+" "+cost);
$.ajax({
    type:"POST",
    url:"rateProperty",
    dataType:"html",
    async:false,
    data:{pid:pid,citycode:citycode,ambi:ambi,cost:cost,serv:serv,qua:qual,exot:exotic,indi:indi,likef:likef,cat:cat},
    success: function cool(data)
    {
        alert(data);
    }
    
    
});
        
}
</script>
</head>
<body>
<table >

<tr>
<td>Ambience</td>
<td><input id="ambi1" type="range" min="1" max="10" step="1" default="5" onChange="var str;if(value>=0 && value<4) str='Poor';else if(value>=4 && value<=6) str='Good';else if(value>=7 && value<=8) str='Very Good';else if(value>8) str='Excellent';document.getElementById('ambi').innerHTML=str+'('+value+')';"/>
</td>
<td id="ambi"> </td>
</tr>
<tr>
<td>Cost</td>
<td><input id="cost1" type="range" min="1" max="10" step="1" onChange="var str;if(value>=0 && value<4) str='Low';else if(value>=4 && value<=6) str='Moderate';else if(value>=7 && value<=8) str='Expensive';else if(value>8) str='Very Expensive';document.getElementById('cost').innerHTML=str+'('+value+')';" /></td>
<td id="cost"> </td>
</tr><tr>
<td>Service</td>
<td><input id="serv" type="range" min="1" max="10" step="1" onChange="var str;if(value>=0 && value<4) str='Poor';else if(value>=4 && value<=6) str='Good';else if(value>=7 && value<=8) str='Very Good';else if(value>8) str='Excellent';document.getElementById('service').innerHTML=str+'('+value+')';"/></td>
<td id="service"> </td>
</tr><tr>
<td>Quality</td>
<td><input id="qual" type="range" min="1" max="10" step="1" onChange="var str;if(value>=0 && value<4) str='Poor';else if(value>=4 && value<=6) str='Good';else if(value>=7 && value<=8) str='Very Good';else if(value>8) str='Excellent';document.getElementById('quality').innerHTML=str+'('+value+')';"/></td>
<td id="quality"> </td>
</tr>
<%
if(cat==103||cat==104||cat==108||cat==109||cat==110||cat==111)
{
     out.println("<tr><td>Exotic factor</td><td><input id=\"exo\" type=\"range\" min=\"1\" max=\"10\" step=\"1\" onChange=\"var str;if(value>=0 && value<4) str='Poor';else if(value>=4 && value<=6) str='Good';else if(value>=7 && value<=8) str='Very Good';else if(value>8) str='Excellent';document.getElementById('exotic').innerHTML=str+'('+value+')';\"/></td><td id=\"exotic\"> </td></tr>");
     out.println("<tr><td>IndiFactor</td><td><input id=\"ind\" type=\"range\" min=\"1\" max=\"10\" step=\"1\" onChange=\"var str;if(value>=0 && value<4) str='Poor';else if(value>=4 && value<=6) str='Good';else if(value>=7 && value<=8) str='Very Good';else if(value>8) str='Excellent';document.getElementById('indi').innerHTML=str+'('+value+')';\"/></td><td id=\"indi\"> </td></tr>");
}

%>


</table>
<img src="image008.png" usemap="#imagelike"/>
<map name="imagelike">
<area shape="rect" coords="0,0,136,109" href="javascript:testa(1)"/>
<area shape="rect" coords="136,0,286,114" href="javascript:testa(0)"/>
<area shape="rect" coords="286,0,396,111" href="javascript:testa(2)"/>
</map>


</br><input type="button" value="Give Rating" onclick="senddata()" />
<%
}
else
       {
    out.println("Please log in to rate this property");
}
}
catch(Exception e)
               {
    out.println("Please log in to rate this property");
    
}

%>
</body>
</html>