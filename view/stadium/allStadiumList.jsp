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
		daeduckgu();
		yusungu();
		seogu();
		goongu();
		dongu();
		all();
		reg();
		
		// 전체 우클릭 금지시키기
		$(document).bind("contextmenu", function(){
			return false;
		});	//end bind
	});
	
	function daeduckgu(){
		$("#daeduckgu").click(function(){
			var district = $("#daeduckgu").val();
			location.href="./allStadiumList.do?district="+district;
		});
	}
	
	function seogu(){
		$("#seogu").click(function(){
			var district = $("#seogu").val();
			location.href="./allStadiumList.do?district="+district;
		});
	}
	
	function yusungu(){
		$("#yusungu").click(function(){
			var district = $("#yusungu").val();
			location.href="./allStadiumList.do?district="+district;
		});
	}
	
	function goongu(){
		$("#goongu").click(function(){
			var district = $("#goongu").val();
			location.href="./allStadiumList.do?district="+district;
		});
	}
	
	function dongu(){
		$("#dongu").click(function(){
			var district = $("#dongu").val();				
			location.href="./allStadiumList.do?district="+district;
		});
	}

	function all(){
		$("#all").click(function(){
			location.href="./allStadiumList.do";
		});
	}

	function reg(){
		$("#add").click(function(){
			location.href="./add.do";
		});
	}

</script>
<body>
	<%@include file="../main/topmain.jsp" %>
	
	<div class="presentation-container">
      	<div class="container">
      		<div class="row">
	       		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
	           		<h1><span class="violet">풋살장 시설</span></h1>
<!-- 	           		<h1>대전 풋살경기장 보기</h1> -->
	           	</div>
          	</div>
          	<div class="col-sm-12 work-title wow fadeIn">
				<h2>전체 풋살장 (${totalCount})</h2>
	    	</div>
        </div>
    </div>
    <br/>
	
	<form method="post">
	<div class="container">
		<div class="row">
<!-- 			<div style="position:relative; left:10px;"> -->
			<div align="center">
				<input type="button" id="all" value="ALL" class="small_Btn"/>
				<input type="button" id="daeduckgu" name="대덕구" value="대덕구" class="small_Btn"/>
				<input type="button" id="dongu" name="동구" value="동구 " class="small_Btn"/>
				<input type="button" id="seogu" name="서구" value="서구 " class="small_Btn"/>
				<input type="button" id="goongu" name="중구" value="중구 " class="small_Btn"/>
				<input type="button" id="yusungu" name="유성구" value="유성구" class="small_Btn"/>
				
				
				<c:if test="${master != null}">
					<input type="button" id="add" value="구장등록하기" class="small_Btn"/>
				</c:if>
			</div>
		</div>
	</div>
	<br/>
	<br/>
    <div class = "container">
    	<div class="row" >
           	<table class="vaughn_table vaughn_table-striped vaughn_table-bordered vaughn_table-hover text-muted" >
<!--            	<table class="table table-striped table-bordered table-hover text-muted" > -->
				<tr style="font-size:16px;font-weight:bold;">
					<th class="text-center" width="20%">경기장사진</th>
					<th class="text-center" width="20%">경기장이름</th>
					<th class="text-center" width="30%">경기장 주소</th>
					<th class="text-center" width="30%">구장시설</th>
				</tr>
				<c:if test="${totalCount != 0}">
				<c:forEach var="stadium" items="${AllStadium}" varStatus="status" >
				<tr style="vertical-align:middle;!important" onclick="location.href='/eachStadiumInfo.do?stadiumName=${stadium.STADIUM_NAME}'">
					<td >
						<img src="StadiumImage/${stadium.STADIUM_TITLE}" width="160px" height="110px" />
					</td>
					<td>
						${stadium.STADIUM_NAME}
					</td>
					<td>
						<c:set var="address" value="${stadium.ADDRESS}"/>
						${fn:substring(address, 4, fn:length(address))}
					</td>
					<td >
						<c:set var="info" value="${stadium.INFO}" />
						${fn:substringAfter(info, "/")} 
					</td>
				</tr>
				</c:forEach>
				</c:if>
			</table>
			</div>
		</div>
		<c:if test="${totalCount == 0}">
		<tr>
			<td>해당 게시물에 내용이 없습니다.</td>
		</tr>
	</c:if>
	</form>
</body>
</html>