<%-- 
    Document   : enroll_insert
    Created on : Apr 19, 2015, 7:23:27 PM
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
                if ( !( level_.equals( "student" ) ) )
                {
                    String student_name = request.getParameter( "student_name" );
                    rs = statement.executeQuery( "SELECT * FROM students WHERE name = '"
                            + student_name + "'" );
                    rs.next();
                    int student_id = rs.getInt( "student_id" );

                    String course_description = request.getParameter( "course_description" );
                    rs = statement.executeQuery( "SELECT * FROM courses WHERE description = '"
                            + course_description + "'" );
                    rs.next();
                    int course_id = rs.getInt( "course_id" );
                    String grade = request.getParameter( "grade" );
                    
                    statement.executeUpdate( "INSERT INTO enroll "
                            + "VALUES (" + student_id + ", " + course_id + ", '"
                            + grade + "')" );

                    response.sendRedirect( "enroll.jsp" );
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
