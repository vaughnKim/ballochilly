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
    		
//     		alert('${user.ID}');
    		$("#newPw").focus();
    		chkPw();
    		modifyPw();
    		fnNewChkPw();
    		
    	});
    	
		function chkPw() {
			
			$("#newPw").blur(function(){
				
				var pw = $("#newPw").val();
				$("#newPw").val(pw);
				
				// 특수문자가 포함되지 않았을때
				if(checkStringFormat(pw)) {
					
					initPw();
					$("#newPwText").text("특수문자가 포함되지 않았어요").css("color", "red");
					
				} else { // 특수문자가 포함되어 있을 때
					
					$("#newPwText").text("");
					
					// 비번이 값이 없지 않다면
					if(pw != "") {
						
						// 중간에 공백이 있는지
						if(pw != removeSpace(pw)) {
							
							initPw();
							$("#newPwText").text("비번에 공백이 있내요").css("color", "red");
							
						} else {	//비번 중간에 공백이 없다면
							
							$("#newPwText").text("사용가능해요").css("color", "blue");
						
						}	//end if
						
					}	//end if
					
				}	//end if
				
			});	//end blur
			
		}	//end chkPw
		
		function fnNewChkPw() {
			
			$("#newPw").blur(function(){
				
				if($("#newPw").val().length < 8) {
					initPw();
					$("#newPwText").text("비번은 8자리 이상입력 가능").css("color", "red");
				}
				
			});
			
		}
		
    	
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
			var stringRegx = /[~!@\#$%<>^&*\()\-=+_\’]/gi; 
			var isValid = true; 
			if(stringRegx.test(string)) { 
				isValid = false; 
			}
			
			return isValid; 
		}
		
		function initPw() {
			$("#newPw, #newPwChk").val("");
			$("#newPw").focus();
		}	//end initPw
		
    	
    	function modifyPw() {
    		
			$("#modifyPwBtn").click(function(){
				
				var pw = $("#newPw").val();
				var chkPw = $("#newPwChk").val();
				var id = '${user.ID}';
				
				if(pw != chkPw) {
					
					initPw();
					$("#newPwText").text("비번이 일치하지 않아요").css("color", "red");
					
				} else {
				
				
					if(pw != "" && chkPw != "") {
					
						$.ajax({
							
							url : "./modifyPw.do",
							type : "post",
							data : {"id" : id, "pw" : pw},
							success : function(data) {
								alert(data.msg);
								if(data.code == 200) {
									location.href = "./main.do";
								} else {
									return false;
								}
							}
							
						});
						
					}
					
				}
				
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
	            		<h1><span class="violet">비밀번호 수정</span></h1>
	            	</div>
	           	</div>
	       	</div>
		</div>
		<div class = "services-container">
	       	<div class = "container">
				<div class="row">
					<div class="no-text-center panel-heading">
						<table class="table table-striped table-bordered table-hover text-muted no-text-center" style = "width:70%;">
							<tr>
								<td>새로운 비번</td>
								<td>
									<input type = "password" id = "newPw" name = "pw">
								</td>
							</tr>
							<tr>
								<td>다시 입력</td>
								<td>
									<input type = "password" id = "newPwChk">
								</td>
							</tr>
							<tr>
								<td colspan = "2" class = "text-center">
									<label id = "newPwText">비번일치여부</label>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class ="no-text-center panel-heading text-muted" align="center">
		    		<input type = "button" id = "modifyPwBtn" value ="모디파이" class = "btn"/>
		    		<input type = "button" id = "cancel" value ="돌아가기" class = "btn"/>
		    	</div>
			</div>
		</div>
	</body>
</html>