<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
 	<head>
        <%@include file="../sub/subfile.jsp" %>
    </head>
    
    <script>
    $(document).ready(function(){
    	// Paging
		$("#goStartPage").click(function(){
			var page = $("#goStartPage").attr("pagination");
			location.href = "myReservation.do?page=" + page;
		});
		
		$(".goPage").click(function(){
			var page = $(this).attr("pagination");
			location.href = "myReservation.do?page=" + page;
		});
		
		$("#goNextPage").click(function(){
			var page = $("#goNextPage").attr("pagination");
			location.href = "myReservation.do?page=" + page;
		});
		
		$("#showEach10").change(function(){
			var pageSize = $("#showEach10 > option:selected").val();
// 			alert(pageSize);
			location.href="./myReservation.do?pageSize="+pageSize;
		});
    });
    
    function pastReservation(_this) {
    	var pastReservation = $(_this).attr("reser-seq-no");
    	alert("지난 날짜는 예약을 취소할 수 없습니다."); 
    }
    
	function deleteReservation(_this) {
		var reservation = $(_this).attr("reser-seq-no");
		var input = confirm("정말 예약을 취소하시겠습니까?")
		if(input) {
			$.ajax({
				url : "./myReservation.do",
				type : "post",
				data : {"rvSeqNo" : reservation},
				success : function(data) {
					alert(data.msg);
					location.reload();
				}
			});
		}
	}
    	
    	
    	
    </script>

    <body>
        <!-- Top menu -->
        <%@include file="../main/topmain.jsp" %>
		<div class="presentation-container">
	       	<div class="container">
	       		<div class="row">
	        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
	            		<h1><span class="violet">내 예약현황</span></h1>
	            	</div>
	           	</div>
	           	<div class="col-sm-12 work-title wow fadeIn">
					<h2>전체 예약 수 (${totalCount})</h2>
	    		</div>
	       	</div>
		</div>
		
		<form>
		<div class = "services-container">
	       	<div class = "container">
			<div class="row">
			</div>
			<div class="row">
				<div class="no-text-center panel-heading">
					<form>
						<table class="table table-striped table-bordered table-hover text-muted no-text-center" style = "width:70%;">
							<tr>
								<th style="text-align: center;" colspan="2">예약자 I D</th>
								<td style="text-align: center;" colspan="4">
									<label>${id}</label>
								</td>
							</tr>
							<tr>
								<th style="text-align: center;">예약번호</th>
								<th style="text-align: center;">구장이름</th>
								<th style="text-align: center;">코트</th>
								<th style="text-align: center;">예약날짜</th>
								<th style="text-align: center;">예약시간</th>
								<th style="text-align: center;">예약취소</th>
							</tr>
							<c:if test="${totalCount != 0}">
								<c:forEach var="board" items="${reservation}" varStatus="i">
									<tr>
										<td style="text-align: center;">${board.RNUM}</td>
										<td style="text-align: center;">${board.STADIUM_NAME}</td>
										<td style="text-align: center;">${board.COURT}</td>
										<td style="text-align: center;">${board.YEAR}-${board.MONTH}-${board.DAY}</td>
										<td style="text-align: center;">${board.START_TIME} ~ ${board.END_TIME}</td>
										<c:choose>
											<c:when test="${board.IS_CANCEL == 'Y'}">
												<td style="text-align: center;"><input type="button" value="예약취소" class="btn" onclick = "deleteReservation(this)" reser-seq-no = "${board.RV_SEQ_NO}"></td>
											</c:when>
											<c:otherwise>
												<td style="text-align: center;"><input type="button" value="예약취소" class="btn" onclick = "pastReservation(this)" reser-seq-no = "${board.RV_SEQ_NO}"></td>
											</c:otherwise>
										</c:choose>
									</tr>
								</c:forEach>
							</c:if>								
						</table>
						<label>
							${paging}
						</label>
						<input type = "hidden" name = "id" value = "${id}" />
						<c:if test="${totalCount == 0}">
							<tr>
								<td>해당 게시물에 내용이 없습니다.</td>
							</tr>
						</c:if>
					</form>
				</div>
			</div>
		</div>
		</form>
	</body>
</html>