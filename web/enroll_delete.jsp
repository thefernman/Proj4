<%-- 
    Document   : enroll_delete
    Created on : Apr 19, 2015, 7:23:42 PM
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

            String level_ = null;
            String enrollment = null;

            try
            {
                level_ = session.getAttribute( "level" ).toString();
                enrollment = request.getParameter( "enrollment" );
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
            {
                if ( !( level_.equals( "student" ) ) )
                {
                    String description = enrollment.substring( enrollment.indexOf( ":")+2 );
                    String name = enrollment.substring( 0, enrollment.indexOf( ":")-1 );
                    
                    rs = statement.executeQuery( "SELECT enroll.student_id, "
                            + "enroll.course_id, enroll.grade, students.name, "
                            + "courses.description FROM enroll, students, courses "
                            + "WHERE enroll.student_id = students.student_id and "
                            + "enroll.course_id = courses.course_id and students.name = '" 
                            + name + "' and courses.description = '" + description + "'" );
                    
                    rs.next();
                    int student_id = rs.getInt( "student_id" );
                    int course_id = rs.getInt( "course_id");
                    
                    try
                    {                        
                        statement.executeUpdate( "DELETE FROM enroll WHERE student_id = " 
                                + student_id + " and course_id = " + course_id + "" );
                        response.sendRedirect( "enroll.jsp" );
                    }
                    catch(SQLException e)
                    {
                        out.println("<h3>Error</h3>");
                        out.println("Error perfroming delete of enrollment of " 
                                + name + " for "+ description 
                                + "<br><br>" + e.getMessage() + "</h3>");
                        %><br><br><a href="enroll.jsp">Enroll</a><%
                    }
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
