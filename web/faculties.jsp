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
            String name_ = session.getAttribute( "name" ).toString();
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
                        "jdbc:postgresql://cop4710-postgresql.cs.fiu.edu:5432/spr15_fcamp001?user=spr15_fcamp001&password=1299228" );
            }
            catch ( Exception e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }

            statement = connection.createStatement();

            if ( !( level_.equals( "student" ) ) )
            {
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

        %>
        <form action="faculties_insert.jsp" method="post">
            <tr><td><input type="number" name="faculty_id" required></td>
                <td><input type="text" name="name" required></td>
                <td><input type="date" name="date_of_birth" required></td>
                <td><input type="text" name="address" required></td>
                <td><input type="email" name="email" required></td>
                <td><select name="level" id>
                        <option selected>Instr</option>
                        <option>Prof</option>
                        <option>AP</option>
                    </select></td>
                    </table>
            <br><input type="submit" value="Insert">
        </form>
        <%
            rs = statement.executeQuery( "SELECT * FROM faculties" );
        %>

        <h3>Delete Faculty</h3>
        <form action="faculties_delete.jsp" method="post">
            <select name="faculty_name">
                <%  while ( rs.next() )
                    {%>
                <option><%= rs.getString( "name" )%></option>
                <% } %>
            </select>
            <br><br><input type="submit" value="Delete">
        </form>    
        <%
            }

            connection.close();
        %>
        <br><br><a href="Home.jsp">Home</a>
    </body>
</html>
