<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">

	<script>
		
	</script>

<body>

	<nav class="navbar" role="navigation">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#top-navbar-1">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<h1 class = "navbar-brand" id = "goMainPage"><span class="violet" style = "cursor:pointer;">Ballochilly</span></h1>
			</div>
			<div class="collapse navbar-collapse" id="top-navbar-1">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown active" id = "goMainHome">
						<a href="./main.do" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000">
							<i class="fa fa-home"></i><br>Home
						</a>
					</li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000">
							<i class="fa fa-soccer-ball-o"></i><br>stadium<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="./allStadiumList.do">경기시설</a></li>
							<li><a href="./listBoard.do">이용후기</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	
</body>

</html>