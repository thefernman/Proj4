<%-- 
    Document   : LoginCheck
    Created on : Apr 17, 2015, 4:02:43 PM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import = "java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            Connection connection = null;

            String username = request.getParameter( "username" );
            String password = request.getParameter( "password" );

            try
            {
                Class.forName( "org.postgresql.Driver" );
            }
            catch ( ClassNotFoundException e )
            {
                out.println( "<h1>Driver not found:" + e + e.getMessage() + "</h1>" );
            }
            try
            {
                connection = DriverManager.getConnection( "jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/spr15_fcamp001?user=spr15_fcamp001&password=1299228" );
            }
            catch ( Exception e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }

            if ( connection != null )
            {
                session.setAttribute( "username", username );
                session.setAttribute( "password", password );
                response.sendRedirect( "Home.jsp" );
            }
            else
                response.sendRedirect( "Error.jsp" );
        %>
    </body>
</html>
