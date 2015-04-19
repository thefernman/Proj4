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
            Statement statement = null;
            ResultSet rs = null;

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
                statement = connection.createStatement();

                rs = statement.executeQuery( "SELECT * FROM login WHERE email = '" + username + "' AND password = '" + password + "'" );
                if ( rs.next() )
                {
                    session.setAttribute( "username", rs.getString( "email" ) );
                    session.setAttribute( "name", rs.getString( "name" ) );
                    session.setAttribute( "level", rs.getString( "level" ) );                    
                    response.sendRedirect( "Home.jsp" );
                }
                else
                response.sendRedirect( "Error.jsp" );
            }
            else
                response.sendRedirect( "Error.jsp" );
        %>
    </body>
</html>
