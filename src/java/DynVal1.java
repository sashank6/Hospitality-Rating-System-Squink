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
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Sashank
 */
public class DynVal1 extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        PrintWriter pw=res.getWriter();
        try {
            String type=rq.getParameter("type");
            String data=rq.getParameter("data");
            Connect obj=new Connect();
            Connection con=obj.conect();
            if(Integer.parseInt(type)==1)
            {
                PreparedStatement pstmt=con.prepareStatement("select count(*) from employeeDB where phonenumber=?");
                pstmt.setLong(1, Long.parseLong(data));
                ResultSet rs=pstmt.executeQuery();
                int ci = -1;
                while(rs.next())
                {
                    ci=rs.getInt(1);
                }
                if(ci==0)
                    pw.println("0");
                            else
                    pw.println("1");
                    
            }
            if(Integer.parseInt(type)==2)
            {
                PreparedStatement pstmt=con.prepareStatement("select count(*) from employeeDB where emailid=?");
                pstmt.setString(1, data);
                ResultSet rs=pstmt.executeQuery();
                int ci = -1;
                while(rs.next())
                {
                    ci=rs.getInt(1);
                }
                if(ci==0)
                    pw.println("0");
                            else
                    pw.println("1");
                    
            }
            con.close();
        } 
        catch (SQLException ex) {
            Logger.getLogger(DynVal1.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

}