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
	$(document).ready(function(){
		
		// 전체 우클릭 금지시키기
		$(document).bind("contextmenu", function(){
			return false;
		});	//end bind
		
		$("#find").change(function(){
			var type = $(this).val();
			if(type == "4") {  // 작성일자 선택
				$("input[name=searchText]:eq(0)").attr("disabled", true);
				$("input[name=searchText]:eq(0)").hide();
				
				$("input[name=searchText]:eq(1)").attr("disabled", false);
				$("input[name=searchText]:eq(1)").show();
			} else {
				$("input[name=searchText]:eq(0)").attr("disabled", false);
				$("input[name=searchText]:eq(0)").show();
				
				$("input[name=searchText]:eq(1)").attr("disabled", true);
				$("input[name=searchText]:eq(1)").hide();
			}
		});
		
		$("#searchBtn").click(function(){
			var searchType = $("option:selected").val();
			var searchText = $("input[name=searchText]:not(:disabled)").val();
			if(searchType == '4') {
				searchText1 = searchText.split("-").join("/").substring(2,10);
				location.assign("./listBoard.do?searchType=" +searchType+
													 "&searchText=" +searchText1);
			} else {
				location.assign("./listBoard.do?searchType=" +searchType+
													 "&searchText=" +searchText);
			}
		});
		
		$(".bsrSeqNo").click(function(){
			var bsrSeqNo = $(this).attr("bsr-SeqNo");
			location.href="./viewBoard.do?bsrSeqNo="+bsrSeqNo;
		});
	
		$("#add").click(function(){
			location.assign("./addBoard.do");
		});
		
		// Paging
		$("#goStartPage").click(function(){
			var page = $("#goStartPage").attr("pagination");
			location.href = "listBoard.do?page=" + page;
		});
		
		$(".goPage").click(function(){
			var page = $(this).attr("pagination");
			location.href = "listBoard.do?page=" + page;
		});
		
		$("#goNextPage").click(function(){
			var page = $("#goNextPage").attr("pagination");
			location.href = "listBoard.do?page=" + page;
		});
		
		$("#showEach10").change(function(){
			var pageSize = $("#showEach10 > option:selected").val();
			location.href="./listBoard.do?pageSize="+pageSize;
		});
		
	});
</script>

<body>
	<%@include file="../main/topmain.jsp" %>
	
	<div class="presentation-container">
      	<div class="container">
      		<div class="row">
	       		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
	           		<h1><span class="violet">이용후기</span></h1>
	           	</div>
          	</div>
          	<div class="col-sm-12 work-title wow fadeIn">
				<h2>전체 글 (${totalCount})</h2>
	    	</div>
        </div>
    </div>
    <br/>
    
	<div class = "container">
		<div class="row" style="float:right">
			<select name="searchType" id="find">
				<option value="1">제목</option>
				<option value="2">아이디</option>
				<option value="3">내용</option>
				<option value="4">날짜</option>
			</select>
			<input type="search" name="searchText" placeholder="검색어" maxlength="85"/>
			<input type="date" name="searchText" disabled style="display:none;"/>
			<input type="button" value="검색" id="searchBtn" class="M_Btn"/>
			<select id = "showEach10">
           			<option>선택하세요</option>
           			<option value ="10">10개보기</option>
           			<option value ="20">20개보기</option>
           			<option value ="30">30개보기</option>
           	</select>
           	<c:if test="${master == null}">
				<input type="button" id="add" value="글쓰기" class="L_Btn"/>
			</c:if>
		</div>
	</div>
	<br/>
	<div class = "container">
        <div class="row" >
			<table class="table table-striped table-bordered table-hover text-muted">
				<tr style="font-size:13px;">
					<th class="text-center" width="10%">글번호</th>
					<th class="text-center" width="58%">제목</th>
					<th class="text-center" width="10%">글쓴이</th>
					<th class="text-center" width="15%">작성일자</th>
					<th class="text-center" width="7%">조회수</th>
				</tr>
				<c:if test="${totalCount != 0}">
					<c:forEach var="board" items="${BoardList}" >
						<tr bsr-SeqNo="${board.BSR_SEQ_NO}" align="center" class="bsrSeqNo">
							<td style="cursor:pointer;"> ${board.BSR_SEQ_NO} </td>
							<td align="left">
								<c:forEach begin="1" end="${board.LVL}">
								&nbsp;&nbsp;
								</c:forEach>
								<c:if test='${board.LVL > 0}'>
									<img src="../image/boardsub/image.png">
									<img src="StadiumImage/reply_icon.gif" width="30px" height="15px" />
								</c:if>
								<img src="../image/boardsub/image.png">
								${board.TITLE}
									<c:if test='${board.NOW_DATE == "Y"}'>
										<img src="StadiumImage/new.jpg"/>
									</c:if>
									<c:if test='${board.CNT > 0}'>
										<label style = "color:coral;">[${board.CNT}]</label>
									</c:if>
							</td>
							<td class="text-center" style="cursor:pointer;">${board.ID}</td>
							<td class="text-center" style="cursor:pointer;">
								<c:set var="date" value="${board.CRE_DATE}"/>
									${fn:substring(date, 0, 10)}
							</td>
							<td class="text-center" style="cursor:pointer;">${board.HIT}</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
			<label>
				${paging}
			</label>
		</div>
	</div>
	<c:if test="${totalCount == 0}">
		<div>
			해당 게시물에 내용이 없습니다.
		</div>
	</c:if>
	
</body>
</html>