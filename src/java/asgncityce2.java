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
 * @author Sridevi
 */
public class asgncityce2 extends HttpServlet
{
    @Override
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        PrintWriter pw=res.getWriter();
        try {
            String id=rq.getParameter("id");
            String country=rq.getParameter("Country");
            String city=rq.getParameter("City");
            Connect obj=new Connect();
            Connection con=obj.conect();
            PreparedStatement pstmt=con.prepareStatement("select citycode from servicedCityDB where country=? and cityname=?");   
            pstmt.setString(1, country);
            pstmt.setString(2,city);
            ResultSet rs=pstmt.executeQuery();
            String citycode=null;
            while(rs.next())
            {
                citycode=rs.getString(1);              
            }
            
            pstmt.close();
            pstmt=con.prepareStatement("select type from loginDB where username=?");
            pstmt.setString(1, id);
            rs.close();
            rs=pstmt.executeQuery();
            int type1 = 0;
            while(rs.next())
            {
                type1=rs.getInt(1);
            }
            pstmt.close();
            if(type1==3)
            {
            pstmt=con.prepareStatement("insert into ce2service values(?,?)");
            pstmt.setLong(1, Long.parseLong(id));
            pstmt.setString(2,citycode);
            pstmt.execute();
            pstmt.close();
            pstmt=con.prepareStatement("insert into citypendingce2db_"+citycode+"(id,rating) select id,rating from employeeDB where id=? ");
            pstmt.setLong(1, Long.parseLong(id));
            pstmt.execute();
            pstmt.close();
            pstmt=con.prepareStatement("update citypendingce2db_"+citycode+" set pendingcount=0 where id=?");
            pstmt.setLong(1, Long.parseLong(id));
            pstmt.execute();
            pw.println("1");
            }
            else
                con.close();
                pw.println("0");
        } catch (SQLException ex) {
            Logger.getLogger(asgncityce2.class.getName()).log(Level.SEVERE, null, ex);
            pw.println("0");
        }
        
        
    }
}
  