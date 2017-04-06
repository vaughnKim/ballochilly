<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="kr">

    <head>
        <%@include file="../sub/subfile.jsp" %>
    </head>
    
<title>경기장 이용후기 게시판 게시물</title>

<script>
	$(document).ready(function() {
		
// 		alert('${master}');
// 		alert('${master.MASTER_ID}');
		
		// 전체 우클릭 금지시키기
		$(document).bind("contextmenu", function(){
			return false;
		});	//end bind
		
		replyBoard();
		editBoard();
		deleteBoard();
		addcomment();
		addCmtOfCmt();
		editcomment();
		deletecomment();
		paging()
	});
	
	// empty Boardinfos on typing space 
	function emptyEditBoard() {
		if($("#edit_board_title").val() == ""){
			alert("제목 검색해 주세요");
			$("#edit_board_title").focus(); 
			return false;
		} else if($("#edit_board_content").val() == "") {
			alert("내용을 입력해 주세요");
			$("#edit_board_content").focus(); 
			return false;
		} 
	}
	
	// empty Commentinfos on typing space 
	function emptyComment() {
		if($("#add_new_comment").val() == ""){
			alert("새 댓글을 입력해 주세요");
			$("#add_new_comment").focus(); 
			return false;
		} 
	}
	
// 		reply board
		function replyBoard() {
			$("#reply_board_Btn").click(function() {
				location.href = "./addBoard.do?pId=${boardlist.BSR_SEQ_NO}&lvl=${boardlist.LVL}";
			});
		}
		
// 		edit board
		function editBoard() {
			$("#edit_board_Btn").click(function() {
				$("#title, #hit, #file, #show_file, #show_comment_upper, #show_comment_lower, #reply_Btn, #edit_board_Btn, #delete_board_Btn, #countComment, #show_paging").hide();
				
				$(".show_comment_upper").hide();
				$(".show_comment_lower").hide();
				$(".add_new_comment").hide();
				$(".show_paging").hide();
				
				$("#edit_board_title, #edit_board_file_area, #complete_edit_board_Btn, #cancel_edit_board_Btn").show();
				$(".edit_board_content_area").show();
			});
			$("#complete_edit_board_Btn").click(function(){
				emptyEditBoard();
				$("form").ajaxSubmit({
					url : "./editBoard.do",
					type : "post",
					success : function(result){
						alert(result.msg)
						location.href="./viewBoard.do?bsrSeqNo=${boardlist.BSR_SEQ_NO}";
					}
				});
				return false;
			});
		}
		
// 		delete board
		function deleteBoard() {
			$("#delete_board_Btn").click(function() {
				var alarm = confirm("삭제 하시겠습니까?");
				if(alarm) {
					var bsrSeqNo = $("input[name=bsrSeqNo]").val();
					$.ajax({
						url : "./deleteBoard.do",
						type : "post",
						data : {"bsrSeqNo" : bsrSeqNo},
						success : function(result){
							alert(result.msg);
							location.assign("./listBoard.do");
						}
					});
				}
			});	
		}	
		
// 		add comment
		function addcomment() {
			$("#add_new_comment_Btn").click(function(){
				emptyComment();
				var id = $("#nick").val();
				var bsrSeqNo = $("input[name=bsrSeqNo]").val();
				var new_comment = $("#add_new_comment").val();
				var pId = '';
				var lvl = '';
// 				alert(lvl);
				$.ajax({
					url : "./addCommentBoard.do",
					type : "post",
					data : {
					 "id" : id, "bsrSeqNo" : bsrSeqNo, "content" : new_comment, "pId" : pId, "lvl" : lvl
					},
					success : function(result){
						alert(result.msg)
// 						location.assign("./viewBoard.do?bsrSeqNo=${boardlist.BSR_SEQ_NO}");
						location.reload();
					}
				});
			});
		}
		
// 		add comment of comment		
		function addCmtOfCmt() {
			$(".CmtOfCmt_Btn").click(function(){
				var idx = $(this).attr("idx");

				$(".show_add_CmtOfCmt_area[idx=" + idx + "]").show();
				$(".cancel_CmtOfCmt_Btn[idx=" + idx + "]").show();
				
				$(".CmtOfCmt_Btn[idx="+idx+"]").hide();
				$(".edit_comment_Btn[idx=" + idx + "]").hide();
				$(".delete_comment_Btn[idx=" + idx + "]").hide();
			});	
				
			$(".cancel_CmtOfCmt_Btn").click(function(){
				var idx = $(this).attr("idx");
				location.reload();
			});	

			$(".add_cmtOfcmt_Btn").click(function(){
				var idx = $(this).attr("idx");
				
				if($(".add_CmtOfCmt[idx="+idx+"]").val() == ""){
					alert("댓글을 입력해 주세요");
					$(".add_CmtOfCmt[idx="+idx+"]").focus();
					return false;
				}
				
				var id = $("#nick").val();
				var bsrSeqNo = $("input[name=bsrSeqNo]").val();
				var content = $(".add_CmtOfCmt[idx=" + idx + "]").val();
				var pId = $("input[name=pId]").eq(idx - 1).val();
				var lvl = $("input[name=lvl]").eq(idx - 1).val();
				
// 				console.log("id : " + id);
// 				console.log("bsrSeqNo : " + bsrSeqNo);
// 				console.log("pId : " + pId);
// 				console.log("content : " + content);
// 				console.log("lvl : " + lvl);
				$.ajax({
					url : "./addCommentBoard.do",
					type : "post",
					data : {"id" : id, "bsrSeqNo" : bsrSeqNo, "content" : content, "pId" : pId, "lvl" : lvl},
					success : function(result){
						alert(result.msg)
						location.assign("./viewBoard.do?bsrSeqNo=${boardlist.BSR_SEQ_NO}");
					}
				});
			});
		}
		
		
// 		edit comment
		function editcomment() {
			$("input[name=edit_comment_Btn]").click(function(){
				var idx = $(this).attr("idx");
				$(".for_edit_comment[idx=" + idx + "]").hide();
				$(".edit_comment_Btn[idx=" + idx + "]").hide();
				$(".delete_comment_Btn[idx=" + idx + "]").hide();
				$(".CmtOfCmt_Btn[idx="+idx+"]").hide();
	
				$(".edit_comment_area[idx=" + idx + "]").show();
				$(".complete_comment_Btn[idx=" + idx + "]").show();
				$(".cancel_comment_Btn[idx=" + idx + "]").show();
			});
			
			$("input[name=complete_comment_Btn]").click(function(){
				var idx = $(this).attr("idx");
				if($(".edit_comment[idx=" + idx + "]").val() == ""){
					alert("수정할 댓글을 입력해 주세요");
					$(".edit_comment").focus(); 
					return false;
				} 
				var brSeqNo = $(".brseqno[idx="+ idx+"]").val();
				var comment = $(".edit_comment[idx=" + idx + "]").val();
				$.ajax({
					url : "./editComment.do",
					type : "post",
					data : {
							"brSeqNo" : brSeqNo,
							"content" : comment
							},
					success : function(result){
						alert(result.msg);
						location.assign("./viewBoard.do?bsrSeqNo=${boardlist.BSR_SEQ_NO}");
					}
				});
				return false;
			});		
		}
		
// 		delete comment
		function deletecomment() {
			$("input[name=delete_comment_Btn]").click(function(){
				var alarm = confirm("삭제 하시겠습니까?");
				if(alarm) {
					var idx = $(this).attr("idx");
					var brSeqNo = $(".brseqno[idx="+ idx+"]").val();
					$.ajax({
						url : "./deleteComment.do",
						type : "post",
						data : { "brSeqNo" : brSeqNo},
						success : function(result) {
							alert(result.msg);
							location.href="./viewBoard.do?bsrSeqNo=${boardlist.BSR_SEQ_NO}";
						}
					});
					return false;
				}
			});
		}
		
		// Paging
		function paging() {
			$("#goStartPage").click(function(){
				var page = $("#goStartPage").attr("pagination");
				var bsrSeqNo = "${boardlist.BSR_SEQ_NO}";
				location.href = "viewBoard.do?page=" +page+"&bsrSeqNo="+bsrSeqNo;
			});
			
			$(".goPage").click(function(){
				var page = $(this).attr("pagination");
				var bsrSeqNo = "${boardlist.BSR_SEQ_NO}";
				location.href = "viewBoard.do?page=" +page+"&bsrSeqNo="+bsrSeqNo;
			});
			
			$("#goNextPage").click(function(){
				var page = $("#goNextPage").attr("pagination");
				var bsrSeqNo = "${boardlist.BSR_SEQ_NO}";
				location.href = "viewBoard.do?page=" +page+"&bsrSeqNo="+bsrSeqNo;
			});
		}
		
</script>

<style>

.hidething {
	display:none;
}
</style>

<body>
	<%@include file="../main/topmain.jsp" %>
	
	<div class="presentation-container">
      	<div class="container">
      		<div class="row">
	       		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig; font-style:Verdana">
	           		<h1>게시글 보기</h1>
	           	</div>
          	</div>
        </div>
    </div>
    <div class="row">
		<div class="no-text-center panel-heading">
			<form method="post" action="editBoard.do" enctype="multipart/form-data">
				<table class="table table-striped table-bordered table-hover text-muted no-text-center" style="width:70%;">
					<tr>
						<td align="left">제목</td>
						<td>&nbsp;&nbsp;
							<strong id="title">${boardlist.TITLE}</strong>
		<!-- 	edit part -->
							<input type="text" name="title" id="edit_board_title" style="display:none;" value="${boardlist.TITLE}" maxlength="85"/> 
						</td>
						<td id="hit">조회수  ${boardlist.HIT}</td>
					</tr>
					<tr>
						<td align="left">아이디</td>
						<td colspan="2">&nbsp;&nbsp;
							<strong>${boardlist.ID}</strong>
						</td>
					</tr>
		<!-- 	edit part -->					
					<tr id="edit_board_file_area" style="display:none;">
						<td align="left">파일</td>
						<td>&nbsp;&nbsp;
							<input type="file" name="bsrAtchFname" multiple/>${Images[0].BSR_ATCH_FNAME}
						</td>
					</tr>
					<tr>
						<td align="left">날짜</td>
						<td colspan="2">&nbsp;&nbsp;
							<c:set var="date" value="${boardlist.CRE_DATE}"/>
							<strong>${fn:substring(date,0, 16)}</strong>
						</td>
					</tr>
				</table>
				<table class="table table-striped table-bordered table-hover text-muted no-text-center" style="width:70%;">	
					<tr>
			            <td id="show_file" width="399" colspan="2" height="200" align="left" >
			            	<c:if test="${Images[0].BSR_ATCH_FNAME != null}">
			            		<c:forEach var="images" items="${Images}">
			            			<br/>
			            			<img src="StadiumImage/${images.BSR_ATCH_FNAME}" />
				            		<br/>
			            		</c:forEach>
			            	</c:if>
		            		<strong>
		            			<br/>${boardlist.CONTENT}<br/> 
		            		</strong>
		            		<br/>
		            		<br/>
			            </td>
<!--    edit part -->	            
			            <td width="399" colspan="2" height="200" class="edit_board_content_area hidething" >
			            	<c:if test="${Images[0].BSR_ATCH_FNAME != null}">
			            		<c:forEach var="images" items="${Images}">
			            			<br/>
			            			<img src="StadiumImage/${images.BSR_ATCH_FNAME}" />
				            		<br/>
			            		</c:forEach>
			            	</c:if>
			            	<br/><textarea name="content" cols="50" rows="13" id="edit_board_content" maxlength="1000">${boardlist.CONTENT}</textarea><br/>
			            </td>
					</tr>
		            <tr id="countComment">
		           		<td> 
		           			<strong>덧글</strong>
		           			<c:choose> 
			           			<c:when test='${CountComment == 0}'> ${CountComment} </c:when>
			           			<c:otherwise> <strong>${CountComment}</strong> <img src="StadiumImage/new.jpg" /> </c:otherwise>
		           			</c:choose>
		           		</td>
		           	</tr>
				</table>
				
<!-- 	show recent comments		 -->
				<table class="table table-striped table-bordered table-hover text-muted no-text-center" style="width:70%;background-color:ffffff;">
				<c:forEach var="comment" items="${CommentAll}" varStatus="status">
					<tr class="show_comment_upper">
						<td style="position:relative;">
							&nbsp;&nbsp;
						  <c:forEach begin="1" end="${comment.LVL}"> 
						    &nbsp;&nbsp;
						  </c:forEach>
						  <c:if test='${comment.LVL > 0}'>
					  	  	<img src="StadiumImage/reply_icon.gif" width="30px" height="15px" />
					  	  	&nbsp;
					  	  </c:if>	
							
							<strong>${comment.ID}</strong>
							&nbsp;&nbsp;
							
							<c:set var="date" value="${comment.CRE_DATE}"/>
							${fn:substring(date,0, 16)}
						 
						  <c:if test="${user.ID != null || master != null}">
							&nbsp;&nbsp;
							<label class="CmtOfCmt_Btn" idx="${status.count}" style="color:black; font-weight:bold; font-size:11px;" />
								댓글
							</label>
							<label class="cancel_CmtOfCmt_Btn hidething" idx="${status.count}" style="color:red; font-weight:bold; font-size:11px;"/>
								댓글 취소
							</label>
						  </c:if>
						  	
						  <c:if test="${comment.ID == user.ID}">					
							<span style="position:absolute; right:60px;"><input type="button" value="수정" name="edit_comment_Btn" id="S_Btn" class="edit_comment_Btn" idx="${status.count}" /></span>
							<span style="position:absolute; right:10px;"><input type="button" value="삭제" name="delete_comment_Btn" id="S_Btn" class="delete_comment_Btn" idx="${status.count}"/></span>
							<span style="position:absolute; right:80px;"><input type="button" value="수정완료" name="complete_comment_Btn" id="S_Btn" class="complete_comment_Btn hidething" idx="${status.count}" /></span>
							<span style="position:absolute; right:10px;"><input type="button" value="수정취소" id="S_Btn" class="cancel_comment_Btn hidething" idx="${status.count}" onclick="location.reload()" /></span>
							<input type="hidden" class="brseqno" idx="${status.count}" value="${comment.BR_SEQ_NO}" />
						  </c:if>
						    <br/>
							<c:forEach begin="1" end="${comment.LVL}"> 
							&nbsp;&nbsp;
							</c:forEach>
							<c:if test='${comment.LVL > 0}'>
								&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;
							</c:if> 
							&nbsp;&nbsp;
							<label class="show_comment_lower for_edit_comment" idx="${status.count}">
							${comment.CONTENT}
							</label>
	
	<!-- 	edit comments		 -->						
							<label class="edit_comment_area hidething" idx="${status.count}">
								<textarea name="content" class="edit_comment" idx="${status.count}" cols="120" rows="6" >${comment.CONTENT}</textarea>
							</label>
						  
						</td>
					</tr>
					
					
<!-- 	add comment of chosen comment	 -->
					<tr class="show_add_CmtOfCmt_area hidething" idx="${status.count}" >
						<td colspan="2">
							&nbsp;&nbsp; 
							<img src="../image/boardsub/image.png"/>
							<img src="StadiumImage/reply_icon.gif" width="30px" height="15px" />
							<textarea name="recomment" class="add_CmtOfCmt" idx="${status.count}" cols="113" rows="6" maxlength="85"></textarea>
							<input type="button" value="댓글" name="complete_recmt" class="s_round-btn add_cmtOfcmt_Btn" idx="${status.count}" />
							<input type="hidden" name="pId" value="${comment.BR_SEQ_NO}" idx="${status.count}"/>
							<input type="hidden" name="lvl" value="${comment.P_ID != null && comment.P_ID != '' ? comment.LVL + 1 : 1}" idx="${status.count}"/>
						</td>
					</tr>
				</c:forEach>

<!--  add comment part -->
				<c:if test="${user.ID != null || master.MASTER_ID != null}">	
					<tr class="add_new_comment">
						<td align="center">
							<c:if test="${master.MASTER_ID != null}">
								<input type="hidden" id ="nick" value="${master.MASTER_ID}" readonly /> <br/>
							</c:if>
							<input type="hidden" name="id" id="nick" value="${user.ID}" readonly /> <br/>
							<textarea name="reply" id="add_new_comment" cols="110" rows="6" maxlength="85" style="backgroundcolor:white;"></textarea>
							<input type="button" value="댓글" id="add_new_comment_Btn" class="round-btn"/>
						</td>
					</tr>
				</c:if>
				
			</table>
			
			<div class="show_paging"> 
				<c:if test="${CountComment > 10}">
				<span align="center">${paging}</span>
				</c:if>
			</div>
		
			
<!-- 	all buttons  -->
			<div class ="no-text-center panel-heading text-muted" align="center">		
			<c:if test="${user.ID != null}">	
				<input type="button" value="글쓰기" id="write_board_Btn" class="L_Btn" onclick="javascript:location.href='./addBoard.do'"/>
				<input type="button" value="답글" id="reply_board_Btn" class="L_Btn"/>
				
			</c:if>
			<c:if test="${user.ID != null && boardlist.ID == user.ID}">	
				<input type="button" value="수정" id="edit_board_Btn" class="L_Btn"/>
				<input type="button" value="삭제" id="delete_board_Btn" class="L_Btn"/>
			</c:if>
				<input type="submit" value="수정완료" id="complete_edit_board_Btn" class="L_Btn hidething"  />
				<input type="button" value="수정취소" id="cancel_edit_board_Btn" class="L_Btn hidething" onclick="javascript:location.href='./viewBoard.do?bsrSeqNo=${boardlist.BSR_SEQ_NO}'"/>
				<input type="button" value="목록" onclick="javascript:location.href='./listBoard.do'" class="L_Btn"/>
				<input type="hidden" value="${boardlist.BSR_SEQ_NO}" name="bsrSeqNo" />
			</div>							
			</form>
		</div>
	</div>	
</body>
</html>






