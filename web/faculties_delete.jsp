<%-- 
    Document   : faculties_delete
    Created on : Apr 17, 2015, 4:34:06 PM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            Connection connection = null;
            Statement statement = null;

            String username = session.getAttribute( "username" ).toString();
            String password = session.getAttribute( "password" ).toString();
            String db_name = session.getAttribute( "db_name" ).toString();
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
                connection = DriverManager.getConnection(
                        "jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/spr15_" + db_name,
                        "spr15_" + username, password );
                statement = connection.createStatement();
            }
            catch ( Exception e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }
            try
            {
                String name = request.getParameter( "faculty_name" );
                statement.executeUpdate( "DELETE FROM faculties WHERE faculty_id = (SELECT faculty_id FROM faculties WHERE name = '" + name + "')" );
                if ( connection != null )
                    response.sendRedirect( "faculties.jsp" );
            }
            catch ( Exception e )
            {
                out.println( "<h3>exception: " + e + e.getMessage() + "</h3>" );
            }
//            else
//            {
//                out.println( "Error" );
//                response.sendRedirect( "Error.jsp" );
//            }


        %>
    </body>
</html>
