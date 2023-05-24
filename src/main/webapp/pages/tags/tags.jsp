<%@ page import="com.blog.blog.model.Post" %>
<%@ page import="com.blog.blog.repository.interfaces.PostRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.PostRepositoryHibernate" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.blog.blog.repository.interfaces.TagRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.TagRepositoryHibernate" %>
<%@ page import="com.blog.blog.model.Tag" %><%--
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
<form action="tagService" method="post">
    <input type="text" hidden="hidden" id="action2" name="action" value="createTag"/>
    <input type="text" id="tagName" name="tagName" required="true"/>
    <button type="submit" class="submit">create</button>
</form>
<%}%>
<%
    TagRepository tagRepository = new TagRepositoryHibernate();
    ArrayList<Tag> tags = tagRepository.getAll();
    if (tags.size() > 0)
        for (Tag t : tags) {
%>
<div>
    <a href="tag?id=<%=t.getId()%>">
        <p><%=t.getName()%>
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
