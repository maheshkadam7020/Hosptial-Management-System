package com.hospital;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/register")
public class AddPatient extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		res.setContentType("text/html");
		PrintWriter pw=res.getWriter();
		String pname=req.getParameter("pname");
		int  page=Integer.parseInt(req.getParameter("page"));
		String pgender=req.getParameter("pgender");
		String pnumber=req.getParameter("pnumber");
		String padd=req.getParameter("padd");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection =DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital","root","0000");
			String query="INSERT INTO patient(name, age, gender,phone,address) VALUES (?,?,?,?,?)";
			PreparedStatement preparedStatement=connection.prepareStatement(query);
			preparedStatement.setString(1, pname);
			preparedStatement.setInt(2, page);
			preparedStatement.setString(3, pgender);
			preparedStatement.setString(4, pnumber);
			preparedStatement.setString(5, padd);
			
			int num=preparedStatement.executeUpdate();
			if(num==0)
			{
				res.sendRedirect("fail.html");
			}
			else {
				res.sendRedirect("dataupload.html");
			}
			connection.close();
		} catch (Exception s) {
			pw.println("<h1>"+s.getMessage()+"</h1>");
		}
	}
	

}
