<%-- 
    Document   : enroll_insert_update
    Created on : Apr 23, 2015, 5:27:48 AM
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
                    String name = request.getParameter( "name" );
                    String description = request.getParameter( "description" );
                    String grade = request.getParameter( "grade" );
                    
                    rs = statement.executeQuery( "SELECT students.student_id, courses.course_id "
                            + "FROM students, courses WHERE students.name = '" 
                            + name + "' and description = '" + description + "'");
                    
                    rs.next();
                    int student_id = rs.getInt( "student_id" );
                    int course_id = rs.getInt( "course_id");
                    
                    try
                    {                        
                        int nu = statement.executeUpdate( "UPDATE enroll SET student_id = " + student_id 
                            + ", course_id = " 
                            + course_id + ", grade = '" + grade + "' WHERE student_id = " 
                            + student_id + " and course_id = " + course_id + "" );
                        
                        if(nu == 0)
                        {
                            out.println("<h3>Error</h3>");
                        out.println("Error perfroming update of enrollment of " 
                                + name + " for course "+ description 
                                + "<br><br>Cannot change Student Name and/or Course. Only change the grade");
                        %><br><br><a href="enroll.jsp">Enroll</a><%
                        }
                        else
                            response.sendRedirect( "enroll.jsp" );
                    }
                    catch(SQLException e)
                    {
                        out.println("<h3>Error</h3>");
                        out.println("Error perfroming update of enrollment of " 
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
