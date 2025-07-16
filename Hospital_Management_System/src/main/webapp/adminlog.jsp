<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - Hospital Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
        }
        .login-container {
            margin-top: 80px;
            max-width: 400px;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        .login-header {
            font-size: 24px;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <!-- Header Start -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">🏥 Hospital Management System</a>
        </div>
    </nav>
    <!-- Header End -->

    <div class="container d-flex justify-content-center">
        <div class="login-container">
            <div class="text-center login-header mb-4">Admin Login</div>
            <form action="login" method="post">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" required autofocus>
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Login</button>
            </form>
        </div>
    </div>

</body>
</html>
