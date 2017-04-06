<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="kr">

    <head>
        <%@include file="../sub/subfile.jsp" %>
    </head>
    
    <script>
    
    	$().ready(function(){
    		
    		btnAction();
    		
    	});
    	
    	function btnAction(){
    		
    		$("#closeBtn").click(function(){
    			
    			window.self.close();
    			
    		});
    		
    		$("#sendBtn").click(function(){
    			
   				var receiver = '${param.sender}';
   				var sender = '${id}';
   				var content = $("#content").val();
   				
    			$.ajax({
					
    				url : "./returnNote.do",
    				type : "post",
    				data : {"receiver" : receiver, "sender" : sender, "content" : content},
    				success : function(data) {
    					
    					alert(data.msg);
    					if(data.code == 200) {
    						
    						window.self.close();
    						
    					}
    					
    				}
    				
    			});
    			
    		});
    		
    	}
    
    
    </script>
    
<body>

	<% 
		String test = request.getHeader("referer");
		request.setAttribute("test", test);
		System.out.println(test);
	%>
	
		<div class="presentation-container">
		<h1><span class="violet">답장</span></h1>
	</div>
	
	<table class="table table-striped table-bordered table-hover text-muted">
		<tr>
			<td width = "50%"><label>받는사람</label></td>
			<td><label>${param.sender}</label></td>
		</tr>
		<tr>
			<td width = "50%" colspan = "2" height = "150px"><textarea cols="30" rows="6" name = "content" id = "content"></textarea></td>
		</tr>
	</table>
		<label>
			<input type = "button" value = "보내기" class = "btn" id = "sendBtn" />
			<input type = "button" value = "닫기" class = "btn" id = "closeBtn" />
		</label>
	
</body>
</html>