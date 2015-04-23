<%-- 
    Document   : enroll_update
    Created on : Apr 23, 2015, 5:00:02 AM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Enroll Update</title>
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
                if ( !( level_.equals( "student" ) ) )
                {
                    String className = enrollment.substring( enrollment.indexOf( ":")+2 );
                    String name_ = enrollment.substring( 0, enrollment.indexOf( ":")-1 );
                    
                    rs = statement.executeQuery( "SELECT enroll.student_id, "
                            + "enroll.course_id, enroll.grade, students.name, "
                            + "courses.description FROM enroll, students, courses "
                            + "WHERE enroll.student_id = students.student_id and "
                            + "enroll.course_id = courses.course_id and students.name = '" 
                            + name_ + "' and courses.description = '" + className + "'" );
                    
                    rs.next();
                    String course_id = rs.getString( "course_id" );
                    String student_id = rs.getString( "student_id" );
                    String grade = rs.getString( "grade" );
                    String name = rs.getString( "name" );
                    String description = rs.getString( "description" );
                    
//                    rs = statement.executeQuery( "SELECT enroll.student_id, "
//                            + "enroll.course_id, enroll.grade, students.name, "
//                            + "courses.description FROM enroll, students, courses "
//                            + "WHERE enroll.student_id = students.student_id and "
//                            + "enroll.course_id = courses.course_id" );
                    
                    %>
                    <h3>Update Enroll</h>
                    <table border=1>
                        <tr><td> Student Name </td><td> Description </td><td> Grade </td></tr>
                    <form action="enroll_insert_update.jsp" method="post">
                        <tr><td><input type="text" name="name" readonly c:out value="<%=name%>" </td>
                            <td><input type="text" name="description" readonly c:out value="<%=description%>" required></td>
                <td><select name="grade">
                    <option selected><%=grade%></option>
                    <option>A</option>
                    <option>B</option>
                    <option>C</option>
                    <option>D</option>
                    <option>F</option>
                    </select></td>
                    </table>
            <br><input type="submit" value="Update">
        </form>
        </table>
                    <%
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
        
        <br><br><a href="enroll.jsp">Enroll</a>
    </body>
    </body>
</html>
