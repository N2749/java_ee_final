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
        nav {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 20px;
        }
    </style>
</head>
<body>
<nav>

    <a href="posts">posts</a>
    <a href="tags">tags</a>
    <%
        Cookie[] cookies = request.getCookies();
        int userId = -1;

        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("userId")) {
                userId = Integer.parseInt(cookie.getValue());
            }
        }
        if (userId != -1) {
    %>
    <a href="profile">profile</a>
    <a href="logOut">logout</a>
    <%
    } else {
    %>
    <a href="login">login</a>
    <%
        }
    %>
</nav>
<br>
</body>
</html>
