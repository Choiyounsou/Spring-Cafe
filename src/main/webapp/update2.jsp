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
<script>
        function submitForm() {
            document.getElementById("myForm").submit();
        }
    </script>

</head>
<body>
	<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	int bbsID = 0;
	if (request.getParameter("bbsID") != null) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	}

	int pageNumber = 1;
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	String category = bbs.getCategory();
	%>
	<div class="layer"></div>
	<!-- ! Body -->
	<a class="skip-link sr-only" href="#skip-target">Skip to content</a>
	<div class="page-flex">
		<!-- ! Sidebar -->
		<aside class="sidebar">
			<div class="sidebar-start">
				<div class="sidebar-head">
					<a href="/" class="logo-wrapper" title="Home"> <span
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

					<div class="row">
						<div class="col-lg-12">
							<div
								style="display: flex; justify-content: space-between; align-items: center;">
								<h2 class="main-title"><%=BbsDAO.getCategoryInKorean(category)%></h2>

							</div>

							<div class="users-table table-wrapper">
							<form id="myForm" method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
								<table class="posts-table" style="text-align: center;">
									<colgroup>
										<col style="width: 15%;">
										<!-- 첫 번째 열 너비 -->
										<col style="width: 85%;">
										<!-- 두 번째 열 너비 -->

									</colgroup>

									<tbody>
										<tr>
											<td class="centered-cell">글제목</td>
											<td class="left-aligned-cell" colspan="2">
													<textarea
													placeholder="제목" name="bbsTitle" maxlength="2480"
													style="height: auto; width: 700px"><%=bbs.getBbsTitle()%></textarea>
												</td>
										</tr>
										<tr>
											<td class="centered-cell">작성자</td>
											<td class="left-aligned-cell" colspan="2"><%=bbs.getUserID()%></td>
										</tr>
										<tr>
											<td class="centered-cell">작성일자</td>
											<td class="left-aligned-cell" colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + " 시 "
		+ bbs.getBbsDate().substring(14, 16) + " 분"%></td>
										</tr>
										<tr>
											<td class="centered-cell">내용</td>
											<td class="left-aligned-cell" colspan="2"
												style="min-height: 200px; text-align: left;"><textarea
													placeholder="내용" name="bbsContent" maxlength="2480"
													style="height: 350px; width: 700px"><%=bbs.getBbsContent()%></textarea></td>
										</tr>
									</tbody>
								</table>
								<input type="hidden" name="category" value="<%=bbs.getCategory() %>">
								</form>						
							</div>
							<a href="bbs2.jsp?category=<%=category%>" class="input-submit">목록</a>
							<%
							if (userID != null && userID.equals(bbs.getUserID())) {
							%>			
							<input type="button" class="input-submit" value="수정" onclick="submitForm();" />
							<a onclick="return confirm('정말로 삭제하시겠습니까?');"
								href="deleteAction.jsp?bbsID=<%=bbsID%>" class="input-submit">삭제</a>
							<%
							}
							%>
							
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