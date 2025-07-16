package com.hospital;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/addDoctor")
public class AddDoctor extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name=req.getParameter("doctorName");
		String specialization=req.getParameter("specialization");
		String phone=req.getParameter("phoneNumber");
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital","root","0000");
			String query="insert into doctor(name,specialization,phone) values(?,?,?)";
			PreparedStatement preparedStatement =connection.prepareStatement(query);
			preparedStatement.setString(1,name);
			preparedStatement.setString(2,specialization);
			preparedStatement.setString(3,phone);
			int num=preparedStatement.executeUpdate()	;
			
			if(num==0)
			{
				resp.sendRedirect("fail.html");
			}
			else {
				resp.sendRedirect("dataupload.html");
			}
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	

}
