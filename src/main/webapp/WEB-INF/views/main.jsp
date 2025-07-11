<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>나띵 메인</title>
    <style>
        body { font-family: Arial; margin: 20px; }
        .post-box {
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
        }
        .blurred { color: #999; font-style: italic; }
    </style>
</head>
<body>
<h1>📌 최신 게시글</h1>

<c:forEach var="post" items="${postList}">
    <div class="post-box">
        <div>
            <strong>감정:</strong> ${post.emotion}  
            <span style="float:right">${post.createdAt}</span>
        </div>
        <div class="${post.blurred ? 'blurred' : ''}">
            ${post.content}
        </div>
        <c:if test="${post.imageUrl != null}">
            <div><img src="${post.imageUrl}" style="max-width: 300px; margin-top: 10px;"></div>
        </c:if>
        <div style="margin-top: 10px;">
            ❤️ ${post.likeCount} &nbsp;&nbsp;
            🔁 ${post.repostCount}
        </div>
    </div>
</c:forEach>

</body>
</html>
