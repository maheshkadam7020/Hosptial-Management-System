<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "0000");
        pstmt = conn.prepareStatement("DELETE FROM appointment WHERE id = ?");
        pstmt.setInt(1, id);
        pstmt.executeUpdate();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
    response.sendRedirect("appointmentlist.jsp");
%>
