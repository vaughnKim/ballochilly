<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<li class = "dropdown">
		<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000"> 
			<i class="fa fa-user fa-fw"></i><br> <span class="violet">${user.NAME}</span><span class="caret"></span>
		</a>
		<ul class="dropdown-menu" role="menu">
			<li><a href="./modifyInfo.do">정보수정</a></li>
			<li><a href="./message.do">메시지함</a></li>
			<li><a href="./userTeam.do">내팀정보</a></li>
			<li><a href="./myReservation.do">예약현황보기</a></li>
			<li><a href="./logout.do">로그아웃</a></li>
		</ul>
	</li>

</body>
</html>