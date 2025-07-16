<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String patientName = "", doctorName = "", date = "", time = "", reason = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "0000");

        pstmt = conn.prepareStatement(
            "SELECT a.*, p.name AS pname, d.name AS dname FROM appointment a " +
            "JOIN patient p ON a.p_id = p.id " +
            "JOIN doctor d ON a.d_id = d.id WHERE a.id = ?"
        );
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            patientName = rs.getString("pname");
            doctorName = rs.getString("dname");
            date = rs.getString("appointment_date");
            time = rs.getString("appointment_time").substring(0,5); // HH:MM only
            
        }

    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Appointment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold fs-4" href="#">🏥 Hospital Management System</a>
    </div>
</nav>
<div class="container py-5">
    <div class="card p-4 shadow-sm">
        <h4 class="text-center mb-4">✏️ Edit Appointment</h4>
        <form method="post">
            <div class="mb-3">
                <label class="form-label">Patient</label>
                <input type="text" class="form-control" value="<%=patientName%>" disabled>
            </div>
            <div class="mb-3">
                <label class="form-label">Doctor</label>
                <input type="text" class="form-control" value="<%=doctorName%>" disabled>
            </div>
            <div class="mb-3">
                <label class="form-label">Date</label>
                <input type="date" name="date" class="form-control" value="<%=date%>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Time</label>
                <input type="time" name="time" class="form-control" value="<%=time%>" required>
            </div>
            
            <div class="d-grid">
                <button type="submit" class="btn btn-success">Update Appointment</button>
            </div>
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String newDate = request.getParameter("date");
                String newTime = request.getParameter("time");
                

                try {
                    pstmt = conn.prepareStatement("UPDATE appointment SET appointment_date = ?, appointment_time = ? WHERE id = ?");
                    pstmt.setDate(1, Date.valueOf(newDate));
                    pstmt.setTime(2, Time.valueOf(newTime + ":00"));
                    
                    pstmt.setInt(3, id);

                    int result = pstmt.executeUpdate();
                    if (result > 0) {
                        response.sendRedirect("appointmentlist.jsp");
                    } else {
                        out.println("<div class='alert alert-danger mt-3'>Failed to update appointment.</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='alert alert-danger mt-3'>Error: " + ex.getMessage() + "</div>");
                }
            }

            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        %>
    </div>
</div>
</body>
</html>
