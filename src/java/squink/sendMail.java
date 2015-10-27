/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package squink;

import java.security.Security;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Sashank
 */
public class sendMail
{
    static String SmtpServer = "smtp.gmail.com";
	
	 static String Subject = "Verification Mail";
	 static String mailFrom= "squink007@gmail.com";

	 
    public void send(String content,String sendTo) throws MessagingException
    {
        String[] recip=new String[1];
        recip[0]=sendTo;
        Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
		sendSSLMessage(recip, Subject,content , mailFrom);
		System.out.println("Sucessfully Sent");
        
    }
    public void sendSSLMessage(String recipients[], String subject,String message, String from) throws MessagingException 
	{
		boolean debug = false;
		Properties props = new Properties();
		props.put("mail.smtp.host",  SmtpServer);
		props.put("mail.smtp.auth", "true");
		props.put("mail.debug", "true");
		props.put("mail.smtp.port","587"); 
		Session session = Session.getInstance(props, new javax.mail.Authenticator() 
		{
			protected PasswordAuthentication getPasswordAuthentication()
			{
return new PasswordAuthentication("squink007@gmail.com", "curator007");
			}
		});

		session.setDebug(debug);
		Message msg = new MimeMessage(session);
		InternetAddress addressFrom = new InternetAddress(from);
		msg.setFrom(addressFrom);
		InternetAddress[] addressTo = new InternetAddress[recipients.length];
		for (int i = 0; i < recipients.length; i++) 
		{
			addressTo[i] = new InternetAddress(recipients[i]);
		}
		msg.setRecipients(Message.RecipientType.TO, addressTo);
		// Setting the Subject and Content Type
		msg.setSubject(subject);
		msg.setContent(message, "text/plain");
		Transport.send(msg);
	}
}
