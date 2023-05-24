<%@ page import="com.blog.blog.repository.interfaces.UserRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.UserRepositoryHibernate" %>
<%@ page import="com.blog.blog.model.User" %>
<%@ page import="com.blog.blog.model.Post" %><%--
  Created by IntelliJ IDEA.
  User: nurba
  Date: 17.05.2023
  Time: 22:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<jsp:include page="../../components/header.jsp"></jsp:include>
<%
    int currentUserId = -1;
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("userId")) {
            currentUserId = Integer.parseInt(cookie.getValue());
        }
    }
    int parameterUserId = request.getParameter("userId") == null ? -1 : Integer.parseInt(request.getParameter("userId"));
    UserRepository repository = new UserRepositoryHibernate();
    User user = repository.get(parameterUserId == -1 ? currentUserId : parameterUserId);
    if (user == null) {
        request.getRequestDispatcher("/login").forward(request, response);
    }
%>
<h3>Profile of <%=user.getUsername()%>, the <%=request.getAttribute("postfix")%>
</h3>
<%
    if (user.getId() == currentUserId) {
%>
<p><a href="userEdit">edit</a></p>
<form action="users" method="post">
    <input type="text" hidden="hidden" id="action" name="action" value="deleteUser"/>
    <button type="submit" class="submit">delete</button>
</form>
<%
    }
%>
<h3>Posts</h3>
<% for (Post p :
        user.getPosts()) {
%>
<p><a href="post?id=<%=p.getId()%>"><%=p.getText()%>
</a></p>
<%
    }
%>
</body>
</html>
