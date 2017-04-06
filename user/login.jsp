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
    		
    		$("#id").focus();
    		
    		isExistId();
    		loginClick();
    		$("#loginPw").keypress(function(event){
				if(event.keyCode == 13){
					$("#loginClick").trigger("click");
				}
				
			});
    		
    	});
    	
    	function isExistId() {
    		
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
							
						}	//end success
						
					});	//end ajax
					
	    		}	//end if
	    		$("#idText").text("");
	    		
    		});
			
    	}	//end isExistId
    	
    	
    	<% 
			String backPage = request.getHeader("referer");
			request.setAttribute("backPage", backPage);
			System.out.print(backPage);
			System.out.print("backPage");
		%>
    	
    	
    	function loginClick() {
    		
    		$("#loginClick").click(function(){
    			
    			var id = $("#loginId").val();
    			var pw = $("#loginPw").val();
    			
    			if(id != "" && pw != "") {
    				
    				$.ajax({
    					
    					url : "./login.do",
    					type : "post",
    					data : {"id" : id, "pw" : pw},
    					success : function(data) {
    						
    						if(data.code == 200) {
    							
    							if('${backPage}' != "http://localhost/teamRegister.do") {
	    							location.href = '${backPage}';
    							} else {
									location.href = "./teamRegister.do"
    							}
    							
//     							<a href = "javascript:history.back()"><input type="button" value="취소"/></a>
    						} else if(data.code == 201){
    							
	    						$("#pwText").text(data.msg).css("color", "red");
    							$("#loginPw").val("");
    							$("#loginPw").focus();
    						}
    						
    					}
    					
    				});
    				
    				return false;
    				
    			} else if (id == "") {
    				alert("아이디를 입력하세요.");
					$("#loginId").focus();
    			} else if (pw == "") {
    				alert("비밀번호를 입력하세요.");
					$("#loginPw").focus();
    			}
    			
    		});
    		
    	}
    	
    </script>
    
    
<body>
	<%@include file="../main/topmain.jsp" %>
	<div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">로그인 페이지</span></h1>
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
					<table class="table table-striped table-bordered table-hover text-muted no-text-center" style = "width:70%;">
						<tr>
							<td  width = "20%">아이디</td>
							<td class = "text-left" >
								<input type = "text" name = "id" 
													 id = "loginId"
													 size = "23" 
													 tabindex="1" 
													 style = "border-radius: 21px;" 
													 required >
								<label id = "idText"></label>
							</td>
							<td rowspan = "2" width = "20%">
<!-- 								<input type ="button" id = "loginClick" value = "Login" class = "btn-xl text-border" tabindex="3"/> -->
								<a href><img id = "loginClick" src="mainImg/Bbtn_login.png" width="120px" tabindex="3"></a>
							</td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td class = "text-left">
								<input type = "password" name = "pw" id = "loginPw" tabindex="2" class = "text-border" required>
								<label id = "pwText"></label>
							</td>
						</tr>
						<tr class = "text-center">
							<td colspan = "3">
								<a href = "./joinMember.do">회원가입</a> &nbsp; 
								<a href = "./serachForInfo.do">아이디 / 비번찾기</a>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>