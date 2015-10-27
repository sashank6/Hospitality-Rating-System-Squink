<%-- 
    Document   : userRegistration
    Created on : Feb 28, 2014, 9:19:59 AM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Registration</title>
        <link href="style1.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function addData()
            {
                
                var usr=document.getElementById("username").value;;
                var pass=document.getElementById("pass").value;
                var email=document.getElementById("email").value;
                var phno=document.getElementById("phno").value;
                
                $.ajax({
                    type:"POST",
                    dataType:"html",
                    url:"addUser",
                    async:true,
                    data:{username:usr,pass:pass,email:email,phno:phno},
                    success: function calla(data)
                    {
                        alert(data);
                    }
                    
                    
                });
                
            }
        </script>
    </head>
    <body>
        <table>
            <tr>
                <td>Username</td>
                <td><input type="text" id="username"/></td>
                    
            </tr>
            <tr>
                <td>Password</td>
                <td><input type="password" id="pass"/></td>
            </tr>
            <tr>
                <td>Confirm Password</td>
                <td><input type="password" id="cnfpass"/></td>
            </tr>
            <tr>
                <td>e-mail</td>
                <td><input type="text" id="email"/></td>
            </tr>
             <tr>
                <td>Phone Number</td>
                <td><input type="text" id="phno"/></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="button" value="Register" onclick="addData()"/></td>
            </tr>
            
        </table>
        <span id="msg"></span>
    </body>
</html>
