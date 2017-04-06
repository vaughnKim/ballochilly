<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">

	<script>
		$().ready(function(){
			
			goMainPage();
			loginShow();
			delBtn();
			$("#loginForm").draggable();
			loginBtn();
			isExistMainId();
			
			$("#mainPw").keypress(function(event){
				if(event.keyCode == 13){
					$("#loginBtn").trigger("click");
				}
				
			});
			
			goPage();
			getLogin();
		});
		
		
		function setSave(name, value, expiredays) {
			var today = new Date();
			today.setDate(today.getDate() + expiredays);
			document.cookie = name + "=" + escape(value) + ";path=/;expires=" + today.toGMTString() + ";';"
		}
		
		function saveLogin(id) {
			if(id != "") {
				// userId 쿠키에 id값을 7일간 저장
				setSave("id", id, 7);
			} else {
// 				userId 쿠키 삭제
				setSave("id", id, -1);
			}
		}
		
		function getLogin() {
			var cook = document.cookie + ";";
			var idx = cook.indexOf("id", 0);
			var val = "";
			
			if(idx != -1) {
				cook = cook.substring(idx, cook.length);
				begin = cook.indexOf("=", 0) + 1;
				end = cook.indexOf(";", begin);
				val = unescape(cook.substring(begin, end));
// 				alert(cook);
// 				alert(val);
			}
			
			if (val != "") {
// 				alert($("#mainId").val());
				document.getElementById("mainId").value = val;
				document.getElementById("idcheck").checked = true;
				document.getElementById("loginId").value = val;
				document.getElementById("checkid").checked = true;
			}
			
		}
		
		
		
		function goPage() {
			
			$("#goJoinMember").click(function(){
				location.href = "./joinMember.do";
			});
			$("#goSearchInfo").click(function(){
				location.href = "./serachForInfo.do";
			});
		}
		
		function loginShow() {
			
			$("#loginShow").click(function(event){
				
				$("#loginForm").show();
				
			});	//end click
			
		}	//end loginShow
		
		function delBtn() {
			
			$("#delBtn").click(function(){
				
				$("#loginForm").hide();
				
			});	//end click
			
		}	//end delBtn
		
		function goMainPage() {
			
			$("#goMainPage, #goMainHome").click(function(){
				
				location.href = "./main.do";
				
			});	//end click
			
		}	//end goMainPage
		
		function isExistMainId() {
			
			$("#mainId").blur(function(){
				
				var id = $("#mainId").val();
				
				if(id != "") {
					
					$.ajax({
						
						url : "./isExistId.do",
						type : "post",
						data : {"id" : id},
						success : function(data) {
							
							if(data.code == 200) {
								
								$("#mainIdText").text("good").css("color", "blue");
								
							} else if (data.code == 201){
								
								$("#mainId").val("");
								$("#mainId").focus();
								$("#mainIdText").text("해당 ID 없음!!").css("color", "red");
								
							}	//end if
						}
						
					});
					
				}
				
			});
			
		}
		
		function loginBtn() {
			
			$("#loginBtn").click(function(){
				
				if (document.getElementById("idcheck").checked) {
// 					alert(1);
					saveLogin(document.getElementById("mainId").value);
				} else {
// 					alert(2);
					saveLogin("");
				}
				
				var id = $("#mainId").val();
    			var pw = $("#mainPw").val();
    			
    			if(id != "" && pw != "") {
    				
    				$.ajax({
    					
    					url : "./login.do",
    					type : "post",
    					data : {"id" : id, "pw" : pw},
    					success : function(data) {
    						
    						if(data.code == 200) {
    							location.reload();
    						} else if(data.code == 201){
    							$("#mainIdText").text(data.msg).css("color", "red");
    							$("#mainPw").val("");
    							$("#mainPw").focus();
    						}
    						
    					}
    					
    				});
    				
    				return false;
    			} else if (id == "") {
    				alert("아이디를 입력하세요.");
					$("#mainId").focus();
    			} else if (pw == "") {
    				alert("비밀번호를 입력하세요.");
					$("#mainPw").focus();
    			}
				
			});
			
		}
		
		
	
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
				<h1 class = "navbar-brand" id = "goMainPage"><span class="violet" style = "cursor:pointer;" id = "mainText">Ballochilly</span></h1>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse" id="top-navbar-1">
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown active" id = "goMainHome">
						<a href="./main.do" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000">
							<i class="fa fa-home"></i><br>Home
						</a>
					</li>
					<c:if test="${master == null}">
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000">
							<i class="fa fa-question"></i><br>About<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
<!-- 							<li><a href="#">소개</a></li> -->
<!-- 							<li><a href="#">인사말</a></li> -->
<!-- 							<li><a href="#">정보</a></li> -->
							<li><a href="./videoBoard.do">풋살동영상</a></li>
							<li><a href="./rule.do">경기규칙 / 룰</a></li>
						</ul>
					</li>
<!-- 					<li class="dropdown"> -->
<!-- 						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000"> -->
<!-- 							<i class="fa fa-comments"></i><br>Cummunity<span class="caret"></span> -->
<!-- 						</a> -->
<!-- 						<ul class="dropdown-menu" role="menu"> -->
<!-- 						</ul> -->
<!-- 					</li> -->
					<li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000">
							<i class="fa fa-calendar"></i><br>reservation<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="./Reservation-date-search.do">날짜/시간 구장예약</a></li>
							<li><a href="./Reservation-location-search.do">지역검색 구장예약</a></li>
						</ul>
					</li>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000">
							<i class="fa fa-tasks"></i><br>team<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="./teamInfo.do">팀 정보 / 찾기</a></li>
							<li><a href="./teamRegister.do">팀 등록</a></li>
							<li><a href="./lookForTeamBoard.do">팀구하기</a></li>
							<li><a href="./lookForPlayerBoard.do">선수구하기</a></li>
						</ul>
					</li>
					</c:if>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000">
							<i class="fa fa-soccer-ball-o"></i><br>stadium<span class="caret"></span>
						</a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="./allStadiumList.do">경기시설</a></li>
							<li><a href="./listBoard.do">이용후기</a></li>
						</ul>
					</li>
					<c:if test="${master == null}">
						<c:if test="${user.ID == null}">
							<%@include file="../user/beforeLogin.jsp" %>
						</c:if>
						<c:if test="${user.ID != null}">
							<%@include file="../user/afterLogin.jsp" %>
						</c:if>
					
					<li class="dropdown" id = "loginForm" >
						<table class=" table-hover text-muted" style = "z-index:1000;">
							<tr>
								<td>
									&nbsp;
									<input type="checkbox" name="idcheck" id="idcheck" width = "70px"/>
									ID기억
								</td>
								<td colspan = "2" class = "text-right">
									<label id ="mainIdText"></label>
									<input type = "button" value = "X" id = "delBtn" class = "btn-top"/>
								</td>
							</tr>
							<tr>
								<td class = "text-right">ID &nbsp; </td>
								<td><input type = "text" name = "id" id = "mainId" size = "9" style = "border-radius: 21px;"/></td>
								<td rowspan = "2">
									<input type ="button" id = "loginBtn" 
														  value = "Login" 
														  class = "btn text-border" 
														  tabindex="3"/>
								</td>
							</tr>
							<tr>
								<td class = "text-right">PW &nbsp; </td>
								<td><input type = "password" name = "pw" id = "mainPw" size = "11" class = "text-border"  style = "height: 23px;"
								onkeypress="if(event.keyCode==13) {loginBtn(); return false;}"/></td>
							</tr>
							<tr class = "text-center">
								<td colspan = "3">
									<label id = "goJoinMember" style = "color: darkblue; cursor:pointer; font-size: 12px;">회원가입</label>
									<label id = "goSearchInfo" style = "color: darkblue; cursor:pointer; font-size: 12px;">아이디/비번찾기</label>
								</td>
							</tr>
						</table>
					</li>
					</c:if>
				</ul>
			</div>
		</div>
		
	</nav>
	
</body>

</html>