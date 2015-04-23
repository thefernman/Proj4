<%-- 
    Document   : courses_delete
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
            String description = request.getParameter( "description" );;

            try
            {
                level_ = session.getAttribute( "level" ).toString();
                //description = request.getParameter( "description" );
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
                    try
                    {
                        statement.executeUpdate( "DELETE FROM courses WHERE description = '" + description + "'" );
                        response.sendRedirect( "courses.jsp" );
                    }
                    catch(SQLException e)
                    {
                        out.println("<h3>Error</h3>");
                        out.println("Error perfroming deletion of " + description + "<br><br>" + e.getMessage() + "</h3>");
                        %><br><br><a href="faculties.jsp">Courses</a><%
                    }
                    
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
