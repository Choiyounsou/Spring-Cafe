<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width initial-scale=1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>BIT 게시판 웹 사이트</title>
</head>
<body>
	<%	
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">BIT 게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">게시판<span class="caret"></span></a>
					<ul class="dropdown-menu">

						<li><a href="bbs.jsp?category=free">자유게시판</a>
						<li><a href="bbs.jsp?category=sports">스포츠</a></li>
						<li><a href="bbs.jsp?category=economy">경제</a></li>
						<li><a href="bbs.jsp?category=entertainment">연예</a></li>

					</ul></li>
			</ul>

			<%
				if(userID == null){

			%>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul></li>
			</ul>

			<%
			}
			else
			{
				
			%>

			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
						<li><a href="myInfo.jsp">내 정보</a></li>
						<li><a href="myWrite.jsp">내가 쓴 글</a></li>
					</ul></li>
			</ul>

			<%
			}
			%>
		</div>
	</nav>

	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>BIT 카페에 오신걸 환영합니다!</h1>
				<p>안녕하세요!</p>
				<p>
					<a class="btn btn-primary btn-pull"
						href="https://weather.naver.com/" role="button">오늘의 날씨</a>
				</p>
			</div>
		</div>
	</div>

	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>

			<div class="carousel-inner">
				<div class="item active">
					<img src="images/1.jpg"> <a class="btn btn-primary btn-pull"
						href="https://entertain.naver.com/home" role="button">연예 기사</a>
				</div>
				<div class="item">
					<img src="images/2.jpg"> <a class="btn btn-primary btn-pull"
						href="https://sports.news.naver.com/index" role="button">스포츠
						기사</a>
				</div>
				<div class="item">
					<img src="images/3.jpg"> <a class="btn btn-primary btn-pull"
						href="https://news.naver.com/main/main.naver?mode=LSD&mid=shm&sid1=101"
						role="button">경제 기사</a>
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a> <a class="right carousel-control" href="#myCarousel"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js">
	</script>
	<script src="js/bootstrap.js"></script>
</body>
</html>

