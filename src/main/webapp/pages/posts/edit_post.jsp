<%@ page import="com.blog.blog.model.Post" %>
<%@ page import="com.blog.blog.repository.interfaces.PostRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.PostRepositoryHibernate" %>
<%@ page import="com.blog.blog.repository.interfaces.TagRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.TagRepositoryHibernate" %>
<%@ page import="com.blog.blog.model.Tag" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.UserRepositoryHibernate" %>
<%@ page import="com.blog.blog.repository.interfaces.UserRepository" %>
<%@ page import="com.blog.blog.model.User" %>
<%@ page import="java.util.List" %><%--
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
    boolean isAdmin = false;
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("userId")) {
            userId = Integer.parseInt(cookie.getValue());
        }
        if (cookie.getName().equals("isAdmin")) {
            isAdmin = Boolean.parseBoolean(cookie.getValue());
        }
    }
    if (userId == -1 || (post.getCreator().getId() != userId && !isAdmin)) {
        response.sendError(HttpServletResponse.SC_UNAUTHORIZED);
    }
%>
<form action="postService" method="post">
    <input type="text" hidden="hidden" id="action" name="action" value="updatePost"/>
    <input type="text" hidden="hidden" id="postId" name="postId" value="<%=post.getId()%>"/>
    <span>tags
    <%
        TagRepository tagRepository = new TagRepositoryHibernate();
        List<Tag> parentTags = post.getTags();
        post.getTags().stream().forEach(System.out::println);
        for (Tag t : tagRepository.getAll()) {
    %>
    <label>
        <input type="checkbox" name="tags" value="<%=t.getId()%>" <%if(parentTags.contains(t)){%>checked="checked"<%}%> ><%=t.getName()%>
    </label>
    <%
        }
    %>
    </span>
    <br>
    <% if (isAdmin) {
    %>
    <label for="creator">creator</label>
    <select name="creator" id="creator">
        <%
            UserRepository userRepository = new UserRepositoryHibernate();
            for (User u : userRepository.getAll()) {
        %>
        <option value="<%=u.getId()%>"
                <%if (u.getId() == post.getCreator().getId()){%>selected<%}%>><%=u.getUsername()%>
        </option>
        <%
            }
        %>
    </select><br>
    <%
        }
    %>
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
