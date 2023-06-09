<%--
  Created by IntelliJ IDEA.
  User: nurba
  Date: 17.05.2023
  Time: 22:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
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
<jsp:include page="../../components/header.jsp"></jsp:include>
<article>
    <form id="form" action="users" method="post">
        <input type="text" hidden="hidden" id="action" name="action" value="logIn"/>
        <label for="login">login</label> <br>
        <input id="login" type="text" name="login" placeholder="cool_username334"> <br>

        <label for="password">password</label><br>
        <input id="password" type="password" name="password" placeholder="********">
        <br>
        <label for="check">show password</label>
        <input type="checkbox" name="see" onclick="showPassword()" id="check"><br>
        <button type="submit" class="submit">login</button>
        <p>
            Don't have an account? <br> <a href="register">Register</a>
        </p>
    </form>

</article>
<script>
    function showPassword() {
        input = document.getElementById("password");
        let type = document.getElementById("check").checked ? "text"
            : "password";
        input.setAttribute("type", type);
    }
</script>
</body>
</html>
