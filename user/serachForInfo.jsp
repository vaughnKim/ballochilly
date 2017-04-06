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
    		
    		searchId();
    		searchEmail();
    		tempPwSubmit();
    	});
    	
    	// 아이디 찾기 펑션
    	function searchId() {
    		
    		$("#name, #phone").keyup(function(){
    			
    			var name = $("#name").val();
    			var phone = $("#phone").val();
    			
    			$.ajax({
    				
    				url : "./searchId.do",
    				type : "post",
    				data : {"name" : name, "phone" : phone},
    				success : function(data) {
    					
    					if(data.code == 200) {
    						var temp = "";
    						
    						for(var i = 0 ; i < data.returnId.length ; i++) {
    							console.log(i + " : " + data.returnId[i].ID);
    							temp = data.returnId[i].ID + "   " + temp;
    						}
//     						console.log(data.returnId);
	    					$("#searchId").text(temp).css("color", "blue");
	    					
    					} else {
    						
    						$("#searchId").text(data.msg).css("color", "red");
    						
    					}	//end if
    					
    				}	//end success
    				
    			});	//end ajax
    			
    		});	//end kepup
    		
    	}	//end 
    	
    	
    	function searchEmail() {
    		
    		$("#id, #name-2, #phone-2").keyup(function(){
    			
    			var id = $("#id").val();
    			var name = $("#name-2").val();
    			var phone = $("#phone-2").val();
    			
				$.ajax({
					
					url : "./searchEmail.do",
					type : "post",
    				data : {"id" : id, "name" : name, "phone" : phone},
    				success : function(data) {
    					
    					if(data.code == 200) {
	    					$("#searchEmail").text(data.email.EMAIL).css("color", "blue");
    					} else {
    						$("#searchEmail").text(data.msg).css("color", "red");
    					}
    					
    				}	//end success
					
				});    			
    			
    			
    		});
    		
    	}
    	
		function tempPwSubmit() {
			
			$("#tempPwSubmit").click(function(){
				
				var email = $("#searchEmail").text();
				var id = $("#id").val();
				var name = $("#name-2").val();
				var phone = $("#phone-2").val();
				alert(email);
				if(id != "" && name != "" && phone != "") {
				
					$.ajax({
						
						url : "./sendMail.do",
						type : "post",
						data : {"email" : email},
						success : function(data) {
							
							alert("임시비번이 " + email + " 로 전송되었습니다");
							
						}
						
					});	//end ajax
					
				}
				
			});	//end click
			
		}	//end newPwSubmit
    	
    </script>
    
    
<body>
	<%@include file="../main/topmain.jsp" %>
	<div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">내 정보 찾기</span></h1>
            	</div>
           	</div>
       	</div>
	</div>
	<div class = "services-container">
       	<div class = "container">
			<div class="row">
 				 <div class="col-sm-12 work-title wow fadeIn">
	                <h2>아이디 찾기</h2>
	            </div>
			</div>
			<div class="row">
				<div class="no-text-center panel-heading">
					<table class="table table-striped table-bordered table-hover text-muted" >
						<tr height = "20%">
		    				<td width="20%" class = "text-right">
		    					<label>NAME : </label>
		    				</td>
		    				<td width="70%">
		    					<input type="text" id = "name" name = "name" />
		    				</td>
		    			</tr>
						<tr height = "20%">
							<td class = "text-right">
								<label>PHONE : </label>
							</td>
							<td>
		    					<input type="text" id = "phone" name = "phone" />
							</td>
						</tr>		    			
						<tr height = "20%">
							<td class = "text-right">
								<label>찾는 아이디 : </label>
							</td>
							<td>
		    					<label id = "searchId"></label>
							</td>
						</tr>		    			
					</table>
				</div>
				<div class="row">
 					<div class="col-sm-12 work-title wow fadeIn">
	                	<h2>비밀번호 찾기</h2>
	            	</div>
				</div>
				<div class="row">
					<div class="no-text-center panel-heading">
						<table class="table table-striped table-bordered table-hover text-muted" >
							<tr>
								<td width="20%" class = "text-right">
			    					<label>ID : </label>
			    				</td>
			    				<td width="70%">
			    					<input type="text" id = "id" />
			    				</td>
							</tr>
							<tr>
								<td width="20%" class = "text-right">
									<label>NAME :</label>
								</td>
								<td>
			    					<input type="text" id = "name-2" />
								</td>
							</tr>
							<tr height = "20%">
								<td class = "text-right">
									<label>PHONE : </label>
								</td>
								<td>
			    					<input type="text" id = "phone-2" />
								</td>
							</tr>	
							<tr height = "20%">
								<td class = "text-right">
									<label>가입당시 EMAIL : </label>
								</td>
								<td>
			    					<label id = "searchEmail">임시비번전송 클릭하면, 해당 EMAIL로 전송됩니다.</label>
								</td>
							</tr>		
						</table>
					</div>
					<div class ="no-text-center panel-heading text-muted" align="center">
						<input type = "button" value = "임시비밀번호 전송하기" class = "btn btn-xl" id = "tempPwSubmit"/><br/>
					</div>
				</div>
			</div>
		</div>
	</div>
	

</body>
</html>