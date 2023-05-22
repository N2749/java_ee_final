<%--
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
<form id="form" action="/postService" method="post">
    <input type="text" hidden="hidden" id="action" name="action" value="createPost"/>
    <label for="title">title</label> <br>
    <input type="text" id="title" name="title" placeholder="sunny day" required="required"> <br>

    <label for="text">text</label> <br>
    <textarea name="text" placeholder="My name is Kira Yoshikage..." id="text" required="required"></textarea> <br>

    <button type="submit" class="submit">post!</button>
</form>

</body>
</html>
