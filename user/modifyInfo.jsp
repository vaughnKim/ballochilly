<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 	<head>
        <%@include file="../sub/subfile.jsp" %>
    </head>
    
    <script>
    	
    	$().ready(function(){
    		
    		splitEmail();
    		selectAge();
    		selectLoc();
    		selectPos();
    		btnAction();
    		chkPhone();
    		email();
    		
    	});
    	
    	function selectAge() {
    		
    		var age = '${user.AGE}';
			
    		$("#userAge > option").each(function(idx, data){
    			
    			if( $(data).val() == age ){
//     			alert($(data).val());
    				$(data).attr("selected", "selected") ;
    			}
    			
    		}) ;
    		
    	}
    	
    	function selectLoc() {
    		
    		var loc = '${user.LOCATION}';
			$("#selectLocation > option").each(function(idx, data){
    			
    			if( $(data).val() == loc ){
    				$(data).attr("selected", "selected") ;
    			}
    			
    		}) ;
    		
    	}
    	
    	function selectPos() {
    		
    		var pos = '${user.POSITION}';
			$("#selectPosition > option").each(function(idx, data){
    			
    			if( $(data).val() == pos ){
    				$(data).attr("selected", "selected") ;
    			}
    			
    		}) ;
    		
    		
    	}
    	
    	function splitEmail() {
    		
    		var test = '${user.EMAIL}';
    		var temp = test.split("@");
    		var emailId = temp[0];
    		var emailAddress = temp[1];
    		
    		$("#emailId").val(emailId);
    		var selectEmailAddress = $("#emailAddress").val(emailAddress);
    		
    		$("#userEmailAddress > option").each(function(idx, data){
    			
//     			alert($(data).val());
    			
    			if( $(data).val() == emailAddress ){
    				
    				$(data).attr("selected", "selected") ;
    				
    			}
    			
    		}) ;
    		
    	}
    	
		function email() {
			
			$("#userEmailAddress").click(function(){
				
				var address = $("#userEmailAddress > option:selected").val();
				
				if(address != "9999"){
					$("#emailAddress").val($("#userEmailAddress > option:selected").text());
				} else if(address == "9999") {
					$("#emailAddress").val("");
				}	//end if
				
			});	//end click
			
		}	//end email
		
		function initPhone() {
			$("#phone").val("");
			$("#phone").focus();
		}
		
		function chkPhone() {
			
			$("#phone").blur(function(){
				
				var phone = $("#phone").val();
				$("#phone").val(phone);
				
				if(phone != "") {
					if(isNaN(parseInt(phone))) {
						initPhone();
						$("#phoneText").text("숫자만 입력해주세요").css("color", "red");
					} else {
						$("#phoneText").text("사용가능합니다").css("color", "blue");
					}	//end if
				}	//end if
				
			});	//end blur
			
		}	//end chkPhone
		
		function makeVal() {
			
			var position = $("#selectPosition > option:selected").val()
			$("#position").val(position);
			var loc = $("#selectLocation > option:selected").val()
			$("#location").val(loc);
			var age = $("#userAge > option:selected").val();
			$("#age").val(age);
			
			var emailId = $("#emailId").val();
			
			if($("#userEmailAddress > option:selected").val() == "9999") {
				$("#email").val(emailId + "@" + $("#emailAddress").val());
			} else {
				$("#email").val(emailId + "@" + $("#userEmailAddress > option:selected").text());
			}	//end if
			
		}
    	
    	
    	function btnAction() {
    		
    		$("#modifyPwBtn").click(function(){
    			
    			var nowId = $("#nowId").text();
    			var nowPw = $("#modifyPw").val();
    			$.ajax({
    				
    				url : "./modifyPw.do",
    				type : "post",
    				data : {"id" : nowId, "pw" : nowPw},
    				success : function(data) {
    					
    					if(data.code == 200) {
							location.href = "./modifyPw.do";
    					} else {
    						alert(data.msg);
    						return false;
    					}
						
    				}
    				
    			});
    			
    		});
    		
    		$("#modifyInfoBtn").click(function(){
    			
    			var position = $("#selectPosition > option:selected").val()
    			$("#position").val(position);
    			var loc = $("#selectLocation > option:selected").val()
    			$("#location").val(loc);
    			var age = $("#userAge > option:selected").val();
    			$("#age").val(age);
    			
    			var emailId = $("#emailId").val();
    			
    			if($("#userEmailAddress > option:selected").val() == "9999") {
    				$("#email").val(emailId + "@" + $("#emailAddress").val());
    			} else {
    				$("#email").val(emailId + "@" + $("#userEmailAddress > option:selected").text());
    			}	
    			
    			$.ajax({
    				
    				url : "./modifyInfo.do",
    				type : "post",
    				data : $("form").serialize(),
    				success : function(data) {
    					
    					alert(data.msg);
    					location.reload();
    					
    				}
    				
    			});
    			
    		});
    		
    	}
    	
    	
    	
    </script>

    <body>
        <!-- Top menu -->
        <%@include file="../main/topmain.jsp" %>
	</body>
		<div class="presentation-container">
	       	<div class="container">
	       		<div class="row">
	        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
	            		<h1><span class="violet">내 정보 수정</span></h1>
	            	</div>
	           	</div>
	       	</div>
		</div>
		<div class = "services-container">
	       	<div class = "container">
				<div class="row">
	<!-- 				<div class="col-sm-12 work-title wow fadeIn"><h2>&nbsp;</h2> -->
	<!-- 		         <h2>reservation state</h2> -->
	<!-- 		    </div> --> 
				</div>
				<div class="row">
					<div class="no-text-center panel-heading">
						<form>
							<table class="table table-striped table-bordered table-hover text-muted no-text-center" style = "width:70%;">
								<tr>
									<td>아이디</td>
									<td>
										<label id = "nowId">${user.ID}</label>
									</td>
								</tr>
								<tr>
									<td>이름</td>
									<td>
										<label>${user.NAME}</label>
									</td>
								</tr>
								<tr>
									<td>나이</td>
									<td>
										<select id = "userAge">
				    						<option value ="유소년">유소년</option>
				    						<option value ="10대">10대</option>
				    						<option value ="20대">20대</option>
				    						<option value ="30대">30대</option>
				    						<option value ="40대">40대</option>
				    						<option value ="50대">50대</option>
				    						<option value ="60대">60대</option>
				    						<option value ="70대">70대</option>
				    						<option value ="80대">80대</option>
				    					</select>
									</td>
								</tr>
								<tr>
									<td>이메일</td>
									<td class = "text-left">
				    					<input type="text" id = "emailId" />
				    					<label> &nbsp; @ &nbsp; </label>
				    					<label>
				    						<input type = "text"  id = "emailAddress" /> &nbsp;
				    					</label>
				    					<select id = "userEmailAddress">
				    						<option selected = "selected" value = "9999">직접입력하기</option>
				    						<option value ="naver.com">naver.com</option>
				    						<option value ="daum.net">daum.net</option>
				    						<option value ="yahoo.co.kr">yahoo.co.kr</option>
				    						<option value ="gmail.com">gmail.com</option>
				    					</select>
				    				</td>
								</tr>
								<tr>
									<td>폰넘버</td>
									<td class = "text-left">
										<input type = "text" name = "phone" id = "phone" value = "${user.PHONE}">
										<label id = "phoneText"></label>
									</td>
								</tr>
								<tr>
									<td>지역</td>
									<td class = "text-left">
										<select id = "selectLocation">
											<option value = "7777" disabled = "disabled" selected = "selected">선택하세요</option>
											<option value = "서구">서구</option>
											<option value = "동구">동구</option>
											<option value = "유성구">유성구</option>
											<option value = "대덕구">대덕구</option>
											<option value = "중구">중구</option>
										</select>
									</td>
								</tr>
								<tr>
									<td>포지션</td>
									<td class = "text-left">
										<select id = "selectPosition">
											<option value = "8888" disabled = "disabled" selected = "selected">선택하세요</option>
											<option value = "GK">GK</option>
											<option value = "LW">LW</option>
											<option value = "CB">CB</option>
											<option value = "RW">RW</option>
											<option value = "MF">MF</option>
											<option value = "FW">FW</option>
										</select>
									</td>
								</tr>
							</table>
							<input type = "hidden" name = "id" value = "${user.ID}" />
							<input type = "hidden" id = "email" name = "email" />
				    		<input type = "hidden" id = "position" name = "position" />
				    		<input type = "hidden" id = "location" name = "location" />
				    		<input type = "hidden" id = "age" name = "age" />
						</form>
					</div>
					<div class = "container">
						<div class="row">
<!-- 							<input type = "button" value ="비번바꾸기" id = "modifyPwBtn" class = "btn"/> -->
				        	<input type = "submit" value = "저장하기" id = "modifyInfoBtn" class = "btn" />
				        	<input type = "button" value = "다시작성" id = "reWriteBtn" class = "btn" />
				        	<input type = "button" value = "메인가기" id = "goMainBtn" class = "btn" />
					    </div> 
					</div>
				</div>
				<div class="presentation-container">
					<div class="container">
			       		<div class="row">
			        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
			            		<h1><span class="violet">비밀번호 수정</span></h1>
			            	</div>
			           	</div>
			       	</div>
			       	<div class="row">
					<div class="no-text-center panel-heading">
						<table class="table table-striped table-bordered table-hover text-muted no-text-center" style = "width:70%;">
							<tr class = "text-center">
								<td>현재 비번을 다시 입력해주세요</td>
							</tr>
							<tr class = "text-center">
								<td>
									<input type = "password" name = "pw" id = "modifyPw" />
								</td>
							</tr>
						</table>
					</div>
					<div class = "container">
						<div class="row">
				        	<input type = "button" value = "확인" class = "btn" id = "modifyPwBtn"/>
					    </div> 
					</div>
		       	</div>
			</div>
		</div>
</html>