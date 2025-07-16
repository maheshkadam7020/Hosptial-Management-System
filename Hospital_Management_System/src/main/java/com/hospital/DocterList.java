package com.hospital;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/doclist")
public class DocterList extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        PrintWriter pw = resp.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital", "root", "0000");
            String query = "SELECT * FROM doctor";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            pw.println("<!DOCTYPE html>");
            pw.println("<html lang='en'>");
            pw.println("<head>");
            pw.println("<meta charset='UTF-8'>");
            pw.println("<title>Doctor Details</title>");
            pw.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' rel='stylesheet'>");
            pw.println("</head>");
            pw.println("<body>");

            pw.println("<div class='container mt-5'>");
            pw.println("<h2 class='mb-4'>Doctor Details</h2>");
            pw.println("<a href='addDoctor.html' class='btn btn-primary mb-3'>Add New Doctor</a>");
            pw.println("<a href='main.html' class='btn btn-primary mb-3'>Home</a>");

            pw.println("<table class='table table-bordered table-striped'>");
            pw.println("<thead class='table-dark'>");
            pw.println("<tr>");
            pw.println("<th>ID</th>");
            pw.println("<th>Name</th>");
            pw.println("<th>Specialization</th>");
            
            
            pw.println("<th>Phone</th>");
            pw.println("<th>Actions</th>");
            pw.println("</tr>");
            pw.println("</thead>");
            pw.println("<tbody>");

            while (rs.next()) {
                int id = rs.getInt("id");
                pw.println("<tr>");
                pw.println("<td>" + id + "</td>");
                pw.println("<td>" + rs.getString("name") + "</td>");
                pw.println("<td>" + rs.getString("specialization") + "</td>");
                
                pw.println("<td>" + rs.getString("phone") + "</td>");
                pw.println("<td>");
                pw.println("<a href='bookAppointment.jsp' class='btn btn-sm btn-warning ms-3'>Book</a>");
                pw.println("<a href='Appointment?id=" + id + "' class='btn btn-sm btn-danger ms-3'>Appointment</a>");
                pw.println("</td>");
                pw.println("</tr>");
            }

            pw.println("</tbody>");
            pw.println("</table>");
            pw.println("</div>");

            pw.println("</body>");
            pw.println("</html>");

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            pw.println("<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
