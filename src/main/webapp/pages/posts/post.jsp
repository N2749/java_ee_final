<%@ page import="com.blog.blog.model.Post" %>
<%@ page import="com.blog.blog.repository.interfaces.PostRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.PostRepositoryHibernate" %><%--
  Created by IntelliJ IDEA.
  User: nurba
  Date: 17.05.2023
  Time: 22:57
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
    PostRepository postRepository = new PostRepositoryHibernate();
    Post post = postRepository.get(Integer.parseInt(request.getParameter("id")));

    Cookie[] cookies = request.getCookies();
    int userId = -1;
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("userId")) {
            userId = Integer.parseInt(cookie.getValue());
        }
    }
    if (userId != -1 && post.getCreator().getId() == userId) {
%>
<p>
    <a href="postEdit?post=<%=post.getId()%>">edit</a>
</p>
<form action="postService" method="post">
    <input type="text" hidden="hidden" id="action" name="action" value="deletePost"/>
    <input type="text" hidden="hidden" id="postId" name="postId" value="<%=post.getId()%>"/>
    <button type="submit" class="submit">delete</button>
</form>
<%
    }
%>

<p><%=post.getTitle()%>
</p>
<p>created by: <%=post.getCreator().getUsername()%>
</p>
<p><%=post.getText()%>
</p>
</body>
</html>
