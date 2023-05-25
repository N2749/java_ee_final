<%--
  Created by IntelliJ IDEA.
  User: nurba
  Date: 22.05.2023
  Time: 22:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
        }

        nav {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 20px;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        nav a {
            color: #337ab7;
            text-decoration: none;
            font-size: 21px;
        }

        nav a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<nav>

    <a href="posts">Posts</a>
    <a href="tags">Tags</a>
    <%
        Cookie[] cookies = request.getCookies();
        int userId = -1;
        boolean isAdmin = false;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = Integer.parseInt(cookie.getValue());
            }
            if (cookie.getName().equals("isAdmin")) {
                isAdmin = Boolean.parseBoolean(cookie.getValue());
            }
        }
        if (userId != -1) {
    %>
    <a href="profile">Profile</a>
    <a href="logOut">Logout</a>
    <%
    } else {
    %>
    <a href="login">Login</a>
    <%
        }
    %>
    <% if (isAdmin) { %>
    <a href="ausers">Users</a>
    <%
        }
    %>
</nav>
<br>
</body>
</html>
