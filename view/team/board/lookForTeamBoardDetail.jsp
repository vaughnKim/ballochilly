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
    		cmtOfCmt();
    		
    	});
    	
    	function btnAction() {
    		
			$("#goStartPage").click(function(){
				
				var page = $("#goStartPage").attr("pagination");
				location.href = "./lookForTeamBoardDetail.do?bthSeqNo=" + '${param.bthSeqNo}' + "&replyPage=" + page;
				
			});
			
			$(".goPage").click(function(){
				
				var page = $(this).attr("pagination");
				location.href = "./lookForTeamBoardDetail.do?bthSeqNo=" + '${param.bthSeqNo}' + "&replyPage=" + page;
				
			});
			
			$("#goNextPage").click(function(){
				
				var page = $("#goNextPage").attr("pagination");
				location.href = "./lookForTeamBoardDetail.do?bthSeqNo=" + '${param.bthSeqNo}' + "&replyPage=" + page;
				
			});
    		
    		
    		$("#replyBtn").click(function(){
    			
    			location.href = "./lookForTeamBoardWrite.do?pId=${boardList.BTH_SEQ_NO}&lvl=${boardList.LVL}";
//     			history.back();
    			
    		});
    		
			$("#modifyBtn").click(function(){
				
				location.href = "./lookForTeamModify.do?bthSeqNo=${boardList.BTH_SEQ_NO}";
				
			});	// end click
			
			$("#deleteBtn").click(function(){
				
				var bthSeqNo = '${boardList.BTH_SEQ_NO}';
				
				$.ajax({
					
					url : "./deleteList.do",
					type : "post",
					data : {"bthSeqNo" : bthSeqNo},
					success : function(data) {
						alert(data.msg);
						if(data.code == 200) {
							location.href = "./lookForTeamBoard.do";
						}
						
					}
					
				});
				
			});
    		
    		$("#listBtn").click(function(){
    			
    			location.href = "./lookForTeamBoard.do";
    			
    		});
			
			$("#closeBtn").click(function(){
				
				$("#noteForm").hide();
				
			});
			
			$("#replyInputBtn").click(function(){
				
				var writerId = '${boardList.ID}';
	    		var writerContent = $("textarea").val();
	    		var writerTitle = '${boardList.TITLE}';
	    		
				var id = '${id}';
				var bthSeqNo = '${param.bthSeqNo}';
				var content = $("#content").val(); 
				var secretReply = "";
				
				$("input:checkbox:checked").each(function(idx, data) {  
					secretReply = $(this).val();
			    });  
				
				if(content != "") {
					
					if(writerId != "" || writerContent != "" || writerTitle != "") {
						
						$.ajax({
							
							url : "./replyInsert.do",
							type : "post",
							data : {"id" : id, "bthSeqNo" : bthSeqNo, "content" : content, "secretReply" : secretReply},
							success : function(data) {
								
								alert(data.msg);
								location.reload();
								
							}
							
						});
					
					} else {
						alert("잘못된 접근입니다.");
						history.back();
					}
					
				} else {
					
					alert("내용을 입력해주세요");
					$("#content").focus();
					
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
					$("#noteContent").focus();
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
    			
    			url : "./deleteReply.do",
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
		    			
		    			url : "./modiftyReply.do",
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
    	
    	function cmtOfCmt() {
    		
    		var pId = "";
    		var lvl = "";
    		var id = '${id}';
    		var bthSeqNo = "";
    		
    		$(".rSeqNo").click(function(){
    			
    			pId = $(this).attr("rSeqNo");
    			rlvl = $(this).attr("rLvl");
				var bthSeqNo = '${param.bthSeqNo}';
    			
    			$(".rSeqNo_" + pId).show();
	    		
	    		$(".rSeqNoBtn_" + pId).click(function(){
	    			
		    		var content = $("input[name=cmtOfCmtContent_" + pId + "]").val();
		    		
	    			var test = rlvl.split("_");
	    			lvl = test[1] *= 1;
	    			lvl += 1;
					
	    			if(content != "") {
	    				
		    			$.ajax({
		    				
		    				url : "./cmtOfCmt.do",
		    				type : "post",
		    				data : {"id" : id, "pId" : pId, "lvl" : lvl, "content" : content, "bthSeqNo" : bthSeqNo},
		    				success : function(data) {
		    					alert(data.msg);
		    					location.reload();
		    				}
		    				
		    			});
		    			
	    			} else {
	    				alert("내용을 입력하세요.");
	    				$("input[name=cmtOfCmtContent_" + pId + "]").focus();
	    			}
	    			
	    			
	    		});
	    		
	    		$(".rSeqNoCancelBtn_" + pId).click(function(){
	    			
	    			location.reload();
	    			
	    		});
    			
    		});
    		
    	}
    	
    	
    
    </script>
    
    <style>
    
    	#noteForm {
    	
    		position : absolute;
    		display:none;
    		background-color: powderblue;
   		    border: 2px solid;
    		
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
						<td class = "text-right" width="50%"><label>받는사람</label><br/></td>
						<td><label>${boardList.ID}</label></td>
					</tr>
					<tr>
						<td colspan = "2">
							<textarea rows="12" 
									  cols="22" 
									  id = "noteContent"
									  style ="background-color: mintcream;"></textarea>
						</td>
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
				<div class="row no-text-center">
					<table class="table table-striped table-bordered table-hover" id = "boardTable" style = "width:50%">
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
<%-- 											  style ="background-color:aliceblue;">${fn:replace(boardList.CONTENT, '<br>', '&#13;&#10;')}</textarea> --%>
								</label>
							</td>
						</tr>
					</table>
					<div class ="no-text-center panel-heading text-muted" align="center">
						<input type = "hidden" value = "${id}" name = "id"/>
			    		<input type = "button" value ="답글쓰기" class = "btn board-btn-xl" id = "replyBtn"/>
			    		<c:if test="${id == boardList.ID}">
			    			<input type = "button" value ="수정하기" class = "btn board-btn-xl" id = "modifyBtn"/>
		    				<input type = "button" value ="삭제하기" class = "btn board-btn-xl" id = "deleteBtn"/>
			    		</c:if>
			    		<input type = "button" value ="목록보기" class = "btn board-btn-xl" id = "listBtn"/>
			    	</div>
				</div>
			</div>
			<div class = "services-container">
				<div class="row no-text-center">
					<table class="table table-striped table-bordered table-hover" style="width:70%">
						<tr>
							<td colspan = "2"><label style = "font-size:15px">댓글(${replyCount})</label></td>
						</tr>
						<c:if test="${id != null}">
							<tr>
								<td style = "text-align: left;">
									<input type = "checkbox" id = "secretReply" value = "비밀 댓글"/> &nbsp;비밀 글 설정 <br/>
									<textarea id = "content"
											  rows="3" 
											  cols="113" 
											  style ="background-color:cornsilk;"></textarea></td>
								<td style="width:10%">
									<input type = "button" value = "등록" class = "reply-btn" id = "replyInputBtn" />
								</td>
							</tr>
						</c:if>
						<c:forEach var = "reply" items = "${replyList}" varStatus="i">
							<tr rSeqNo = "${reply.BR_SEQ_NO}"  bth-seq-no = "${reply.BTH_SEQ_NO}">
								<td style = "text-align: left;">
									<c:if test="${reply.SECRET == null}">
									
									<c:forEach begin="1" end ="${reply.LVL}">
										&nbsp;
									</c:forEach>
										<c:if test ='${reply.LVL > 0}' >		
								 			<img src = "../image/boardsub/image.png">
											<img src="StadiumImage/reply_icon.gif" width="30px" height="15px" />
								 		</c:if>
										<label>${reply.ID} : </label>&nbsp;&nbsp;&nbsp;
										<span class ="test_${i.count}">${reply.CONTENT}</span>&nbsp;&nbsp;&nbsp; 
										${reply.CRE_DATE} &nbsp;&nbsp;&nbsp;
										<c:if test="${id != null}">
											<label class = "rSeqNo" rSeqNo = "${reply.BR_SEQ_NO}" rLvl = "rLvl_${reply.LVL}" style = "font-size:12px;color:blue;cursor: pointer;">
												댓글
											</label><br/>
										</c:if>
										
										<input type = "text" 
											   value = "${reply.CONTENT}" 
											   class = "reply-hide reply replySeqNo_${i.count}" 
											   replySeqNo = "${reply.BR_SEQ_NO}"/>
										<input type = "text"
										 	   size = "100"
											   name = "cmtOfCmtContent_${reply.BR_SEQ_NO}"
											   class = "rSeqNo_${reply.BR_SEQ_NO} reply-hide"/>
										<input type = "button"
											   value = "저장"
											   class = "mini-btn rSeqNo_${reply.BR_SEQ_NO} rSeqNoBtn_${reply.BR_SEQ_NO} reply-hide"/>
										<input type = "button"
											   value = "취소"
											   style = "background-color:pink;" 
											   class = "mini-btn rSeqNo_${reply.BR_SEQ_NO} rSeqNoCancelBtn_${reply.BR_SEQ_NO} reply-hide"/>
									</c:if>
									<c:if test="${reply.SECRET != null}">
										<c:choose>
											<c:when test="${id == boardList.ID || id == reply.ID}">
												<label>${reply.ID} : </label>&nbsp;&nbsp;&nbsp;
												<span class ="test_${i.count}" style = "color:blue;">${reply.CONTENT}</span>&nbsp;&nbsp;&nbsp;
												${reply.CRE_DATE}&nbsp;&nbsp;&nbsp; 
												<c:if test="${id != null}">
													<label class = "rSeqNo" rSeqNo = "${reply.BR_SEQ_NO}" rLvl = "rLvl_${reply.LVL}" style = "font-size:12px;color:blue;cursor: pointer;">
														댓글
													</label><br/>
												</c:if>
												<input type = "text" 
													   value = "${reply.CONTENT}" 
													   class = "reply-hide reply replySeqNo_${i.count}" 
													   replySeqNo = "${reply.BR_SEQ_NO}"/>
												<input type = "text"
													   name = "cmtOfCmtContent_${reply.BR_SEQ_NO}"
													   size = "100"
													   class = "rSeqNo_${reply.BR_SEQ_NO} reply-hide"/>
												<input type = "button"
													   value = "저장"
													   class = "mini-btn rSeqNo_${reply.BR_SEQ_NO} rSeqNoBtn_${reply.BR_SEQ_NO} reply-hide"/>
											    <input type = "button"
													   value = "취소"
													   style = "background-color:pink;" 
													   class = "mini-btn rSeqNo_${reply.BR_SEQ_NO} rSeqNoCancelBtn_${reply.BR_SEQ_NO} reply-hide"/>
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
										<input type = "button" value = "수정" class = "mini-btn modify_${i.count}" 
											   onclick = "modifyReply(this)" 
											   style = "float:left;" 
											   reply-seq-no = "${reply.BR_SEQ_NO}"/>
										<input type = "button" value = "저장" class = "mini-btn reply-hide save_${i.count}" 
											   onclick ="reallyModifyBtn(this)" 
											   style = "float:left;" 
											   reply-seq-no = "${reply.BR_SEQ_NO}"/>
										<input type = "button" value = "삭제" class = "mini-btn delete_${i.count}" 
										       onclick = "deleteReply(this)" 
										       style = "float:left;background-color:pink;" 
										       reply-seq-no = "${reply.BR_SEQ_NO}"/>
										<input type = "button" value = "취소" class = "mini-btn reply-hide cancel_${i.count}" 
											   onclick = "cancelBtn(this)" 
										       style = "float:left;background-color:pink;" 
											   reply-seq-no = "${reply.BR_SEQ_NO}"/>
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