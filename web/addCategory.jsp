<%-- 
    Document   : addCategory
    Created on : Feb 26, 2014, 10:02:22 PM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <link href="style1.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function func2()
            {
                var catname=document.getElementById("catname").value;
                $.ajax({
                    type:"POST",
                    dataType:"html",
                    url:"addCat",
                    data:{catname:catname},
                    async:false,
                    success: function cool(data)
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
                <td>Category Name</td>
                <td><input type="text" id="catname"/></td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="button" value="Add Category" onclick="func2()"/></td>
            </tr>
        </table>
    </body>
</html>
