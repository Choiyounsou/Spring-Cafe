<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO, user.User" %>
<% String userID = (String) session.getAttribute("userID"); %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>나의 정보</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/custom.css">
</head>
<body>
    <nav class="navbar navbar-default">
        <!-- 네비게이션 바 내용 -->
    </nav>

    <div class="container">
        <h2>나의 정보</h2>
        <div class="row">
            <div class="col-md-6">
                <% 
                    UserDAO userDAO = new UserDAO();
                    User userInfo = userDAO.getUserInfo(userID);
                    if (userInfo != null) {
                %>
                <table class="table table-bordered">
                    <tbody>
                        <tr>
                            <th>아이디</th>
                            <td><%= userID %></td>
                        </tr>
                        <tr>
                            <th>이름</th>
                            <td><%= userInfo.getUserName() %></td>
                        </tr>
                        <tr>
                            <th>성별</th>
                            <td><%= userInfo.getUserGender() %></td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td><%= userInfo.getUserEmail() %></td>
                        </tr>
                        <tr>
                            <th>생년월일</th>
                            <td><%= userInfo.getBirth() %></td>
                        </tr>
                        <tr>
                            <th>전화번호</th>
                            <td><%= userInfo.getpNumber() %></td>
                        </tr>
                        <tr>
                            <th>주소</th>
                            <td><%= userInfo.getAddress() %></td>
                        </tr>
                    </tbody>
                </table>
                <% } else { %>
                <p>사용자 정보를 불러올 수 없습니다.</p>
                <% } %>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src="js/bootstrap.js"></script>
</body>
</html>
