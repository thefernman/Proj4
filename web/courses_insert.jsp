<%-- 
    Document   : courses_insert
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
            ResultSet rs = null;

            String level_ = session.getAttribute( "level" ).toString();

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
            {
                if ( !( level_.equals( "student" ) ) )
                {
                    int course_id = Integer.parseInt( request.getParameter( "course_id" ) );
                    String description = request.getParameter( "description" );
                    String level = request.getParameter( "level" );
                    String semester = request.getParameter( "semester" );
                    
                    String faculty_name = request.getParameter( "faculty_name" );
                    rs = statement.executeQuery( "SELECT faculty_id FROM faculties WHERE name = '" 
                            + faculty_name + "'" );
                    rs.next();
                    int faculty_id = rs.getInt( "faculty_id" );
                    
                    statement.executeUpdate( "INSERT INTO courses "
                            + "VALUES (" + course_id + ", '" + description + "', '" 
                            + level + "', " + faculty_id + ", '"+ semester +"')" );

                    response.sendRedirect( "courses.jsp" );
                }
                else
                {
                    out.println( "No Access" );
                    response.sendRedirect( "No_Access.jsp" );
                }
            }
            else
            {
                out.println( "Error" );
                response.sendRedirect( "Error.jsp" );
            }


        %>
    </body>
</html>
