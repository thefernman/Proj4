<%-- 
    Document   : faculties
    Created on : Apr 17, 2015, 4:35:28 PM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Faculties Table</title>
    </head>
    <body>
        <h2>Faculties Table</h2>
        <%
            String username = session.getAttribute( "username" ).toString();
            String password = session.getAttribute( "password" ).toString();
            String db_name = session.getAttribute( "db_name" ).toString();
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
                        "jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/spr15_" + db_name,
                        "spr15_" + username, password );

                statement = connection.createStatement();

                rs = statement.executeQuery( "SELECT * FROM faculties" );
                out.println( "<table border=1>" );
                out.println( "<tr><td> faculty_id </td><td> name </td><td> date_of_birth </td><td> address </td><td> email </td><td> level </td></tr>" );
                while ( rs.next() )
                {
                    String faculty_id = rs.getString( "faculty_id" );
                    String name = rs.getString( "name" );
                    String date_of_birth = rs.getString( "date_of_birth" );
                    String address = rs.getString( "address" );
                    String email = rs.getString( "email" );
                    String level = rs.getString( "level" );
                    out.println( "<tr><td>" + faculty_id + "</td><td>" + name + "</td><td>" + date_of_birth + "</td><td>" + address + "</td><td>" + email + "</td><td>" + level + "</td></tr>" );
                }
                out.println( "</table>" );

            }
            catch ( Exception e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }
        %>
        
        <h3>Insert New Faculty</h3>
        <form action="faculties_insert.jsp" method="post">
            Faculty ID:<br><input type="number" name="faculty_id" required>
            <br/>Name:<br><input type="text" name="name" required>
            <br/>Date of Birth:<br><input type="text" name="date_of_birth" required>
            <br/>Address:<br><input type="text" name="address" required>
            <br/>Email:<br><input type="text" name="email" required>
            <br/>Level:<br>
            <select name="level" id>
                <option selected>Instr</option>
                <option>Prof</option>
                <option>AP</option>
            </select>
            <br><br><input type="submit" value="Insert">
        </form>
        <%
        rs = statement.executeQuery( "SELECT * FROM faculties" );
        %>
        
    <h3>Delete Student</h3>
    <form action="faculties_delete.jsp" method="post">
        <select name="faculty_name">
        <%  while(rs.next()){ %>
            <option><%= rs.getString( "name" )%></option>
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
