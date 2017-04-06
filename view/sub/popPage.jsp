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
    		
    		fnPop();
    		
    	});
    	
    	function fnPop() {
    		
    		$("#mainGo").click(function(){
    			
    			window.opener.parent.location.href = "./main.do";
    			window.self.close();
    			
    		});
    		
    		$("#loginGo").click(function(){
    			
    			window.opener.parent.location.href = "./login.do";
    			window.self.close();
    			
    		});
    		
    	}
    	
    </script>
<body>
	<div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">Success<br>Join Member</span></h1>
            	</div>
           	</div>
       	</div>
       	<div class="container">
       		<div class="row">
				<input type = "button" value ="메인갈래?" id = "mainGo" class = "btn"/> 
				<input type = "button" value ="로그인할래?" id = "loginGo" class = "btn"/> 
       		</div>
       	</div>
	</div>
</body>
</html>