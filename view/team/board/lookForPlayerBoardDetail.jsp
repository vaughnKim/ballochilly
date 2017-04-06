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
    		noteShow();
    		$("#noteForm").draggable();
    		sendNote();
    		
    	});
		
    	function btnAction() {
    		
    		$("#replyBtn").click(function(){
    			
    			location.href = "./lookForPlayerBoardWrite.do?pId=${boardList.BPH_SEQ_NO}&lvl=${boardList.LVL}";
//     			history.back();
    			
    		});
    		
			$("#modifyBtn").click(function(){
				
				location.href = "./lookForPlayerModify.do?bphSeqNo=${boardList.BPH_SEQ_NO}";
				
			});	// end click
    		
    		$("#listBtn").click(function(){
    			
    			location.href = "./lookForPlayerBoard.do";
    			
    		});
			
			$("#closeBtn").click(function(){
				
				$("#noteForm").hide();
				
			});
			
			$("#replyInputBtn").click(function(){
				
				var id = '${id}';
				var bphSeqNo = '${param.bphSeqNo}';
				var content = $("#content").val(); 
				var secretReply = "";
				
				$("input:checkbox:checked").each(function(idx, data) {  
					secretReply = $(this).val();
			    });  
				
				if(content != "") {
				
					$.ajax({
						
						url : "./replyInsert2.do",
						type : "post",
						data : {"id" : id, "bphSeqNo" : bphSeqNo, "content" : content, "secretReply" : secretReply},
						success : function(data) {
							
							alert(data.msg);
							location.reload();
							
						}
						
					});
					
				} else {
					
					alert("내용을 입력해주세요")
					
				}
				
			});
			
    	}

		function sendNote() {
			
			$("#sendBtn").click(function(){
				
				var receiver = '${boardList.ID}';
				var sender = '${id}';
				var content = $("#noteContent").val();
				
				if(content != "") {
					
					$.ajax({
						
						url : "./insertNote.do",
						type : "post",
						data : {"sender" : sender, "receiver" : receiver,  "content" : content},
						success : function(data) {
							
							alert(data.msg);
							location.reload();
							
						}
						
					});
				} else {
					alert("내용을 입력하세요.");
				}
				
			});
	
	
		}

    	
    	function noteShow() {
    		
			$("#note").click(function(event){
				
				var btn = event.which;

				if(btn == 1) {
					
					var x = event.pageX;
					var y = event.pageY;
					$("#noteForm").css({"left" : x, "top" : y});
					$("#noteForm").show();
					return false;
					
				}	//end if
				
			});	//end click
    		
    	}
    	
    	
    	function deleteReply(_this) {
    		
    		var reply = $(_this).attr("reply-seq-no");
    		
    		$.ajax({
    			
    			url : "./deleteReply2.do",
    			type : "post",
    			data : {"brSeqNo" : reply},
    			success : function(data) {
    				
    				alert(data.msg);
    				location.reload();
    				
    			}
    			
    		});
    		
    	}
    	
    	function modifyReply(_this){
    		
    		$(".reply").each(function(idx, data){
    			
    			if($(data).attr("replySeqNo") == $(_this).attr("reply-seq-no")) {
    				
		    		var index = idx +1;
		    		$(".replySeqNo_" + index).show();
		    		$(".test_" + index).hide();
		    		$(".save_" + index).show();
		    		$(".cancel_" + index).show();
		    		$(".modify_" + index).hide();
		    		$(".delete_" + index).hide();
		    		
    			}
    			
    		});
    		
    	}
    	
    	function cancelBtn(_this) {
    		
			$(".reply").each(function(idx, data){
    			
    			if($(data).attr("replySeqNo") == $(_this).attr("reply-seq-no")) {
    				
		    		var index = idx +1;
		    		$(".replySeqNo_" + index).hide();
		    		$(".test_" + index).show();
		    		$(".save_" + index).hide();
		    		$(".cancel_" + index).hide();
		    		$(".modify_" + index).show();
		    		$(".delete_" + index).show();
		    		
    			}
    			
    		});
    		
    		
    	}
    	
    	function reallyModifyBtn(_this) {
    		
			$(".reply").each(function(idx, data){
    			
    			if($(data).attr("replySeqNo") == $(_this).attr("reply-seq-no")) {
    				
		    		var index = idx +1;
		    		var content = $(".replySeqNo_" + index).val();
		    		var brSeqNo = $(_this).attr("reply-seq-no");
		    		
		    		$.ajax({
		    			
		    			url : "./modiftyReply2.do",
		    			type : "post",
		    			data : {"content" : content , "brSeqNo" : brSeqNo},
		    			success : function(data){
		    				
		    				alert(data.msg);
		    				location.reload();
		    				
		    			}
		    		
		    		});
		    		
    			}
    			
    		});
    		
    		
    	}
    	
    
    </script>
    
    <style>
    
    	#noteForm {
    	
    		position : absolute;
    		display:none;
    		background-color: cornsilk;
    		
    	}
    	
    	.reply-hide {
    		
    		display:none;
    	
    	}
    
    </style>
    
    
<body>
	<%@include file="../../main/topmain.jsp" %>
	
	<c:if test="${id != null}">
		<div id = "noteForm" style="z-index:1000;" >
			<div>
				<table class="text-muted ">
					<tr>
						<td colspan = "3" class = "text-right">
							<label id ="mainIdText"></label>
						</td>
					</tr>
					<tr>
						<td class = "text-right" width="50%">받는사람<br/></td>
						<td>${boardList.ID}</td>
					</tr>
					<tr>
						<td colspan = "2"><textarea rows="12" cols="22" id = "noteContent"></textarea></td>
					</tr>
					<tr>
						<td colspan = "2">
							<input type = "button" value = "send" class = "mini-btn" id = "sendBtn"/>
							<input type = "button" value = "close" class = "mini-btn" id = "closeBtn"/>
						</td>
					</tr>
				</table>
			</div> 
		</div>
	</c:if>
	<div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">글 읽기</span></h1>
            	</div>
           	</div>
           	<div class = "services-container">
				<div class="row">
					<table class="table table-striped table-bordered table-hover" id = "boardTable">
						<tr>
							<td width="100px"> <label>제목</label> </td>
							<td style = "text-align: left;"> <label>${boardList.TITLE}</label> </td>
						</tr>
						<tr>
							<td> <label>작성자</label> </td>
							<td style = "text-align: left;"> <label>${boardList.ID}&nbsp;&nbsp;</label> 
								<c:if test="${id != boardList.ID && id != null}">
									<i class="fa fa-envelope-o" id = "note">쪽지보내기</i>
								</c:if>
							</td>
						</tr>
						<tr>
							<td colspan = "2"> 
								<label>
									<textarea rows="15" 
											  cols="120" 
											  disabled="disabled" 
											  style ="background-color:aliceblue;">${boardList.CONTENT}</textarea>
								</label>
							</td>
						</tr>
					</table>
					<div class ="no-text-center panel-heading text-muted" align="center">
						<input type = "hidden" value = "${id}" name = "id"/>
			    		<input type = "button" value ="답글쓰기" class = "btn board-btn-xl" id = "replyBtn"/>
				    		<c:if test="${id == boardList.ID}">
				    			<input type = "button" value ="수정하기" class = "btn board-btn-xl" id = "modifyBtn"/>
				    		</c:if>
			    		<input type = "button" value ="목록보기" class = "btn board-btn-xl" id = "listBtn"/>
			    	</div>
				</div>
			</div>
			<div class = "services-container">
				<div class="row">
					<div style = "text-align: left;">
						<label style = "font-size:15px">댓글(${replyCount})</label>
					</div>
					<table class="table table-striped table-bordered table-hover">
						<tr>
							<td style = "text-align: left;">
								<input type = "checkbox" id = "secretReply" value = "비밀 댓글"/> &nbsp;비밀 글 설정 <br/>
								<textarea id = "content"
										  rows="3" 
										  cols="100" 
										  style ="background-color:cornsilk;"></textarea></td>
							<td>
								<input type = "button" value = "등록" class = "reply-btn" id = "replyInputBtn"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
			<div class = "services-container">
				<div class="row">
					<table class="table table-striped table-bordered table-hover">
					<c:forEach var = "reply" items = "${replyList}" varStatus="i">
						<tr>
							<td style = "text-align: left;"><label>${reply.ID}</label>&nbsp;&nbsp;&nbsp;${reply.CRE_DATE}<br/>
								<c:if test="${reply.SECRET == null}">
									<span class ="test_${i.count}">${reply.CONTENT}</span>
									<input type = "text" value = "${reply.CONTENT}" class = "reply-hide reply replySeqNo_${i.count}" replySeqNo = "${reply.BR_SEQ_NO}"/>
								</c:if>
								<c:if test="${reply.SECRET != null}">
									<c:choose>
										<c:when test="${id == boardList.ID || id == reply.ID}">
											<span class ="test_${i.count}" style = "color:blue;">${reply.CONTENT}</span>
											<input type = "text" value = "${reply.CONTENT}" class = "reply-hide reply replySeqNo_${i.count}" replySeqNo = "${reply.BR_SEQ_NO}"/>
										</c:when>
										<c:otherwise>
											<i class="fa fa-lock" style = "color: red;">
												비밀 댓글 입니다
											</i><br/>
										</c:otherwise>
									</c:choose>
								</c:if>
							</td>
							<td width = "15%">
								&nbsp;
								<c:if test="${id == reply.ID}">
									<input type = "button" value = "수정" class = "mini-btn modify_${i.count}" onclick = "modifyReply(this)" reply-seq-no = "${reply.BR_SEQ_NO}"/>
									<input type = "button" value = "저장" class = "mini-btn reply-hide save_${i.count}" onclick ="reallyModifyBtn(this)" reply-seq-no = "${reply.BR_SEQ_NO}"/>
									<input type = "button" value = "삭제" class = "mini-btn delete_${i.count}" onclick = "deleteReply(this)" reply-seq-no = "${reply.BR_SEQ_NO}"/>
									<input type = "button" value = "취소" class = "mini-btn reply-hide cancel_${i.count}" onclick = "cancelBtn(this)" reply-seq-no = "${reply.BR_SEQ_NO}"/>
								</c:if>
							</td>
						</tr>
					</c:forEach>
					</table>
				</div>
				${replyPagination}
			</div>
        </div>
   </div>
</body>
</html>