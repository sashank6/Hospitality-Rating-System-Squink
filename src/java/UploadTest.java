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

public class UploadTest extends HttpServlet {
   
   private boolean isMultipart;
   private String filePath;
   private int maxFileSize = 1024 * 1024;
   private int maxMemSize =1024 * 1024;
   private File file ;

   public void init( ){
      // Get the file location where it would be stored.
      filePath = 
             getServletContext().getInitParameter("file-upload"); 
   }
   public void doPost(HttpServletRequest request, 
               HttpServletResponse response)
              throws ServletException, java.io.IOException {  
       Connection con=null;
      isMultipart = ServletFileUpload.isMultipartContent(request);
      response.setContentType("text/html");
      java.io.PrintWriter out = response.getWriter( );
      if( !isMultipart ){
         out.println("<html>");
         out.println("<head>");
         out.println("<title>Servlet upload</title>");  
         out.println("</head>");
         out.println("<body>");
         out.println("<p>No file uploaded</p>"); 
         out.println("</body>");
         out.println("</html>");
         return;
      }
      DiskFileItemFactory factory = new DiskFileItemFactory();     
      factory.setSizeThreshold(maxMemSize);      
      factory.setRepository(new File("c:\\temp"));     
      ServletFileUpload upload = new ServletFileUpload(factory);     
      upload.setSizeMax( maxFileSize );
      try{      
      List fileItems = upload.parseRequest(request);      
      Iterator i = fileItems.iterator();
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      Connect obj=new Connect();
     con= obj.conect();
      con.setAutoCommit(false);
      PreparedStatement pstmt=con.prepareStatement("select eid.nextval as eid from dual ");
      ResultSet rs=pstmt.executeQuery();
      int id = 0;
      while(rs.next())
      {
          id=rs.getInt(1);
      }
      pstmt.close();
      String fileName = String.valueOf(id)+".jpg";
      String[] data=new String[14];
      int ct=0;
      while ( i.hasNext () ) 
      {
         FileItem fi = (FileItem)i.next();
         if ( !fi.isFormField () )	
         {            
            String fieldName = fi.getFieldName();          
            String contentType = fi.getContentType();
            boolean isInMemory = fi.isInMemory();
            long sizeInBytes = fi.getSize();           
            if( fileName.lastIndexOf("\\") >= 0 ){
               file = new File( filePath + 
               fileName.substring( fileName.lastIndexOf("\\"))) ;
            }else{
               file = new File( filePath + 
               fileName.substring(fileName.lastIndexOf("\\")+1)) ;            }
            fi.write( file ) ;
            out.println("Uploaded Image " + fileName + "<br>");
         }
         else
         {
             data[ct++]=fi.getString();             
         }
      }  
      pstmt=con.prepareStatement("select dbms_random.string(\'A\',10) from dual");
       rs=pstmt.executeQuery();
       String cnfcode = null;
      while(rs.next())
      {
          cnfcode=rs.getString(1);
      }  
      pstmt.close();
      pstmt=con.prepareCall("{ call addEmployee1(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
      pstmt.setInt(1, id);
      pstmt.setString(2, obj.md5("default"));
      if(data[5].equals("CE1"))
          pstmt.setInt(3,2);
      else
          if(data[5].equals("CE2"))
          pstmt.setInt(3,3);
      else
              if(data[5].equals("PQA"))
          pstmt.setInt(3,6);
      pstmt.setString(4,data[0]);
      pstmt.setString(5, data[1]);
      
      int yr=Integer.parseInt(data[4]);
      int mm=Integer.parseInt(data[3]);
      int dd=Integer.parseInt(data[2]);
      Calendar c=Calendar.getInstance();
        c.set(yr, mm-1, dd);
        java.sql.Date dt=new java.sql.Date(c.getTimeInMillis());
        pstmt.setDate(6, dt);              
      pstmt.setString(7,data[5]);
      pstmt.setString(8,data[6]);
      pstmt.setString(9,data[7]);
      pstmt.setString(10,data[8]);
      pstmt.setInt(11, Integer.parseInt(data[9]));
      pstmt.setLong(12, Long.parseLong(data[10]));
      pstmt.setString(13,data[11]);
      pstmt.setString(14,data[12]);
      pstmt.setInt(15,0);
      pstmt.execute(); 
      pstmt.close();
      pstmt=con.prepareStatement("insert into confirmation values(?,?) ");
      pstmt.setString(1,String.valueOf(id));
      pstmt.setString(2,cnfcode);
      pstmt.execute();
      
      sendMail obj1=new sendMail();
      String msgcontent="Please click on the link to verify the e-mail id http://localhost:7070/Squink/confirm.jsp?cnfcode="+cnfcode;
      obj1.send(msgcontent, data[11]);
      con.commit();
      con.close();
      out.println("Data Added Successfully");
      out.println("<a href=\"admin_home.jsp\">Go Back</a>");
      out.println("</body>");
      out.println("</html>");
   }catch(Exception ex) {
            try {
                con.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(UploadTest.class.getName()).log(Level.SEVERE, null, ex1);
            }
       out.println("Error");
       System.out.println(ex);
   }
   }  
}