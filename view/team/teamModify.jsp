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
//     		alert('${teamList.TEAM_EMBLEM}');
//     		alert('${teamList.TEAM_SEQ_NO}');
   			btnAction();
    		selectTeamLoc();
    		selectTeamAge();
    		teamEmblemView();
    		
    	});
    	
    	function btnAction() {
    		
    		$("#changeEmblem").click(function(){
    			
    			var form = $("form")[0];
				var formData = new FormData(form);
				
    			$.ajax({
    				
    				url : "./updateEmblemTeam.do",
    				type : "post",
    				processData : false,
					contentType : false,
    				data : formData,
    				success : function(data) {
    					
   						alert(data.msg);
//     					if(data.code == 200) {
    						location.reload();
//     					}
    					
    				}
    				
    				
    			});
    			
    		});
    		
    		
    		$("#saveBtn").click(function(){
    			
    			var teamSeqNo = '${teamList.TEAM_SEQ_NO}';
    			var teamLoc = $("#selectTeamLocation > option:selected").val();
    			var teamAge = $("#selectTeamMemberAge > option:selected").val();
    			var teamNum = $("#teamNumber").val();
    			var teamInfo = $("#teamInfo").val();
    			var teamName = $("#teamName").val();
//     			var teamEmblem = $("#teamEmblem").val();
    			
//     			alert(teamSeqNo);
//     			alert(teamLoc);
//     			alert(teamAge);
//     			alert(teamNum);
//     			alert(teamInfo);
//     			alert(teamName);

//     			var form = $("form")[0];
// 				var formData = new FormData(form);
				
    			$.ajax({
    				
    				url : "./teamModify.do",
    				type : "post",
//     				processData : false,
// 					contentType : false,
//     				data : formData,
					data : {"teamSeqNo" : teamSeqNo,
							"teamLoc" : teamLoc,
							"teamAge" : teamAge,
							"teamNum" : teamNum,
							"teamInfo" : teamInfo,
							"teamName" : teamName},
    				success : function(data) {
    					
   						alert(data.msg);
    					if(data.code == 200) {
    						location.href = "./userTeam.do";
    					}
    					
    				}
    				
    				
    			});
    			
    			
    		});
    		
    		$("#cancleBtn").click(function(){
    			
    			location.href = "./userTeam.do";
    			
    		});
    		
    		
    	}
    	
    	function selectTeamLoc() {
    		
    		var teamLoc = '${teamList.TEAM_LOCATION}';
			$("#selectTeamLocation > option").each(function(idx, data){
    			
    			if( $(data).val() == teamLoc ){
    				$(data).attr("selected", "selected") ;
    			}
    			
    		});
    		
    	}
    	
    	function selectTeamAge() {
    		
    		var teamAge = '${teamList.TEAM_MEMBER_AGE}';
			$("#selectTeamMemberAge > option").each(function(idx, data){
    			
    			if( $(data).val() == teamAge ){
    				$(data).attr("selected", "selected") ;
    			}
    			
    		});
    		
    	}
    	
		function teamEmblemView() {
			
			$("#teamEmblem").change(function(){
				
				$("form").ajaxSubmit({
					url : "./fileUpload.do",
					type : "post",
					success : function(data) {
//	 					alert(data.result);
//	 					console.log(data);
						$("#view").css({"background-image":"url(" + data.fileImage +")" ,
							            "background-size":"100px 100px" ,
							            "border-radius":"100px;"});
					}
				});
			
				return false;
				
			});
			
		}
    
    
    </script>
    
    
    
<body>
	<%@include file="../main/topmain.jsp" %>
	<div class="presentation-container">
	       	<div class="container">
	       		<div class="row">
	        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
	            		<h1><span class="violet">팀 정보수정</span></h1>
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
									 style = "border-radius: 100px;"><br/>
								<form enctype="multipart/form-data" accept-charset="utf-8">
						           	<input type = "hidden" value = "${param.teamSeqNo}" name = "teamSeqNo" />
									<input type = "file" id = "teamEmblem" name = "teamEmblem" value = "${teamList.TEAM_EMBLEM}"/> <br/>
							           	<lable style = "color:red;">최적사이즈 100px X 100px</lable><br/><br/>
										<lable style = "color:royalblue;">엠블럼 미리보기</lable><br/><br/>
										<div id = "view" style = "width:100px; height:100px; border:1px solid steelblue; border-radius: 100px; margin: 0 auto;">
										</div><br/>
									<input type = "button" id = "changeEmblem" value = "엠블럼변경" class = "mini-btn"/>
						       	</form>
	           				</td>
	           			</tr>
	           			<tr>
	           				<td>팀명</td>
	           				<td><input type = "text" id = "teamName" name = "teamName" value = "${teamList.TEAM_NAME}" /></td>
	           			</tr>
	           			<tr>
	           				<td>실제 인원 수</td>
	           				<td><input type = "text" id = "teamNumber" name = "teamNum" value = "${teamList.TEAM_MEMBER_NUM}" /></td>
	           			</tr>
	           			<tr>
	           				<td>가입 한 사이트 회원 수</td>
	           				<td>${countTeamMember}</td>
	           			</tr>
	           			<tr>
	           				<td>연령층</td>
							<td>
								<select id = "selectTeamMemberAge" name = "teamAge">
			    					<option value = "6666" disabled = "disabled" selected = "selected">선택하세요</option>
		    						<option value ="유소년">유소년</option>
		    						<option value ="10대">10대</option>
		    						<option value ="20대">20대</option>
		    						<option value ="30대">30대</option>
		    						<option value ="40대">40대</option>
		    						<option value ="50대">50대</option>
		    						<option value ="60대">60대</option>
		    						<option value ="70대">70대</option>
		    						<option value ="80대">80대</option>
		    					</select>
		    				</td>
	           			</tr>
	           			<tr>
	           				<td>지역</td>
	           				<td>
	          					<select id = "selectTeamLocation" name = "teamLoc">
									<option value = "7777" disabled = "disabled" selected = "selected">선택하세요</option>
									<option value = "서구">서구</option>
									<option value = "동구">동구</option>
									<option value = "유성구">유성구</option>
									<option value = "대덕구">대덕구</option>
									<option value = "중구">중구</option>
								</select>
	           				</td>
	           			</tr>
	           			<tr>
	           				<td>팀소개</td>
	           				<td>
	           					<textarea id = "teamInfo" name = "teamInfo">${teamList.TEAM_INFO}</textarea>
	         				</td>
	           			</tr>
	           		</table>
	           	</div>
	           	<input type = "button" value = "저장" id = "saveBtn" class = "btn"/>
	           	<input type = "button" value = "취소" id = "cancleBtn" class = "btn"/>
	       	</div>
	</div>
</body>
</html>