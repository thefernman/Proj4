<%-- 
    Document   : enroll
    Created on : Apr 17, 2015, 4:36:50 PM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Enroll Table</title>
    </head>
    <body>
        <h2>Enroll Table</h2>
        <%
            String name_ = null;
            String level_ = null;
            Connection connection = null;
            Statement statement = null;
            ResultSet rs = null;

            try
            {
                name_ = session.getAttribute( "name" ).toString();
                level_ = session.getAttribute( "level" ).toString();
            }
            catch ( NullPointerException e )
            {

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
                    rs = statement.executeQuery( "SELECT enroll.student_id, "
                            + "enroll.course_id, enroll.grade, students.name, "
                            + "courses.description FROM enroll, students, courses "
                            + "WHERE enroll.student_id = students.student_id and "
                            + "enroll.course_id = courses.course_id" );
                    out.println( "<table border=1>" );
                    out.println( "<tr><td> Student Name </td><td> Course Desription </td><td> grade </td></tr>" );
                    while ( rs.next() )
                    {
                        String student_name = rs.getString( "name" );
                        String course_description = rs.getString( "description" );
                        String grade = rs.getString( "grade" );
                        out.println( "<tr><td>" + student_name + "</td><td>" + course_description + "</td><td>" + grade + "</td></tr>" );
                    }

        %>
        <form action="enroll_insert.jsp" method="post">
            <tr><td><select name="student_name" required>
                        <option selected disabled hidden value=''></option>
                        <%                            //rs.first();
                            rs = statement.executeQuery( "SELECT name FROM students" );
                            while ( rs.next() )
                            {%>
                        <option><%= rs.getString( "name" )%></option>
                        <% } %>
                    </select></td>
                <td><select name="course_description" required>
                        <option selected disabled hidden value=''></option>
                        <%
                            //rs.first();
                            rs = statement.executeQuery( "SELECT description FROM courses" );
                            while ( rs.next() )
                            {%>
                        <option><%= rs.getString( "description" )%></option>
                        <% } %>
                    </select></td>
                <td><select name="grade" required>
                        <option selected disabled hidden value=''></option>
                        <option>A</option>
                        <option>B</option>
                        <option>C</option>
                        <option>D</option>
                        <option>F</option>
                    </select></td>
                    <%
                        out.println( "</table>" );
                    %>
            <br><input type="submit" value="Insert">
        </form>
        <%
        }
        else
        {

            rs = statement.executeQuery( "SELECT enroll.student_id, "
                    + "enroll.course_id, enroll.grade, students.name, "
                    + "courses.description FROM enroll, students, courses "
                    + "WHERE enroll.student_id = students.student_id and "
                    + "enroll.course_id = courses.course_id and students.name = '" + name_ + "'" );
            out.println( "<table border=1>" );
            out.println( "<tr><td> Student Name </td><td> Course Desription </td><td> grade </td></tr>" );
            while ( rs.next() )
            {
                String student_name = rs.getString( "name" );
                String course_description = rs.getString( "description" );
                String grade = rs.getString( "grade" );
                out.println( "<tr><td>" + student_name + "</td><td>" + course_description + "</td><td>" + grade + "</td></tr>" );
            }

        %>
        <form action="students_insert.jsp" method="post">
            <tr><td><%= name_%></td>
                <td><select name="course_description" required>
                        <option selected disabled hidden value=''></option>
                        <%
                            rs = statement.executeQuery( "SELECT description FROM courses" );
                            while ( rs.next() )
                            {%>
                        <option><%= rs.getString( "description" )%></option>
                        <% } %>
                    </select></td>
                <td>
                    <%
                        out.println( "</table>" );
                    %>
                    <br><input type="submit" value="Insert">
        </form>
        <%
                }

            connection.close();
        %>
        <br><br><a href="Home.jsp">Home</a>

    </body>
</html>
