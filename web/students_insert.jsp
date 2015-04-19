<%-- 
    Document   : students_insert
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

            String username = session.getAttribute( "username" ).toString();
            String password = session.getAttribute( "password" ).toString();
            String db_name = session.getAttribute( "db_name" ).toString();
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
            }
            catch ( Exception e )
            {
                out.println( "<h1>exception: " + e + e.getMessage() + "</h1>" );
            }

            int student_id = Integer.parseInt(request.getParameter( "student_id" ));
            String name = request.getParameter( "name" );
            String date_of_birth = request.getParameter( "date_of_birth" );
            String address = request.getParameter( "address" );
            String email = request.getParameter( "email" );
            String level = request.getParameter( "level" );
            statement.executeUpdate( "INSERT INTO students "
                    + "VALUES (" + student_id + ", '" + name + "', (to_date('" 
                    + date_of_birth + "', 'MM/DD/YYYY')), '" + address + "', '" 
                    + email + "', '" + level + "')" );
            if ( connection != null)
                response.sendRedirect( "students.jsp" );
            else
            {
                out.println( "Error" );
                response.sendRedirect( "Error.jsp" );
            }


        %>
        
        
        
        
        
        
    </body>
</html>
