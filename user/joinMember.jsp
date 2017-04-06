<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">

    <head>
        <%@include file="../sub/subfile.jsp" %>
    </head>
    
    <script>
    	
    	$().ready(function(){
    		
    		// 시작과 동시에 id에 포커스 이벤트를 줌
			$("#id").focus(); 
    		// 회원가입 버튼을 누르면 ajax로 회원가입되게
    		joinMember();
    		// 이멜 직접 입력하기 선택했을 때
    		email();
    		// 취소버튼 누르면 메인으로 되돌리기
    		cancel();
    		chkPw();
    		chkName();
    		chkPhone();
//     		chkAge();
    		chkId();
    		
    	});
    	
    	// 빈값이 있으면 가입못하게 
    	function nullText() {
    		if($("#id").val() == ""){
    			alert("아이디를 입력하세요");
    			$("#id").focus(); 
    			return false;
    		} else if($("#pw").val() == "") {
    			alert("비번 입력하세요");
    			$("#pw").focus(); 
    			return false;
    		} else if($("#chkpw").val() == "") {
    			alert("비번체크하세여");
    			$("#chkpw").focus(); 
    			return false;
    		} else if($("#name").val() == "") {
    			alert("이름 입력하세여");
    			$("#name").focus(); 
    			return false;
    		} else if($("#age").val() == "") {
    			alert("나이입력바람");
    			$("#age").focus(); 
    			return false;
    		} else if($("#emailId").val() == "") {
    			alert("인풋 이멜주소");
    			$("#emailId").focus(); 
    			return false;
    		} else if($("#emailAddress").val() == "") {
    			alert("선택 이멜주소");
    			$("#emailAddress").focus(); 
    			return false;
    		} else if($("#phone").val() == "") {
    			alert("폰넘 입력하세요");
    			$("#phone").focus(); 
    			return false;
    		} 
    			
    	}
    	
    	
    	// 회원가입
    	function joinMember() {
    		
    		$("input[type=submit]").click(function(){
    			
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
				
// 				chkAge();
				
				// 빈 값이 있으면 가입못하게 
				nullText();
				
    			$.ajax({
					
    				url : "./joinMember.do",
    				type : "post",
    				data : $("form").serialize(),
    				success : function(data) {
						
// 						console.log(data);

						alert(data.msg);
						if(data.code == 200) {
							
							popUpPage();
							location.href = "./main.do";
							
						}	//end if
	
					}	//end success
    				
    			});	//end ajax
    			
    			return false;
    			
    		});	//end click
    		
    	}	//end joinMember
    	
    	function popUpPage(){
    		
    		var popUrl = "./popPage.do";	//팝업창에 출력될 페이지 URL
    		var popOption = "width=250, height=250, resizable=no, scrollbars=no, status=no, top=300, left=300,  location=no, menubar=no";    //팝업창 옵션(optoin)
    			window.open(popUrl,"",popOption);
    		
    	}
    	
    	// 이메일 직접입력하기 선택했을 때
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
		
		// 취소버튼 누르면 메인으로 돌아가기
		function cancel() {
			
			$("#cancel").click(function(){
				
				location.href = "./main.do";
				
			});	//end click
			
		}	//end cancel
		
		// 아이디 초기화시켜주는 펑션
		function initId() {
			$("#id").val("");
			$("#id").focus();
		}
		
		// 비번 초기화시켜주는 펑션
		function initPw() {
			$("#pw, #chkPw").val("");
			$("#pw").focus();
		}	//end initPw
		
		// 이름 초기화시켜주는 펑션
		function initName() {
			$("#name").val("");
			$("#name").focus();
		}
		
		function initPhone() {
			$("#phone").val("");
			$("#phone").focus();
		}
// 		function initAge() {
// 			$("#age").val("");
// 			$("#age").focus();
// 		}
		
		// 아이디를 체크하는 펑션
		function chkId() {
			
			$("#id").blur(function(){
				
				var id = $("#id").val();
				$("#id").val(id);
				
				// 특수문자가 포함되지 않았을 때 
				if(checkStringFormat(id)) {
					
					if(id == "") {
						$("#idText").text("");
					} else {
						
						if(isHasKr(id)) {
							$("#idText").text("한글입력불가").css("color", "red");
							initId();
						} else if (id != removeSpace(id)) {
							$("#idText").text("공백불가").css("color", "red");
							initId();
						} else {
						
							$.ajax({
								
								url : "./isExistId.do",
								type : "post",
								data : {"id" : id},
								success : function(data) {
									
									if(data.code == 200) {
										
										initId();
										$("#idText").text(data.msg).css("color", "red");
										
									} else if (data.code == 201){
										
										$("#idText").text(data.msg).css("color", "blue");
										
									}	//end if
									
								}	//end success
								
							});	//end ajax
							
						}	//end if
						
					}	//end if
					
				} else {
				
					initId();
					$("#idText").text("특수문자안되요").css("color", "red");
					
				}	//end if
				
			});	//end blur
			
		}	//end chkId
		
		// 비번 체크하는 펑션
		function chkPw() {
			
			$("#chkPw").blur(function(){
				
				var pw = $("#pw").val();
				$("#pw").val(pw);
				
				// 특수문자가 포함되지 않았을때
				if(checkStringFormat(pw)) {
					
					initPw();
					$("#pwText").text("특수문자가 포함되지 않았어요").css("color", "red");
					
				} else { // 특수문자가 포함되어 있을 때
					
					$("#pwText").text("");
					
					// 비번이 값이 없지 않다면
					if(pw != "") {
						
						// 중간에 공백이 있는지
						if(pw != removeSpace(pw)) {
							
							initPw();
							$("#pwText").text("비번에 공백이 있내요").css("color", "red");
							
						} else {	//비번 중간에 공백이 없다면
							
							// 비번과 비번체크가 같지 않다면
							if($("#pw").val() != $("#chkPw").val()) {
								
								initPw();	
								$("#pwText").text("비번이 일치하지 않아요").css("color", "red");
								
							} else {	//비번과 비번체크가 같다면
								
								$("#pwText").text("비번이 일치합니다").css("color", "blue");
								
								// 비번 길이가 8자리 이하일때
								if($("#pw").val().length < 8) {
									initPw();
									$("#pwText").text("비번은 8자리 이상입력 가능").css("color", "red");
								}
								
							}	//end if
							
						}	//end if
						
					}	//end if
					
				}	//end if
				
			});	//end blur
			
		}	//end chkPw
		
		// 이름 체크하는 펑션
		function chkName() {
			
			$("#name").blur(function(){
				
				var name = $("#name").val();
				$("#name").val(name);
				
				if(checkStringFormat(name)) {
					if(name != "") {
						if(name != removeSpace(name)) {
							initName();
							$("#nameText").text("이름에 공백이 있내요").css("color", "red");			
						} else{
							$("#nameText").text("사용가능합니다").css("color", "blue");
						}	//end if
					}	//end if
					if(isHasKr(name)){
						$("#nameText").text("사용가능합니다").css("color", "blue");
					} else {
						initName();
						$("#nameText").text("한글만 입력가능").css("color", "red");
					}	//end if
				} else {
					initName();
					$("#nameText").text("한글만 입력가능(특수문자가 있내여)").css("color", "red");
				}	//end if
				
			});	//end blur
			
		}	//end chkName
		
		function onlyNumber(){
			
		    if((event.keyCode < 48)||(event.keyCode > 57)){
		    	
		        event.returnValue=false;
		        initPhone();
		        $("#phoneText").text("숫자만 입력해주세요").css("color", "red");
// 		        alert(1);

		    } else {
// 			   alert(2);
		    	$("#phoneText").text("사용가능합니다").css("color", "blue");
		    }
		}
		
		function chkPhone() {
			$("#phone").blur(function(){
				var phone = $("#phone").val();
				$("#phone").val(phone);
				if(!isHasKr(phone)) {
					$("#phoneText").text("사용가능합니다").css("color", "blue");
				}else {
					$("#phoneText").text("숫자만 입력해주세요").css("color", "red");
				}
			});
		}
		
// 		function chkPhone() {
			
// 			$("#phone").blur(function(){
				
// 				var phone = $("#phone").val();
// 				$("#phone").val(phone);
				
// 				if(phone != "") {
// 					if(isNaN(parseInt(phone))) {
// 						initPhone();
// 						$("#phoneText").text("숫자만 입력해주세요").css("color", "red");
// 					} else {
// 						$("#phoneText").text("사용가능합니다").css("color", "blue");
// 					}	//end if
// 				}	//end if
				
// 			});	//end blur
			
// 		}	//end chkPhone
		
// 		function chkAge() {
			
// 			$("#userAge").click(function(){
				
// 				var age = $("#userAge > option:selected").val();
// // 				alert(age);
// 				$("#age").val(age);
				
// 			});	//end click
			
// 			$("#age").blur(function(){
				
// 				var age = $("#age").val();
// 				$("#age").val(age);
				
// 				if(age != "") {
// // 					var regExp = /^[0-9]$/;
					
// 					if(isNaN(parseInt(age))) {
// 						initAge();
// 						$("#ageText").text("숫자만 입력해주세요").css("color", "red");
// 					} else {
// 						$("#ageText").text("사용가능합니다").css("color", "blue");
// 					}	//end if
// 				}	///end if
				
// 			});	//end blur
			
// 		}	//end chkAge
		
		// 각 항목에서 공백을 찾는 기능
		function removeSpace(data) {
				
			if(data[0] != null ){
				
				var tempStr = "";
				var size = data.length;
	
				for( var i =0; i < size ; i++){
					if( data[i] != " " ){
						tempStr += data[i];
					}	//end if
				}	//end for
				return tempStr;
			 }	//end if
			 
		 } // end removeSpace(data)
		 
		 function chkNum(str) {
			 
			 if(typeof(str) == 'string') {
				var size = str.length;
				var tempStr = "";
				for( var i = 0 ; i < size ; i ++){

					if( str[i] >= 0 && str[i] <= 9){
						tempStr += str[i];
					}	//end if
				}
			 }
		 }
		 
		 // 영어, 숫자만 입력 가능하게 설정된 기능
		 function chkEng(str) {
				
			if( typeof(str) == 'string'){
					 
				var size = str.length;
				var tempStr = "";
				for( var i = 0 ; i < size ; i ++){

					if( str[i] >= 'a' && str[i] <= 'z'){
						tempStr += str[i];
					}else if( str[i] >= 'A' && str[i] <= 'Z'){
						tempStr += str[i];
					}else if( str[i] >= 0 && str[i] <= 9){
						tempStr += str[i];
					}	//end if

				}	//end for

				return tempStr;

			}	//end if

		}	// end chkEng(str)
		
		// 한글이 존재하면 실행
		function isHasKr(str) {
			
			if(str = chkEng(str)) {
				return false;
			} else {
				return true;
			}	//end if
			
		}	//end isHasKr(str)
		
		// 특수문자
		function checkStringFormat(string) { 
		  //var stringRegx=/^[0-9a-zA-Z가-힝]*$/; 
			var stringRegx = /[~!@\#$%<>^&*\()\-=+_\?’`|]/gi; 
			var isValid = true; 
			if(stringRegx.test(string)) { 
				isValid = false; 
			}
			
			return isValid; 
		}
		
    
    </script>
    
<body>
	<%@include file="../main/topmain.jsp" %>
	<div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">회원가입</span></h1>
            	</div>
           	</div>
       	</div>
	</div>
	<div class = "services-container">
		<form>
       	<div class = "container">
			<div class="row">
<!-- 				<div class="col-sm-12 work-title wow fadeIn"><h2>&nbsp;</h2> -->
<!-- 		         <h2>reservation state</h2> -->
<!-- 		    </div> --> 
			</div>
			<div class="row">
				<table class="table table-striped table-bordered table-hover text-muted">
					<tr>
						<td>아이디</td>
						<td class = "text-left">
							<input type = "text" name = "id" id = "id">
							<label id = "idText">한글, 공백, 특수문자 불가능</label>
						</td>
					</tr>
					<tr>
						<td>비밀번호</td>
						<td class = "text-left">
							<input type = "password" name = "pw" id = "pw">
							<label id = "pwText">8자리 이상 특수문자 포함시켜주세요</label>
						</td>
					</tr>
					<tr>
						<td>비번확인</td>
						<td class = "text-left">
							<input type = "password" id = "chkPw">
						</td>
					</tr>
					<tr>
						<td>이름</td>
						<td class = "text-left">
							<input type = "text" name = "name" id = "name">
							<label id = "nameText">한글만 입력가능</label>
						</td>
					</tr>
					<tr>
						<td>나이</td>
						<td class = "text-left">
							<select id = "userAge">
		    					<option value = "6666" disabled = "disabled" selected = "selected">선택하세요</option>
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
<!-- 							<input type = "text" name = "age" id = "age"> -->
<!-- 							<label id = "ageText">숫자만 입력가능</label> -->
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
	    						<option selected = "selected" value = "9999" >직접입력하기</option>
	    						<option value ="1">naver.com</option>
	    						<option value ="2">gmail.com</option>
	    						<option value ="3">daum.net</option>
	    						<option value ="4">yahoo.co.kr</option>
	    					</select>
	    				</td>
					</tr>
					<tr>
						<td>폰넘버</td>
						<td class = "text-left">
							<input type = "number" name = "phone" size = "100" id = "phone" onkeypress="onlyNumber();" min = "1" max = "99999999999">
							<label id = "phoneText">숫자만 입력가능</label>
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
			</div>
		</div>
		<div class ="no-text-center panel-heading text-muted" align="center">
    		<input type = "hidden" id = "email" name = "email" />
    		<input type = "hidden" id = "position" name = "position" />
    		<input type = "hidden" id = "location" name = "location" />
    		<input type = "hidden" id = "age" name = "age" />
    		<input type = "submit" id = "success" value ="가입완료" class = "btn"/>
    		<input type = "reset" id = "reset" value ="다시입력" class = "btn"/>
    		<input type = "button" id = "cancel" value ="돌아가기" class = "btn"/>
    	</div>
    	</form>
	</div>
</body>

</html>