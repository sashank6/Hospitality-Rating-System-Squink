/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Sashank
 */
import java.util.Calendar;
public class NewMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Calendar c=Calendar.getInstance();
        c.set(1900, 1, 1);
        System.out.println(c.getTimeInMillis());
    }
}
