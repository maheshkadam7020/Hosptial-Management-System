<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Appointment - Hospital Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
        }
        .card {
            border-radius: 20px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .form-heading {
            font-weight: bold;
            color: #2c3e50;
        }
    </style>
</head>
<body>

<%
    Connection conn = null;
    Statement stmt1 = null;
    Statement stmt2 = null;
    ResultSet patients = null;
    ResultSet doctors = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "0000");

        stmt1 = conn.createStatement();
        stmt2 = conn.createStatement();

        patients = stmt1.executeQuery("SELECT id, name FROM patient");
        doctors = stmt2.executeQuery("SELECT id, name FROM doctor");
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    }
%>

<div class="container py-5">
    <h2 class="text-center text-primary mb-4">🏥 Hospital Management System</h2>

    <div class="card p-4">
        <h4 class="text-center form-heading mb-3">Book an Appointment</h4>

        <form action="bookappointment.jsp" method="post">
            <div class="mb-3">
                <label for="patientId" class="form-label">Patient</label>
                <select class="form-select" id="patientId" name="patientId" required>
                    <option value="">Select Patient</option>
                    <%
                        if (patients != null) {
                            while (patients.next()) {
                    %>
                        <option value="<%=patients.getInt("id")%>"><%=patients.getString("name")%></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label for="doctorId" class="form-label">Doctor</label>
                <select class="form-select" id="doctorId" name="doctorId" required>
                    <option value="">Select Doctor</option>
                    <%
                        if (doctors != null) {
                            while (doctors.next()) {
                    %>
                        <option value="<%=doctors.getInt("id")%>"><%=doctors.getString("name")%></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label for="appointmentDate" class="form-label">Date</label>
                <input type="date" class="form-control" name="appointmentDate" required>
            </div>

            <div class="mb-3">
                <label for="appointmentTime" class="form-label">Time</label>
                <input type="time" class="form-control" name="appointmentTime" required>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-success btn-lg">Book Appointment</button>
            </div>
        </form>

        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                int patientId = Integer.parseInt(request.getParameter("patientId"));
                int doctorId = Integer.parseInt(request.getParameter("doctorId"));
                String date = request.getParameter("appointmentDate");
                String time = request.getParameter("appointmentTime");
                

                try {
                    PreparedStatement pstmt = conn.prepareStatement(
                        "INSERT INTO appointment (p_id, d_id, appointment_date, appointment_time) VALUES ( ?, ?, ?, ?)"
                    );
                    pstmt.setInt(1, patientId);
                    pstmt.setInt(2, doctorId);
                    pstmt.setDate(3, Date.valueOf(date));
                    pstmt.setTime(4, Time.valueOf(time + ":00")); // Ensure seconds are present
      

                    int result = pstmt.executeUpdate();
                    if (result > 0) {
                        out.println("<div class='alert alert-success mt-3'>✅ Appointment booked successfully!</div>");
                    } else {
                        out.println("<div class='alert alert-warning mt-3'>⚠️ Failed to book appointment.</div>");
                    }
                } catch (Exception ex) {
                    out.println("<div class='alert alert-danger mt-3'>❌ Error: " + ex.getMessage() + "</div>");
                }
            }
        %>
    </div>
</div>

<%
    // Clean-up resources
    if (patients != null) patients.close();
    if (doctors != null) doctors.close();
    if (stmt1 != null) stmt1.close();
    if (stmt2 != null) stmt2.close();
    if (conn != null) conn.close();
%>

</body>
</html>
