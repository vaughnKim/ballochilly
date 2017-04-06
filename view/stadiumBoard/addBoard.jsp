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
	$(document).ready(function() {
		
		addBoard();
		list();
		
		// 전체 우클릭 금지시키기
		$(document).bind("contextmenu", function(){
			return false;
		});	//end bind
	}); 
	
	// empty infos on typing space 
	function emptyInfo() {
		if($("#title").val() == ""){
			alert("제목을 입력하세요");
			$("#title").focus(); 
			return false;
		} else if($("#content").val() == "") {
			alert("게시글을 입력해주세요");
			$("#content").focus(); 
			return false;
		} 
			
	}
	
	function addBoard() {
		$("input[type=submit]").click(function(){
		emptyInfo();
			$("form").ajaxSubmit({
				url : "./addBoard.do",
				type : "post",
				success : function(result){
					alert(result.msg);
					location.assign("./listBoard.do");
				}
			});
			return false;
		});	
	}
	
	function list() {
		$("#list").click(function(){
			location.assign("./listBoard.do");
		});
	}
	
</script>
<body>
    <!-- Top menu -->
    <%@include file="../main/topmain.jsp" %>
    <div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">글쓰기</span></h1>
            	</div>
           	</div>
       	</div>
	</div>
	<form method="post" action="addBoard.do" enctype="multipart/form-data">
	<div class = "services-container">
		<div class = "container">
			<div class="row">
				<div class="no-text-center panel-heading">
					<table class="table table-striped table-bordered table-hover text-muted no-text-center" style = "width:70%;">
					
						<tr>
							<td align="center">제목</td>
							<td align="left"> <input type="text" name="title" id="title" placeholder=" 제목을 입력하세요 " maxlength="85"/> ${param.P_ID}</td>
						</tr>
						
						<tr>
							<td align="center">아이디</td>
							<td align="left"> <label for="id">${user.ID}</label><input type="hidden" name="id" value="${user.ID}"/></td>
						</tr>
						<tr>
							<td align="center">파일</td>
							<td> <input type="file" name="bsrAtchFname" multiple /> </td>
						</tr>
<!-- 						<tr> -->
<!-- 							<td align="center">동영상 파일</td> -->
<!-- 							<td> <input type="file" name="bvAtchVname" multiple /> </td> -->
<!-- 						</tr> -->
						<tr>
							<td align="center">내용</td>
							<td> <textarea name="content" cols="50" rows="13" id="content" maxlength="1000"/></textarea> </td>
						</tr>
					</table>
					<div class ="no-text-center panel-heading text-muted" align="center">
						<input type="submit" value="작성완료" class="L_Btn"/>
						<input type="reset" value="다시쓰기" class="L_Btn" />
						<input type="button" id="list" value="목록" class="L_Btn"/>
						<input type="hidden" name="pId" value="${param.pId}" />
						<input type="hidden" name="lvl" value="${param.pId != null && param.pId != '' ? param.lvl + 1 : ''}" />
					</div>	
				</div>
			</div>
		</div>
	</div>
	</form>
</body>
</html>