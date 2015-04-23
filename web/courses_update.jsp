<%-- 
    Document   : courses_update
    Created on : Apr 22, 2015, 10:25:49 AM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Course Update</title>
    </head>
    <body>
        <%
            Connection connection = null;
            Statement statement = null;
            ResultSet rs = null;

            String level_ = null;
            String description_ = null;

            try
            {
                level_ = session.getAttribute( "level" ).toString();
                description_ = request.getParameter( "description" );
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
                    rs = statement.executeQuery( "SELECT courses.course_id, courses.description, courses.level, "
                        + "faculties.name, courses.semester FROM courses, faculties "
                        + "WHERE courses.instructor = faculties.faculty_id AND courses.description = '" + description_ + "' ORDER BY courses.course_id" );
                    rs.next();
                    String course_id = rs.getString( "course_id" );
                    String description = rs.getString( "description" );
                    String level = rs.getString( "level" );
                    String instructor = rs.getString( "name" );
                    String semester = rs.getString( "semester" );
                    
                    rs = statement.executeQuery( "SELECT * FROM faculties" );
                    %>
                    <h3>Update Course</h>
                    <table border=1>
                        <tr><td> Course ID </td><td> Description </td><td> Level </td><td> Instructor </td><td> Semester </td></tr>
                    <form action="courses_insert_update.jsp" method="post">
                        <tr><td><input type="text" name="course_id" readonly c:out value="<%=course_id%>" </td>
            <td><input type="text" name="description" c:out value="<%=description%>" required></td>
                <td><select name="level">
                    <option selected><%=level%></option>
                    <%
                    if( level.equals( "ugrad" ) )
                    {
                        out.println("<option>grad</option>");
                    }
                    else
                        out.println("<option>ugrad</option>");
                    %>
                    </select></td>
                    <td><select name="faculty_name">
                <option selected><%=instructor%></option>
                <%while ( rs.next() )
                    {
                        String name = rs.getString( "name" );
                        if(!(name.equals( instructor ))){
                        %>
                        <option><%= rs.getString( "name" )%></option>
                        <% }} %>
            </select></td>
                <td><input type="text" name="semester" c:out value="<%=semester%>" required></td>
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
        
        <br><br><a href="courses.jsp">Courses</a>
    </body>
</html>
