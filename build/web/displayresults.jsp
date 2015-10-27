<%-- 
    Document   : displayresults
    Created on : Mar 16, 2014, 6:06:03 PM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String query=request.getParameter("q");
String cityname=request.getParameter("cityname");
String lat=request.getParameter("lat");
String lon=request.getParameter("lon");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <link rel="stylesheet" href="style1.css" type="text/css"></link>
      <style type="text/css">
          td
          {
              border:none;
          }
      </style>
    </head>
    <body>
       <div>
<div id="topbar">
    <span id="text">You are at &nbsp;<span id="cityname"><%=cityname%></span></span>
</div>
<div id="menubar">
<div id="menu1"><div style="padding-left:20px;">Squink</div></div>
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
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Why Squink?</div>
</div>
<div id="menu11">
<div align="center" style="margin-top:2.5px;">Contact Us</div>
</div>

</div>
</div>
<div id="maincontent">
    <br/><br/><br/>
    <table style="font-family: font1; width: 100%">
<%
cityname=cityname.toUpperCase();
Connect obj=new Connect();
Connection con=obj.conect();
PreparedStatement pstmt=con.prepareStatement("select citycode from servicedcitydb where cityname=?");
pstmt.setString(1,cityname);
ResultSet rs=pstmt.executeQuery();
String citycode=null;
while(rs.next())
       {
    citycode=rs.getString(1);
}

pstmt=con.prepareStatement("select pid,name,category,ovambi,ovservice,ovcost,ovq,ovexotic,ovindi,pricelower,priceupper,lat,lon,(likes+dislikes+neutrals),ascorefact,ascore from cityapprovedproperty_"+citycode+" where name like \'%"+query+"%\' and status=1");

rs=pstmt.executeQuery();
while(rs.next())
{
  out.println("<tr>");
  out.println("<td><img src=\"propertyimages/"+citycode+"_"+rs.getString(1)+"_1.jpg\" height=\"100\" width=\"100\"></img></td>");
  out.println("<td><h2>"+rs.getString(2)+"</h2>");
  int cat=rs.getInt(3);
  if(cat==103||cat==104||cat==108||cat==109||cat==110||cat==111)
           {
      out.println("Ambience: "+rs.getInt(4)+", Service: "+rs.getInt(5)+", Cost: ");
      int cost=rs.getInt(6);
      if(cost>0 && cost<4)
          out.println(" Low Cost");
      else
          if(cost>5 && cost<7)
              out.println("Moderate");
      else
          if(cost>6 && cost<8)
              out.println("Expensive");
                      else
                          out.println("Highly Expensive");
      out.println(", Quality: "+rs.getInt(7)+", Exotic: "+rs.getInt(8)+", Indi Fact: "+rs.getInt(9)+"</td>");
      double lat1=rs.getDouble(12);
      double lon1=rs.getDouble(13);
      long tot=rs.getLong(14);
      long afact=rs.getLong(15);
      if(tot>=afact)
       {
          out.println("<td><span style=\"font-size:8px\">aScore</span><br/>");
          out.println("<span style=\"font-family:18px\">"+rs.getLong(16)+"</span></td>");
          
          
      }
      else
                   {
            out.println("<td><span style=\"font-size:8px\">aScore</span><br/>");
          out.println("<span style=\"font-family:18px\">NA</span></td>");
          
      }
      
      out.println("<td>"+Math.abs(obj.haversine(lat1, lon1, Double.parseDouble(lat), Double.parseDouble(lon)))+"</td></tr>");
      
                          
              
  }
  else
           {
       out.println("Ambience: "+rs.getInt(4)+", Service: "+rs.getInt(5)+", Cost: ");
      int cost=rs.getInt(6);
      if(cost>0 && cost<4)
          out.println(" Low Cost");
      else
          if(cost>5 && cost<7)
              out.println("Moderate");
      else
          if(cost>6 && cost<8)
              out.println("Expensive");
                      else
                          out.println("Highly Expensive");
     out.println(", Quality: "+rs.getInt(7)+"</td>");
      double lat1=rs.getDouble(12);
      double lon1=rs.getDouble(13);
      long tot=rs.getLong(14);
      long afact=rs.getLong(15);
      if(tot>=afact)
       {
          out.println("<td><span style=\"font-size:8px\">aScore</span><br/>");
          out.println("<span style=\"font-family:18px\">"+rs.getLong(16)+"</span></td>");
          
          
      }
      else
                   {
            out.println("<td><span style=\"font-size:8px\">aScore</span><br/>");
          out.println("<span style=\"font-family:18px\">NA</span></td>");
          
      }
      
      out.println("<td>"+Math.abs(obj.haversine(lat1, lon1, Double.parseDouble(lat), Double.parseDouble(lon)))+" Km</td></tr>");
      
                          
      
  }
  
    
}
con.close();

%>

    </table>
</div>
    </body>
</html>
