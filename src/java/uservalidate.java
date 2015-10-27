/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import squink.Connect;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author Sashank
 */
public class uservalidate extends HttpServlet {
    protected void doPost(HttpServletRequest rq, HttpServletResponse res) throws IOException
    {
        HttpSession ses=rq.getSession(true);
        try {
            String user=rq.getParameter("user");
            String pass=rq.getParameter("pass");
            Connect obj=new Connect();
            Connection con = null;
            try {
                con=obj.conect();
            } catch (SQLException ex) {
                Logger.getLogger(uservalidate.class.getName()).log(Level.SEVERE, null, ex);
            }
            PreparedStatement pstmt=con.prepareStatement("select password,status,type from loginDB where username=?");
            pstmt.setString(1, user);
            int passtrials=1;
            ResultSet rs=pstmt.executeQuery();
            String passv = null;
            int status = -1;
            int type=0;
            while(rs.next())
            {
                passv=rs.getString(1);
                status=rs.getInt(2);
                type=rs.getInt(3);
            }
            pstmt.close();
            PrintWriter pw=res.getWriter();
            String pass1=obj.md5(pass);
            if(pass1.equals(passv))
            {
                if(status==1)
                {
                    ses.setAttribute("usertype", String.valueOf(type));
                    ses.setAttribute("username", user);
                     if(type==4)
                        pw.println("4");
                     else
                    pw.println("1");
                   
                }
                else
                    pw.println("2");
            }
            else
            {
                
                try
                {
                    String passt=(String) ses.getAttribute("passtrials");
                    passtrials=Integer.parseInt(passt);
                    passtrials++;
                    ses.setAttribute("passtrials",String.valueOf(passtrials));
                    if(passtrials==3)
                    {
                        pstmt=con.prepareStatement("update loginDB set status=2 where id=?");
                        pstmt.setString(1, user);
                        pstmt.executeQuery();
                        pstmt.close();
                    }
                }
                catch(Exception e)
                        {
                            ses.setAttribute("passtrials", String.valueOf(passtrials));
                        }
                if(status!=2)
                pw.println("3");
                else
                    pw.println("2");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(uservalidate.class.getName()).log(Level.SEVERE, null, ex);
        }
        
      
        
    }
     

}