<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="kr">

    <head>
        <%@include file="../../sub/subfile.jsp" %>
    </head>
    
    <script>
    	
    	$().ready(function(){
    		
    		btnAction();
    		
    	});
    	
    	function btnAction() {
    		
    		$("#writeBtn").click(function(){
    			
    			var title = $("#title").val();
	    		var content = $("#content").val();
    			
	    		if(title != "" && content != ""){
	    		
	    			$.ajax({
	    				
		    			url : "./lookForTeamModify.do",
		    			type : "post",
		    			data : $("form").serialize(),
		    			success : function(data) {
		    				alert(data.msg);
		    				location.href = "./lookForTeamBoardDetail.do?bthSeqNo=" + ${boardList.BTH_SEQ_NO}
		    			}
		    			
	    			});
	    			
	    			return false;
    			
	    		} else if (title == ""){
	    			
					alert("제목을 입력하세요.");
					$("#title").focus();
					
				} else if (content == "") {
					
					alert("내용을 입력하세요.");
					$("#content").focus();
					
				} 
    			
    		});
    		
    		$("#listBtn").click(function(){
    			
    			location.href = "./lookForTeamBoard.do";
    			
    		});
    		
    		
    	}
    	
    
    </script>
    
<body>
	<%@include file="../../main/topmain.jsp" %>
	<div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">글 수정</span></h1>
            	</div>
           	</div>
        </div>
    </div>
    <form>
        <div class="presentation-container">
	        <div class="container">
	       		<div class="row">
	       			<table class="table table-striped table-bordered table-hover text-muted">
	       				<tr>
	       					<td>제목</td>
	       					<td style = "text-align: left;"><input type = "text" id = "title" name = "title" size = "50" value = "${boardList.TITLE}" ></td>
	       				</tr>
	       				<tr>
	       					<td>작성자</td>
	       					<td style = "text-align: left;"><label id = "writer">${id}</label></td>
	       				</tr>
	       				<tr>
	       					<td colspan = "2">
								<textarea rows="15" 
										  cols="120" 
										  id = "content"
										  style ="background-color:lavenderblush;" name = "content" >${boardList.CONTENT}</textarea>
							</td>
	       				</tr>
	       			</table>
	       		</div>
	       	</div>
       	</div>
       	<div class="presentation-container">
	        <div class="container">
	       		<div class="row">
	       			<input type = "hidden" value = "${id}" name = "id" />
	       			<input type = "hidden" value = "${boardList.BTH_SEQ_NO}" name = "bthSeqNo" />
	       			<input type = "button" class = "btn" value = "저장하기" id = "writeBtn"/>
	       			<input type = "button" class = "btn" value = "목록가기" id = "listBtn"/>
	       			<input type = "hidden" name = "pId" value = "${param.pId}" />
					<input type = "hidden" name = "lvl" value = "${param.pId != null && param.pId != '' ? param.lvl + 1 : ''}" />
	       		</div>
	       	</div>
	    </div>
	</form>
    
</body>
</html>