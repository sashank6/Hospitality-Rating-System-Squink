<!--
To change this template, choose Tools | Templates
and open the template in the editor.
-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
try
  {
    String type=(String)session.getAttribute("usertype");
    if(Integer.parseInt(type)!=1)
        response.sendRedirect("LoginPage.jsp");
       
}
catch(Exception e)
               {
    response.sendRedirect("LoginPage.jsp");
}
%>
<!DOCTYPE html>
<html>
<head>
     <link href="style1.css" rel="stylesheet" type="text/css"/>
<title>Add Employee</title>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
    function datav(a)
    {
        var data;
        if(a==1)
            {
                data=document.getElementById("phno").value;
                $.ajax({
                                    type:"POST",
                                    async:true,
                                    url:"DynVal1",
                                    data:{type:a,data:data},
                                    dataType:"html",
                                    success: function(data) {
                                                 var t=parseInt(data);
                                                 if(t==0)
                                                     document.getElementById("vdfcheck").innerHTML="Valid Phone Number";
                                                 else
                                                      document.getElementById("vdfcheck").innerHTML="Phonenumber already exists";
                                                     
                       }
                });
            }
            if(a==2)
            {
                data=document.getElementById("email").value;
                $.ajax({
                                    type:"POST",
                                    async:true,
                                    url:"DynVal1",
                                    data:{type:a,data:data},
                                    dataType:"html",
                                    success: function(data) {
                                                 var t=parseInt(data);
                                                 if(t==0)
                                                     document.getElementById("vdf1").innerHTML="Valid e-mail id";
                                                 else
                                                      document.getElementById("vdf1").innerHTML="e-mail id already exists";
                                                     
                                                                    }
                                                                
                                    
            
                                     });
                                    
            }
    
    }
</script>
</head>
<body>
<form action="UploadTest" method="post"
                        enctype="multipart/form-data">
 <table border="1">
            <tr>
                <td>First Name:</td>
                <td><input type="text" name="fname"/></td>
            </tr>
            <tr>
                <td>Last Name:</td>
                <td><input type="text" name="lname"/></td>
            </tr>
            <tr>
                <td>Date of Birth</td>
                <td><select name="date">
                        <%
                        for(int i=1;i<32;i++)
                            out.println("<option>"+i+"</option>");
                        %>
                        
                    </select>
                        <select name="month">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                            <option>6</option>
                            <option>7</option>
                            <option>8</option>
                            <option>9</option>
                            <option>10</option>
                            <option>11</option>
                            <option>12</option>
                        </select>
                        <select name="year">
                            <% 
                            GregorianCalendar obj=new GregorianCalendar();
                            int year=obj.get(Calendar.YEAR);
                            for(int i=1900;i<=year;i++)
                                out.println("<option>"+i+"</option>");
                            
                            
                            %>
                        </select>
            </tr>
            <tr>
                <td>Department</td>
                <td><select name="dept">
                        <option>CE1</option>
                        <option>CE2</option>
                        <option>PQA</option>
                    </select>
                </td>
                    
            <tr>
                    <td>Address</td>
                    <td> <textarea rows="4" cols="20" name="address"> </textarea></td>
            </tr>
            <tr>
                <td>
                    City:</td>
                <td><input type="text" name="city">
                </td>
            </tr>       
            <tr>
                <td>Country</td>
                <td><input type="text" name="country"> </td>
            </tr>
            <tr>
                <td>Rating</td>
                <td><input type="text" name="rating"/></td>
            </tr>
            <tr>
                <td>Phone no</td>
                <td><input type="text" name="Phno" id="phno" onblur="datav(1)"> </td>
                <td id="vdfcheck"></td>
            </tr>
            <tr>
                <td>Emailid</td>
                <td>
                    <input type="text" name="Email" id="email" onblur="datav(2)"> </td>
                <td id="vdf1"></td>
            </tr>
            <tr>
                <td> SSN\PAN </td>
                <td> <input type="text" name="SSN"> </td>
                
            </tr>
            <tr>
                <td>Employee Image</td>
                <td><input type="file" name="file"/></td>
            </tr>
                
        </table>
                        <input type="submit" value="submit"/>
</form>
</body>
</html>