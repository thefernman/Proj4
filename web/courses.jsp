<%-- 
    Document   : courses
    Created on : Apr 17, 2015, 4:38:10 PM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Courses Table</title>
    </head>
    <body>
        <h2>Courses Table</h2>
        <%
            String level_ = session.getAttribute( "level" ).toString();
            Connection connection = null;
            Statement statement = null;
            ResultSet rs = null;

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
            }
            catch ( Exception e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }

            statement = connection.createStatement();

            if ( connection != null )
            {
                rs = statement.executeQuery( "SELECT course_id, description, courses.level, "
                        + "faculties.name, semester FROM courses, faculties "
                        + "WHERE instructor = faculty_id ORDER BY course_id" );
                out.println( "<table border=1>" );
                out.println( "<tr><td> course_id </td><td> description </td><td> level "
                        + "</td><td> instructor </td><td> semester </td></tr>" );
                while ( rs.next() )
                {
                    String course_id = rs.getString( "course_id" );
                    String description = rs.getString( "description" );
                    String level = rs.getString( "level" );
                    String instructor = rs.getString( "name" );
                    String semester = rs.getString( "semester" );
                    out.println( "<tr><td>" + course_id + "</td><td>" + description + "</td><td>"
                            + level + "</td><td>" + instructor + "</td><td>" + semester + "</td></tr>" );
                }
                if ( !( level_.equals( "student" ) ) )
                {
        %>
        <form action="courses_insert.jsp" method="post">
            <tr><td><input type="number" name="course_id" required></td>
                <td><input type="text" name="description" required></td>
                <td><select name="level" id>
                        <option selected>ugrad</option>
                        <option>grad</option>
                    </select></td>
                <td><select name="faculty_name">
                        <%
                            rs = statement.executeQuery( "SELECT name FROM faculties" );
                            //rs.first();
                            while ( rs.next() )
                            {
                        %>
                        <option><%= rs.getString( "name" )%></option>
                        <%
                            }
                        %>
                    </select></td>
                <td><input type="text" name="semester" required></td>
                    <%
                        out.println( "</table>" );
                    %>
            <br><input type="submit" value="Insert">
        </form>
        <%
            rs = statement.executeQuery( "SELECT description, course_id FROM courses" );
            //rs.first();
        %>

        <h3>Delete Course</h3>
        <form action="courses_delete.jsp" method="post">
            <select name="description">
                <%  while ( rs.next() )
                    {%>
                <option><%= rs.getString( "description" )%></option>
                <% } %>
            </select>
            <br><br><input type="submit" value="Delete">
        </form>    
        <%
                }
                else
                    out.println( "</table>" );
            }
            connection.close();
        %>

        <br><br><a href="Home.jsp">Home</a>
    </body>
</html>
