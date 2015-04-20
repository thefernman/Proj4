<%-- 
    Document   : students_delete
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
            String level_ = null;
            String name = null;

            try
            {
                level_ = session.getAttribute( "level" ).toString();
                name = request.getParameter( "student_name" );
            }
            catch ( NullPointerException e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }
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
                        "jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/"
                                + "spr15_fcamp001?user=spr15_fcamp001&password=1299228" );
                statement = connection.createStatement();
            }
            catch ( Exception e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }
            
            if ( connection != null )
                if ( !( level_.equals( "student" ) ) )
                {
                    statement.executeUpdate( "DELETE FROM students WHERE student_id = "
                    + "(SELECT student_id FROM students WHERE name = '" + name + "')" );
                    response.sendRedirect( "students.jsp" );
                }
                else
                {
                    out.println( "No Access" );
                    response.sendRedirect( "No_Access.jsp" );
                }
            else
            {
                out.println( "Error" );
                response.sendRedirect( "Error.jsp" );
            }


        %>
    </body>
</html>
