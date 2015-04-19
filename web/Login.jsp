<%-- 
    Document   : index
    Created on : Apr 17, 2015, 4:00:57 PM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <h1>COP-4710 Database Login</h1>
        <form action="LoginCheck.jsp" method="post">
            <br/>Username:<br><input type="text" name="username">
            <br/>Password:<br><input type="password" name="password">
            <br/><br><input type="submit" value="Submit">
        </form>	
    </body>
</html>
