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
public class getRegionCode extends HttpServlet
{
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {PrintWriter pw=res.getWriter();
        try {
            String citycode=rq.getParameter("citycode");
            Connect obj=new Connect();
            Connection con=obj.conect();
            PreparedStatement pstmt=con.prepareStatement("select *from cityregiondb_"+citycode);
            ResultSet rs=pstmt.executeQuery();
           pw.println("<option></option>");
            while(rs.next())
            {
                pw.print("<option value=\""+rs.getString(1)+"\">"+rs.getString(2)+"</option>");
               
            }
            con.close();
          
        } catch (SQLException ex) {
            Logger.getLogger(getRegionCode.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }

}