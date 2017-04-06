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
    		msgDetailPop();
    		myNoteDetailPop();
    		readMessageState();
//     		allCheck();
    		
    	});
    	
    	
    	function btnAction() {
    		
			$("#goStartPage").click(function(){
				
				var page = $("#goStartPage").attr("pagination");
				location.href = "message.do?page=" + page;
				
			});
			
			$(".goPage").click(function(){
				
				var page = $(this).attr("pagination");
				location.href = "message.do?page=" + page;
				
			});
			
			$("#goNextPage").click(function(){
				
				var page = $("#goNextPage").attr("pagination");
				location.href = "message.do?page=" + page;
				
			});
			// 메시지 선택 삭제하는 기능
			$("#chkDelBtn").click(function(){
				
				if(confirm("진짜 삭제합니까?")) {
					
					$(".msgCheck:checked").each(function(idx, row){
						
						var row = $(row).parents("tr").remove();
						var msgSeqNo = $(this).attr("msgSeqNo");
						
						$.ajax({
							
							url : "./deleteMsg.do",
							type : "post",
							data : {"msgSeqNo" : msgSeqNo},
							success : function(data) {
								location.reload();
							}	//end success
							
						});	//end ajax
						
					});	//end each
					
				}	//end if
				
				alert("삭제가 완료됐습니다.");
				
			});	//end click
			
			$("#chkMyNoteDelBtn").click(function(){
				
				if(confirm("진짜 삭제합니까?")) {
					
					$(".noteCheck:checked").each(function(idx, row){
						
						var row = $(row).parents("tr").remove();
						var noteSeqNo = $(this).attr("noteSeqNo");
						
						$.ajax({
							
							url : "./deleteNote.do",
							type : "post",
							data : {"noteSeqNo" : noteSeqNo},
							success : function(data) {
								location.reload();
							}	//end success
							
						});	//end ajax
						
					});	//end each
					
				}	//end if
				
				alert("삭제가 완료됐습니다.");
				
			});	//end click
			
			$("#chkSendDel").click(function(){
				
				if(confirm("진짜 삭제합니까?")) {
					
					$(".sendCheck:checked").each(function(idx, row){
						
						var row = $(row).parents("tr").remove();
						var noteSeqNo = $(this).attr("sendSeqNo");
						
						$.ajax({
							
							url : "./deleteNote.do",
							type : "post",
							data : {"noteSeqNo" : noteSeqNo},
							success : function(data) {
								location.reload();
							}	//end success
							
						});	//end ajax
						
					});	//end each
					
				}	//end if
				
				alert("삭제가 완료됐습니다.");
				
			});	//end click
			
			
    	}	//end btnAction
    	
    	// 전체 선택, 해제 기능
//     	function allCheck() {
    		
//     		$(".msgCheck").on('change', function(){
    			
//     			$(".msgCheck").prop('checked', this.checked);
    			
    			
//     		});
    		
//     	}
    	
    	function myNoteDetailPop() {
    		
    		$(".noteSeqNo").click(function() {
    			
    			var noteYn = $(this).attr("note-yn");
				var noteSeqNo = $(this).attr("note-seq-no");
				var sender = $(this).attr("sender");
	    		var popUrl = "./myNoteDetail.do?noteYn=" + noteYn + "&noteSeqNo=" + noteSeqNo + "&sender=" + sender;	
	    		var popOption = "width=250, height=350, resizable=no, scrollbars=no, status=no, top=300, left=300, location=no, menubar=no";    //팝업창 옵션(optoin)
	    			window.open(popUrl,"",popOption);
    			
    		});	//end click
    		
    	}
    	
    	
		function msgDetailPop(){
    		
			$(".msgSeqNo").click(function(){
				
				var teamSeqNo = $(this).attr("team-seq-no");
				var msgYn = $(this).attr("msg-yn");
				var msgSeqNo = $(this).attr("msg-seq-no");
	    		var popUrl = "./msgDetailPop.do?msgSeqNo=" + msgSeqNo + "&msgYn=" + msgYn + "&teamSeqNo=" + teamSeqNo;	
	    		var popOption = "width=250, height=350, resizable=no, scrollbars=no, status=no, top=300, left=300, location=no, menubar=no";    //팝업창 옵션(optoin)
	    			window.open(popUrl,"",popOption);
	    		
			});	//end click
    		
    	}	//end msgDetailPop
		
		function readMessageState() {
			
			$(".msgCnt").each(function(idx, data){
				
				var index = idx + 1;
				
				if($(".msgYn_" + index).text() == 'N') {
					
					$(".msgYn_" + index).text("읽지않음").css("color", "red");
					
				} else {
					
					$(".msgYn_" + index).text("읽음").css("color", "blue");
					
				}	//end if
				
			});	//end each
			
			$(".noteCnt").each(function(idx, data){
				
				var index = idx + 1;
				
				if($(".noteYn_" + index).text() == 'N') {
					
					$(".noteYn_" + index).text("읽지않음").css("color", "red");
					
				} else {
					
					$(".noteYn_" + index).text("읽음").css("color", "blue");
					
				}	//end if
				
			});	//end each
			
			$(".sendCnt").each(function(idx, data){
				
				var index = idx + 1;
				
				if($(".sendYn_" + index).text() == 'N') {
					
					$(".sendYn_" + index).text("읽지않음").css("color", "red");
					
				} else {
					
					$(".sendYn_" + index).text("수신확인").css("color", "blue");
					
				}	//end if
				
			});	//end each
			
		}	//end readMessageState
		
		function cancelBtn(_this) {
			
			if(confirm("진짜 삭제합니까?")) {
				
				var sendSeqNo = $(_this).attr("sendSeqNo");
				
				$.ajax({
					
					url : "./deleteNote.do",
					type : "post",
					data : {"noteSeqNo" : sendSeqNo},
					success : function(data) {
						alert(data.msg);
						location.reload();
					}	//end success
					
				});	//end ajax
				
			}	//end if
			
		}
    	
    
    </script>
    
    <style>
    	
   	.content {

		padding:5em;
		border:3px solid red;

	}
	
	#tab input:nth-of-type(1):checked ~ label:nth-of-type(1), label[for=tab1]:hover {   
	
		background-color: dodgerblue;
		color:#ffffff;

	}

	#tab input:nth-of-type(2):checked ~ label:nth-of-type(2), label[for=tab2]:hover {    

		background-color: darkslateblue;
		color:#ffffff;

	}
	
	#tab input:nth-of-type(3):checked ~ label:nth-of-type(3), label[for=tab3]:hover {    

		background-color: slateblue;
		color:#ffffff;

	}

	#tab1, .tab1_content, 
	#tab2, .tab2_content,
	#tab3, .tab3_content{

 		display:none; 

	}

	#tab input:nth-of-type(1):checked ~ div:nth-of-type(1),
  	#tab input:nth-of-type(2):checked ~ div:nth-of-type(2),
  	#tab input:nth-of-type(3):checked ~ div:nth-of-type(3){

		display : block;

	}

	#tab input:nth-of-type(1):checked ~ .content{

		 border-color : dodgerblue;

	}

	#tab input:nth-of-type(2):checked ~ .content{

		 border-color : darkslateblue;

	}
	
	#tab input:nth-of-type(3):checked ~ .content{

		 border-color : slateblue;

	}
	
	.test {
	
		display: inline-block;
		max-width: 100%;
		margin-bottom: 0px;
		font-weight: 700;
		font-size: 20px;
	
	}

    </style>
    
<body>
	<%@include file="../main/topmain.jsp" %>
	
	<div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">내 쪽지함</span></h1>
            	</div>
           	</div>
           	
           	<div id="tab">
	           	<input type="radio" id="tab1" name="tab" checked/>
				<input type="radio" id="tab2" name="tab" />
				<input type="radio" id="tab3" name="tab" />
				
				<label for="tab1" class = "test" style ="cursor: pointer;">&nbsp;팀 신청 쪽지함&nbsp;</label>&nbsp;&nbsp;&nbsp;&nbsp;
				<label for="tab2" class = "test" style ="cursor: pointer;">&nbsp;받은 편지함&nbsp;</label>&nbsp;&nbsp;&nbsp;&nbsp;
				<label for="tab3" class = "test" style ="cursor: pointer;">&nbsp;보낸 편지함&nbsp;</label>
				
	           	<div class ="tab1_content content">
					<c:if test="${code == 200}">
						<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
		            		<h1>팀 신청 쪽지함</h1>
		            	</div>
						<div class="row">
		           			<input type = "button" value = "선택삭제" id = "chkDelBtn" class = "btn text-center" style="float:right;" />
			           	</div>
			           	<div class="row">
			           		<table class="table table-striped table-bordered table-hover text-muted">
				           		<tr>
				           			<th class = "text-center" width = "25%">선택</th>
				           			<th class = "text-center" width = "25%">보낸사람 / 팀</th>
				           			<th class = "text-center" width = "25%">읽기여부</th>
				           		</tr>
					           	<c:forEach var ="msg" items ="${msgList}" varStatus="i">
						           	<tr>
						           		<td>
						           			<input type ="checkbox" name = "msgCheck_${msg.MSG_SEQ_NO}" class = "msgCheck" msgSeqNo = "${msg.MSG_SEQ_NO}"/>
						           		</td>
						           		<td style = "cursor: pointer;"class = "msgSeqNo" team-seq-no = "${msg.TEAM_SEQ_NO}"msg-seq-no = "${msg.MSG_SEQ_NO}" msg-yn="${msg.MSG_YN}" >${msg.SENDER}</td>
						           		<td style = "cursor: pointer;"class = "msgCnt msgSeqNo" msg-seq-no = "${msg.MSG_SEQ_NO}" msg-yn="${msg.MSG_YN}">
						           			<label class = "msgYn_${i.count}">${msg.MSG_YN}</label>
						           		</td>
						           	</tr>
					           	</c:forEach>
					           	
				           	</table>
				        </div>
			           	<div class="row">
		           			${pagination}
			           	</div>
			           
		           	</c:if>
		           	
		           	<c:if test="${code == 201}">
		           		${msg}
		           	</c:if>
				 </div>
				 
				 <div class ="tab2_content content">
	
					<c:if test="${code2 == 300}">
						<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
		            		<h1>받은 편지함</h1>
		            	</div>
						<div class="row">
		           			<input type = "button" value = "선택삭제" id = "chkMyNoteDelBtn" class = "btn text-center" style="float:right;" />
			           	</div>
			           	<div class="row">
			           		<table class="table table-striped table-bordered table-hover text-muted">
				           		<tr>
				           			<th class = "text-center" width = "25%">선택</th>
				           			<th class = "text-center" width = "25%">보낸사람</th>
				           			<th class = "text-center" width = "25%">읽기여부</th>
				           		</tr>
					           	<c:forEach var ="note" items ="${myNoteList}" varStatus="i">
						           	<tr>
						           		<td>
						           			<input type ="checkbox" name = "noteCheck_${note.NOTE_SEQ_NO}" class = "noteCheck" noteSeqNo = "${note.NOTE_SEQ_NO}"/>
						           		</td>
						           		<td style = "cursor: pointer;"class = "noteSeqNo" note-seq-no = "${note.NOTE_SEQ_NO}" note-yn="${note.NOTE_YN}" sender = "${note.SENDER}">${note.SENDER}</td>
						           		<td style = "cursor: pointer;"class = "noteCnt note-seq-no" note-seq-no = "${note.NOTE_SEQ_NO}" note-yn="${note.NOTE_YN}">
						           			<label class = "noteYn_${i.count}">${note.NOTE_YN}</label>
						           		</td>
						           	</tr>
					           	</c:forEach>
					           	
				           	</table>
				        </div>
			           	<div class="row">
		           			${notePagination}
			           	</div>
			           
		           	</c:if>
		           	
		           	<c:if test="${code2 == 301}">
		           		${msg2}
		           	</c:if>
			
				 </div>
				 <div class ="tab3_content content">
	
					<c:if test="${code3 == 400}">
						<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
		            		<h1>보낸 편지함</h1>
		            	</div>
			           	<div class="row">
			           		<table class="table table-striped table-bordered table-hover text-muted">
				           		<tr>
				           			<th class = "text-center" width = "25%">받는사람</th>
				           			<th class = "text-center" width = "25%">수신확인</th>
			           				<th class = "text-center" width = "25%">발송취소</th>
				           		</tr>
					           	<c:forEach var ="send" items ="${sendList}" varStatus="i">
						           	<tr>
						           		<td class = "sendSeqNo" send-seq-no = "${send.NOTE_SEQ_NO}" send-yn="${send.NOTE_YN}" receiver = "${send.RECEIVER}">${send.RECEIVER}</td>
						           		<td class = "sendCnt send-seq-no" send-seq-no = "${send.MSG_SEQ_NO}" send-yn="${send.NOTE_YN}">
						           			<label class = "sendYn_${i.count}">${send.NOTE_YN}</label>
						           		</td>
						           		<td>
						           			<c:if test="${send.NOTE_YN == 'N'}">
						           				<input type = "button" value = "발송취소" class = "mini-btn" onclick = "cancelBtn(this)" sendSeqNo = "${send.NOTE_SEQ_NO}"/>
						           			</c:if>
						           			<c:if test="${send.NOTE_YN != 'N'}">
						           				취소 할 수 없습니다
						           			</c:if>
						           		</td>
						           	</tr>
					           	</c:forEach>
					           	
				           	</table>
				        </div>
			           	<div class="row">
		           			${sendPagination}
			           	</div>
			           
		           	</c:if>
		           	
		           	<c:if test="${code3 == 401}">
		           		${msg3}
		           	</c:if>
			
				</div>
			</div>
<!-- 			위에 div가 tab end -->
       	</div>
	</div>
</body>
</html>