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
    		
    		$("#createTeam").click(function(){
    			location.href = "./teamRegister.do";	
    		});
    		
    		$("#searchTeam").click(function(){
    			location.href = "./teamInfo.do";	
    		});
    		
    		
    		$(".teamModify").click(function(){
    			
    			var teamSeqNo = $(this).attr("team-seq-no-3");
    			location.href = "./teamModify.do?teamSeqNo=" + teamSeqNo;
    			
    		});
    		
    		
    		// 팀 삭제
    		$(".teamDelete").click(function(){
    			
    			var id = '${id}';
    			var teamSeqNo = $(this).attr("team-seq-no-2");
    			
    			if(confirm("진짜 삭제합니까?")) {
	    			$.ajax({
	    				
	    				url : "./teamDelete.do",
	    				type : "post",
	    				data : {"id" : id, "teamSeqNo" : teamSeqNo},
	    				success : function(data) {
	    					alert(data.msg);
	    					location.reload();
	    				}
	    			});
    			}
    		});
    		
    		// 팀 탈퇴
    		$(".teamDropOut").click(function(){
    			
    			var id = '${id}';
    			var teamSeqNo = $(this).attr("team-seq-no");
    			
    			if(confirm("진짜 탈퇴합니까?")) {
    				
	    			$.ajax({
	    				
	    				url : "./dropOut.do",
	    				type : "post",
	    				data : {"id" : id, "teamSeqNo" : teamSeqNo},
	    				success : function(data){
	    					
	    					alert(data.msg);
	    					location.reload();
	    				}	//end success
	    				
    				});	//end ajax
	    			
    			}	//end if
    			
    		});	//end click
    		
    	}	//btnAction
    
    </script>
    
<body>
	<%@include file="../main/topmain.jsp" %>
	<div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">내 팀 정보</span></h1>
            	</div>
           	</div>
			<c:if test="${count != 0}">
	           	<div class="row">
					<div class="col-sm-12 work-title wow fadeIn">
						<h2>가입한 팀 (${count})</h2>
			    	</div> 
				</div>
	           	<div class="row">
					<table class="table table-striped table-bordered table-hover text-muted">
						<tr>
							<td width = "30%">엠블럼</td>
							<td width = "60%">상세정보</td>
							<td width = "10%">비고</td>
						</tr>
						<c:forEach items="${myTeamList}" var="myTeam" varStatus="status">
							<tr height = "50px" >
								<td>
									<img src="/emblem/${myTeam.TEAM_EMBLEM}" 
											 width = "100px" 
											 height = "100px" 
											 onerror = 'this.src="/emblem/null.jpg"'
											 style = "border-radius: 100px;">
								</td>
								<td>
									팀 이름 : ${myTeam.TEAM_NAME}<br/>
									멤버 수 : ${myTeam.TEAM_MEMBER_NUM}<br/>
									연령층 : ${myTeam.TEAM_MEMBER_AGE}<br/>
									지역 : ${myTeam.TEAM_LOCATION}<br/>
									소개 : ${myTeam.TEAM_INFO}<br/>
								</td>
								<td>
									<c:if test="${id == myTeam.ID}">
										<input type = "button" value ="팀 삭제" class = "btn teamDelete" team-seq-no-2 = "${myTeam.TEAM_SEQ_NO}"/> <br/><br/>
										<input type = "button" value ="팀 수정" class = "btn teamModify" team-seq-no-3 = "${myTeam.TEAM_SEQ_NO}"/>
									</c:if>
									<c:if test="${id != myTeam.ID}">
										<input type = "button" value ="팀 탈퇴" class = "btn teamDropOut" team-seq-no = "${myTeam.TEAM_SEQ_NO}"/>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
					<label>
						${pagination}
					</label>
				</div>							
			</c:if>
			<c:if test="${count == 0 }">
				<div class="row">
					<fieldset>	
						<legend><h3>현재 가입된 팀이 없습니다</h3></legend>
					</fieldset>
				</div>
				<div class="row">
					<table class="table table-striped table-bordered table-hover text-muted" >
						<tr>
							<td>
								<h4>새로운 팀을 직접 생성하시려면 <br/>팀 생성 버튼을 눌러주세요</h4>
								<input type = "button" value = "▶ 팀 생성" class = "btn" id = "createTeam"/>
							</td>
						</tr>
						<tr>
							<td>
								<h4>이미 생성되어 있는 팀에 가입하시려면 <br/>팀 검색 버튼을 눌러주세요</h4>
								<input type = "button" value = "▶ 팀 검색" class = "btn" id = "searchTeam"/>
							</td>
						</tr>
					</table>
				</div>
			</c:if>
       	</div>
	</div>
</body>
</html>