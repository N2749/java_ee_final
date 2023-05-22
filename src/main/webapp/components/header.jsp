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
</head>
<body>
<a href="/posts">posts</a>
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
<%--TODO: profile page--%>
<a href="">profile</a>
<%
} else {
%>
<a href="login">login</a>
<a href="">logout</a>
<%
    }
%>
<hr>
</body>
</html>
