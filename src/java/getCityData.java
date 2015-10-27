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
public class getCityData extends HttpServlet
{
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        PrintWriter pw=res.getWriter();
        try {
            String ctry=rq.getParameter("ctry");
            Connect obj=new Connect();
            Connection con=obj.conect();
            PreparedStatement pstmt=con.prepareStatement("select citycode,cityname from servicedCityDB where country=?");
            pstmt.setString(1, ctry);
            ResultSet rs=pstmt.executeQuery();
           
            pw.println("<option></option>");
            while(rs.next())
            {
                pw.println("<option value=\""+rs.getString(1)+"\" >"+rs.getString(2)+"</option>");
            }
     
            con.close();
            pstmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(getCityData.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }

}