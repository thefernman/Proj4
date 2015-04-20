<%-- 
    Document   : faculties_insert
    Created on : Apr 17, 2015, 4:34:06 PM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <%
            Connection connection = null;
            Statement statement = null;

            String level_ = session.getAttribute( "level" ).toString();

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
                    int faculty_id = Integer.parseInt( request.getParameter( "faculty_id" ) );
                    String name = request.getParameter( "name" );
                    String date_of_birth = request.getParameter( "date_of_birth" );
                    String address = request.getParameter( "address" );
                    String email = request.getParameter( "email" );
                    String level = request.getParameter( "level" );

                    statement.executeUpdate( "INSERT INTO faculties "
                            + "VALUES (" + faculty_id + ", '" + name + "', (to_date('"
                            + date_of_birth + "', 'YYYY-MM-DD')), '" + address + "', '"
                            + email + "', '" + level + "')" );

                    response.sendRedirect( "faculties.jsp" );
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
    </body>
</html>
