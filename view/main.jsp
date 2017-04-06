<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">

    <head>
        <%@include file="sub/subfile.jsp" %>
    </head>
    <link rel="stylesheet" href="assets/bootstrap/css/setCss.css">
    <script>
    	
		
		$().ready(function(){
			
			$("#tabs").tabs();
			masterLogin();
			
			$("#loginId").focus();
			
			goPage_Main();
			isExistId_Main();
			mainLogin();
			
			deojeonWeatherInfo();
			
			$("#pw").keypress(function(event){
				if(event.keyCode == 13){
					$("#mainLogin").trigger("click");
				}
				
			});
			
		});
		
		function deojeonWeatherInfo(){
			
			var count = 0;
			
			$("#deojeonWeatherInfo").click(function(){
				
				count++;
				if(count == 5) {
					alert("대전 기상청 믿을 수가 없어요!!!!!!!!!");
					count = 0;
				}
				
			});
			
		}
		
		
		var newDate = new Date();
		var yy = newDate.getFullYear();
		var mm = newDate.getMonth()+1;
		var dd = newDate.getDate();
		
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
			}
			
			if (val != "") {
				document.getElementById("loginId").value = val;
				document.getElementById("checkid").checked = true;
			}
			
		}
		
		
		function goPage_Main() {
			
			$("#goJoinMemberPage").click(function(){
				location.href = "./joinMember.do";
			});
			$("#goSearchInfoPage").click(function(){
				location.href = "./serachForInfo.do";
			});
			$("#userIdText").click(function(){
				location.href = "./modifyInfo.do";
			});
			$("#myInfoModify").click(function(){
				location.href = "./modifyInfo.do";
			});
			$("#myNotePage").click(function(){
				location.href = "./message.do";
			});
			$("#myNotePage2").click(function(){
				location.href = "./message.do";
			});
			$("#receiverTeamMsg").click(function(){
				location.href = "./message.do";
			});
			$("#receiverTeamMsg2").click(function(){
				location.href = "./message.do";
			});
			$("#myReservationPage").click(function(){
				location.href = "./myReservation.do";
			});
			$("#myTeamInfo").click(function(){
				location.href = "./userTeam.do";
			});
// 			$("#logoutBtn").click(function(){
// 				location.href = "./logout.do";
// 			});
			$("#masterLogout").click(function(){
				location.href = "./masterLogout.admin";
			});
			
		}
		
		function isExistId_Main() {
			
			$("#loginId").blur(function(){
				
				var id = $("#loginId").val();
				
				if(id != "") {
					
					$.ajax({
						
						url : "./isExistId.do",
						type : "post",
						data : {"id" : id},
						success : function(data) {
							
							if(data.code == 200) {
								
								$("#idText").text("good").css("color", "blue");
								
							} else if (data.code == 201){
								
								$("#loginId").val("");
								$("#loginId").focus();
								$("#idText").text("해당 ID 없음!!").css("color", "red");
								
							}	//end if
						}
						
					});
					
				}
				
				
			});
			
			
		}
		
		function mainLogin() {
			
			$("#mainLogin").click(function(){
				
				if (document.getElementById("checkid").checked) {
// 					alert(1);
					saveLogin(document.getElementById("loginId").value);
				} else {
// 					alert(2);
					saveLogin("");
				}
				
				var id = $("#loginId").val();
    			var pw = $("#pw").val();
				
				if(id != "" && pw != "") {
    				
    				$.ajax({
    					
    					url : "./login.do",
    					type : "post",
    					data : {"id" : id, "pw" : pw},
    					success : function(data) {
    						
    						if(data.code == 200) {
    							location.reload();
    						} else if(data.code == 201){
    							$("#idText").text(data.msg).css("color", "red");
    							$("#pw").val("");
    							$("#pw").focus();
    						}
    						
    					}
    					
    				});
    				
    				return false;
    				
    			} else if (id == "") {
    				alert("아이디를 입력하세요.");
					$("#loginId").focus();
    				
    			} else if (pw == "") {
    				alert("비밀번호를 입력하세요.");
					$("#pw").focus();
    			}
    			
    			
			});
			
		}
		
		function masterLogin() {
			
			$("#masterLogin").click(function(){
				
				var masterId = $("#masterId").val();
    			var masterPw = $("#masterPw").val();
				
				if(masterId != "" && masterPw != "") {
    				
    				$.ajax({
    					
    					url : "./masterLogin.admin",
    					type : "post",
    					data : {"masterId" : masterId, "masterPw" : masterPw},
    					success : function(data) {
    						
    						if(data.code == 200) {
    							location.reload();
    						}
    						
    					}
    					
    				});
    				
    				return false;
    				
    			} 
    			
			});
			
		}
		
    
    </script>
    

    <body>
        
        <!-- Top menu -->
        <c:if test="${master.MASTER_ID == null}">
        	<%@include file="main/topmain.jsp" %>
		</c:if>
		
        <c:if test="${master.MASTER_ID != null}">
        	<%@include file="main/masterTopMain.jsp" %>
		</c:if>

        <!-- Slider  -->
        <div class="slider-container testtest">
            <div class="container">
                <div class="row">
                    <div class="col-sm-10 col-sm-offset-1 slider" style ="margin: 0px 5% 0px 0px; float:left;">
                        <div class="flexslider">
                            <ul class="slides">
                                <li data-thumb="mainImg/월평풋살장.PNG" >
                                	<a href="./eachStadiumInfo.do?stadiumName=월평%20풋살장">
	                                    <img src="mainImg/월평풋살장.PNG">
	                                    <div class="flex-caption">
	                                    	월평풋살장<br/>
	                                    	대한민국 대전광역시 서구 월평동 111-16
	                                    </div>
                                    </a>
                                </li>
                                <li data-thumb="mainImg/JOIN-US풋살장.PNG">
                                    <img src="mainImg/JOIN-US풋살장.PNG">
                                    <div class="flex-caption">
                                    	JOIN-US풋살장
                                    </div>
                                </li>
                                <li data-thumb="mainImg/가장풋살장.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=가장%20풋살장">
	                                    <img src="mainImg/가장풋살장.PNG">
	                                    <div class="flex-caption">
	                                    	가장풋살장<br/>
	                                    	대한민국 대전광역시 서구 가장동 21-7
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/강남풋살장.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=강남%20풋살장">
                                    	<img src="mainImg/강남풋살장.PNG">
                                    	<div class="flex-caption">
                                    		강남풋살장<br/>
                                    		대한민국 대전광역시 서구 월평동 82-3
                                    	</div>
                                    </a>
                                </li>
                                <li data-thumb="mainImg/강정훈풋살클럽.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=강정훈%20풋살클럽">	                                    
	                                    <img src="mainImg/강정훈풋살클럽.PNG">
	                                    <div class="flex-caption">
	                                    	강정훈풋살클럽<br/>
	                                    	대한민국 대전광역시 서구 관저동 980
	                                    </div>
                                    </a>
                                </li>
                                <li data-thumb="mainImg/굿모닝풋살장.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=굿모닝%20풋살장">	      
                                		<img src="mainImg/굿모닝풋살장.PNG">
	                                    <div class="flex-caption">
	                                    	굿모닝풋살장<br/>
	                                    	대한민국 대전광역시 유성구 하기동 328-3
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/남선공원풋살장.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=남선공원%20풋살장">
	                                    <img src="mainImg/남선공원풋살장.PNG">
	                                    <div class="flex-caption">
	                                    	남선공원풋살장<br/>
	                                    	대한민국 대전광역시 서구 탄방동 1084
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/덕암축구클럽.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=덕암%20축구센터%20풋살장">
	                                    <img src="mainImg/덕암축구클럽.PNG">
	                                    <div class="flex-caption">
	                                    	덕암축구클럽<br/>
	                                    	대한민국 대전광역시 대덕구 목상동 250
	                                    </div>
                                	</a>    
                                </li>
                                <li data-thumb="mainImg/동아풋살장.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=동아%20풋살장">
	                                    <img src="mainImg/동아풋살장.PNG">
	                                    <div class="flex-caption">
	                                    	동아풋살장<br/>
	                                    	대한민국 대전광역시 유성구 지족동 914 동아쇼핑마트 6층
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/문화풋살장.jpg">
                                	<a href ="./eachStadiumInfo.do?stadiumName=문화%20풋살클럽">
	                                    <img src="mainImg/문화풋살장.jpg">
	                                    <div class="flex-caption">
	                                    	문화풋살장<br/>
	                                    	대한민국 대전광역시 중구 문화동 311-17
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/삼성풋살장.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=삼성%20풋살장">
	                                    <img src="mainImg/삼성풋살장.PNG">
	                                    <div class="flex-caption">
	                                    	삼성풋살장<br/>
	                                    	대한민국 대전광역시 동구 삼성동 107-11
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/송촌풋살장.jpg">
                                	<a href ="./eachStadiumInfo.do?stadiumName=송촌%20풋살장">
	                                    <img src="mainImg/송촌풋살장.jpg">
	                                    <div class="flex-caption">
	                                    	송촌풋살장<br/>
	                                    	대한민국 대전광역시 대덕구 법동 66-21
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/씨티풋살장.png">
                                	<a href ="./eachStadiumInfo.do?stadiumName=씨티%20풋살구장">
	                                    <img src="mainImg/씨티풋살장.png">
	                                    <div class="flex-caption">
	                                    	씨티풋살장<br/>
	                                    	대한민국 대전광역시 유성구 계산동
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/안영풋살장.JPG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=안영%20풋살장">
	                                    <img src="mainImg/안영풋살장.JPG">
	                                    <div class="flex-caption">
	                                    	안영풋살장<br/>
	                                    	대한민국 대전광역시 중구 안영동 415-1
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/유성풋살장.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=유성%20풋살장">
	                                    <img src="mainImg/유성풋살장.PNG">
	                                    <div class="flex-caption">
	                                    	유성풋살장<br/>
	                                    	대한민국 대전광역시 유성구 봉명동 615-2
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/점프풋살장.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=점프%20풋살장">
	                                    <img src="mainImg/점프풋살장.PNG">
	                                    <div class="flex-caption">
	                                    	점프풋살장<br/>
	                                    	대한민국 대전광역시 동구 대성동 137
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/테크노풋살장.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=테크노%20풋살장">
	                                    <img src="mainImg/테크노풋살장.PNG">
	                                    <div class="flex-caption">
	                                    	테크노풋살장<br/>
	                                    	대한민국 대전광역시 유성구 전민동 25-1
	                                    </div>
	                                </a>
                                </li>
                                <li data-thumb="mainImg/판암풋살장.PNG">
                                	<a href ="./eachStadiumInfo.do?stadiumName=판암%20풋살클럽">
	                                    <img src="mainImg/판암풋살장.PNG">
	                                    <div class="flex-caption">
	                                    	판암풋살장<br/>
	                                    	대한민국 대전광역시 동구 판암동 244
	                                    </div>
	                                </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    <div style = "float:left; width:400px;">
                    
	                    <c:if test="${user.ID == null && master.MASTER_ID == null}">
	                    
		                    <div id = "tabs">
		                    	<ul style = "list-style: none;margin-top:45px; overflow:auto;     padding-left: 0px;">
		                    		<li><a href = "#tabs-1" style = "float:left; padding-right:15px;">사용자</a></li>
		                    		<li><a href = "#tabs-2" style = "float:left;">운영자</a></li>
		                    	</ul>
	                    		<div id = "tabs-1">
			            	        <table class="table table-striped table-bordered table-hover text-muted backsuTable">
				        				<tr>
				        					<td width = "30%" colspan = "2">
				        						<label>
				        						&nbsp;
												<input type="checkbox" name="checkid" id="checkid" width = "70px"/>
												&nbsp;
												ID기억하기
												</label>&nbsp;&nbsp;
				        					</td>
				        					<td>
				        						<label id ="idText"></label>
				        					</td>
				        				</tr>
				        				<tr>
				        					<td>ID </td>
				        					<td width = "50%">
				        						<input type = "text" id = "loginId" name = "id" style = "-webkit-appearance: textfield;
																									     padding: 1px;
																									     background-color: white;
																									     border: 2px inset;
																									     border-image-source: initial;
																									     border-image-slice: initial;
																									     border-image-width: initial;
																									     border-image-outset: initial;
																									     border-image-repeat: initial;
																									     -webkit-rtl-ordering: logical;
																									     -webkit-user-select: text;
																									     cursor: auto;border-radius: 21px;background-color: white;" size = "25"
																									     tabindex="1"/>
				        					</td>
				        					<td rowspan = "2">
<!-- 				        						<input type ="button" id = "mainLogin"  -->
<!-- 																	  value = "Login"  -->
<!-- 																	  class = "btn-xl text-border"  -->
<!-- 																	  tabindex="3"/> -->
												<a href><img id = "mainLogin" src="mainImg/Bbtn_login.png" width="110px" tabindex="3"></a>
				        					</td>
				        				</tr>
				        				<tr>
				        					<td>PW </td>
				        					<td><input type = "password" id = "pw" name = "pw" class = "text-border" tabindex="2"/></td>
				        				</tr>
				        				<tr>
				        					<td colspan = "3">
				        						<label id = "goJoinMemberPage" style = "color: darkblue; cursor:pointer; font-size: 15px;">회원가입</label>
				        						&nbsp;&nbsp;&nbsp;&nbsp;
												<label id = "goSearchInfoPage" style = "color: darkblue; cursor:pointer; font-size: 15px;">아이디/비번찾기</label>
				        					</td>
				        				</tr>
				        			</table>
				        			<div class="clear"></div>
			        			</div>
			        			<div id = "tabs-2">
			        				<table class="table table-striped table-bordered table-hover text-muted backsuTable">
			        					<tr>
			        						<td width = "30%">
			        							<label>운영자 ID </label>
			        						</td>
			        						<td width = "35%">
			        							<input type = "text" id = "masterId" name = "masterId" style = "border-radius: 21px;" size = "17" tabindex="1"/>
			        						</td>
			        						<td rowspan = "2">
<!-- 				        						<input type ="button" id = "masterLogin"  -->
<!-- 																	  value = "Login"  -->
<!-- 																	  class = "btn-xl text-border"  -->
<!-- 																	  tabindex="3"/> -->
												<a href><img id = "masterLogin" src="mainImg/Bbtn_login.png" width="110px" tabindex="3"></a>
				        					</td>
			        					</tr>
			        					<tr>
			        						<td>
			        							<label>운영자 PW </label>
			        						</td>
			        						<td>
			        							<input type = "password" id = "masterPw" name = "masterPw" class = "text-border" size = "15" tabindex="2"/>
			        						</td>
			        					</tr>
			        				</table>
			        			</div>
			        		</div>	
		        		</c:if>
		        		
		        		<c:if test="${master.MASTER_ID != null}">
		        			<table class="table table-striped table-bordered table-hover text-muted backsuTable" style = "margin-top:45px;">
	        					<tr>
	        						<td width = "25%">
	        							<label>운영자 ID</label>
	        						</td>
	        						<td width = "50%">
	        							<label>${master.MASTER_NAME}</label>
	        						</td>
	        						<td rowspan = "2" colspan = "2"> 
<!-- 		        						<input type ="button" id = "masterLogout"  -->
<!-- 															  value = "Logout"  -->
<!-- 															  class = "btn-xl text-border"  -->
<!-- 															  tabindex="3"/> -->
									  	<a href="./masterLogout.admin"><img id = "masterLogout" src="mainImg/Bbtn_logout.png" height="70px"></a>
		        					</td>
	        					</tr>
	        					<tr>
	        						<td>
	        							<label>풋살구장</label>
	        						</td>
	        						<td>
	        							<label>${master.MASTER_ID}</label>
	        						</td>
	        					</tr>
	        					<tr>
	        						<td colspan = "3">
	        							<a href="./allStadiumList.do">경기시설</a>
	        							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	        							<a href="./listBoard.do">이용후기</a>
	        						</td>
	        					</tr>
	        					
	        				</table>
		        		
		        		</c:if>
	        		
		        		<c:if test="${user.ID != null && master.MASTER_ID == null}">
		        			<table class="table table-striped table-bordered table-hover text-muted backsuTable" style = "margin-top:45px;">
		        				<tr>
		        					<td width = "70%" colspan = "2">
		        						<label id = "userIdText" style = "color: darkblue; cursor:pointer; font-size: 15px;">${user.ID}</label>&nbsp;&nbsp;님 반갑습니다
		        						<i class="fa fa-smile-o"></i>
		        					</td>
		        					<td width = "20%">
		        						<label id = "myInfoModify" style = "color: darkblue; cursor:pointer; font-size: 15px;">
		        							<i class="fa fa-pencil-square-o"></i>
		        							내 정보 수정
		        						</label>
		        					</td>
		        				</tr>
		        				<tr>
		        					<td width = "40%">
		        						<label id = "myNotePage" style = "color: darkblue; cursor:pointer; font-size: 15px;">
		        							<i class="fa fa-envelope-o"></i>&nbsp;쪽지
		        						</label>
		        						<label id = "myNotePage2" style = "color: red; cursor:pointer; font-size: 15px;">
		        							<c:if test="${newNote != null}">
		        								(${newNote})
		        							</c:if>
		        						</label>
		        					</td>
		        					<td width = "35%">
		        						<label id = "myReservationPage" style = "color: darkblue; cursor:pointer; font-size: 15px;">
		        							<i class="fa fa-list-alt"></i>
		        							내 예약 현황
		        						</label>
		        					</td>
		        					<td rowspan = "2" width="25%">
<!-- 		        						<input type = "button" id = "logoutBtn"value = "Logout" class = "btn-xl text-border"/> -->
										<a href="./logout.do"><img id = "logoutBtn" src="mainImg/Bbtn_logout.png" height="70px"></a>
		        					</td>
		        				</tr>
		        				<tr>
		        					<td>
		        						<label id = "receiverTeamMsg" style = "color: darkblue; cursor:pointer; font-size: 15px;">
		        							<i class="fa fa-briefcase"></i>
		        							팀 신청 메시지
		        						</label>
		        						<label id = "receiverTeamMsg2" style = "color: red; cursor:pointer; font-size: 15px;">
		        							<c:if test="${newMsg != null}">
		        								(${newMsg})
		        							</c:if>
		        						</label>
		        					</td>
		        					<td>
		        						<label id = "myTeamInfo" style = "color: darkblue; cursor:pointer; font-size: 15px;">
		        							<i class="fa fa-futbol-o"></i>
		        								내 팀 보기
		        						</label>
		        					</td>
		        				</tr>
		        			</table><br/><br/>
		        			<div class="clear"></div>
		        		</c:if>
		        		<c:if test="${master.MASTER_ID == null}">
							<%@include file="reservation/MainSimpleReservation.jsp" %>
	        			</c:if>
	        		</div>
        			<div class="clear"></div>
                </div>
            </div>
        </div>
        <c:if test="${master.MASTER_ID != null}">
        	<div class="testimonials-container">
		        <div class="container">
		        	<div class="row">
			            <%@include file="master/masterCal.jsp" %>
			        </div>
			    </div>
			</div>
        </c:if>
		
		
		<c:if test="${master.MASTER_ID == null}">
			<div class="testimonials-container">
		        <div class="container">
		               	<div class="row">
				            <div class="col-sm-12 testimonials-title wow fadeIn">
				                <h2>금일 예약 현황</h2>
				            </div>
			            </div>
			        	<div class="row">
		                   <table class="table table-striped table-bordered table-hover text-muted backsuTable" >
			       				<tr>
			       					<th width="35%" style="text-align: center;"> 날짜 </th>
			       					<th width="35%" style="text-align: center;"> 예약자 </th>
			       					<th width="35%" style="text-align: center;"> 구장 </th>
			       				</tr>
			       				<c:forEach var="board" items="${mainReservation}" >
			        				<tr>
			        					<td>${board.YEAR}-${board.MONTH}-${board.DAY}</td>
			        					<td>${board.ID}</td>
			        					<td>${board.STADIUM_NAME}</td>
			        				</tr>
			        			</c:forEach>
		       				</table>
						</div>
				</div>
			</div>
   		</c:if>	
		<c:if test="${master.MASTER_ID == null}">
	        <div class="testimonials-container">
		        <div class="container">
		        	<div class="row">
			            <div class="col-sm-12 testimonials-title wow fadeIn">
			                <h2 id = "deojeonWeatherInfo">대전 날씨 정보</h2>
			            </div>
		            </div>
		            <div class="row">
		                <div class="col-sm-offset-1 testimonial-list">
		                	<table class="table table-striped table-bordered table-hover text-muted">
		                		<tr>
		                			<th width = '9%' class = "text-center">날짜</th>
			                		<c:forEach var = "weather" items = "${weatherList}" >
			                				<th width = '9%' class = "weather_${weather.day} text-center">${weather.month}/${weather.day}</td>
			                		</c:forEach>
			                		<c:forEach var = "weekWeather" items = "${weekWeatherList}" varStatus="i">
			                			<c:if test ="${weekWeather.day != null}">
		                					<th width = '9%' class = "text-center">${weekWeather.day}</td>
		                				</c:if>
		                			</c:forEach>
		                		</tr>
		                		<tr>
		                			<th class = "text-center">날씨</th>
		                			<c:forEach var = "weather" items = "${weatherList}" >
			                			<td class = "text-center">
			                				<c:if test="${weather.wfKor == '맑음'}">
			                					<img src = '/weather/NB01.png' /><br/>
			                					${weather.wfKor}
			                				</c:if>
			                				<c:if test="${weather.wfKor == '구름 조금'}">
			                					<img src = '/weather/NB02.png' /><br/>
			                					${weather.wfKor}
			                				</c:if>
			                				<c:if test="${weather.wfKor == '구름 많음'}">
			                					<img src = '/weather/NB03.png' /><br/>
			                					${weather.wfKor}
			                				</c:if>
			                				<c:if test="${weather.wfKor == '구름많음'}">
			                					<img src = '/weather/NB03.png' /><br/>
			                					${weather.wfKor}
			                				</c:if>
			                				<c:if test="${weather.wfKor == '구름조금'}">
			                					<img src = '/weather/NB03.png' /><br/>
			                					${weather.wfKor}
			                				</c:if>
			                				<c:if test="${weather.wfKor == '흐림'}">
			                					<img src = '/weather/NB04.png' /><br/>
			                					${weather.wfKor}
			                				</c:if>
			                				<c:if test="${weather.wfKor == '구름많고 비'}">
			                					<img src = '/weather/NB20.png' /><br/>
			                					${weather.wfKor}
			                				</c:if>
			                				<c:if test="${weather.wfKor == '호우'}">
			                					<img src = '/weather/NB07.png' /><br/>
			                					${weather.wfKor}
			                				</c:if>
			                				<c:if test="${weather.wfKor == '비'}">
			                					<img src = '/weather/DB05.png' /><br/>
			                					${weather.wfKor}
			                				</c:if>
			                				<c:if test="${weather.wfKor == '흐리고 비'}">
			                					<img src = '/weather/DB05.png' /><br/>
			                					${weather.wfKor}
			                				</c:if>
			                			</td>
			                		</c:forEach>
			                		<c:forEach var = "weekWeather" items = "${weekWeatherList}" varStatus="i">
			                			<c:if test ="${weekWeather.day != null}">
			                				<td class = "text-center">
			                					<c:if test="${weekWeather.wf == '맑음'}">
				                					<img src = '/weather/NB01.png' /><br/>
				                					${weekWeather.wf}
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '구름 조금'}">
				                					<img src = '/weather/NB02.png' /><br/>
				                					${weekWeather.wf}
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '구름 많음'}">
				                					<img src = '/weather/NB03.png' /><br/>
				                					${weekWeather.wf}
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '구름많음'}">
				                					<img src = '/weather/NB03.png' /><br/>
				                					${weekWeather.wf}
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '구름조금'}">
				                					<img src = '/weather/NB03.png' /><br/>
				                					${weekWeather.wf}
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '흐림'}">
				                					<img src = '/weather/NB04.png' /><br/>
				                					${weekWeather.wf}
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '구름많고 비'}">
				                					<img src = '/weather/NB20.png' /><br/>
				                					${weekWeather.wf}
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '호우'}">
				                					<img src = '/weather/NB07.png' /><br/>
				                					${weekWeather.wf}
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '비'}">
				                					<img src = '/weather/DB05.png' /><br/>
				                					${weekWeather.wf}
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '흐리고 비'}">
				                					<img src = '/weather/DB05.png' /><br/>
				                					${weekWeather.wf}
				                				</c:if>
			                				</td>
		                				</c:if>
		                			</c:forEach>
		                		</tr>
		                		<tr>
		                			<th class = "text-center">온도</th>
		                			<c:forEach var = "weather" items = "${weatherList}" >
			                			<td class = "text-center">${weather.temp}</td>
			                		</c:forEach>
			                		<c:forEach var = "weekWeather" items = "${weekWeatherList}" varStatus="i">
			                			<c:if test ="${weekWeather.day != null}">
		                					<td class = "text-center">-</td>
		                				</c:if>
		                			</c:forEach>
	                			</tr>
		                		<tr>
		                			<th class = "text-center">최고기온</th>
		                			<c:forEach var = "weather" items = "${weatherList}" >
		                				<c:if test="${weather.tmx != '-999.0'}">
			                				<td class = "text-center">${weather.tmx}</td>
			                			</c:if>
			                			<c:if test="${weather.tmx == '-999.0'}">
			                				<td class = "text-center">-</td>
			                			</c:if>
			                		</c:forEach>
			                		<c:forEach var = "weekWeather" items = "${weekWeatherList}" varStatus="i">
			                			<c:if test ="${weekWeather.day != null}">
		                					<td class = "text-center">${weekWeather.tmx}</td>
		                				</c:if>
		                			</c:forEach>
		                		</tr>
		                		<tr>
		                			<th class = "text-center">최저기온</th>
		                			<c:forEach var = "weather" items = "${weatherList}" >
			                			<c:if test="${weather.tmn != '-999.0'}">
				                			<td class = "text-center">${weather.tmn}</td>
			                			</c:if>
			                			<c:if test="${weather.tmn == '-999.0'}">
			                				<td class = "text-center">-</td>
			                			</c:if>
			                		</c:forEach>
			                		<c:forEach var = "weekWeather" items = "${weekWeatherList}" varStatus="i">
			                			<c:if test ="${weekWeather.day != null}">
		                					<td class = "text-center">${weekWeather.tmn}</td>
		                				</c:if>
		                			</c:forEach>
		                		</tr>
	                		</table>
		             	</div>
		             </div>
		        </div>
		    </div>
		</c:if>
        <!-- Footer -->
        <footer>
        	
            <div class="col-sm-12  wow fadeIn">
            	<h3>Contact Us</h3>
            	<div class="footer-box-text footer-box-text-contact">
            		<p><i class="fa fa-map-marker"></i> Address: 9th floor, JoyBuilding, 672, tanbang-dong, seo-gu, Daejeon-si, South Korea</p>
		            <p><i class="fa fa-phone"></i> Phone: +82 010 6396 9799</p>
		            <p><i class="fa fa-user"></i> KaKaoTalk: desparu</p>
		            <p><i class="fa fa-envelope"></i> Email: vaughnkjm@gmail.com</p>
	            </div>
            </div>
            <div class="row">
               	<div class="col-sm-12 wow fadeIn">
               		<div class="footer-border"></div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-7 footer-copyright wow fadeIn">
                	<p>Copyright 2015 Ballochilly - All rights reserved. Template by <a href="#">Ballochilly</a>.</p>
                </div>
            </div>
        </footer>
    </body>
    

</html>