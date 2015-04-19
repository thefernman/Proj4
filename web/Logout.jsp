<%-- 
    Document   : Logout
    Created on : Apr 17, 2015, 4:31:06 PM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
    </head>
    <body>
        <%
            session.removeAttribute( "username" );
            session.removeAttribute( "password" );
            session.invalidate();
        %>
        <h1>Logout was done successfully.</h1><br>
        <a href="Login.jsp">Login</a>
    </body>
</html>
