<%@ page import="com.blog.blog.repository.interfaces.UserRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.UserRepositoryHibernate" %>
<%@ page import="com.blog.blog.model.User" %><%--
  Created by IntelliJ IDEA.
  User: nurba
  Date: 25.05.2023
  Time: 02:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    Cookie[] cookies = request.getCookies();
    int userId = -1;
    boolean isAdmin = false;
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("isAdmin")) {
            isAdmin = Boolean.parseBoolean(cookie.getValue());
        }
    }
    if (!isAdmin) response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
%>
<jsp:include page="../../components/header.jsp"></jsp:include>
<h3>Users:</h3>
<%
    UserRepository userRepository = new UserRepositoryHibernate();
    for (User user : userRepository.getAll()) {
%>
<p>
    <a href="userEdit?userId=<%=user.getId()%>"><%=user.getUsername()%></a>
</p>
<%
    }
%>
</body>
</html>