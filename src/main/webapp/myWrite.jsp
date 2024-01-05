<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO, bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>
<% String userID = (String) session.getAttribute("userID"); %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>내가 쓴 글</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/custom.css">
</head>
<body>
    <nav class="navbar navbar-default">
        <!-- 네비게이션 바 내용 -->
    </nav>

    <div class="container">
        <h2>내가 쓴 글</h2>
        <div class="row">
            <table class="table table-striped" style="text-align:center; border: 1px solid #dddddd;">
                <thead>
                    <tr>
                        <th style="background-color: #eeeeee;">번호</th>
                        <th style="background-color: #eeeeee;">제목</th>
                        <th style="background-color: #eeeeee;">작성일</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    BbsDAO bbsDAO = new BbsDAO();
                    ArrayList<Bbs> myPosts = bbsDAO.getMyPosts(userID);

                    for (Bbs post : myPosts) {
                %>
                    <tr>
                        <td><%= post.getBbsID() %></td>
                        <td><a href="view.jsp?bbsID=<%= post.getBbsID() %>"><%= post.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
                        <td><%= post.getBbsDate() %></td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>