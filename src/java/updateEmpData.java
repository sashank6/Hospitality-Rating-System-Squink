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
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Sashank
 */
public class updateEmpData extends HttpServlet
{
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        PrintWriter pw=res.getWriter();
        String id=rq.getParameter("id");
        String fname=rq.getParameter("fname");
        String lname=rq.getParameter("lname");
        String dob=rq.getParameter("dob");
        String dept=rq.getParameter("dept");
        String adr=rq.getParameter("adr");
        String city=rq.getParameter("city");
        String ctry=rq.getParameter("ctry");
        String rating=rq.getParameter("rating");
        String phno=rq.getParameter("phno");
        String email=rq.getParameter("email");
        String ssn=rq.getParameter("ssn");
        String[] dob1=dob.split("-");
        Connection con = null;
        try
        {
            Connect obj=new Connect();
           con=obj.conect();
            con.setAutoCommit(false);
            PreparedStatement pstmt=con.prepareStatement("update employeeDb set firstname=?,lastname=?,dob=?,dept=?,address=?,city=?,country=?,rating=?,phonenumber=?,emailid=?,ssn_pan=? where id=?");
           pstmt.setQueryTimeout(5);
            pstmt.setString(1, fname);
            pstmt.setString(2, lname);
            Calendar c=Calendar.getInstance();
        c.set(Integer.parseInt(dob1[0]), Integer.parseInt(dob1[1])-1, Integer.parseInt(dob1[2]));
        java.sql.Date dt=new java.sql.Date(c.getTimeInMillis());
        pstmt.setDate(3, dt);
        pstmt.setString(4, dept);
        pstmt.setString(5, adr);
        pstmt.setString(6, city);
        pstmt.setString(7,ctry);
        pstmt.setInt(8,Integer.parseInt(rating));
        pstmt.setLong(9, Long.parseLong(phno));
        pstmt.setString(10,email);
        pstmt.setString(11,ssn);
        pstmt.setInt(12,Integer.parseInt(id));
    pstmt.executeUpdate();
    pstmt.close();
    pstmt=con.prepareStatement("update loginDB set type=? where username=?");
    
    if(dept.equals("CE1"))
        pstmt.setInt(1, Integer.parseInt("1"));
    else
        if(dept.equals("CE2"))
pstmt.setInt(1,Integer.parseInt("3")) ;
    else
            if(dept.equals("PQA"))
                pstmt.setInt(1,6);
    pstmt.setString(2, id);
    pstmt.executeUpdate();
       con.commit();
         con.close();
        pw.println("Update Successful");
            
        }
        catch(Exception e)
        {
            try {
                con.rollback();
                pw.println("Update Unsuccessful");
            } catch (SQLException ex) {
                Logger.getLogger(updateEmpData.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        
                
        
    }

}