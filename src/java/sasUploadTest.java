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
public class sasUploadTest extends HttpServlet {
    static String filepath="C:\\Users\\Sashank\\Documents\\NetBeansProjects\\Squink\\web\\testimage\\";
    protected void doPost(HttpServletRequest rq,HttpServletResponse res)
    {
        boolean isMp=ServletFileUpload.isMultipartContent(rq);
        if(isMp)
        {
            DiskFileItemFactory fact=new DiskFileItemFactory();
            fact.setSizeThreshold(1024*1024*1024*1024);
            fact.setRepository(new File("C:\\tempimage\\"));
            ServletFileUpload upload=new ServletFileUpload(fact);
            upload.setSizeMax(1024*1024);
            int count=1;
            try
            {
                List fileitems=upload.parseRequest(rq);
                Iterator i=fileitems.iterator();
                while(i.hasNext())
                {
                    FileItem fi=(FileItem) i.next();
                    if(!fi.isFormField())
                    {
                        String filename=filepath+"test_"+count+".jpg";
                        File file=new File(filename);
                        fi.write(file);
                        count++;
                    }
                    else
                    {
                        
                    }
                    
                }
            }
            catch(Exception e)
            {
                
            }
            
        }
    }
    

}