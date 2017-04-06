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
    	
    	
    	function btnAction() {
    		
    		$("#closeBtn").click(function(){
    			
    			window.self.close();
    			
    		});
    		
    		$("#reBtn").click(function(){
    			
    			var sender = '${param.sender}';
    			location.href = "./returnMsg.do?sender=" + sender;
    			
    		});
    		
    	}
    	
    
    </script>


<body>

	<div class="presentation-container">
		<h1><span class="violet">받은 쪽지</span></h1>
	</div>
	
	<table class="table table-striped table-bordered table-hover text-muted">
		<tr>
			<td width = "50%"><label>보낸사람</label></td>
			<td><label>${myNoteList.SENDER}</label></td>
		</tr>
		<tr>
			<td width = "50%" colspan = "2" height = "150px">${myNoteList.CONTENT}</td>
		</tr>
	</table>
	<label>
		<input type = "button" value = "답장" class = "btn" id = "reBtn" />
		<input type = "button" value = "닫기" class = "btn" id = "closeBtn" />
	</label>
	
</body>
</html>