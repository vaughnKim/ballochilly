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

	// 날짜를 option에서 선택을 하면 해당 월로 이동하게 하는 펑션
	function selectMonth() {
		
		for(var i = 1 ; i <= $("#selectMonth option").size() ; i++) {
			
			if( $("#selectMonth").val('${dateList[0].nowMonth}') ){
				$("#selectMonth select[value="+i+"]").prop("selected", true);
				
			}	//end if
			
		}	//end for
			
		$("#selectMonth").change(function(){
			
			var year = '${dateList[0].nowYear}';
			var month = $("#selectMonth").val();
			
			// form을 이용한 방법
			$("input[name=year]").val(year);
			$("input[name=month]").val(month);
			$("input[name=day]").val(1);
			
			$("form")[0].method = "post";
			$("form")[0].action = "./calendar.do";
			$("form")[0].submit();
			
		});	//end change
		
	}	//end selectMonth

	$().ready(function(){
		
// 		alert('${today}');
		
		$("#prev, #next").click(function(){
			var year = $(this).attr("year");
			var month = $(this).attr("month");
// 			location.assing("./main.do?year=" + year + "&month=" + month);

			// form을 이용한 방법
			$("input[name=year]").val(year);
			$("input[name=month]").val(month);
			$("input[name=day]").val(1);
			
// 			$("form")[0].method = "post";
// 			$("form")[0].action = "./calendar.do";
// 			$("form")[0].submit();
			
		});	//end click
		
		// 전체 우클릭 금지시키기
		$(document).bind("contextmenu", function(){
			
			return false;
			
		});	//end bind
		
		$("td").mousedown(function(event){
			console.log(this);
			
			var btn = event.which;
			var date = $(this).text(); // 일
			
			if(date == "") {
				return false;
			}	//end if
			
			if(isNaN(date) == true) {
				console.log(1);
				return false;
			}	//end if
			
			
			if(btn == 1) {	//좌클릭
				$(this).css("background-color", "pink");
				$("td").not(this).css("background-color", "");
				var today = new Date();
				var toYear = today.getFullYear();
				var toMonth = today.getMonth()+1;
				if(toMonth < 10) {
					toMonth = "0"+toMonth;
				}
				var toDate = today.getDate();
				if(toDate < 10) {
					toDate = "0"+toDate;
				}
				
				var clickYear = ${dateList[0].nowYear};
				var clickMonth = ${dateList[0].nowMonth};
				if(clickMonth < 10) {
					clickMonth = "0"+ clickMonth;
				}
				var clickDay = $(this).text();
				
				var toDate2 = toYear + '' + toMonth + '' + toDate;
				var clickDay2 = clickYear + '' + clickMonth + '' + clickDay;
				
			}
			$(this).css("background-color", "pink");	
		});	//end event(mousedown)
		
		selectMonth();
		
	});	//end ready
	
	
	
	
</script>

<body>
<%-- <%@include file="../main/topmain.jsp" %> --%>
	
	<style>
/* 		tr > td:last { */
/* 			color:bule; */
/* 		} */
		#span-font {
			font-size:30px;
			color:green;
		}
		.span-font-sub {
			font-size:20px;
		}
/* 		table tr td:last-child { */
/* 			color:blue; text-align: center;*/
/* 		} */
		th {
			  text-align: center;
			}
	</style>
	
	<form>
		<input type = "hidden" name = "year" id="year" value = "${dateList[0].nowYear}"/>
		<input type = "hidden" name = "month" id="month" value = "${dateList[0].nowMonth < 10 ? '0' + dateList[0].nowMonth : dateList[0].nowMonth}"/>
		<input type = "hidden" name = "date" />
		<input type = "hidden" name = "day" id="day" />
		<input type = "hidden" name = "content" />
		<input type = "hidden" name = "courtNo" value="${param.courtNo}"/>
		<input type = "hidden" name = "stadiumName" value="${param.stadiumName}"/>
<%-- 		<c:forEach var="i" begin="1" end="${param.courtNo}" step="1"> --%>
<%-- 			<input type="hidden" name="court" value="${paramValues.court[i-1]}"/> --%>
<%-- 		</c:forEach> --%>
	</form>
	
	<div class = "row"> 
		<div class ="no-text-center panel-heading text-muted " align="center">
			<div class="col-lg-12 text-center">
				<h2>${param.stadiumName} 날짜선택</h2>
			</div>
		</div>
	</div>
	
	<div class = "row services-container">
		<div class ="no-text-center panel-heading text-muted " align="center">
			<span>
				<input type = "button" value = "<<" class = "btn board-btn-xl" id = "prev"
					   month = "${dateList[0].prevMonth}"
					   year = "${dateList[0].prevYear}"
				/>
			</span>
			<span class = "span-font-sub">${dateList[0].nowYear} 년 </span>	
			<span id = "span-font">${dateList[0].nowMonth} 월</span>
			<span>
				<select id = "selectMonth">
					<option value = "01">1월</option>
					<option value = "02">2월</option>
					<option value = "03">3월</option>
					<option value = "04">4월</option>
					<option value = "05">5월</option>
					<option value = "06">6월</option>
					<option value = "07">7월</option>
					<option value = "08">8월</option>
					<option value = "09">9월</option>
					<option value = "10">10월</option>
					<option value = "11">11월</option>
					<option value = "12">12월</option>
				</select> 
			</span>
			<span>
				<input type = "button" value = ">>" class = "btn board-btn-xl" id = "next"
					   month = "${dateList[0].nextMonth}"
				       year = "${dateList[0].nextYear}"
				/>
			</span>
		</div>
	</div>
	<div class = "container">
		<div class = "row">
			<div class ="no-text-center panel-heading text-muted">
				<table class="table table-striped table-bordered table-hover text-center tableSchedule" >
					<tr align = "center" >
						<th style = "color:red;" class = "text-center">일</th>
						<th class = "text-center">월</th>
						<th class = "text-center">화</th>
						<th class = "text-center">수</th>
						<th class = "text-center">목</th>
						<th class = "text-center">금</th>
						<th style = "color:blue;" class = "text-center">토</th>
					</tr>
					<c:forEach items = "${dateList}" var = "date" varStatus="i">
						<c:choose>
							<c:when test="${date.week == 1}">
								<tr>
									<td class = "test" style = "color:red;height:50px">
										${date.date}
									</td>
							</c:when>
							<c:otherwise>
								<c:if test="${date.week > 1 && date.date == 1}">
									<c:forEach begin = "2" end = "${date.week}">
										<td class = "test" style = "height:50px"></td>
									</c:forEach>
								</c:if>
								
								<td class = "test" style = "height:50px">
									${date.date}<br/>
								<c:forEach items = "${weatherList}" var = "weather">
									<c:if test="${weather.day == date.date && weather.month == date.nowMonth}">
									${weather.wfKor}
									</c:if>
								</c:forEach>
								</td>
								
								<c:if test="${date.week == 7}">
									</tr>
								</c:if>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>
	
</body>
</html>