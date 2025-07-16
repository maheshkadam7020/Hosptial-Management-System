package com.hospital;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/edit")
public class Edit extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        int id = Integer.parseInt(req.getParameter("id"));

        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");

           
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital", "root", "0000");

            
            PreparedStatement ps = con.prepareStatement("SELECT * FROM patient WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                out.println("<!DOCTYPE html>");
                out.println("<html lang='en'>");
                out.println("<head>");
                out.println("<meta charset='UTF-8'>");
                out.println("<title>Update Patient</title>");
                out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' rel='stylesheet'>");
                out.println("</head>");
                out.println("<body>");

                out.println("<div class='container mt-5'>");
                out.println("<h2 class='mb-4 text-center'>Update Patient Information</h2>");

                out.println("<form action='updatePatient' method='post'>");

                out.println("<input type='hidden' name='id' value='" + id + "'>");

                out.println("<div class='mb-3'>");
                out.println("<label class='form-label'>Name</label>");
                out.println("<input type='text' class='form-control' name='name' value='" + rs.getString("name") + "' required>");
                out.println("</div>");

                out.println("<div class='mb-3'>");
                out.println("<label class='form-label'>Age</label>");
                out.println("<input type='number' class='form-control' name='age' value='" + rs.getInt("age") + "' required>");
                out.println("</div>");

                out.println("<div class='mb-3'>");
                out.println("<label class='form-label'>Gender</label>");
                out.println("<select class='form-select' name='gender' required>");
                out.println("<option value='Male'" + (rs.getString("gender").equals("Male") ? " selected" : "") + ">Male</option>");
                out.println("<option value='Female'" + (rs.getString("gender").equals("Female") ? " selected" : "") + ">Female</option>");
                out.println("<option value='Other'" + (rs.getString("gender").equals("Other") ? " selected" : "") + ">Other</option>");
                out.println("</select>");
                out.println("</div>");

                out.println("<div class='mb-3'>");
                out.println("<label class='form-label'>Address</label>");
                out.println("<textarea class='form-control' name='address' rows='3'>" + rs.getString("address") + "</textarea>");
                out.println("</div>");

                out.println("<div class='mb-3'>");
                out.println("<label class='form-label'>Phone</label>");
                out.println("<input type='text' class='form-control' name='phone' value='" + rs.getString("phone") + "' required>");
                out.println("</div>");

                out.println("<div class='text-center'>");
                out.println("<button type='submit' class='btn btn-warning'>Update</button>");
                out.println("<a href='showlist' class='btn btn-secondary ms-2'>Cancel</a>");
                out.println("</div>");

                out.println("</form>");
                out.println("</div>");

                out.println("</body>");
                out.println("</html>");
            } else {
                out.println("<h3 style='color:red'>No patient found with ID " + id + "</h3>");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
