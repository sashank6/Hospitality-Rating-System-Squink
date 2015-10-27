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
import squink.Connect;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.*;

/**
 *
 * @author Sashank
 */
public class rateProperty extends HttpServlet
{
    PrintWriter pw;
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
       pw=res.getWriter();
        String pid=rq.getParameter("pid");
        String citycode=rq.getParameter("citycode");
        String ambi=rq.getParameter("ambi");
        String cost=rq.getParameter("cost");
        String serv=rq.getParameter("serv");
        String qua=rq.getParameter("qua");
        String indi=rq.getParameter("indi");
        String exot=rq.getParameter("exot");
        String likef=rq.getParameter("likef");
        String cat=rq.getParameter("cat");
          int catid=Integer.parseInt(cat);
          HttpSession ses=rq.getSession();
          String username=(String) ses.getAttribute("username");
          Connection con = null;
          
        try
        {
        Connect obj=new Connect();
        con=obj.conect();
        con.setAutoCommit(false);
        PreparedStatement pstmt=con.prepareStatement("select cityfact from servicedcitydb where citycode=?");
        double cityfact = 0;int param;double param1;
        pstmt.setString(1,citycode);
        ResultSet rs=pstmt.executeQuery();
        int oambi = 0,oserv = 0,ocost = 0,oq = 0,oexo = 0,oindi = 0;
        while(rs.next())
            cityfact=rs.getDouble(1);
        if(catid==103||catid==104||catid==108||catid==109||catid==110||catid==111)
        {
            pstmt=con.prepareStatement("insert into pidrating_"+pid+"_"+citycode+" values(?,?,?,?,?,?,?)");
            pstmt.setString(1, username);
            pstmt.setInt(2, Integer.parseInt(ambi));
            pstmt.setInt(3,Integer.parseInt(serv));
            pstmt.setInt(4, Integer.parseInt(cost));
            pstmt.setInt(5, Integer.parseInt(qua));
            pstmt.setInt(6, Integer.parseInt(exot));
            pstmt.setInt(7, Integer.parseInt(indi));
            pstmt.execute();
            con.commit();
            pstmt=con.prepareStatement("select avg(ovambi),avg(ovservice),avg(ovcost),avg(ovq),avg(ovexotic),avg(ovindi) from pidrating_"+pid+"_"+citycode);
            rs=pstmt.executeQuery();
            
            while(rs.next())
            {
                oambi=rs.getInt(1);
                oserv=rs.getInt(2);
                ocost=rs.getInt(3);
                oq=rs.getInt(4);
                oexo=rs.getInt(5);
                oindi=rs.getInt(6);
                
            }
            param=oambi+oserv+10-ocost+oq+oexo+oindi;
            param1=(double)param/6;
            
            
            
        }
        else
        {
             pstmt=con.prepareStatement("insert into pidrating_"+pid+"_"+citycode+" values(?,?,?,?,?)");
            pstmt.setString(1, username);
            pstmt.setInt(2, Integer.parseInt(ambi));
            pstmt.setInt(3,Integer.parseInt(serv));
            pstmt.setInt(4, Integer.parseInt(cost));
            pstmt.setInt(5, Integer.parseInt(qua));
            
            pstmt.execute();
            con.commit();
            pstmt=con.prepareStatement("select avg(ovambi),avg(ovservice),avg(ovcost),avg(ovq) from pidrating_"+pid+"_"+citycode);
            rs=pstmt.executeQuery();
           
            while(rs.next())
            {
                oambi=rs.getInt(1);
                oserv=rs.getInt(2);
                ocost=rs.getInt(3);
                oq=rs.getInt(4);
               
                
            }
            param=oambi+oserv+(10-ocost)+oq;
            param1=(double)param/4;
        }
        pstmt=con.prepareStatement("select likes,dislikes,neutrals,ascorefact,premfact from cityapprovedproperty_"+citycode+" where pid=?");
        pstmt.setString(1, pid);
        long likes = 0,dislikes = 0,neutrals = 0,ascorefact = 0,premfact = 0;
        rs=pstmt.executeQuery();
        while(rs.next())
        {
            likes=rs.getLong(1);
            dislikes=rs.getLong(2);
            neutrals=rs.getLong(3);
            ascorefact=rs.getLong(4);
            premfact=rs.getLong(5);
            
        }
         if(Integer.parseInt(likef)==0)
            dislikes++;
        else
            if(Integer.parseInt(likef)==1)
           likes++;
        if(Integer.parseInt(likef)==2)
            neutrals++;
        long tc=likes+dislikes+neutrals;
        double ascore1=tc/ascorefact;
        if(ascore1>60)
            ascore1=60;
        double ascore=(param1*((double)likes/(double)tc))+10*((double)likes/(double)tc)+(premfact*10)+(ascore1*((double)likes/(double)tc))*cityfact;
       pstmt=con.prepareStatement("update cityapprovedproperty_"+citycode+" set ovambi=?,ovservice=?,ovcost=?,ovq=?,ovexotic=?,ovindi=?,likes=?,dislikes=?,neutrals=?,ascore=?,rate=rate-1");
       pstmt.setInt(1, oambi);
       pstmt.setInt(2, oserv);
       pstmt.setInt(3, ocost);
       pstmt.setInt(4, oq);
       pstmt.setInt(5, oexo);
       pstmt.setInt(6, oindi);
       pstmt.setLong(7, likes);
       pstmt.setLong(8, dislikes);
       pstmt.setLong(9,neutrals);
       pstmt.setDouble(10, ascore);
       pstmt.execute();
       con.commit();
        pw.println("Success");
        
        con.close();
        }
        catch(Exception ex)
        {
            try {
                con.rollback();
                pw.println("Failure");
            } catch (SQLException ex1) {
                Logger.getLogger(rateProperty.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(rateProperty.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        
    }

}