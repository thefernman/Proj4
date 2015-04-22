<%-- 
    Document   : students_insert_update
    Created on : Apr 21, 2015, 5:02:24 PM
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
                    String student_id = request.getParameter( "student_id" );
                    String name = request.getParameter( "name" );
                    String date_of_birth = request.getParameter( "date_of_birth" );
                    String address = request.getParameter( "address" );
                    String email = request.getParameter( "email" );
                    String level = request.getParameter( "level" );

//                    out.println("UPDATE students SET name = '" + name 
//                            + "', date_of_birth = (to_date('"
//                            + date_of_birth + "', 'YYYY-MM-DD')), address = '" 
//                            + address + "', email = '" + email + "', level = '" 
//                            + level + "' WHERE student_id = " + student_id + "");
                    statement.executeUpdate( "UPDATE students SET name = '" + name 
                            + "', date_of_birth = (to_date('"
                            + date_of_birth + "', 'YYYY-MM-DD')), address = '" 
                            + address + "', email = '" + email + "', level = '" 
                            + level + "' WHERE student_id = " + student_id + "" );
                    
                    response.sendRedirect( "students.jsp" );
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
