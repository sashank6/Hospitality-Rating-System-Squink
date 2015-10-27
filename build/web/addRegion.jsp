<%-- 
    Document   : addRegion
    Created on : Feb 22, 2014, 3:15:26 PM
    Author     : Sashank
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String citycode=request.getParameter("citycode");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <link href="style1.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="jquery.js"></script>
        <script type="text/javascript">
            function addData()
            {
                var cityCode="<%=citycode%>";
                var area=document.getElementById("area").value;
                //alert(area);
                $.ajax({
                    type:"POST",
                    url:"addRegionCode",
                    dataType:"html",
                    async:false,
                    data:{ccode:cityCode,area:area},
                    success: function gft(data)
                    {
                        alert(data);
                    }
                    
                    
                    
                });
            }
            
            
        </script>
    </head>
    <body>
        <table border="1">
            <tr>
                <td>Area</td>
                <td>
            <input type="text" id="area"></td>
            </tr>
            <tr>
                <td colspan="2"><input type="button" value="Add" onclick="addData()"/></td>
            </tr>
        </table>
    </body>
</html>
