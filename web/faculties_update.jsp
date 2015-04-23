<%-- 
    Document   : faculties_update
    Created on : Apr 22, 2015, 9:54:35 AM
    Author     : Fernando
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Faculties Update</title>
    </head>
    <body>
        <%
            Connection connection = null;
            Statement statement = null;
            ResultSet rs = null;

            String level_ = null;
            String name_ = null;

            try
            {
                level_ = session.getAttribute( "level" ).toString();
                name_ = request.getParameter( "faculty_name" );
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
                if ( !( level_.equals( "student" ) ) )
                {
                    rs = statement.executeQuery( "SELECT * FROM faculties WHERE "
                            + "name = '" + name_ + "'" );
                    rs.next();
                    int faculty_id = rs.getInt( "faculty_id" );
                    String name = rs.getString( "name" );
                    String date_of_birth = rs.getDate( "date_of_birth" ).toString();
                    String address = rs.getString( "address" );
                    String email = rs.getString( "email" );
                    %>
                    <h3>Update Faculty</h>
                    <table border=1>
                        <tr><td>Faculty ID </td><td> Name </td><td> Date of Birth </td><td> Address </td><td> Email </td><td> Level </td></tr>
                    <form action="faculties_insert_update.jsp" method="post">
                        <tr><td><input type="text" name="faculty_id" readonly c:out value="<%=faculty_id%>" </td>
            <td><input type="text" name="name" c:out value="<%=name%>" required></td>
                <td><input type="date" name="date_of_birth" fmt:formatDate value="<%=date_of_birth%>" pattern="YYYY-MM-DD" required></td>
                <td><input type="text" name="address" c:out value="<%=address%>" required></td>
                <td><input type="email" name="email" c:out value="<%=email%>" required></td>
                <td><select name="level">
                        <option selected>Instr</option>
                        <option>Prof</option>
                        <option>AP</option>
                    </select></td>
                    </table>
            <br><input type="submit" value="Update">
        </form>
        </table>
                    <%
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
        
        <br><br><a href="faculties.jsp">Faculties</a>
    </body>
</html>
