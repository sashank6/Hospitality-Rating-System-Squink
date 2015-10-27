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
import javax.servlet.http.*;

/**
 *
 * @author Sashank
 */
public class setLocation extends HttpServlet
{

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    protected void doPost(HttpServletRequest rq,HttpServletResponse res) throws IOException
    {
        String cityname=rq.getParameter("cityname");
        String lat=rq.getParameter("lat");
          String lon=rq.getParameter("lon");
            String ctry=rq.getParameter("ctry");
          HttpSession ses=rq.getSession();
          ses.setAttribute("cityname", cityname);
          ses.setAttribute("lat", lat);
          ses.setAttribute("lon", lon);
          ses.setAttribute("ctry", ctry);
          PrintWriter pw=res.getWriter();
          pw.println("Cool");
          
          
        
    }
    
}