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
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import squink.Connect;

/**
 *
 * @author Sashank
 */
public class addCat extends HttpServlet
{
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException 
    {
        PrintWriter pw=res.getWriter();
        try {
            String catname=rq.getParameter("catname");
            Connect obj=new Connect();
            Connection con=obj.conect();
            PreparedStatement pstmt=con.prepareStatement("insert into categorytable values(catid.nextval,?)");
            pstmt.setString(1,catname);
            pstmt.execute();
            pw.println("Success");
        } catch (SQLException ex) {
            pw.println("Error");
            Logger.getLogger(addCat.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

}