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
    		
    		msgPop();
    		btnAction();
    		rejectBtnState();
   			
    	}); 
    	
    	function msgPop() {
    		
    		opener.location.reload();
    		
    	}	//end msgPop
    	
    	function rejectBtnState() {
    		var msgYn = '${param.msgYn}';
    		if(msgYn == 'Y' || msgYn == 'N') {
    			$("#rejectBtn, #approveBtn").attr("disabled", false);
    		} else {
    			$("#rejectBtn, #approveBtn").attr("disabled", "disabled");
    		}	//end if
    	}	//end rejectBtnState
    	
    	function btnAction() {
    		
			$("#approveBtn").click(function(){
				
	    		var id = '${msgList.SENDER}';
	    		var teamSeqNo = '${param.teamSeqNo}';
// 	    		alert(teamSeqNo);
	    		
	    		$.ajax({
	    			
	    			url : "./isExistTeamMember.do",
					type : "post",
					data : {"id" : id, "teamSeqNo" : teamSeqNo},
					success : function(data) {
						
						if(data.code == 201) {
							alert(data.msg);
							opener.location.reload();
							window.self.close();
							return false;
						} else {
							opener.location.reload();
							approveMember();
						}	//end if
					}	//end success
	    			
	    		});	//end ajax
				return false;
    		});	//end click
    		
    		
    		$("#rejectBtn").click(function(){
    			
				var id = '${msgList.SENDER}';
				var teamSeqNo = '${param.teamSeqNo}';
	    		
	    		$.ajax({
	    			
	    			url : "./isExistTeamMember.do",
					type : "post",
					data : {"id" : id, "teamSeqNo" : teamSeqNo},
					success : function(data) {
						
						if(data.code == 201) {
							alert(data.msg);
							opener.location.reload();
							window.self.close();
							return false;
						} else {
							opener.location.reload();
							rejectBtn();
						}	//end if
					}	//end success
	    			
	    		});	//end ajax
				return false;
    			
    		});	//end click
    		
    	}	//end btnAction
    	
    	function rejectBtn() {
    		
    		var sender = '${selectTeam.TEAM_NAME}';
			var receiver = '${msgList.SENDER}';
			
			$.ajax({
				
				url : "./rejectTeam.do",
				type : "post",
				data : {"sender" : sender, "receiver" : receiver},
				success : function(data) {
					
					alert(data.msg);
					updateMsgYnState();
					
				}	//end success
				
			});	//end ajax
			
    		
    	}
    	
    	
    	function updateMsgYnState() {
    		
    		var msgSeqNo = '${msgList.MSG_SEQ_NO}';
    		var msgYn = '${msgList.MSG_YN}';
    		
    		$.ajax({
    			
    			url : "./updateMsgYnState.do",
    			type : "post",
    			data : {"msgSeqNo" : msgSeqNo, "msgYn" : msgYn},
    			success : function(data) {
    				opener.location.reload();
    				window.self.close();
    			}	//end success
    			
    		});	//end ajx
    		
    	}	//end updateMsgYnState
    	
    	
    	function approveMember() {

   			var sender = '${id}';
   			var receiver = '${msgList.SENDER}';
   			var teamSeqNo = '${param.teamSeqNo}';
   			
   			$.ajax({
   				
   				url : "./approveTeam.do",
   				type : "post",
   				data : {"sender" : sender, "receiver" : receiver, "teamSeqNo" : teamSeqNo},
   				success : function(data) {
   					
   					alert(data.msg);
   					if(data.code == 200) {
   						
   						window.self.close();
   						
   					}	//end if
   				}	//end success
   				
   			});	//end ajax
    		
    	}	//end approveMember
    	
    </script>
<body>

	<div class="presentation-container">
		<h1><span class="violet">메시지</span></h1>
	</div>
	
	<table class="table table-striped table-bordered table-hover text-muted">
		<tr>
			<td width = "50%"><label>보낸사람 / 팀</label></td>
			<td><label>${msgList.SENDER}</label></td>
		</tr>
		<tr>
			<td width = "50%" colspan = "2" height = "150px">${msgList.CONTENT}</td>
		</tr>
	</table>
	<c:if test="${msgList.CONTENT != '거절하셨습니다'}">
		<label>
			<input type = "button" value = "승인" class = "btn" id = "approveBtn" />
			<input type = "button" value = "거절" class = "btn" id = "rejectBtn" />
		</label>
	</c:if>
	
</body>

</html>