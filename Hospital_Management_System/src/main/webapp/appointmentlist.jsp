<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Appointment List - Hospital Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f0f2f5; }
        .container { max-width: 1000px; }
        .card { border-radius: 20px; box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
        h2 { font-weight: bold; color: #2c3e50; }
        .table th { background-color: #007bff; color: white; }
        .action-btns a { margin-right: 5px; }
    </style>
</head>
<body>

<!-- Navbar Header -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container">
    <a class="navbar-brand fw-bold fs-4" href="#">🏥 Hospital Management System</a>
  </div>
</nav>

<div class="container py-5">
    <h2 class="text-center mb-4">📋 Appointment List</h2>

    <div class="card p-4">
        <table class="table table-bordered table-hover text-center align-middle">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Patient Name</th>
                    <th>Doctor Name</th>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                int num = 1;
                int recordsPerPage = 5;
                if (request.getParameter("num") != null) {
                    num = Integer.parseInt(request.getParameter("num"));
                }

                Connection conn = null;
                PreparedStatement pstmt = null;
                PreparedStatement countStmt = null;
                ResultSet rs = null;
                ResultSet countRs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "0000");

                    String query = "SELECT a.id, p.name AS patient_name, d.name AS doctor_name, a.appointment_date, a.appointment_time " +
                                   "FROM appointment a " +
                                   "JOIN patient p ON a.p_id = p.id " +
                                   "JOIN doctor d ON a.d_id = d.id " +
                                   "ORDER BY a.appointment_date DESC, a.appointment_time DESC " +
                                   "LIMIT ?, ?";
                    pstmt = conn.prepareStatement(query);
                    pstmt.setInt(1, (num - 1) * recordsPerPage);
                    pstmt.setInt(2, recordsPerPage);
                    rs = pstmt.executeQuery();

                    int count = (num - 1) * recordsPerPage + 1;
                    while (rs.next()) {
            %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= rs.getString("patient_name") %></td>
                    <td><%= rs.getString("doctor_name") %></td>
                    <td><%= rs.getDate("appointment_date") %></td>
                    <td><%= rs.getTime("appointment_time").toString().substring(0,5) %></td>
                    <td class="action-btns">
                        <a href="editappointment.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-warning">Edit</a>
                        <a href="deleteappointment.jsp?id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger" 
                           onclick="return confirm('Are you sure you want to delete this appointment?');">Delete</a>
                    </td>
                </tr>
            <%
                    }

                    countStmt = conn.prepareStatement("SELECT COUNT(*) FROM appointment");
                    countRs = countStmt.executeQuery();

                    int totalRecords = 0;
                    if (countRs.next()) {
                        totalRecords = countRs.getInt(1);
                    }

                    int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            %>
            </tbody>
        </table>

        <!-- Pagination -->
        <nav>
            <ul class="pagination justify-content-center">
                <%
                    for (int i = 1; i <= totalPages; i++) {
                        if (i == num) {
                %>
                    <li class="page-item active" aria-current="page"><span class="page-link"><%= i %></span></li>
                <%
                        } else {
                %>
                    <li class="page-item"><a class="page-link" href="appointmentlist.jsp?num=<%= i %>"><%= i %></a></li>
                <%
                        }
                    }
                %>
            </ul>
        </nav>

            <%
                } catch (Exception e) {
                    out.println("<tr><td colspan='6' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                } finally {
                    if (rs != null) rs.close();
                    if (countRs != null) countRs.close();
                    if (pstmt != null) pstmt.close();
                    if (countStmt != null) countStmt.close();
                    if (conn != null) conn.close();
                }
            %>
    </div>
</div>

</body>
</html>
