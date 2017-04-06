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
    		
//     		alert('${teamList.TEAM_SEQ_NO}');
    		btnAction();
    		
    	});
    	
//     	function alreadyJoinTeam() {
    		
//     		var id = '${id}';
//     		var teamSeqNo = '${teamList.TEAM_SEQ_NO}';
    		
//     		$.ajax({
    			
//     			url : "./alreadyJoinTeam.do",
//     			type : "post",
//     			data : {"id" : id, "teamSeqNo" : teamSeqNo},
//     			success : function(data) {
    				
//     			}
    			
//     		});
    		
//     	}
    	
    	function joinTeamMsg() {
    		
    		var sender = '${id}';
			var receiver = '${teamList.ID}';
			var content = $("#content").val();
			var teamSeqNo2 = '${teamList.TEAM_SEQ_NO}';
			
// 			alert(teamSeqNo2);
			
			$.ajax({
				
				url : "./joinTeamMessage.do",
				type : "post",
				data : {"sender" : sender, "receiver" : receiver, "content" : content, "teamSeqNo2" : teamSeqNo2},
				success : function(data){
					
					alert(data.msg);
					
					if(data.code == 200) {
    					location.href = "./teamInfo.do";
					} else {
						location.href = "./main.do";
					}
					
				}	//end success
				
			});	//end ajax
    		
    	}
    	
    	
    	function btnAction() {
    		
    		$("#joinTeamBtn").click(function(){
    			
    			var id = '${id}';
        		var teamSeqNo = '${teamList.TEAM_SEQ_NO}';
        		
        		$.ajax({
        			
        			url : "./alreadyJoinTeam.do",
        			type : "post",
        			data : {"id" : id, "teamSeqNo" : teamSeqNo},
        			success : function(data) {
        				
        				if(data.code == 200) {
        					joinTeamMsg();
        				} else {
        					alert(data.msg);
        				}
        				
        			}
        			
        		});
    			
    			
    		});	//end click
    		
    		
    		$("#backBtn").click(function(){
    			
    			location.href = "./teamInfo.do";
    			
    		});
    		
    	}
    
    
    </script>
    
    
    
<body>
	<%@include file="../main/topmain.jsp" %>
	<div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">팀 상세보기</span></h1>
            	</div>
           	</div>
           	<div class="row">
				<div class="col-sm-12 work-title wow fadeIn">
					<h2>${teamList.TEAM_NAME}</h2>
		    	</div> 
			</div>
           	<div class="row">
           		<table class="table table-striped table-bordered table-hover text-muted">
           			<tr>
           				<td rowspan = "7" width = "30%">
           					<img src="/emblem/${teamList.TEAM_EMBLEM}" 
								 width = "180px" 
								 height = "180px" 
								 onerror = 'this.src="/emblem/null.jpg"'
								 style = "border-radius: 100px;margin:7% 0 0 0;">
           				</td>
           			</tr>
           			<tr>
           				<td>팀명</td>
           				<td>${teamList.TEAM_NAME}</td>
           			</tr>
           			<tr>
           				<td>
           					실제 인원 수<br/>
           					(최초 입력 수 + 가입 한 사이트 회원 수)
           				</td>
           				<td>${teamList.TEAM_MEMBER_NUM + countTeamMember}
           			</tr>
           			<tr>
           				<td>가입 한 사이트 회원 수</td>
           				<td>${countTeamMember}</td>
           			</tr>
           			<tr>
           				<td>연령층</td>
           				<td>${teamList.TEAM_MEMBER_AGE}</td>
           			</tr>
           			<tr>
           				<td>지역</td>
           				<td>${teamList.TEAM_LOCATION}</td>
           			</tr>
           			<tr>
           				<td>팀소개</td>
           				<td>
           					<textarea disabled="disabled">${teamList.TEAM_INFO}</textarea>
         				</td>
<%--            				<td><textarea disabled="disabled">${teamList.TEAM_INFO}</textarea></td> --%>
           			</tr>
           		</table>
           	</div>
           	
           	<div class="row">
           		<input type = "button" value = "목록보기" id = "backBtn" class = "btn"/>
           	</div>
           	
          	<c:if test="${teamList.ID != null && teamList.ID != id && id != null}">
           	<div class="row">
				<div class="col-sm-12 work-title wow fadeIn">
					<h2>팀 신청 메시지</h2>
		    	</div> 
			</div>
           	
	           	<div class="row">
           			<table class="table table-striped table-bordered table-hover text-muted mini-table-center" style = "width:270px;margin-left: auto;margin-right: auto;" >
           				<tr>
           					<td>받는사람</td>
           					<td>${teamList.ID}</td>
           				</tr>
           				<tr>
           					<td>보내는사람</td>
           					<td>${id}</td>
           				</tr>
           				<tr>
           					<td>내용</td>
           					<td><textarea id = "content" name = "content"></textarea></td>
           				</tr>
           			</table>
           			<input type = "button" value = "가입신청" id = "joinTeamBtn" class = "btn"/>
	           	</div>
           	</c:if>
       	</div>
	</div>
</body>
</html>