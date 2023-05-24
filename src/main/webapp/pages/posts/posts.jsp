<%@ page import="com.blog.blog.model.Post" %>
<%@ page import="com.blog.blog.repository.interfaces.PostRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.PostRepositoryHibernate" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: nurba
  Date: 22.05.2023
  Time: 22:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Blog!</title>
</head>
<body>
<jsp:include page="../../components/header.jsp"></jsp:include>
<%
    Cookie[] cookies = request.getCookies();
    boolean isStaff = false;

    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("isStaff")) {
            isStaff = Boolean.parseBoolean(cookie.getValue());
        }
    }
%>
<% if (isStaff) { %>
<button><a href="addPost">create new post</a></button>
<%}%>
<%
    PostRepository postRepository = new PostRepositoryHibernate();
    ArrayList<Post> posts = postRepository.getAll();
    if (posts.size() > 0)
        for (Post p : posts) {
%>
<div>
    <a href="post?id=<%=p.getId()%>">
        <p><%=p.getTitle()%> by <%=p.getCreator().getUsername()%></p>
    </a>
</div>
<%
    }
else {
%>
<p>nothing here...</p>
<%
    }
%>
</body>
</html>
