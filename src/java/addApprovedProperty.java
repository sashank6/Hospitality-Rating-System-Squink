/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import squink.Connect;
import java.io.*;
import java.util.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
 import javax.servlet.http.*;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.output.*;
import squink.sendMail;

/**
 *
 * @author Sashank
 */
public class addApprovedProperty extends HttpServlet
{
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
       String filepath="C:\\Users\\Sashank\\Documents\\NetBeansProjects\\Squink\\web\\propertyimages\\";
       PrintWriter pw=res.getWriter();
        boolean isMp=ServletFileUpload.isMultipartContent(rq);
        if(isMp)
        {
            try {
                DiskFileItemFactory fact=new DiskFileItemFactory();
                fact.setRepository(new File("C:\\tempimage\\"));
                fact.setSizeThreshold(1024*1024*10);
                ServletFileUpload up=new ServletFileUpload(fact);
                up.setSizeMax(1024*1024*5);
                HttpSession ses=rq.getSession();
                String citycode=(String) ses.getAttribute("citycode");
                String pid=(String) ses.getAttribute("pid");
                ses.removeAttribute("citycode");
                ses.removeAttribute("pid");
                String[] data=new String[15];
                int dcount=0;
                int count=1;
                try
                {
                    List fileItems=up.parseRequest(rq);
                    Iterator i=fileItems.iterator();
                    while(i.hasNext())
                    {
                        FileItem fi=(FileItem)i.next();
                        if(fi.isFormField())
                        {
                            data[dcount++]=fi.getString();
                            
                        }
                        else
                        {
                            File file=new File(filepath+citycode+"_"+pid+"_"+count+".jpg");
                            fi.write(file);
                            count++;
                        }
                    }
                }
                catch(Exception e)
                {
            }
                Connect obj=new Connect();
                Connection con=obj.conect();
                PreparedStatement pstmt=con.prepareCall("{call cityappprop(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                pstmt.setString(1, pid);
                pstmt.setString(2, data[0]);
                pstmt.setString(3, data[1]);
                pstmt.setInt(4,0);
                pstmt.setInt(5, Integer.parseInt(data[10]));
                pstmt.setDouble(6, Double.parseDouble(data[2]));
                pstmt.setDouble(7,Double.parseDouble(data[3]));
                pstmt.setInt(8,Integer.parseInt(data[5]));
                pstmt.setInt(9,0);
                pstmt.setInt(10,0);
                pstmt.setInt(11,0);
                pstmt.setInt(12,0);
                pstmt.setString(13,data[4]);
                pstmt.setString(14, citycode);
                pstmt.setString(15,data[11]);
                pstmt.setInt(16,0);
                pstmt.setInt(17,0);
                pstmt.setInt(18,0);
                pstmt.setInt(19,0);
                pstmt.setInt(20,0);
                pstmt.setLong(21,Long.parseLong(data[6]));
                pstmt.setInt(22,0);
                pstmt.setInt(23,Integer.parseInt(data[7]));
                pstmt.setLong(24,Long.parseLong(data[8]));
                pstmt.setLong(25,3*Long.parseLong(data[8]));
                pstmt.setInt(26, 1);
                String[] pricetaker=data[9].split("-");
               
                pstmt.setLong(27,Long.parseLong(pricetaker[0]));
                pstmt.setLong(28,Long.parseLong(pricetaker[1]));
                pstmt.execute();
                con.close();
                pw.println("Successful");
                
                
            } catch (Exception ex) {
                pw.println("Failure");
                Logger.getLogger(addApprovedProperty.class.getName()).log(Level.SEVERE, null, ex);
            }
            
    }

}
}