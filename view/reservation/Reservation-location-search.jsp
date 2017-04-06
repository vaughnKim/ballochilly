<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">

    <head>
        <%@include file="../sub/subfile.jsp" %>
    </head>
<script>
	$(document).ready(function() {
// 		$("#DuckArm").click(function(){
// 			var stadiumName = $("#DuckArm").
			
// 			$("#stadiumName").val(stadiumName);
// 		});

		$("#dongArea").hide();
		$("#seoArea").hide();
		$("#yuseongArea").hide();
		$("#jungArea").hide();
		$("#deaduckArea").hide();
		
		
		$("#deaduck").click(function(){
			$("#deaduckArea").show();
			$("#dongArea").hide();
			$("#seoArea").hide();
			$("#yuseongArea").hide();
			$("#jungArea").hide();
		});
		$("#dong").click(function(){
			$("#deaduckArea").hide();
			$("#dongArea").show();
			$("#seoArea").hide();
			$("#yuseongArea").hide();
			$("#jungArea").hide();
		});
		$("#seo").click(function(){
			$("#deaduckArea").hide();
			$("#dongArea").hide();
			$("#seoArea").show();
			$("#yuseongArea").hide();
			$("#jungArea").hide();
		});
		$("#yuseong").click(function(){
			$("#deaduckArea").hide();
			$("#dongArea").hide();
			$("#seoArea").hide();
			$("#yuseongArea").show();
			$("#jungArea").hide();
		});
		$("#jung").click(function(){
			$("#deaduckArea").hide();
			$("#dongArea").hide();
			$("#seoArea").hide();
			$("#yuseongArea").hide();
			$("#jungArea").show();
		});
	});
	
	
</script>
<style>
	.hide {
		display:none;
	}
	.show {
		display:initial;
	}
</style>

<body style="text-align:center;">
<%@include file="../main/topmain.jsp" %>
	<form method="post">
		<input type="hidden" name="stadiumName" id="stadiumName"/>
	</form>
	
	<h2>지역별 예약</h2>
	<div style="width:100%;">
	<table style="margin: auto" >
		<tr>
			<td>
				<div id="city">
					<img src="image/deajeon.png" align="middle" border="0" alt="지역을 선택하세요 " usemap="#imgmap201571133842" hspace="0" width="500" height="500" >
					<map id="imgmap201571133842" name="imgmap201571133842">
					<area shape="poly" title="" id="deaduck" style ="cursor: pointer;" 
						  coords="354,50,322,58,324,76,315,87,292,80,266,75,250,90,231,97,243,109,263,129,272,138,265,156,264,183,257,184,262,194,254,197,245,199,244,212,254,229,260,238,281,238,294,210,305,224,320,228,330,214,307,195,312,178,314,163,328,143,340,144,347,116,368,114,358,98,373,96,377,82,362,86,352,87,345,74,351,65,356,52,356,52"
						   alt="대덕구" />
					<area shape="poly" title="" id="dong" style ="cursor: pointer;"
						  coords="431,131,415,136,403,128,389,141,390,162,370,151,361,126,358,121,346,137,320,202,348,223,330,243,292,236,280,253,318,299,331,322,300,321,300,380,313,401,289,423,286,443,302,455,316,457,314,438,331,433,337,409,358,392,351,356,365,325,367,290,376,241,404,221,404,197,401,177,443,164,435,148"
						   alt="동구" />	  
					<area shape="poly" title="" id="seo" style ="cursor: pointer;"
						  coords="236,201,216,210,181,238,201,267,172,275,167,316,96,386,121,420,140,411,167,459,162,479,177,452,203,391,193,358,212,345,206,313,227,291,228,263,246,254,247,226,247,226" 
						   alt="서구" />
					<area shape="poly" title="" id="yuseong" style ="cursor: pointer;"
						  coords="230,19,199,39,198,52,210,66,161,139,115,137,94,188,98,227,70,339,91,354,123,351,155,292,167,249,182,216,233,190,256,192,265,145,252,125,232,104,246,74,248,45" 
						   alt="유성구" />
					<area shape="poly" title="" id="jung" style ="cursor: pointer;"
						  coords="257,247,248,264,229,284,235,294,218,340,246,366,238,373,239,403,263,430,281,443,277,409,298,412,298,395,284,377,283,363,293,356,285,336,294,310,320,313,286,281,274,259,265,252" 
						   alt="중구" />
					</map>
				</div>
			</td>
			
			<td>
				<div>
					<h2>원하시는 지역을 클릭하세요!</h2>					
				</div>
				<div id="deaduckArea" >
					<img src='image/deaduck.png' align="middle" border="0" alt="구장을 선택하세요 " usemap="#imgmap1"/>
					<map id="imgmap1" name="imgmap1">
					<area id="DuckArm"shape="rect" alt="덕암 축구센터 풋살장" title="" coords="122,116,288,135" 
						  href='./eachStadiumInfo.do?stadiumName=덕암%20축구센터%20풋살장' target="" /> <!-- href를 풋살구장 정보 불러오는 곳으로 옮기기 -->
					<area id="song"shape="rect" alt="송촌 풋살장" title="" coords="179,323,281,342" 
						  href="./eachStadiumInfo.do?stadiumName=송촌%20풋살장" target="" /> <!-- href를 풋살구장 정보 불러오는 곳으로 옮기기 -->
					</map>
<!-- 					<input type="button" value="뒤로가기" onclick="location.href='/Ballochilly/Reservation-location-search.do'"> -->
				</div>
				
				<div id="dongArea" >
					<img src='image/dong.png' align="middle" border="0" alt="구장을 선택하세요 " usemap="#imgmap2"/>
					<map id="imgmap2" name="imgmap2">
					<area shape="rect" alt="삼성 풋살장" title="" coords="134,153,244,168" 
						  href="./eachStadiumInfo.do?stadiumName=삼성%20풋살장" target="" />
					<area shape="rect" alt="판암 풋살클럽" title="" coords="209,201,333,217" 
						  href="./eachStadiumInfo.do?stadiumName=판암%20풋살클럽" target="" />
					<area shape="rect" alt="점프 풋살장" title="" coords="201,239,317,252" 
						  href="./eachStadiumInfo.do?stadiumName=점프%20풋살장" target="" />
					</map>
				</div>
				
				<div id="seoArea" >
					<img src='image/seo.png' align="middle" border="0" alt="구장을 선택하세요 " usemap="#imgmap3"/>
					<map id="imgmap3" name="imgmap3">
					<area shape="rect" alt="월평 풋살장" title="" coords="111,56,227,74" href="./eachStadiumInfo.do?stadiumName=월평%20풋살장" target="" />
					<area shape="rect" alt="강남 풋살장" title="" coords="113,79,226,95" href="./eachStadiumInfo.do?stadiumName=강남%20풋살장" target="" />
					<area shape="rect" alt="남선공원 풋살장" title="" coords="277,70,400,97" href="./eachStadiumInfo.do?stadiumName=남선공원%20풋살장" target="" />
					<area shape="rect" alt="가장 풋살장" title="" coords="260,100,379,127" href="./eachStadiumInfo.do?stadiumName=가장%20풋살장" target="" />
					<area shape="rect" alt="강정훈 풋살장" title="" coords="56,155,189,184" href="./eachStadiumInfo.do?stadiumName=강정훈%20풋살클럽" target="" />
					</map>
				</div>
				
				<div id="yuseongArea" >
					<img src='image/yuseong.png' align="middle" border="0" alt="구장을 선택하세요 " usemap="#imgmap4"/>
					<map id="imgmap4" name="imgmap4">
					<area shape="rect" alt="송강 풋살장" title="" coords="258,76,375,102" href="./eachStadiumInfo.do?stadiumName=송강%20풋살%20구장" target="" />
					<area shape="rect" alt="테크노 풋살장" title="" coords="286,128,399,156" href="./eachStadiumInfo.do?stadiumName=테크노%20풋살장" target="" />
					<area shape="rect" alt="굿모닝 풋살장" title="" coords="77,171,207,190" href="./eachStadiumInfo.do?stadiumName=굿모닝%20풋살장" target="" />
					<area shape="rect" alt="동아 풋살장" title="" coords="57,212,180,228" href="./eachStadiumInfo.do?stadiumName=동아%20풋살장" target="" />
					<area shape="rect" alt="유성 풋살장" title="" coords="201,248,316,265" href="./eachStadiumInfo.do?stadiumName=유성풋살장" target="" />
					<area shape="rect" alt="씨티 풋살구장" title="" coords="29,266,155,284" href="./eachStadiumInfo.do?stadiumName=씨티%20풋살구장" target="" />
					</map>
				</div>
				
				<div id="jungArea" >
					<img src='image/jung.png' align="middle" border="0" alt="구장을 선택하세요 " usemap="#imgmap5"/>
					<map id="imgmap5" name="imgmap5">
					<area shape="rect" alt="문화 풋살클럽" title="" coords="170,83,306,102" href="./eachStadiumInfo.do?stadiumName=문화%20풋살클럽" target="" />
					<area shape="rect" alt="JOIN-US 풋살구장" title="" coords="23,121,174,147" href="./eachStadiumInfo.do?stadiumName=경성%20풋살구장" target="" />
					<area shape="rect" alt="안영 풋살장" title="" coords="43,162,141,187" href="./eachStadiumInfo.do?stadiumName=안영%20풋살장" target="" />
					</map>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			
			</td>
		</tr>
	
		
	
	
	</table>
	</div>
</body>
</html>