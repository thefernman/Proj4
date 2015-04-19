<%-- 
    Document   : title
    Created on : Apr 17, 2015, 4:39:24 PM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Titles Table</title>
    </head>
    <body>
        <h2>Titles Table</h2>
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

                rs = statement.executeQuery( "SELECT * FROM title" );
                out.println( "<table border=1>" );
                out.println( "<tr><td> name </td><td> abbreviation </td></tr>" );
                while ( rs.next() )
                {
                    String name = rs.getString( "name" );
                    String abbreviation = rs.getString( "abbreviation" );
                    out.println( "<tr><td>" + name + "</td><td>" + abbreviation + "</td></tr>" );
                }
                out.println( "</table>" );

                connection.close();
            }
            catch ( Exception e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }
        %>
        <br><br><a href="Home.jsp">Home</a>
    </body>
</html>
