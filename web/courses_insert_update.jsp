<%-- 
    Document   : courses_insert_update
    Created on : Apr 22, 2015, 10:56:26 AM
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
                    int course_id = Integer.parseInt( request.getParameter( "course_id" ) );
                    String description = request.getParameter( "description" );
                    String level = request.getParameter( "level" );
                    String semester = request.getParameter( "semester" );
                    
                    String faculty_name = request.getParameter( "faculty_name" );
                    rs = statement.executeQuery( "SELECT faculty_id FROM faculties WHERE name = '" 
                            + faculty_name + "'" );
                    rs.next();
                    int faculty_id = rs.getInt( "faculty_id" );
                    
                    try
                    {                        
                        int nu = statement.executeUpdate( "UPDATE courses SET description = '" + description 
                            + "', level = '" 
                            + level + "', semester = '" + semester + "', instructor = " 
                            + faculty_id + " WHERE course_id = " + course_id + "" );
                        
                        if(nu == 0)
                        {
                            out.println("<h3>Error</h3>");
                        out.println("Error perfroming update of " + description + "<br><br>Cannot change Course ID");
                        %><br><br><a href="courses.jsp">Courses</a><%
                        }
                        else
                            response.sendRedirect( "courses.jsp" );
                    }
                    catch(SQLException e)
                    {
                        out.println("<h3>Error</h3>");
                        out.println("Error perfroming update of " + description + "<br><br>" + e.getMessage() + "</h3>");
                        %><br><br><a href="courses.jsp">Courses</a><%
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
