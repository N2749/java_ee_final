<%@ page import="com.blog.blog.model.Post" %>
<%@ page import="com.blog.blog.repository.interfaces.PostRepository" %>
<%@ page import="java.util.ArrayList" %>
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
<%--TODO: edit--%>
<%
    PostRepository postRepository = new PostRepositoryHibernate();
    Post post = postRepository.getPost(Integer.parseInt(request.getParameter("id")));
%>
<p><%=post.getTitle()%></p>
<p>created by: <%=post.getCreator().getUsername()%></p>
<p><%=post.getText()%></p>
</body>
</html>
