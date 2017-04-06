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
    		detail();
    		pageSize();
    		
    	});
    	
    	function btnAction() {
    		
			$("#goStartPage").click(function(){
				
				var page = $("#goStartPage").attr("pagination");
				location.href = "lookForPlayerBoard.do?page=" + page;
				
			});
			
			$(".goPage").click(function(){
				
				var page = $(this).attr("pagination");
				location.href = "lookForPlayerBoard.do?page=" + page;
				
			});
			
			$("#goNextPage").click(function(){
				
				var page = $("#goNextPage").attr("pagination");
				location.href = "lookForPlayerBoard.do?page=" + page;
				
			});
    		
    		$("#writeBtn").click(function(){
    			
    			location.href = "./lookForPlayerBoardWrite.do";
    			
    		});
    		
    	}
    	
    	function detail(){
    		
			$(".bphSeqNo").click(function(){
				
				var bphSeqNo = $(this).attr("bph-seq-no");
				var bphHit = $(this).attr("bph-hit");
				location.href = "./lookForPlayerBoardDetail.do?bphSeqNo=" + bphSeqNo;
				
				bphHit *= 1;
				bphHit += 1;
				
				$.ajax({
					
					url : "./updateHit2.do",
					type : "post",
					data : {"bphSeqNo" : bphSeqNo, "bphHit" : bphHit},
					success : function(data) {
						
					}
					
				});
				
				
			});	//end click
			
		}	//end detail
		
		function pageSize() {
			
			$("#selectViewNum").change(function(){
				
				var pageSize = $("#selectViewNum > option:selected").val();
				location.href = "./lookForPlayerBoard.do?pageSize=" + pageSize;
				
				
			});
			
		}
    
    </script>
    
<body>
	<%@include file="../main/topmain.jsp" %>
	
	<div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">선수구하기</span></h1>
            	</div>
           	</div>
			<div class="col-sm-12 work-title wow fadeIn">
				<h2>전체 글 (${count})</h2>
	    	</div> 
        </div>
   </div>
			
		<div class = "container">
           	<div class="row" style="float:right">
           		<select id = "selectViewNum">
           			<option>선택하세요</option>
           			<option value ="10">10개보기</option>
           			<option value ="20">20개보기</option>
           			<option value ="30">30개보기</option>
           		</select>
           		<input type = "button" value = "글쓰기" class = "btn" id = "writeBtn"/><br/>
           	</div>
        </div>
        <div class = "container">
	        <div class="row" >
	           	<table class="table table-striped table-bordered table-hover text-muted" id = "list">
	           		<tr>
	           			<th class = "text-center" width = "15%">글번호</th>
	           			<th class = "text-center" width = "40%">제목</th>
	           			<th class = "text-center" width = "15%">글쓴이</th>
	           			<th class = "text-center" width = "15%">작성일자</th>
	           			<th class = "text-center" width = "15%">조회수</th>
	           		</tr>
					<c:if test="${count != 0}">
		           		<c:forEach var = "list" items = "${boardList}">
							<tr bph-seq-no = "${list.BPH_SEQ_NO}" bph-hit = "${list.HIT}" class = "bphSeqNo">
								<td style="cursor:pointer">
									${list.BPH_SEQ_NO}
								</td>
								<td style="cursor:pointer;  text-align: left;">
									<c:forEach begin="1" end ="${list.LVL}">
										&nbsp;
									</c:forEach>
										<c:if test ='${list.LVL > 0}' >		
								 			<img src = "../image/boardsub/image.png">
											<img src="StadiumImage/reply_icon.gif" width="30px" height="15px" />
								 		</c:if>
						 			<img src = "../image/boardsub/image.png">
									${list.TITLE}
									<c:if test="${list.COUNT != 0}">
										<label style = "color:coral;">[${list.COUNT}]</label>
									</c:if>
								</td>
								<td class = "text-center" style="cursor:pointer">
									${list.ID}
								</td>
								<td class = "text-center" style="cursor:pointer">
									${list.CRE_DATE}
								</td>
								<td class = "text-center" style="cursor:pointer">
									${list.HIT}
								</td>
							</tr>
						</c:forEach>
		           	</c:if>
		           	</table>
		           	<label>
						${pagination}
		           	</label>
	           	</div>
           	</div>
           	<c:if test="${count == 0}">
           		<tr>
           			<td>해당 게시물에 내용이 없습니다.</td>
           		</tr>
           	</c:if>
</body>
</html>