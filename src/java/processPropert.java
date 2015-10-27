/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;
import squink.Connect;
import java.sql.*;
/**
 *
 * @author Sashank
 */
public class processPropert extends HttpServlet 
{
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        PrintWriter pw=res.getWriter();
        String ambi=rq.getParameter("ambi");
        String service=rq.getParameter("service");
        String cost=rq.getParameter("cost");
        String quality=rq.getParameter("quality");
        String cityname=rq.getParameter("cityname");
        String catid=rq.getParameter("catid");
        String ovexotic=rq.getParameter("exotic");
        String ovindi=rq.getParameter("indi");
       String lat=null,lon=null;
       
       if(cityname==null)
       {
           HttpSession ses=rq.getSession();
           lat=(String)ses.getAttribute("lat");
           lon=(String)ses.getAttribute("lon");
           cityname=(String)ses.getAttribute("cityname");
           
       }
      // pw.println(ambi+" "+service+" "+cost+" "+quality+" "+lat+" "+lon+" "+cityname);
       try
       {
       Connect obj=new Connect();
       Connection con=obj.conect();
       PreparedStatement pstmt=con.prepareStatement("select citycode from servicedCityDB where cityname=?");
       pstmt.setString(1, cityname.toUpperCase());
       ResultSet rs=pstmt.executeQuery();
       String citycode=null;
       while(rs.next())
       {
           citycode=rs.getString(1);
       }
      // pw.println(citycode);
       pstmt.close();
       rs.close();
       pw.println("<table id=\"redf\">");
       if(Integer.parseInt(catid)==103||Integer.parseInt(catid)==104||Integer.parseInt(catid)==108||Integer.parseInt(catid)==109||Integer.parseInt(catid)==110||Integer.parseInt(catid)==111)
       {
       pstmt=con.prepareStatement("select pid,name,ovambi,ovservice,ovcost,ovq,ovexotic,ovindi,lat,lon,(likes+dislikes+neutrals) as tc,ascorefact,ascore,pricelower,priceupper  from cityapprovedproperty_"+citycode+" where ovambi>=? and ovcost>=? and ovservice>=? and ovq>=? and category=? and ovexotic>=?  and ovindi>=? and status=1");
       pstmt.setInt(1, Integer.parseInt(ambi));
       pstmt.setInt(2,Integer.parseInt(cost));
       pstmt.setInt(3,Integer.parseInt(service));
       pstmt.setInt(4,Integer.parseInt(quality));
       pstmt.setInt(5,Integer.parseInt(catid));
       pstmt.setInt(6,Integer.parseInt(ovexotic));
       pstmt.setInt(7,Integer.parseInt(ovindi));
       
       
       rs=pstmt.executeQuery();
       boolean x=false;
       while(rs.next())
       {
           pw.println("<tr>");
           pw.println("<td><img src=\"propertyimages/"+citycode+"_"+rs.getString(1)+"_1.jpg\" height=\"100px\" width=\"100px\"/></td>");
           pw.println("<td><b>"+"<a href=\"viewProperty.jsp?pid="+rs.getString(1)+"&citycode="+citycode+"\">"+rs.getString(2)+"</a></b><br/>Ambience: "+rs.getInt(3)+" Service: "+rs.getInt(4)+" Cost: ");
           int cty=rs.getInt(5);
           String factor=null;
           if(cty>=0 && cty<=4)
           factor="Low Cost";
           else
           if(cty>4 && cty<=6)
            factor="Moderate Pricing";
           else
               if(cty>6 && cty<8)
           factor="Expensive";
           else
           factor="Highly Expensive";
       
       
          pw.println(factor+"("+cty+")  Quality: "+rs.getInt(6)+" Exotic: "+rs.getInt(7)+" Indigenous Factor: "+rs.getInt(8));
           double lat1=Double.parseDouble(lat);
           double lon1=Double.parseDouble(lon);
           double lat2=rs.getDouble(9);
           double lon2=rs.getDouble(10);
           long tc=rs.getLong(11);
           long afact=rs.getLong(12);
          double ascore=rs.getDouble(13);
          long plow=rs.getLong(14);
          long phigh=rs.getLong(15);
           pw.println(" Price Range: "+plow+"-"+phigh+"</td>");
           if(tc<afact)
               pw.println("<td><span id=\"small\">aScore</span><br/><span>NA</span></td>");
           else
               pw.println("<td><span id=\"small\">aScore</span><br/><span>"+ascore+"</span></td>");
           pw.println("<td>"+Math.abs(obj.haversine(lat1, lon1, lat2, lon2))+"km"+"</td>");
           
           
           
           
          
           x=true;
           
           
       }
       if(!x)
           pw.println("<tr><td align=\"center\">No Data Found</td></tr>");
       pw.println("</table>");
       }
       else
       {
            pstmt=con.prepareStatement("select pid,name,ovambi,ovservice,ovcost,ovq,lat,lon,(likes+dislikes+neutrals) as tc,ascorefact,ascore,pricelower,priceupper  from cityapprovedproperty_"+citycode+" where ovambi>=? and ovcost>=? and ovservice>=? and ovq>=? and category=?  and status=1");
       pstmt.setInt(1, Integer.parseInt(ambi));
       pstmt.setInt(2,Integer.parseInt(cost));
       pstmt.setInt(3,Integer.parseInt(service));
       pstmt.setInt(4,Integer.parseInt(quality));
       pstmt.setInt(5,Integer.parseInt(catid));
       
       
       
       rs=pstmt.executeQuery();
       boolean x=false;
       while(rs.next())
       {
           pw.println("<tr>");
           pw.println("<td><img src=\"propertyimages/"+citycode+"_"+rs.getString(1)+"_1.jpg\" height=\"100px\" width=\"100px\"/></td>");
           pw.println("<td><b>"+"<a href=\"viewProperty.jsp?pid="+rs.getString(1)+"&citycode="+citycode+"\">"+rs.getString(2)+"</a></b><br/>Ambience: "+rs.getInt(3)+" Service: "+rs.getInt(4)+" Cost: ");
           int cty=rs.getInt(5);
           String factor=null;
           if(cty>=0 && cty<=4)
           factor="Low Cost";
           else
           if(cty>4 && cty<=6)
            factor="Moderate Pricing";
           else
               if(cty>6 && cty<8)
           factor="Expensive";
           else
           factor="Highly Expensive";
       
       
          pw.println(factor+"("+cty+")  Quality: "+rs.getInt(6));
           double lat1=Double.parseDouble(lat);
           double lon1=Double.parseDouble(lon);
           double lat2=rs.getDouble(7);
           double lon2=rs.getDouble(8);
           long tc=rs.getLong(9);
           long afact=rs.getLong(10);
          double ascore=rs.getDouble(11);
          long plow=rs.getLong(12);
          long phigh=rs.getLong(13);
           pw.println(" Price Range(Meal for 2): "+plow+"-"+phigh+"</td>");
           if(tc<afact)
               pw.println("<td id=\"ascore\"><span id=\"small\">aScore</span><br/><span id=\"big\">NA</span></td>");
           else
               pw.println("<td id=\"ascore\"><span id=\"small\">aScore</span><br/><span id=\"big\">"+ascore+"</span></td>");
           pw.println("<td>"+Math.abs(obj.haversine(lat1, lon1, lat2, lon2))+"km"+"</td>");
           
           
           
           
          
           x=true;
           
           
       }
       if(!x)
           pw.println("<tr><td align=\"center\">No Data Found</td></tr>");
       pw.println("</table>");
       }
       con.close();
       }
       catch(Exception e)
       {
           System.out.println("Empty");
           pw.println("No Data Found");
           pw.println("</table");
       }
       
       
        
    }

}