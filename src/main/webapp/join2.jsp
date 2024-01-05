<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Elegant Dashboard | Sign Up</title>
<!-- Favicon -->
<link rel="shortcut icon" href="./img/svg/logo.svg" type="image/x-icon">
<!-- Custom styles -->
<link rel="stylesheet" href="./css/style.css">
</head>

<body>
	<div class="layer"></div>
	<main class="page-center">
		<article class="sign-up">
			<h1 class="sign-up__title">회원가입</h1>
			<form class="sign-up-form form" action="joinAction.jsp" method="post">
				<label class="form-label-wrapper">
					<p class="form-label">아이디</p> <input type="text" class="form-input"
					placeholder="아이디" name="userID" maxlength="20">
				</label> <label class="form-label-wrapper">
					<p class="form-label">비밀번호</p> <input type="password"
					class="form-input" placeholder="비밀번호" name="userPassword"
					maxlength="20">

				</label> <label class="form-label-wrapper">
					<p class="form-label">이름</p> <input type="text" class="form-input"
					placeholder="이름" name="userName" maxlength="20">

				</label>

				<!-- 생년월일 -->
				<label class="form-label-wrapper">
					<p class="form-label">생년월일</p> <input type="text"
					class="form-input" placeholder="생년월일" name="birth" maxlength="10">
				</label>

				<!-- 전화번호 -->
				<label class="form-label-wrapper">
					<p class="form-label">생년월일</p> <input type="text"
					class="form-input" placeholder="전화번호" name="pNumber" maxlength="20">
				</label>

				<!-- 주소 -->
				<label class="form-label-wrapper">
					<p class="form-label">생년월일</p> <input type="text"
					class="form-input" placeholder="주소" name="address" maxlength="100">
				</label>
				<div style="text-align: center;">
					<div>
						<label> <input type="radio" name="userGender" value="남자"
							checked> 남자
						</label> <label> <input type="radio" name="userGender" value="여자">
							여자
						</label>
					</div>
				</div>
				<label class="form-label-wrapper">
					<p class="form-label">이메일</p> <input type="email"
					class="form-input" placeholder="이메일" name="userEmail"
					maxlength="20">

				</label> <input type="submit"
					class="form-btn primary-default-btn transparent-btn" value="회원가입">
			</form>
		</article>
	</main>
	<!-- Chart library -->
	<script src="./plugins/chart.min.js"></script>
	<!-- Icons library -->
	<script src="plugins/feather.min.js"></script>
	<!-- Custom scripts -->
	<script src="js/script.js"></script>
</body>

</html>