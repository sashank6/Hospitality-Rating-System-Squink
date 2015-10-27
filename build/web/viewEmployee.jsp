<%-- 
    Document   : viewEmployee
    Created on : Feb 11, 2014, 11:17:00 AM
    Author     : Sashank
--%>

<%@page import="squink.Connect"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try
  {
    String type=(String)session.getAttribute("usertype");
    if(Integer.parseInt(type)==4||Integer.parseInt(type)==5)
        response.sendRedirect("LoginPage.jsp");
}
catch(Exception e)
               {
    response.sendRedirect("LoginPage.jsp");
    
}
%>

<%
String id=request.getParameter("id");        
%>
<!DOCTYPE html>
<html>
<head>
    <link href="style1.css" rel="stylesheet" type="text/css"/>
    <style>

</style>
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript">
    function showicon()
    {
        document.getElementById("icon").innerHTML="<input type=button value=save onclick=getData() /><input type=button value=undo onclick=undore() />";
    }
    function undore()
    {
        location.reload();
    }
    var t=false;
    function displaydept()
    {
        if(!t)
            {
        var ty=document.getElementById("dept");
        ty.innerHTML="";
        var se=document.createElement("select");
        var o=document.createElement("option");
        o.text="CE1";
        var o1=document.createElement("option");
        o1.text="CE2";
        var o2=document.createElement("option");
        o2.text="PQA";
        se.appendChild(o);
        se.appendChild(o1);
        se.appendChild(o2);
        se.setAttribute("id", "dfg");
        
        ty.appendChild(se);
        t=true;
            }
    }
    function getData()
    {
        var id="<%=id%>";
        var fname=document.getElementById("fname").innerHTML;
        var lname=document.getElementById("lname").innerHTML;
        var dob=document.getElementById("dob").innerHTML;
        var dfgg;
        if(t)
            {
        var dept=document.getElementById("dfg");
        dfgg=dept.options[dept.selectedIndex].value;
            }
            else
                {
                dfgg=document.getElementById("dept").innerHTML;
                }
        var adr=document.getElementById("address").innerHTML;
        var cty=document.getElementById("city").innerHTML;
        var ctry=document.getElementById("country").innerHTML;
        var rtg=document.getElementById("rating").innerHTML;
        var phno=document.getElementById("phno").innerHTML;
        var email=document.getElementById("email").innerHTML;
        var ssn=document.getElementById("ssn").innerHTML;
      
      //  alert(fname+" "+lname+" "+dob+" "+dfgg+" "+adr+" "+cty+" "+ctry+" "+rtg+" "+phno+" "+email+" "+ssn);
    
$.ajax({
    type:"POST",
    url:"updateEmpData",
    dataType:"html",
    async:false,
    data:{id:id,fname:fname,lname:lname,dob:dob,dept:dfgg,adr:adr,city:cty,ctry:ctry,rating:rtg,phno:phno,email:email,ssn:ssn},
    success: function fgh(data)
    {
        alert(data);
    }
    
}



);
location.reload();
}
</script>
</head>

<body>
    <table border="1" style="width:200px" onclick="showicon()" >
    <%
out.println("<tr><td><img src=\"images\\"+id+".jpg\""+ "height=\"200\" width=\"200\"></td></tr>");
Connect obj=new Connect();
try
               {
Connection con=obj.conect();
PreparedStatement pstmt=con.prepareStatement("select *from employeeDB where id=?");
pstmt.setInt(1, Integer.parseInt(id));
ResultSet rs=pstmt.executeQuery();
while(rs.next())
       {
        %>
        <tr>
            <td>Employee ID</td>
            <td><%=id%></td>
        </tr>
<tr>
    <td>First name:</td>
    <td contenteditable="true" id="fname"><% out.print(rs.getString(2)); %></td>
</tr>
<tr><td>Last name:</td>
    <td contenteditable="true" id="lname"><% out.print(rs.getString(3)); %></td></tr>
<tr><td>Date of Birth:</td>
    <td contenteditable="true" id="dob"><% out.print(rs.getDate(4)); %></td>

</tr>
<tr><td>Department:</td>
    <td contenteditable="true" onclick="displaydept()" id="dept"><% out.print(rs.getString(5)); %></td>
</tr>
<tr><td>Address:</td>
    <td contenteditable="true" id="address"><% out.print(rs.getString(6)); %></td>
</tr>
<tr><td>City:</td>
    <td contenteditable="true" id="city"><% out.print(rs.getString(7)); %></td>
</tr>
<tr><td>Country:</td>
    <td contenteditable="true" id="country"><% out.print(rs.getString(8)); %></td>
</tr>
<tr><td>Rating:</td>
    <td contenteditable="true" id="rating"><% out.print(rs.getInt(9)); %></td>
</tr>
<tr><td>Phone no:</td>
    <td contenteditable="true" id="phno"><% out.print(rs.getLong(10)); %></td>
</tr>
<tr><td>Emailid:</td>
    <td contenteditable="true" id="email"><% out.print(rs.getString(11)); %></td>
</tr>
<tr>
    <td>SSN\PAN:</td>
    <td contenteditable="true" id="ssn"><% out.print(rs.getString(12)); %></td>
</tr>
<%
}
}
catch(Exception e)
               {}
%>
</table>
<span id="icon"></span>
</body>
</html>