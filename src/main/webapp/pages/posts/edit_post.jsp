<%@ page import="com.blog.blog.model.Post" %>
<%@ page import="com.blog.blog.repository.interfaces.PostRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.PostRepositoryHibernate" %><%--
  Created by IntelliJ IDEA.
  User: nurba
  Date: 17.05.2023
  Time: 22:58
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
    PostRepository repository = new PostRepositoryHibernate();
    Post post = repository.get(Integer.parseInt(request.getParameter("post")));

    Cookie[] cookies = request.getCookies();
    int userId = -1;
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("userId")) {
            userId = Integer.parseInt(cookie.getValue());
        }
    }
    if (userId == -1 || post.getCreator().getId() != userId) {
        System.out.println("sending error");
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
    }
%>
<form action="postService" method="post">
    <input type="text" hidden="hidden" id="action" name="action" value="updatePost"/>
    <input type="text" hidden="hidden" id="postId" name="postId" value="<%=post.getId()%>"/>
    <label for="title">title</label> <br>
    <input type="text" id="title" name="title" placeholder="sunny day" required="required" value="<%=post.getTitle()%>">
    <br>
    <label for="text">text</label> <br>
    <textarea name="text" placeholder="My name is Kira Yoshikage..." id="text"
              required="required"><%=post.getText()%></textarea> <br>

    <button type="submit" class="submit">post!</button>
</form>
</body>
</html>
