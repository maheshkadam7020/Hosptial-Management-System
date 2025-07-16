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
@WebServlet("/deleteappointment")
public class DeleteAppointment extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int id=Integer.parseInt(req.getParameter("id"));
		resp.setContentType("text/html");
		PrintWriter pw =resp.getWriter();		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital","root","0000");
			String query="delete from appointment where id =?";
			PreparedStatement preparedStatement=connection.prepareStatement(query);
			preparedStatement.setInt(1, id);
			int num=preparedStatement.executeUpdate();
			if(num==0)
			{
				resp.sendRedirect("fail.html");
			}
			else {
				resp.sendRedirect("dataupload.html");
			}
		}
			catch (Exception e) {
			// TODO: handle exception
		}
	}

}

