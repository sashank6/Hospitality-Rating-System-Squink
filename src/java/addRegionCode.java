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

/**
 *
 * @author Sashank
 */
public class addRegionCode extends HttpServlet 
{
    @Override
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        PrintWriter pw=res.getWriter();
        try {
           
            String ccode=rq.getParameter("ccode");
            String area=rq.getParameter("area");
           
            Connect obj=new Connect();
            Connection con=obj.conect();
            String sql="insert into cityRegionDB_"+ccode+" values(\'"+ccode+"_\'||ap_"+ccode+".nextval,?)";
            PreparedStatement pstmt=con.prepareStatement(sql);
            
          
            //pstmt.setString(2,ccode);
            pstmt.setString(1, area);
            
            pstmt.execute();
           con.close();
            pw.println("Success");
            
        } catch (SQLException ex) {
            pw.println("Error");
            Logger.getLogger(addRegionCode.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}