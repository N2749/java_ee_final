<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>
  <style>body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
  }

  .container {
    max-width: 960px;
    margin: 0 auto;
    padding: 20px;
  }

  /* Заголовок */
  h1 {
    font-size: 32px;
    text-align: center;
    margin-bottom: 20px;
  }

  /* Описание блога */
  .blog-description {
    text-align: center;
    margin-bottom: 40px;
  }
  </style>
</head>
<body>
<jsp:include page="/components/header.jsp"></jsp:include>
<div class="container">
  <h1>Blog of cultivators</h1>
  <div class="blog-description">
    <p>Genre - "cultivators", 99% is manhua.
      The genre has such aspects as meditation and increasing the strength of the character with the help of scrolls and meditation.
      From what I read, according to the structure of the plot, they are divided mainly into 2 types and look something like this:</p>
    <p>1) There was a master, he was almost a god, but then somehow he was reborn into the past or into another body and now, with all the knowledge, he will develop by leaps and bounds (sometimes connected with the second).
      2) There was a nobody man, he didn’t know how to do anything, he couldn’t achieve anything, and then at some point he either becomes a “genius” or finds crap that makes him a genius.</p>

  </div>
</div>

</body>
</html>