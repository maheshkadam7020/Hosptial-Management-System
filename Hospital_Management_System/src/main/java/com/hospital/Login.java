package com.hospital;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.coyote.Response;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/login")
public class Login extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setContentType("text/html");
		PrintWriter pw=resp.getWriter();
		String username =req.getParameter("username");
		String password =req.getParameter("password");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connection=DriverManager.getConnection("jdbc:mysql://localhost:3306/hospital","root","0000");
			String query="select*from admin";
			PreparedStatement preparedStatement=connection.prepareStatement(query);
			ResultSet rs =preparedStatement.executeQuery();
			
			while (rs.next() ){
				String user=rs.getString("username");
				String pass=rs.getString("password");
				if(user.equals(username)&& pass.equals(password)) {
					resp.sendRedirect("main.html");
				}
				else {
					resp.sendRedirect("logfail.html");
		
				}
			}
			
		}
			catch (Exception e) {
			// TODO: handle exception
		}
	}


}
