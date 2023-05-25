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
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        .container {
            max-width: 500px;
            margin: 0px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            color: #777;
            margin-bottom: 20px;
            padding: 20px;
            border: 2px solid black;
        }

        button {
            margin-bottom: 20px;
        }

        a {
            color: black;
            text-decoration: none;
        }
    </style>
</head>
<body class="container">
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
<p>
    <a href="post?id=<%=p.getId()%>">
        <%=p.getTitle()%> <br>by <%=p.getCreator().getUsername()%>
    </a>
</p>
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
