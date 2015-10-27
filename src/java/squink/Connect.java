package squink;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Sashank
 * 
 */
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
public class Connect
{
    public Connection conect() throws SQLException
    {
        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
        Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","kloser");
return con;
    }
    public  String md5(String input) {
         
        String md5 = null;
         
        if(null == input) return null;
         
        try {
             
        //Create MessageDigest object for MD5
        MessageDigest digest = MessageDigest.getInstance("MD5");
         
        //Update input string in message digest
        digest.update(input.getBytes(), 0, input.length());
 
        //Converts message digest value in base 16 (hex) 
        md5 = new BigInteger(1, digest.digest()).toString(16);
 
        } catch (NoSuchAlgorithmException e) {
 
            e.printStackTrace();
        }
        return md5;
    }
        public  double haversine(double lat1, double lon1, double lat2, double lon2) {
        double R = 6372.8;
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        lat1 = Math.toRadians(lat1);
        lat2 = Math.toRadians(lat2);
 
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2);
        double c = 2 * Math.asin(Math.sqrt(a));
        return Math.ceil(R * c);
    }
    
}
