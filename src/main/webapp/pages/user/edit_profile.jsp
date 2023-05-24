<%@ page import="com.blog.blog.model.User" %>
<%@ page import="com.blog.blog.repository.implementation.hibernate.UserRepositoryHibernate" %>
<%@ page import="com.blog.blog.repository.interfaces.UserRepository" %><%--
  Created by IntelliJ IDEA.
  User: nurba
  Date: 24.05.2023
  Time: 23:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }

        body {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }

        article {
            display: flex;
            align-items: center;
            justify-content: center;
            flex: 1;
        }

        form {
            border: 2px solid black;
            padding: 2rem;
        }

        .submit {
            display: block;
            margin: 1rem auto;
            padding: 0.2rem;
        }
    </style>
</head>
<body>

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
<jsp:include page="../../components/header.jsp"></jsp:include>
<article>
    <form id="form" action="users" method="post">
        <input type="text" hidden="hidden" id="action" name="action" value="updateUser"/>
        <input type="text" hidden="hidden" id="userId" name="userId" value="<%=user.getId()%>"/>
        <label for="username">username</label> <br>
        <input type="text" id="username" name="username" placeholder="cool_dude" required="required"
               value="<%=user.getUsername()%>"> <br>

        <label for="login">login</label> <br>
        <input id="login" type="text" name="login" placeholder="cool.dude@awesome.com" required="required"
               value="<%=user.getLogin()%>"> <br>

        <label for="password">password</label> <br>
        <input type="password" name="password" placeholder="********" id="password" required="required"> <br>

        <label for="see">show</label>
        <input id="see" type="checkbox" name="see" onclick="showPassword()" id="check"><br>

        <button type="submit" class="submit">register</button>
    </form>
</article>
<script>
    function showPassword() {
        let input = document.getElementById("password");
        let type = document.getElementById("see").checked ? "text"
            : "password";
        input.setAttribute("type", type);
    }
</script>
</body>
</html>
