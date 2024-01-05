<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO, user.User"%>
<% String userID = (String) session.getAttribute("userID"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>

<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Elegant Dashboard | Dashboard</title>
<!-- Favicon -->
<link rel="shortcut icon" href="./img/svg/logo.svg" type="image/x-icon">
<!-- Custom styles -->
<link rel="stylesheet" href="./css/style.css">

</head>
<body>
	<div class="layer"></div>
	<!-- ! Body -->
	<a class="skip-link sr-only" href="#skip-target">Skip to content</a>
	<div class="page-flex">
		<!-- ! Sidebar -->
		<aside class="sidebar">
			<div class="sidebar-start">
				<div class="sidebar-head">
					<a href="main2.jsp" class="logo-wrapper" title="Home"> <span
						class="sr-only">홈</span> <span class="icon logo"
						aria-hidden="true"></span>
						<div class="logo-text">
							<span class="logo-title">게시판</span>
						</div>

					</a>
					<button class="sidebar-toggle transparent-btn" title="Menu"
						type="button">
						<span class="sr-only">Toggle menu</span> <span
							class="icon menu-toggle" aria-hidden="true"></span>
					</button>
				</div>
				<div class="sidebar-body">
					<ul class="sidebar-body-menu">
						<li><a class="active" href="main2.jsp"><span
								class="icon home" aria-hidden="true"></span>홈</a></li>
						<li><a class="active" href="bbs2.jsp?category=greeting">
								<span class="icon document" aria-hidden="true"></span>가입인사
						</a></li>
						<li><a class="active" href="bbs2.jsp?category=recent"> <span
								class="icon document" aria-hidden="true"></span>최근 게시물
						</a></li>
						<li><a class="active" href="bbs2.jsp?category=free"> <span
								class="icon document" aria-hidden="true"></span>자유게시판
						</a></li>

						<li><a class="show-cat-btn" href="##"> <span
								class="icon folder" aria-hidden="true"></span>카테고리 <span
								class="category__btn transparent-btn" title="Open list">
									<span class="sr-only">Open list</span> <span
									class="icon arrow-down" aria-hidden="true"></span>
							</span>
						</a>
							<ul class="cat-sub-menu">
								<li><a href="bbs2.jsp?category=sports">스포츠</a></li>
								<li><a href="bbs2.jsp?category=economy">경제</a></li>
								<li><a href="bbs2.jsp?category=entertainment">연예</a></li>
								<li><a href="bbs2.jsp?category=food">음식</a></li>
								<li><a href="bbs2.jsp?category=science">과학</a></li>
							</ul></li>
				</div>
			</div>
		</aside>
		<div class="main-wrapper">
			<!-- ! Main nav -->
			<nav class="main-nav--bg">
				<div class="container main-nav">
					<div class="main-nav-start">
						<div class="search-wrapper">
							<i data-feather="search" aria-hidden="true"></i> <input
								type="text" placeholder="Enter keywords ..." required>
						</div>
					</div>
					<div class="main-nav-end">
						<%
						if (userID == null) {
						%>
						<a href="login.jsp" class="input-submit">로그인</a> <a
							href="join.jsp" class="input-submit">회원가입</a>
						<%
						} else {
						%>
						<h3>
							환영합니다!<br>
							<%=userID%>
							님!
						</h3>
						<a href="logoutAction.jsp" class="input-submit">로그아웃</a>
						<%
						}
						%>
					</div>
				</div>
			</nav>
			<!-- ! Main -->
			<main class="main users chart-page" id="skip-target">
				<div class="container">

					<div class="row" >
						<div class="col-lg-12">
							<div
								style="display: flex; justify-content: space-between; align-items: center;">
								<h2 class="main-title">나의 정보</h2>

							</div>
							<div class="users-table">
							<% 
                    UserDAO userDAO = new UserDAO();
                    User userInfo = userDAO.getUserInfo(userID);
                    if (userInfo != null) {
                %>
							
								<table class="info-table">
									<colgroup>
										<col style="width: 25%;">
										<!-- 첫 번째 열 너비 -->
										<col style="width: 85%;">
										<!-- 두 번째 열 너비 -->

									</colgroup>

									<tbody>
										<tr>
											<td style="border-right: 2px solid #EEEEEE; padding: 0;">아이디</td>
											<td style="padding: 0;"><%= userID %></td>
										</tr>
										<tr>
											<td style="border-right: 2px solid #EEEEEE; padding: 0;">이름</td>
											<td style="padding: 0;"><%= userInfo.getUserName() %></td>
										</tr>
										<tr>
											<td style="border-right: 2px solid #EEEEEE; padding: 0;">성별</td>
											<td style="padding: 0;"><%= userInfo.getUserGender() %></td>
										</tr>
										<tr>
											<td style="border-right: 2px solid #EEEEEE; padding: 0;">이메일</td>
											<td style="padding: 0;"><%= userInfo.getUserEmail() %></td>
										</tr>
										<tr>
											<td style="border-right: 2px solid #EEEEEE; padding: 0;">생년월일</td>
											<td style="padding: 0;"><%= userInfo.getBirth() %></td>
										</tr>
										<tr>
											<td style="border-right: 2px solid #EEEEEE; padding: 0;">전화번호</td>
											<td style="padding: 0;"><%= userInfo.getpNumber() %></td>
										</tr>
										<tr>
											<td style="border-right: 2px solid #EEEEEE; padding: 0;">주소</td>
											<td style="padding: 0;"><%= userInfo.getAddress() %></td>
										</tr>
									</tbody>
								</table>
								<% } else { %>
                <p>사용자 정보를 불러올 수 없습니다.</p>
                <% } %>
							</div>
						</div>
					</div>

				</div>
			</main>
		</div>
	</div>
	<!-- Chart library -->
	<script src="./plugins/chart.min.js"></script>
	<!-- Icons library -->
	<script src="plugins/feather.min.js"></script>
	<!-- Custom scripts -->
	<script src="js/script.js"></script>

</body>
</html>