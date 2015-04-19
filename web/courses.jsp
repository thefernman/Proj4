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
            String username = session.getAttribute( "username" ).toString();
            String password = session.getAttribute( "password" ).toString();
            String db_name = session.getAttribute( "db_name" ).toString();
            Connection connection = null;
            Statement statement = null;
            Statement statement_instr = null;
            ResultSet rs = null;
            ResultSet instr = null;

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
                        "jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/spr15_" + db_name,
                        "spr15_" + username, password );

                statement = connection.createStatement();
                statement_instr = connection.createStatement();

                rs = statement.executeQuery( "SELECT * FROM courses" );
                instr = statement_instr.executeQuery( "SELECT * FROM faculties" );//for drop down instructors
                out.println( "<table border=1>" );
                out.println( "<tr><td> course_id </td><td> description </td><td> level </td><td> instructor </td></tr>" );
                while ( rs.next() )
                {
                    String course_id = rs.getString( "course_id" );
                    String description = rs.getString( "description" );
                    String level = rs.getString( "level" );
                    String instructor = rs.getString( "instructor" );
                    out.println( "<tr><td>" + course_id + "</td><td>" + description + "</td><td>" + level + "</td><td>" + instructor + "</td></tr>" );
                }
                out.println( "</table>" );
            }
            catch ( Exception e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }
        %>

        <h3>Insert New Course</h3>
        <form action="courses_insert.jsp" method="post">
            Course ID:<br><input type="number" name="course_id" required>
            <br/>Description:<br><input type="text" name="description" required>
            <br/>Level:<br>
            <select name="level" id>
                <option selected>ugrad</option>
                <option>grad</option>
            </select>
            <br/>Instructor:<br>
            <select name="faculty_name">
                <% while ( instr.next() )
                    {%>
                <option><%= instr.getString( "name" )%></option>
                <% } %>
            </select>
            <br><br><input type="submit" value="Insert">
        </form>
        <%
            rs = statement.executeQuery( "SELECT * FROM courses" );
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
            connection.close();
        %>

        <br><br><a href="Home.jsp">Home</a>
    </body>
</html>
