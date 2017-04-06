<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">

    <head>
        <%@include file="../../sub/subfile.jsp" %>
    </head>
    <link rel="stylesheet" href="assets/bootstrap/css/setCss.css">
    <script>
    </script>
    <body>
        
        <%@include file="../../main/topmain.jsp" %>
        <div class="presentation-container">
	       	<div class="container">
	       		<div class="row">
	        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
	            		<h1><span class="violet">풋살 경기 규칙</span></h1>
	            	</div>
	           	</div>
	       	</div>
		</div>
        <iframe id="fred" style="border:1px solid #666CCC" 
        		title="PDF in an i-Frame" 
        		src="rule.pdf" 
        		frameborder="1" 
        		scrolling="auto" 
        		height="800" 
        		width="600" ></iframe>
	</body>
</html>