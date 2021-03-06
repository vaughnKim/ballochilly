<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
		
// 		alert('${param.stadiumAddress}');

// 		$("#cal > tr > td.eq(6)").css("color", "blue");
		$("#cal tr > td:nth-child(7)").css("color", "blue");
		
		
		$("#prev, #next").click(function(){
			var year = $(this).attr("year");
			var month = $(this).attr("month");
// 			location.assing("./main.do?year=" + year + "&month=" + month);

			// form을 이용한 방법
			$("input[name=year]").val(year);
			$("input[name=month]").val(month);
			$("input[name=day]").val(1);
			
			$("form")[0].method = "post";
			$("form")[0].action = "./calendar.do";
			$("form")[0].submit();
			
		});	//end click
		
		// 전체 우클릭 금지시키기
		$(document).bind("contextmenu", function(){
			
 			return false;
			
		});	//end bind
		
		$("td").mousedown(function(event){
			console.log(this);
			
			var btn = event.which;
			var date = $(this).find("span").text(); // 일
			
			if(date == "") {
				return false;
			}	//end if
			
			if(isNaN(date) == true) {
				console.log(1);
				return false;
			}	//end if
			
			
			if(btn == 1) {	//좌클릭
// 				$(this).css("background-color", "pink");
// 				$("td").not(this).css("background-color", "");
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
				var clickDay = $.trim($(this).find("span").text());
				
				if(clickDay < 10) {
					clickDay = "0" + clickDay;
				}
				
				var toDate2 = toYear + '' + toMonth + '' + toDate;
				var clickDay2 = clickYear + '' + clickMonth + '' + clickDay;
				if((toDate2) > (clickDay2)){
					alert("선택하신 날짜(지난 날짜)는 예약이 불가능합니다.");
				} else{
					
					$("#year").val(clickYear);
					$("#month").val(clickMonth);
					$("#day").val(clickDay);
					
					$("form")[0].method = "post";
					$("form")[0].action = "./calendar.do";
					$("form")[0].submit();
				}
				
			}
 		});	//end event(mousedown)
		selectMonth();
		reservation();
		
	});	//end ready
	
	function reservation() {
		$("#reservation").click(function(){
			var checkedBoxes = [];
// 			alert(checkedBoxes);
			
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
			var hour = today.getHours();
// 			alert(hour);
			
			//날짜 일에 10보다 작으면 "0"을 넣어주는 시도
			var clickDay = ${day};
				if(clickDay < 10) {
					clickDay = "0" + clickDay;
				}
			var clickMonth = ${dateList[0].nowMonth};
				if(clickMonth < 10) {
					clickMonth = "0" + clickMonth;
				}
			var clickYear = ${dateList[0].nowYear};
			
			$("#day").val(clickDay); // 여기가 날짜 끝
			
// 			$("input[type=checkbox]:checked").each(function(idx, data){
			$(".courtChkBox:checked").each(function(idx, data){
				checkedBoxes.push($(data).val());
			});
			//예약시간 선택 안했을 시 예외처리
			if(checkedBoxes =="") {
				alert("예약시간을 선택해 주세요.");
				return false;
			}
			
			
			for(i=checkedBoxes.length-1; i >=0; i--){
				var startTime = checkedBoxes[i].substring(checkedBoxes[i].indexOf("startTime=") + 10, checkedBoxes[i].indexOf("&end"));
			}
				
			var A = toYear+"-"+toMonth+"-"+toDate;
			var B = clickYear+"-"+clickMonth+"-"+clickDay;
			
			if(A == B) {
				if(startTime <= hour){
					alert("지난시간은 선택할 수 없습니다.");
					location.reload();
					return false;
				} else{
					$("#checkbox").val(checkedBoxes);
					return true;
				}
			} else if(A < B){
				$("#checkbox").val(checkedBoxes);
				return true;
			}
		});
	}
	
	
	
</script>

<style>
	.today {
	   background-color : pink;
	}
</style>
<body>
<%@include file="../main/topmain.jsp" %>
	
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
			
		.tempFont{
			font-size:12px
		}
		
 		#cal td:eq(6) {
 			color:blue; 
 		} 
		
	</style>
	
	<form>
		<input type = "hidden" name = "year" id="year" value = "${dateList[0].nowYear}"/>
		<input type = "hidden" name = "month" id="month" value = "${dateList[0].nowMonth < 10 ? '0' + dateList[0].nowMonth : dateList[0].nowMonth}"/>
		<input type = "hidden" name = "date" />
		<input type = "hidden" name = "stadiumAddress" value="${param.stadiumAddress}"/>
		<input type = "hidden" name = "day" id="day" />
		<input type = "hidden" name = "content" />
		<input type = "hidden" name = "courtNo" value="${param.courtNo}"/>
		<input type = "hidden" name = "stadiumName" value="${param.stadiumName}"/>
		<c:forEach var="i" begin="1" end="${param.courtNo}" step="1">
			<input type="hidden" name="court" value="${paramValues.court[i-1]}"/>
		</c:forEach>
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
				<table class="table table-striped table-bordered table-hover text-center tableSchedule" id = "cal">
					<tr align = "center" >
						<th width = "14%" style = "color:red;" class = "text-center">일</th>
						<th width = "14%" class = "text-center">월</th>
						<th width = "14%" class = "text-center">화</th>
						<th width = "14%" class = "text-center">수</th>
						<th width = "14%" class = "text-center">목</th>
						<th width = "14%" class = "text-center">금</th>
						<th width = "14%" style = "color:blue;" class = "text-center">토</th>
					</tr>

					
					<fmt:formatNumber value="${day}" var="contertDay"/>
					<c:set var="dd" value="${contertDay}" />

					<c:forEach items = "${dateList}" var = "date">
						<c:choose>
							<c:when test="${date.week == 1}">
								<tr>
									<td class = "test <c:if test='${date.date == dd}'>today</c:if>" style = "color:red;height:85px">
										<span>${date.date}</span><br/>
										<c:forEach items = "${weatherList}" var = "weather">
											<c:if test="${weather.day == date.date && weather.month == date.nowMonth}">
												<c:if test="${weather.wfKor == '맑음'}">
				                					<img src = '/weather/NB01.png' /><br/>
				                				</c:if>
				                				<c:if test="${weather.wfKor == '구름 조금'}">
				                					<img src = '/weather/NB02.png' /><br/>
				                				</c:if>
				                				<c:if test="${weather.wfKor == '구름 많음'}">
				                					<img src = '/weather/NB03.png' /><br/>
				                				</c:if>
				                				<c:if test="${weather.wfKor == '구름많음'}">
				                					<img src = '/weather/NB03.png' /><br/>
				                				</c:if>
				                				<c:if test="${weather.wfKor == '구름조금'}">
				                					<img src = '/weather/NB03.png' /><br/>
				                				</c:if>
				                				<c:if test="${weather.wfKor == '흐림'}">
				                					<img src = '/weather/NB04.png' /><br/>
				                				</c:if>
				                				<c:if test="${weather.wfKor == '구름많고 비'}">
				                					<img src = '/weather/NB20.png' /><br/>
				                				</c:if>
				                				<c:if test="${weather.wfKor == '호우'}">
				                					<img src = '/weather/NB07.png' /><br/>
				                				</c:if>
				                				<c:if test="${weather.wfKor == '비'}">
				                					<img src = '/weather/DB05.png' /><br/>
				                				</c:if>
				                				<c:if test="${weather.wfKor == '흐리고 비'}">
				                					<img src = '/weather/DB05.png' /><br/>
				                				</c:if>
				                				<c:if test="${weather.tmx != '-999.0'}">
				                					<div class = "tempFont">최고기온 ${weather.tmx}</div>
				                				</c:if>
											</c:if>
										</c:forEach>
										<c:forEach items = "${weekWeatherList}" var = "weekWeather">
											<c:if test="${weekWeather.weekOfDays == date.date && weekWeather.month == date.nowMonth}">
												<c:if test="${weekWeather.wf == '맑음'}">
				                					<img src = '/weather/NB01.png' /><br/>
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '구름 조금'}">
				                					<img src = '/weather/NB02.png' /><br/>
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '구름 많음'}">
				                					<img src = '/weather/NB03.png' /><br/>
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '구름많음'}">
				                					<img src = '/weather/NB03.png' /><br/>
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '구름조금'}">
				                					<img src = '/weather/NB03.png' /><br/>
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '흐림'}">
				                					<img src = '/weather/NB04.png' /><br/>
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '구름많고 비'}">
				                					<img src = '/weather/NB20.png' /><br/>
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '호우'}">
				                					<img src = '/weather/NB07.png' /><br/>
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '비'}">
				                					<img src = '/weather/DB05.png' /><br/>
				                				</c:if>
				                				<c:if test="${weekWeather.wf == '흐리고 비'}">
				                					<img src = '/weather/DB05.png' /><br/>
				                				</c:if>
			                					<div class = "tempFont">최고기온 ${weekWeather.tmx}</div>
											</c:if>
										</c:forEach>
									</td>
							</c:when>
							<c:otherwise>
								<c:if test="${date.week > 1 && date.date == 1}">
									<c:forEach begin = "2" end = "${date.week}">
										<td class = "test" style = "height:50px"></td>
									</c:forEach>
								</c:if>
								<td class = "test <c:if test='${date.date == dd}'>today</c:if>" style = "height:85px">
									<span>${date.date}</span><br/>
									<c:forEach items = "${weatherList}" var = "weather">
										<c:if test="${weather.day == date.date && weather.month == date.nowMonth}">
											<c:if test="${weather.wfKor == '맑음'}">
			                					<img src = '/weather/NB01.png' /><br/>
			                				</c:if>
			                				<c:if test="${weather.wfKor == '구름 조금'}">
			                					<img src = '/weather/NB02.png' /><br/>
			                				</c:if>
			                				<c:if test="${weather.wfKor == '구름 많음'}">
			                					<img src = '/weather/NB03.png' /><br/>
			                				</c:if>
			                				<c:if test="${weather.wfKor == '구름많음'}">
			                					<img src = '/weather/NB03.png' /><br/>
			                				</c:if>
			                				<c:if test="${weather.wfKor == '구름조금'}">
			                					<img src = '/weather/NB03.png' /><br/>
			                				</c:if>
			                				<c:if test="${weather.wfKor == '흐림'}">
			                					<img src = '/weather/NB04.png' /><br/>
			                				</c:if>
			                				<c:if test="${weather.wfKor == '구름많고 비'}">
			                					<img src = '/weather/NB20.png' /><br/>
			                				</c:if>
			                				<c:if test="${weather.wfKor == '호우'}">
			                					<img src = '/weather/NB07.png' /><br/>
			                				</c:if>
			                				<c:if test="${weather.wfKor == '비'}">
			                					<img src = '/weather/DB05.png' /><br/>
			                				</c:if>
			                				<c:if test="${weather.wfKor == '흐리고 비'}">
			                					<img src = '/weather/DB05.png' /><br/>
			                				</c:if>
			                				<c:if test="${weather.tmx != '-999.0' }">
			                					<div class = "tempFont">최고기온 ${weather.tmx}</div>
			                				</c:if>
										</c:if>
									</c:forEach>
									<c:forEach items = "${weekWeatherList}" var = "weekWeather">
										<c:if test="${weekWeather.weekOfDays == date.date && weekWeather.month == date.nowMonth}">
											<c:if test="${weekWeather.wf == '맑음'}">
			                					<img src = '/weather/NB01.png' /><br/>
			                				</c:if>
			                				<c:if test="${weekWeather.wf == '구름 조금'}">
			                					<img src = '/weather/NB02.png' /><br/>
			                				</c:if>
			                				<c:if test="${weekWeather.wf == '구름 많음'}">
			                					<img src = '/weather/NB03.png' /><br/>
			                				</c:if>
			                				<c:if test="${weekWeather.wf == '구름많음'}">
			                					<img src = '/weather/NB03.png' /><br/>
			                				</c:if>
			                				<c:if test="${weekWeather.wf == '구름조금'}">
			                					<img src = '/weather/NB03.png' /><br/>
			                				</c:if>
			                				<c:if test="${weekWeather.wf == '흐림'}">
			                					<img src = '/weather/NB04.png' /><br/>
			                				</c:if>
			                				<c:if test="${weekWeather.wf == '구름많고 비'}">
			                					<img src = '/weather/NB20.png' /><br/>
			                				</c:if>
			                				<c:if test="${weekWeather.wf == '호우'}">
			                					<img src = '/weather/NB07.png' /><br/>
			                				</c:if>
			                				<c:if test="${weekWeather.wf == '비'}">
			                					<img src = '/weather/DB05.png' /><br/>
			                				</c:if>
			                				<c:if test="${weekWeather.wf == '흐리고 비'}">
			                					<img src = '/weather/DB05.png' /><br/>
			                				</c:if>
		                					<div class = "tempFont">최고기온 ${weekWeather.tmx}</div>
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
	<%@include file="../reservation/TimeCourt.jsp" %>
</body>
</html>