<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="kr">

<head>
<%--         <%@include file="../sub/subfile.jsp" %> --%>
<!--     <link rel="stylesheet" href="assets/bootstrap/css/setCss.css"> -->

</head>
<script>

	$().ready(function(){
		
// 		if($("#masterCal td").text() != "") {
			
		$("#masterCal td").css("cursor","pointer");
			
// 		}
		
		
// 		alert('${dateList[0].nowYear}');
		
		$("#prev, #next").click(function(){
			
			var year = $(this).attr("year");
			var month = $(this).attr("month");
	
			// form을 이용한 방법
			$("input[name=year]").val(year);
			$("input[name=month]").val(month);
			$("form").method = "post";
			$("form").action = "./main.do";
			$("form").submit();
			
		});	//end click
		
		// 전체 우클릭 금지시키기
		$(document).bind("contextmenu", function(){
			
			return false;
			
		});	//end bind
		
		$("#masterCal td").mousedown(function(event){
			
			var btn = event.which;
			var date = $(this).text(); // 일
			
			if(date == "") {
				return false;
			}	//end if
			
			if(btn == 3) {	// 우클릭
				
				var x = event.pageX;
				var y = event.pageY;
				$(this).css("background-color", "skyblue");
				$("td").not(this).css("background-color", "");
				return false;
			}	//end if
			
			if(btn == 1) {	//좌클릭
				
				var masterName = '${master.MASTER_ID}';
// 				alert(masterName);
				$(this).css("background-color", "pink");
				$("td").not(this).css("background-color", "");
				var day = $(this).find("lable").text();
// 				alert(day);
// 				var day = $(this).text();
// 				var month = $("#month").val();
				
				var year = '${dateList[0].nowYear}';
				var month = '${dateList[0].nowMonth}';
				
				day *= 1;
				if( day < 10) {
					day = "0" + day;
				}
				
// 				alert(month);
				month *= 1;
				
				if( month < 10) {
					month = "0" + month;
				}
				
// 				var year = $("#year").val();
// 				alert(year);
// 				alert(month);
				
				var popUrl = "./reservationDetailPop.admin?masterName=" + masterName + "&year=" + year + "&month=" + month +"&day=" + day;
				var popOption = "width=600, height=450, resizable=no, scrollbars=no, status=no, top=300, left=300, location=no, menubar=no";    //팝업창 옵션(optoin)
    			window.open(popUrl,"",popOption);
				
			}	//end if 
			
		});	// end event(mousedown)
	
	});
	

</script>

<style>

	#span-font {
		font-size:30px;
 		color:green;
	}
	.span-font-sub {
		font-size:20px;
	}
	th {
		  text-align: center;
	}
	.tempFont{
		font-size:12px
	}
	
	#masterCal td.test:nth-of-type(7) {
		color:blue; 
	}
	
</style>
<body>
	
	<form>
		<input type = "hidden" name = "year" id="year" value = "${dateList[0].nowYear}" />
		<input type = "hidden" name = "month" id="month" value = "${dateList[0].nowMonth < 10 ? '0' + dateList[0].nowMonth : dateList[0].nowMonth}" />
		<input type = "hidden" name = "day" id="day" />
	</form>
	
	<div class = "row">
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
				<input type = "button" value = ">>" class = "btn board-btn-xl" id = "next"
					   month = "${dateList[0].nextMonth}"
				       year = "${dateList[0].nextYear}"
				/>
			</span>
		</div>
	</div>
	
	<div class = "row">
		<div class ="no-text-center panel-heading text-muted">
			<table class="table table-striped table-bordered table-hover text-center tableSchedule" id = "masterCal">
				<tr align = "center" >
					<th style = "color:red;width:14%;" class = "text-center" >일</th>
					<th style = "width:14%;" class = "text-center">월</th>
					<th style = "width:14%;" class = "text-center">화</th>
					<th style = "width:14%;" class = "text-center">수</th>
					<th style = "width:14%;" class = "text-center">목</th>
					<th style = "width:14%;" class = "text-center">금</th>
					<th style = "color:blue;width:14%;" class = "text-center">토</th>
				</tr>
				<c:forEach items = "${dateList}" var = "date">
					<c:choose>
						<c:when test="${date.week == 1}">
							<tr>
								<td class = "test" style = "color:red;height:70px;">${date.date}</td>
						</c:when>
						<c:otherwise>
							<c:if test="${date.week > 1 && date.date == 1}">
								<c:forEach begin = "2" end = "${date.week}">
									<td class = "test" style = "height:70px"></td>
								</c:forEach>
							</c:if>
								<td class = "test" style = "height:50px">
									<lable>${date.date}</lable><br/><br/>
									<fmt:formatNumber value = "${date.month}" type = "number" var = "numberMonth"/>
									<%
										int count = 0;
									%>
									<c:forEach items = "${allReservaionForName}" var = "list" varStatus = "i">
									<%
										BigDecimal bDay = (BigDecimal) ((Map<String, Object>)pageContext.getAttribute("list")).get("DAY");
										int day = bDay.intValue();
										
										BigDecimal bMonth = (BigDecimal) ((Map<String, Object>)pageContext.getAttribute("list")).get("MONTH");
										int month = bMonth.intValue();
										
										BigDecimal bYear = (BigDecimal) ((Map<String, Object>)pageContext.getAttribute("list")).get("YEAR");
										int year = bYear.intValue();
										
										int date = (int) ((Map<String, Object>)pageContext.getAttribute("date")).get("date");
										int dYear = (int) ((Map<String, Object>)pageContext.getAttribute("date")).get("year");
										int dMonth = (int) ((Map<String, Object>)pageContext.getAttribute("date")).get("month");
										
										BigDecimal bStartTime = (BigDecimal) ((Map<String, Object>)pageContext.getAttribute("list")).get("START_TIME");
										int startTime = bStartTime.intValue();
										
										String reservationId = (String) ((Map<String, Object>)pageContext.getAttribute("list")).get("ID");
										String reservationCourt = (String) ((Map<String, Object>)pageContext.getAttribute("list")).get("COURT");
										
										if(day == date && month == dMonth && year == dYear) {
											
											count++;
// 											System.out.print("test######################## : " + count);
											
											if(count <= 5) {
												out.println(startTime + " 시 " + reservationCourt + "  " + reservationId + "<br/>");
											} else if(count == 6) {
												
												out.println("<input type = 'button' value = '더보기' class = 'btn'/>");
												
											}
											
										}
									%>
<%-- 										<c:if test="${list.DAY == date.date && list.MONTH == numberMonth && list.YEAR == date.year}"> --%>
<%-- 											${list.START_TIME}시 ${list.COURT} ${list.ID} ${i.count}<br/> --%>
<%-- 										</c:if> --%>
									</c:forEach>
								</td>
							<c:if test="${date.week == 7}"> 
								</tr>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</table>
			
			<c:forEach items = "${allReservationForName}" var = "all">
				${all}
			</c:forEach>
		</div>
	</div>
</body>
</html>