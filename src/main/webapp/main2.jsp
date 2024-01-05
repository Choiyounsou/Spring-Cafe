<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="java.util.ArrayList"%>
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
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	String category = "free";
	if (request.getParameter("category") != null) {
		category = request.getParameter("category");
	}
	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
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
						<form action="bbs2.jsp" method="GET">
							<div class="search-wrapper">
								<i data-feather="search" aria-hidden="true"></i> <input
									type="text" name="keywords" placeholder="Enter keywords..."
									required>
								<button type="submit" class="input-submit">검색</button>
							</div>
						</form>
					</div>
					<div class="main-nav-end">
						<%
						if (userID == null) {
						%>
						<a href="login2.jsp" class="input-submit">로그인</a> <a
							href="join2.jsp" class="input-submit">회원가입</a>
						<%
						} else {
						%>
						<h3>
							환영합니다!<br>
							<%=userID%>
							님!
						</h3>
						<a href="myInfo2.jsp" class="input-submit">내 정보</a> <a
							href="myWrite2.jsp" class="input-submit">내가 쓴 글</a> <a
							href="logoutAction.jsp" class="input-submit">로그아웃</a>
						<%
						}
						%>
					</div>
				</div>
			</nav>
			<!-- ! Main -->
			<main class="main users chart-page" id="skip-target">
				<div class="container">

					<div class="row">
						<div class="col-lg-6">
							<h2 class="main-title">가입인사</h2>
							<div class="users-table table-wrapper">
								<table class="posts-table2" style="text-align: center;">
									<colgroup>
										<col style="width: 5%;">
										<!-- 첫 번째 열 너비 -->
										<col style="width: 40%;">
										<!-- 두 번째 열 너비 -->
										<col style="width: 10%;">
										<!-- 세 번째 열 너비 -->
										<col style="width: 10%;">
										<!-- 네 번째 열 너비 -->

									</colgroup>
									<thead>

										<tr class="users-table-info">
											<th>카테고리</th>
											<th class="max-width-column">제목</th>
											<th>작성자</th>
											<th>작성일</th>

										</tr>
									</thead>
									<tbody>
										<%
										BbsDAO bbsDAO = new BbsDAO();
										ArrayList<Bbs> list = bbsDAO.getListByCategory("greeting");
										int listSize = list.size();

										for (int i = 0; i < 6; i++) {
										%>
										<tr>
											<td><%=(i < listSize) ? BbsDAO.getCategoryInKorean(list.get(i).getCategory()) : ""%></td>
											<td>
												<%
												if (i < listSize) {
													out.print("<a href='view2.jsp?bbsID=" + list.get(i).getBbsID() + "'>" + list.get(i).getBbsTitle()
													.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")
													+ "</a>");
												}
												%>
											</td>
											<td><%=(i < listSize) ? list.get(i).getUserID() : ""%></td>
											<td><%=(i < listSize) ? list.get(i).getBbsDate().substring(0, 11) : ""%></td>
										</tr>
										<%
										}
										%>

									</tbody>
								</table>
							</div>
						</div>
						<div class="col-lg-6">
							<h2 class="main-title">최근 게시물</h2>
							<div class="users-table table-wrapper">
								<table class="posts-table2" style="text-align: center;">
									<colgroup>
										<col style="width: 5%;">
										<!-- 첫 번째 열 너비 -->
										<col style="width: 40%;">
										<!-- 두 번째 열 너비 -->
										<col style="width: 10%;">
										<!-- 세 번째 열 너비 -->
										<col style="width: 10%;">
										<!-- 네 번째 열 너비 -->

									</colgroup>
									<thead>
										<tr class="users-table-info">
											<th>카테고리</th>
											<th class="max-width-column">제목</th>
											<th>작성자</th>
											<th id="right-paddig">작성일</th>

										</tr>
									</thead>
									<tbody>
										<%
										list = bbsDAO.getListRecent(pageNumber);
										listSize = list.size();

										for (int i = 0; i < 6; i++) {
										%>
										<tr>
											<td><%=(i < listSize) ? BbsDAO.getCategoryInKorean(list.get(i).getCategory()) : ""%></td>
											<td>
												<%
												if (i < listSize) {
													out.print("<a href='view2.jsp?bbsID=" + list.get(i).getBbsID() + "'>" + list.get(i).getBbsTitle()
													.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")
													+ "</a>");
												}
												%>
											</td>
											<td><%=(i < listSize) ? list.get(i).getUserID() : ""%></td>
											<td><%=(i < listSize) ? list.get(i).getBbsDate().substring(0, 11) : ""%></td>
										</tr>
										<%
										}
										%>

									</tbody>
								</table>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-lg-12">
							<h2 class="main-title">자유게시판</h2>
							<div class="users-table table-wrapper">
								<table class="posts-table" style="text-align: center;">
									<colgroup>
										<col style="width: 5%;">
										<!-- 첫 번째 열 너비 -->
										<col style="width: 40%;">
										<!-- 두 번째 열 너비 -->
										<col style="width: 10%;">
										<!-- 세 번째 열 너비 -->
										<col style="width: 10%;">
										<!-- 네 번째 열 너비 -->
									</colgroup>
									<thead>
										<tr class="users-table-info">
											<th>카테고리</th>
											<th class="max-width-column">제목</th>
											<th>작성자</th>
											<th>작성일</th>
										</tr>
									</thead>
									<tbody>
										<%
										list = bbsDAO.getListMain(category);
										listSize = list.size();

										for (int i = 0; i < Math.max(6, listSize); i++) {
										%>
										<tr>
											<td><%=(i < listSize) ? BbsDAO.getCategoryInKorean(list.get(i).getCategory()) : ""%></td>
											<td>
												<%
												if (i < listSize) {
													out.print("<a href='view2.jsp?bbsID=" + list.get(i).getBbsID() + "'>" + list.get(i).getBbsTitle()
													.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")
													+ "</a>");
												}
												%>
											</td>
											<td><%=(i < listSize) ? list.get(i).getUserID() : ""%></td>
											<td><%=(i < listSize) ? list.get(i).getBbsDate().substring(0, 11) : ""%></td>
										</tr>
										<%
										}
										%>

									</tbody>
								</table>
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