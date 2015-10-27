<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%
Connect obj=new Connect();
Connection con=obj.conect();
String pid=request.getParameter("pid");
String citycode=request.getParameter("citycode");
PreparedStatement pstmt=con.prepareStatement("select name,descp,imagelen,category, ovambi,ovservice,ovcost,ovq,ovexotic,ovindi,address,priceLower,priceUpper,ascore,(likes+dislikes+neutrals) as tc,ascorefact from cityapprovedproperty_"+citycode+" ");
ResultSet rs=pstmt.executeQuery();
String name=null,desc=null,address=null;
int imglen=0,cat=0,ova=0,ovc=0,ovs=0,ovq=0,ove=0,ovi=0,pl=0,pu=0,ascore=0;
long tc=0,ascorefact=0;
while(rs.next())
{
    name=rs.getString(1);
    desc=rs.getString(2);
    imglen=rs.getInt(3);
    cat=rs.getInt(4);
    ova=rs.getInt(5);
    ovs=rs.getInt(6);
    ovc=rs.getInt(7);
    ovq=rs.getInt(8);
    ove=rs.getInt(9);
    ovi=rs.getInt(10);
    address=rs.getString(11);
    pl=rs.getInt(12);
    pu=rs.getInt(13);
    ascore=rs.getInt(14);
    tc=rs.getLong(15);
    ascorefact=rs.getLong(16);    
}

String cityname=null;
pstmt=con.prepareStatement("select cityname from servicedcitydb where citycode=?");
pstmt.setString(1, citycode);
rs=pstmt.executeQuery();
while(rs.next())
    cityname=rs.getString(1);
String categoryname=null;
pstmt=con.prepareStatement("select catname from categorytable where catid=?");
pstmt.setInt(1, cat);
rs=pstmt.executeQuery();
while(rs.next())
    categoryname=rs.getString(1);



%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
#title
{
	font-size: 36px;
	font-family: Arial, Helvetica, sans-serif;
	font-weight:900;
}
#july
{
	border: 1px solid black;
	width:800px;
	
}
#table1
{
	border-collapse:collapse;
	
	width:800px;
}
body
{
	font-family:Arial, Helvetica, sans-serif;
}
#cool
{
	font-size:156px;
}
#kill
{
	font-size:18px;
}
#huyt
{
	color:white;
	background-color:red;
	border-radius:7px;
	
}
#ghy
{
	border-collapse:collapse;
	
}
#ghy td
{
	
	padding:10px;
}

	
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" >
    window.onload=function()
    {
    
    var img="<%=imglen%>";
    var citycode="<%=citycode%>";
    var pid="<%=pid%>";
    document.getElementById("topimage").src="propertyimages/"+citycode+"_"+pid+"_1.jpg";
    var i,j;
    var temp="img";
    img=parseInt(img);
   
    for(i=1;i<=img;i++)
        {
            var temp1=temp+i;
            var temp2="propertyimages/"+citycode+"_"+pid+"_"+i+".jpg";;
            var xd=document.createElement('img');
            var xd1=document.createAttribute('src');
              xd1.nodeValue=temp2;
            xd.setAttributeNode(xd1);
            xd1=document.createAttribute('id');
            xd1.nodeValue=temp+"tf"+i;
             xd.setAttributeNode(xd1);
            xd1=document.createAttribute('width');
            xd1.nodeValue="42.5px";
            xd.setAttributeNode(xd1);
            xd1=document.createAttribute('height');
            xd1.nodeValue="50px";
            xd.setAttributeNode(xd1);
            
            var sd=document.getElementById(temp1);
            sd.appendChild(xd);
                 
            
        }
         var ascore="<%=ascore%>";
         
            ascore=parseInt(ascore);
           
            var ascorefact="<%=ascorefact%>";
           
            ascorefact=parseInt(ascorefact);
             
            var tc="<%=tc%>";
            tc=parseInt(tc);
            
            if(tc<ascorefact)
                ascore="&nbsp;&nbsp;NA&nbsp;&nbsp;";
            document.getElementById("cool").innerHTML=ascore;
            var catid=parseInt("<%=cat%>");
            if(catid==103||catid==104||catid==108||catid==109||catid==110||catid==111)
                {
                    document.getElementById("ambi").innerHTML="<%=ova%>";
                    var cst=parseInt("<%=ovc%>"); var printme;
                    if(cst>=0 && cst<=3)
                        printme="Low Cost";
                    else
                        if(cst >3 && cst<6)
                            printme="Moderate";
                        else
                            if(cst >=6 && cst <8)
                                 printme="Expensive";
                             else
                                 if(cst >=8 &&cst<=10)
                                     printme="Higly Expensive";
                                
                    document.getElementById("cost").innerHTML=printme;
                    document.getElementById("quality").innerHTML="<%=ovq%>";
                    document.getElementById("service").innerHTML="<%=ovs%>";
                    document.getElementById("exotic").innerHTML="<%=ove%>";
                    document.getElementById("indi").innerHTML="<%=ovi%>";
                }
                else
                    {
                         document.getElementById("ambi").innerHTML="<%=ova%>";
                         
                     var cst=parseInt("<%=ovc%>"); var printme;
                    if(cst>=0 && cst<=3)
                        printme="Low Cost";
                    else
                        if(cst >3 && cst<6)
                            printme="Moderate";
                        else
                            if(cst >=6 && cst <8)
                                 printme="Expensive";
                             else
                                 if(cst >=8 &&cst<=10)
                                     printme="Higly Expensive";
                                
                    document.getElementById("cost").innerHTML=printme;
                    document.getElementById("quality").innerHTML="<%=ovq%>";
                    document.getElementById("service").innerHTML="<%=ovs%>";
                    document.getElementById("exotic").innerHTML="NA";
                    document.getElementById("indi").innerHTML="NA";
                    }
    
    
    }
</script>
</head>
<body id="body">
<span id="title"><%=name%>, <%=cityname%></span>
<br/><br/>
<div id="july">
<table id="table1">
<tr>
<td><img src="C1039_P10001_3.jpg" height=300px" width="400px" id="topimage"/></td>
<td style="padding-top: 0px;">
<table id="huyt">
<tr>
<td align="Center"><span id="kill">aScore</span></td>
</tr>
<tr>
<td><span id="cool"></span></a>
</tr>
<tr>
</table>
<table id="ghy">
<tr>
<td><b>Ambience:</b></td><td align="Center"><b id="ambi">8</b></td><td><b>Service:</b></td><td align="center"><b id="service">8</b></td><td><b>Exotic:</b></td><td align="center"><b id="exotic">8</b></td>
</tr>
<tr>
<td><b>Cost:</b></td><td align="center"><b id="cost">8</b></td><td><b>Quality:</b></td><td align="center"><b id="quality">8</b></td>
<td><b>Indi Factor:</b></td><td align="center"><b id="indi">8</b></td>
</tr>
</table>
</td>
</tr>
</table>
<table style="border-collapse: collapse">
<tr>
    <td id="img1" onclick="document.getElementById('topimage').src=document.getElementById('imgtf1').src"></td>
<td id="img2" onclick="document.getElementById('topimage').src=document.getElementById('imgtf2').src"></td>
<td id="img3" onclick="document.getElementById('topimage').src=document.getElementById('imgtf3').src"></td>
<td id="img4" onclick="document.getElementById('topimage').src=document.getElementById('imgtf4').src"></td>
<td id="img5" onclick="document.getElementById('topimage').src=document.getElementById('imgtf5').src"></td>
<td id="img6" onclick="document.getElementById('topimage').src=document.getElementById('imgtf6').src"></td>
<td id="img7" onclick="document.getElementById('topimage').src=document.getElementById('imgtf7').src"></td>
<td id="img8" onclick="document.getElementById('topimage').src=document.getElementById('imgtf8').src"></td>
<td id="img9" onclick="document.getElementById('topimage').src=document.getElementById('imgtf9').src"></td>

</tr>
</table>
<br/><br/><br/>
<table style="width:800px;">
<tr>
<td style="font-size: 30px;"><b id="cat"><%=categoryname%></b><b> Description</b></td>
</tr>
<tr>
<td id="description"><br/><%=desc%><br/><br/><br/>

</td>
</tr>
<tr>
<td style="font-size: 30px;"><b id="cat"><%=categoryname%></b><b> Address</b></td>
</tr>
<tr>
<td id="address"><br/><%=address%><br/><br/><br/>

</td>
</tr>
<tr>
<td style="font-size: 30px;"><b>Cost Factor</b></td>
</tr>
<tr>
    <td><br/>Meal for two costs you around <span id="pricerange"><%=pl%>-<%=pu%>.</span><br/><br/><br/></td></tr>

</table>
<table style="width: 800px;" cellspacing="0">
<tr>
<td align="center" style="height: 100px; background-color: crimson; color: white; font-weight: 900; border-radius: 7px; width:520px;"><a href="user_rate.jsp?pid=<%=pid%>&citycode=<%=citycode%>&catid=<%=cat%>"/> Rate Property</td><td align="center" style="height: 100px; background-color: pink; color: white; font-weight: 900; border-radius: 7px; width: 520px;"> File Complaint</td></tr></table>
</div>
</body>
</html>
