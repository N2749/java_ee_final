<%@ page import="com.blog.blog.model.Post" %>
<%@ page import="com.blog.blog.model.Comment" %>
<%@ page import="com.blog.blog.repository.interfaces.PostRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.PostRepositoryHibernate" %>
<%@ page import="com.blog.blog.repository.interfaces.TagRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.TagRepositoryHibernate" %>
<%@ page import="com.blog.blog.model.Tag" %>
<%@ page import="com.blog.blog.repository.interfaces.CommentRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.CommentRepositoryHibernate" %>
<%@ page import="java.util.ArrayList" %><%--
<%@ page import="com.blog.blog.repository.implementation.hibernate.PostRepositoryHibernate" %>
<%@ page import="com.blog.blog.repository.interfaces.CommentRepository" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.CommentRepositoryHibernate" %>

<%@ page import="java.util.ArrayList" %><%--
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
    <style>
        .popup {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .popup-content {
            background-color: white;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 50%;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
    <script>
        function openPopup1() {
            var popup = document.getElementById("popup1");
            popup.style.display = "block";
        }

        function closePopup1() {
            var popup = document.getElementById("popup1");
            popup.style.display = "none";
        }

        function openPopup2() {
            var popup = document.getElementById("popup2");
            popup.style.display = "block";
        }

        function closePopup2() {
            var popup = document.getElementById("popup2");
            popup.style.display = "none";
        }

        function openPopup3() {
            var popup = document.getElementById("popup3");
            popup.style.display = "block";
        }

        function closePopup3() {
            var popup = document.getElementById("popup3");
            popup.style.display = "none";
        }

    </script>
</head>
<body>
<jsp:include page="../../components/header.jsp"></jsp:include>
<%
    PostRepository postRepository = new PostRepositoryHibernate();
    CommentRepository commentRepository = new CommentRepositoryHibernate();
    Comment com = commentRepository.get(Integer.parseInt(request.getParameter("id")));
    Post post = postRepository.get(Integer.parseInt(request.getParameter("id")));

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
    if (userId != -1 && (post.getCreator().getId() == userId || isAdmin)) {
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
<p>Tags:
    <%
        for (Tag t : post.getTags()) {
    %>
    <span><%=t.getName()%>, </span>
    <%
        }
    %>
</p>
<p><%=post.getText()%>
</p>
<br>
<h4>Comments: </h4>
<%
    if (userId != -1) {
%>
<button onclick="openPopup1()">Create</button>
<%
    }
%>
<div id="popup1" class="popup">
    <div class="popup-content">
        <span class="close" onclick="closePopup1()">&times;</span>
        <form action="commentService" method="post">
            <input type="text" hidden="hidden" id="action2" name="action" value="createComment"/>
            <input type="text" hidden="hidden" name="post_id" value="<%=post.getId()%>"/>
            <label for="text">Text:</label>
            <input type="text" id="text" name="text">
            <br>
            <input type="submit" name="action" value="create">
        </form>
    </div>
</div>
<br>
<%

    ArrayList<Comment> posts = commentRepository.getAll();
    if (posts.size() > 0)
        for (Comment p : posts) {
            if (p.getPost().getId() == post.getId()) {
                if (userId != -1 && p.getCreator().getId() == userId) {
%>
<div>
    <button onclick="openPopup2()">Edit</button>
    <button onclick="openPopup3()">Delete</button>
    <div id="popup2" class="popup">
        <div class="popup-content">
            <span class="close" onclick="closePopup2()">&times;</span>
            <form action="commentService" method="post">
                <input type="text" hidden="hidden" name="action" value="updateComment"/>
                <input type="text" hidden="hidden" name="comment_id" value="<%=p.getId()%>"/>
                <label for="text">Text:</label>
                <input type="text" name="text">
                <br>
                <input type="submit" name="action" value="edit">
            </form>
        </div>
    </div>
    <div id="popup3" class="popup">
        <div class="popup-content">
            <span class="close" onclick="closePopup3()">&times;</span>
            <form action="commentService" method="post">
                <input type="text" hidden="hidden" name="action" value="deleteComment"/>
                <input type="text" hidden="hidden" name="comment_id" value="<%=p.getId()%>"/>
                <H4>Are you sure?</H4>
                <br>
                <input type="submit" name="action" value="Yes">
                <input onclick="closePopup3()" type="button" value="No">
            </form>

        </div>
    </div>
    <%
        }
    %>
    <p><%=p.getText()%> by <%=p.getCreator().getUsername()%>
    </p>
</div>


<%
        }
    }
else {
%>
<p>nothing here...</p>
<%
    }
%>

</body>
</html>
