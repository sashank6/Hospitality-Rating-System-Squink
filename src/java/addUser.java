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
import squink.sendMail;

/**
 *
 * @author Sashank
 */
public class addUser extends HttpServlet 
{
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        PrintWriter pw=res.getWriter();
        Connection con=null;
        try {
            String username=rq.getParameter("username");
            String pass=rq.getParameter("pass");
            String email=rq.getParameter("email");
            String phno=rq.getParameter("phno");
            Connect obj=new Connect();
            con=obj.conect();
            con.setAutoCommit(false);
            PreparedStatement pstmt=con.prepareStatement("select dbms_random.String(\'A\',10) from dual");
            String confirmationcode=null;
            ResultSet rs=pstmt.executeQuery();
            while(rs.next())
            {
                confirmationcode=rs.getString(1);
            }
            rs.close();
            pstmt.close();
            pstmt=con.prepareCall("{call addUser(?,?,?,?,?)}");
            pstmt.setString(1,username);
            pstmt.setString(2,obj.md5(pass));
            pstmt.setString(3, email);
            pstmt.setLong(4,Long.parseLong(phno));
            pstmt.setString(5, confirmationcode);
            pstmt.execute();
            String msgcontent="Thank You for registering at Squink. Follow the url below to confirm your mail id http://localhost:7070/Squink/usercnf.jsp?cnfcode="+confirmationcode+"&username="+username;
            sendMail obj1=new sendMail();
            try {
             obj1.send(msgcontent, email);
             con.commit();
             con.close();
            pw.println("User Added successfully");
            } catch (MessagingException ex) {
                con.rollback();
                pw.println("User Registration failed");
                Logger.getLogger(addUser.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            
            
        } catch (SQLException ex) {
            try {
                con.rollback();
                
                pw.println("User Registration failed");
            } catch (SQLException ex1) {
                Logger.getLogger(addUser.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(addUser.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }

}