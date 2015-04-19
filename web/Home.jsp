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
            String db_name = session.getAttribute( "db_name" ).toString();
            
            
            Connection connection = null;
            Statement statement = null;

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
                connection = DriverManager.getConnection( "jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/spr15_fcamp001?user=spr15_fcamp001&password=1299228" );
            }
            catch ( Exception e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }
        %>
        <h1>Welcome to <%= username%> Database</h2>
        <h2>Main Page</h2>

        <a href="students.jsp">students</a><br>
        <a href="enroll.jsp">enroll</a><br>
        <a href="courses.jsp">courses</a><br>
        <a href="faculties.jsp">faculties</a><br>
        <a href="title.jsp">title</a>
        <br/>
        <br/>
        <br/><br/><br/><br/><br/>
        <a href="Logout.jsp">Logout</a>
</body>
</html>
