<%-- 
    Document   : search
    Created on : Apr 20, 2015, 12:34:18 AM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Results</title>
    </head>
    <body>
        <%
            Connection connection = null;
            Statement statement = null;
            ResultSet rs = null;

            String level_ = null;
            String search_type = null;
            String toSearchFor = null;

            try
            {
                level_ = session.getAttribute( "level" ).toString();
                search_type = request.getParameter( "search_type" ).toString();
                toSearchFor = request.getParameter( "toSearchFor" ).toString();
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
                    if ( search_type.equals( "Student" ) )//Search for students
                    {
                        rs = statement.executeQuery( "SELECT * FROM students WHERE name ILIKE '%" + toSearchFor + "%'" );
                        if ( rs.isBeforeFirst() )
                        {
                            out.println( "<h3>Students</h3>" );
                            rs = statement.executeQuery( "select column_name from "
                                    + "information_schema.columns where table_name = 'students'" );

                            out.println( "<table border=1>" );
                            out.println( "<tr>" );
                            while ( rs.next() )
                            {
                                out.println( "<td>" + rs.getString( "column_name" ) + "</td>" );
                            }
                            out.println( "</tr>" );
                            rs = statement.executeQuery( "SELECT * FROM students WHERE name ILIKE '%" + toSearchFor + "%'" );

                            while ( rs.next() )
                            {
                                out.println( "<tr><td>" + rs.getInt( "student_id" ) + "</td><td>" + rs.getString( "name" )
                                        + "</td><td>" + rs.getString( "date_of_birth" ) + "</td><td>" + rs.getString( "address" )
                                        + "</td><td>" + rs.getString( "email" ) + "</td><td>" + rs.getString( "level" ) + "</td></tr>" );
                            }
                            out.println( "</table>" );

                            rs = statement.executeQuery( "SELECT students.name, courses.description, "
                                    + "enroll.grade FROM enroll, students, courses "
                                    + "WHERE students.student_id = enroll.student_id "
                                    + "AND enroll.course_id = courses.course_id "
                                    + "AND students.name ILIKE '%" + toSearchFor + "%'" );

                            if ( rs.isBeforeFirst() )
                            {
                                out.println( "<h3>Enroll</h3>" );
//                        rs = statement.executeQuery("select column_name from "
//                                + "information_schema.columns where table_name = 'enroll'");
//                        
                                out.println( "<table border=1>" );
                                out.println( "<tr>" );
                                out.println( "<tr><td> Student Name </td><td> Course Desription </td><td> Grade </td></tr>" );
//                        while(rs.next())
//                        {
//                            out.println( "<td>" + rs.getString( "column_name" ) + "</td>");
//                        }
                                out.println( "</tr>" );

                                while ( rs.next() )
                                {
                                    out.println( "<tr><td>" + rs.getString( "name" ) + "</td><td>" + rs.getString( "description" )
                                            + "</td><td>" + rs.getString( "grade" ) + "</td></tr>" );
                                }
                                out.println( "</table>" );
                            }
                            %>
        <br><br><a href="Home.jsp">Home</a>
        <%
                        }
                        else
                        {
                            out.println( "<h3>No search results found</h3>" );
        %>
        <br><br><a href="Home.jsp">Home</a>
        <%
            }
                        
        }//search type students
        else if ( search_type.equals( "Faculty" ) )
        {
            rs = statement.executeQuery( "SELECT * FROM faculties WHERE name ILIKE '%" + toSearchFor + "%'" );
            if ( rs.isBeforeFirst() )
            {
                out.println( "<h3>Faculty</h3>" );
                rs = statement.executeQuery( "select column_name from "
                        + "information_schema.columns where table_name = 'faculties'" );

                out.println( "<table border=1>" );
                out.println( "<tr>" );
                while ( rs.next() )
                {
                    out.println( "<td>" + rs.getString( "column_name" ) + "</td>" );
                }
                out.println( "</tr>" );
                rs = statement.executeQuery( "SELECT * FROM faculties WHERE name ILIKE '%" + toSearchFor + "%'" );

                while ( rs.next() )
                {
                    out.println( "<tr><td>" + rs.getInt( "faculty_id" ) + "</td><td>" + rs.getString( "name" )
                            + "</td><td>" + rs.getString( "date_of_birth" ) + "</td><td>" + rs.getString( "address" )
                            + "</td><td>" + rs.getString( "email" ) + "</td><td>" + rs.getString( "level" ) + "</td></tr>" );
                }
                out.println( "</table>" );

                rs = statement.executeQuery( "SELECT courses.course_id, "
                        + "courses.description, courses.level, faculties.name, "
                        + "courses.semester FROM courses, faculties "
                        + "WHERE instructor = faculties.faculty_id "
                        + "AND faculties.name ILIKE '%" + toSearchFor + "%'"
                        + "ORDER BY courses.course_id " );

                if ( rs.isBeforeFirst() )
                {
                    out.println( "<h3>Courses</h3>" );
                    out.println( "<table border=1>" );
                    out.println( "<tr>" );
                    out.println( "<tr><td> Course ID </td><td> Course Desription "
                            + "</td><td> Level </td><td> Name </td><td> Semester </td></tr>" );

                    while ( rs.next() )
                    {
                        out.println( "<tr><td>" + rs.getInt( "course_id" ) + "</td><td>" + rs.getString( "description" )
                                + "</td><td>" + rs.getString( "level" ) + "</td><td>"
                                + rs.getString( "name" ) + "</td><td>" + rs.getString( "semester" ) + "</td></tr>" );
                    }
                    out.println( "</table>" );
                }
                %>
        <br><br><a href="Home.jsp">Home</a>
        <%
            }
            else
            {
                out.println( "<h3>No search results found</h3>" );
        %>
        <br><br><a href="Home.jsp">Home</a>
        <%
            }
        }//search type facutly
        else // Courses search
        {
            rs = statement.executeQuery( "SELECT * FROM courses, faculties WHERE courses.instructor = faculties.faculty_id AND "
                    + "description ILIKE '%" + toSearchFor + "%'" );
            if ( rs.isBeforeFirst() )
            {
                out.println( "<h3>Courses</h3>" );
                rs = statement.executeQuery( "select column_name from "
                        + "information_schema.columns where table_name = 'courses'" );

                out.println( "<table border=1>" );
                out.println( "<tr>" );
                while ( rs.next() )
                {
                    out.println( "<td>" + rs.getString( "column_name" ) + "</td>" );
                }
                out.println( "</tr>" );
                rs = statement.executeQuery( "SELECT * FROM courses, faculties WHERE courses.instructor = faculties.faculty_id AND "
                        + "description ILIKE '%" + toSearchFor + "%'" );

                while ( rs.next() )
                {
                    out.println( "<tr><td>" + rs.getInt( "course_id" ) + "</td><td>" + rs.getString( "description" )
                            + "</td><td>" + rs.getString( "level" ) + "</td><td>" + rs.getString( "name" )
                            + "</td><td>" + rs.getString( "semester" ) + "</td></tr>" );
                }
                out.println( "</table>" );
                %>
        <br><br><a href="Home.jsp">Home</a>
        <%
            }
            else
            {
                out.println( "<h3>No search results found</h3>" );
        %>
        <br><br><a href="Home.jsp">Home</a>
        <%
                        }
                    }
                }
            }
        %>
    </body>
</html>
