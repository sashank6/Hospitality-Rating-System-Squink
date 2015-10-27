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
public class addCity extends HttpServlet
{
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        PrintWriter pw=res.getWriter();
        try {
            String country=rq.getParameter("ctry");
            String cityname=rq.getParameter("cityname");
            String cityfact=rq.getParameter("cityfact");
            country=country.toUpperCase();
            cityname=cityname.toUpperCase();
            Connect obj=new Connect();
            Connection con=obj.conect();
            PreparedStatement pstmt=con.prepareStatement("insert into servicedCityDB values(\'C\'||cityCode.nextval,?,?,?)");
            pstmt.setString(1, cityname);
            pstmt.setString(2, country);
            pstmt.setDouble(3,Double.parseDouble(cityfact));
            pstmt.execute();
           con.close();
            pw.println("City Added Successfully");
        } catch (SQLException ex) {
            Logger.getLogger(addCity.class.getName()).log(Level.SEVERE, null, ex);
            pw.println("Unable to add city");
        }
        
    }

}