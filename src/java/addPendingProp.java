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
import javax.mail.MessagingException;
import javax.servlet.http.*;
import squink.sendMail;
/**
 *
 * @author Sashank
 */
public class addPendingProp extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        Connection con=null;
        PrintWriter pw=res.getWriter();
        try {
            String name=rq.getParameter("name");
            String rcode=rq.getParameter("rcode");
            String type=rq.getParameter("type");
            String desc=rq.getParameter("desc");
            String crating=rq.getParameter("rating");
            String address=rq.getParameter("address");
            String citycode=rq.getParameter("citycode");
            Connect obj=new Connect();
          con=obj.conect();
            con.setAutoCommit(false);
            PreparedStatement pstmt=con.prepareStatement("select id from citypendingce2db_"+citycode+" where rating >=? and rownum=1 order by pendingcount asc");
            pstmt.setInt(1, Integer.parseInt(crating));
            ResultSet rs=pstmt.executeQuery();
            long id = 0;
            while(rs.next())
            {
                id=rs.getLong(1);
                break;
            }
            pstmt.close();
            HttpSession ses=rq.getSession();
            String username=(String) ses.getAttribute("username");
            pstmt=con.prepareStatement("select pa_"+citycode+".nextval from dual");
            rs=pstmt.executeQuery();
            String pid=null;
            while(rs.next())
                pid=rs.getString(1);
            pstmt.close();
            String pid1="P"+pid;
            pstmt=con.prepareStatement("insert into cityPendingPropDB_"+citycode+" values(?,?,?,?,?,?,0,?,?,?)");
            pstmt.setString(1, pid1);
            pstmt.setString(2, name);
            pstmt.setString(3, rcode);
            pstmt.setInt(4,Integer.parseInt(type));
            pstmt.setString(5, username);
            pstmt.setString(6,desc);
            pstmt.setInt(7,Integer.parseInt(crating));
            pstmt.setLong(8, id);
            pstmt.setString(9,address);
            pstmt.execute();
            pstmt.close();
            pstmt=con.prepareStatement("insert into ce1_"+username+" values(?,?)");
            pstmt.setString(1, pid1);
            pstmt.setString(2,citycode);
            pstmt.execute();
            pstmt.close();
            pstmt=con.prepareStatement("select emailid from employeedb where id=?");
            pstmt.setLong(1, id);
            rs=pstmt.executeQuery();
            String emailce2 = null;
            while(rs.next())
            {
                emailce2=rs.getString(1);
            }
            sendMail sme=new sendMail();
            try {
                sme.send("You have to review a Property, details available on Portal", emailce2);
            } catch (MessagingException ex) {
                Logger.getLogger(addPendingProp.class.getName()).log(Level.SEVERE, null, ex);
            }
            con.commit();
            con.close();
            pw.println("Success");
        } catch (SQLException ex) {
            try {
                con.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(addPendingProp.class.getName()).log(Level.SEVERE, null, ex1);
            }
            pw.println("Error");
            Logger.getLogger(addPendingProp.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }

}