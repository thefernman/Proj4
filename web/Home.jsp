<%-- 
    Document   : Home
    Created on : Apr 17, 2015, 4:04:12 PM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="Error.jsp" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
    </head>
    <body>
        <%
            String username = session.getAttribute( "username" ).toString();
            String name = session.getAttribute( "name" ).toString();
            String level = session.getAttribute( "level" ).toString();

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
                connection = DriverManager.getConnection( "jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/"
                        + "spr15_fcamp001?user=spr15_fcamp001&password=1299228" );
                statement = connection.createStatement();
            }
            catch ( Exception e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }
        %>
        <h1>Welcome to <%= name%></h2>
        <h2>Main Page - <%=level%></h2>
        <%
            if ( connection != null )
            {
                if ( !( level.equals( "student" ) ) )
                {
                    rs = statement.executeQuery( "SELECT table_name FROM information_schema.tables "
                            + "WHERE table_schema = 'public' and table_name != 'school_probs' and "
                            + "table_name != 'grade_values' and table_name != 'simulated_records' and "
                            + "table_name != 'login' and table_name != 'title'" );
                    out.println( "<table border=1>" );
                    out.println("<tr><td>Table Views</td></tr>");
                    while ( rs.next() )
                    {
                        String table_name = rs.getString( "table_name" );
        %><tr><td><a href="<%=table_name%>.jsp"><%=table_name%></td></tr><%
            }
            out.println( "</table>" );
        }
        else
        {
            %><table border=1>
            <tr><td><a href="students.jsp">students</a></td></tr>
            <tr><td><a href="enroll.jsp">enroll</a></td></tr>
            <tr><td><a href="courses.jsp">courses</a></td></tr>
        </table><%
            }
        %>
        <h3>Search</h3>
        <form action="search.jsp" method="post">
            <select name="search_type">
                <option>Student</option>
                <option>Faculty</option>
                <option>Course</option>
                </select>
            <br><br><input type="text" name="toSearchFor">
            <br><br><input type="submit" value="Search">
        </form>
                <%
            }
                %>
                <br/><br/>
                <a href="Logout.jsp">Logout</a>
                </body>
                </html>
