package com.hospital;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/updatePatient")
public class EditUrl extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        int id = Integer.parseInt(req.getParameter("id"));

        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");

           
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/hospital", "root", "0000");

            
            PreparedStatement ps = con.prepareStatement("UPDATE patient SET name = ?, age = ?, gender = ?, address = ?, phone = ? WHERE id = ?");
            ps.setString(1, req.getParameter("name"));
            ps.setInt(2, Integer.parseInt(req.getParameter("age")));
            ps.setString(3, req.getParameter("gender"));
            ps.setString(4, req.getParameter("address"));
            ps.setString(5, req.getParameter("phone"));
            ps.setInt(6, id);
            
            int num=ps.executeUpdate();
            if(num==0)
            {
            	res.sendRedirect("Fail.html");
            }
            else {
            	res.sendRedirect("dataupload.html");
			}
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
