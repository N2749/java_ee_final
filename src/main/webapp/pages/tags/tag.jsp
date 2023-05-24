<%@ page import="com.blog.blog.model.Post" %>
<%@ page import="com.blog.blog.repository.interfaces.PostRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.PostRepositoryHibernate" %>
<%@ page import="com.blog.blog.repository.interfaces.UserRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.UserRepositoryHibernate" %>
<%@ page import="com.blog.blog.model.User" %>
<%@ page import="com.blog.blog.model.Tag" %>
<%@ page import="com.blog.blog.repository.interfaces.TagRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.TagRepositoryHibernate" %><%--
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

    String tagId = request.getParameter("id");
    if (tagId == null) response.sendError(HttpServletResponse.SC_BAD_REQUEST);

    TagRepository tagRepository = new TagRepositoryHibernate();
    Tag tag = tagRepository.get(Integer.parseInt(tagId));

    String isStaff = null;
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("isStaff")) {
            isStaff = cookie.getValue();
        }
    }
    if (isStaff == null || isStaff == "false") {
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
    }
%>
<form action="tagService" method="post">
    <input type="text" hidden="hidden" id="action" name="action" value="deleteTag"/>
    <input type="text" hidden="hidden" id="tagId" name="tagId" value="<%=tag.getId()%>"/>
    <button type="submit" class="submit">delete</button>
</form>

<form action="tagService" method="post">
    <input type="text" hidden="hidden" id="action2" name="action" value="updateTag"/>
    <input type="text" hidden="hidden" id="tagId2" name="tagId" value="<%=tag.getId()%>"/>
    <input type="text" id="tagName" name="tagName" value="<%=tag.getName()%>"/>
    <button type="submit" class="submit">update</button>
</form>
</body>
</html>
