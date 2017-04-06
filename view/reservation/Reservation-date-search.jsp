<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="kr">

    <head>
        <%@include file="../sub/subfile.jsp" %>
    </head>
<style>
    th{
		font-size : 20px;
		text-align: center;    
    }
    td{
		font-size : 15px;
		text-align: center;    
    }
</style>
<script>
	// 전체 우클릭 금지시키기
	$(document).bind("contextmenu", function(){
		
		return false;
		
	});	//end bind
	



	$(document).ready(function() {
		$("#search_btn").click(function(){//예약가능 구장 검색 버튼 함수
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
			var reservationDate = $("#reservationDate").val();
				
			var startTime2 = $("#sTime > option:selected").val();
			var endTime2 = $("#eTime > option:selected").val();
			if(reservationDate == "") {
				alert("날짜를 선택해주세요.")
				return false;
			}else if(reservationDate < (toYear+"-"+toMonth+"-"+toDate)) {
				alert("지난 날짜는 선택할 수 없습니다.");
				return false;
			}else if(startTime2 == "999") {
				alert("시작시간을 선택해주세요.");
				return false;
			} else if(endTime2 == "888"){
				alert("종료시간을 선택해주세요.");
				return false;
			}else if(startTime2 >= endTime2){
				alert("시간선택이 잘못되었습니다.");
				return false;
			}else if(reservationDate == (toYear+"-"+toMonth+"-"+toDate)){
				if(startTime2 <= hour){
					alert("지난 시작시간은 선택할 수 없습니다.");
					return false;
						
				} 
			}
			var startTime = $("select:eq(0) option:selected").val();
			var endTime = $("select:eq(1) option:selected").val();
			var date = reservationDate.split("-");
			var year = date[0];
			var month = date[1];
			var day = date[2];
			
			
			$("#year").val(year);
			$("#month").val(month);
			$("#day").val(day);
			$("#startTime").val(startTime);
			$("#endTime").val(endTime);
			
			$("form").submit();
		});
		
// 		$("#finalReservation").click(function(){
			
// 		});
	});
	
</script>
<body style="text-align:center;">
<%@include file="../main/topmain.jsp" %>
	<h2>날짜/시간별 예약</h2>

	<form method="post">
		<input type="hidden" name="year" id="year"/>
		<input type="hidden" name="month" id="month"/>
		<input type="hidden" name="day" id="day"/>
		<input type="hidden" name="startTime" id="startTime"/>
		<input type="hidden" name="endTime" id="endTime"/>
	</form>
	예약일자 : 
	<input type="date" name="reservationDate"  id="reservationDate"/> &nbsp;/&nbsp;
	시작시간 : 
	<select name="startTime" id="sTime" >
		<option value="999" selected="selected" disabled="disabled">시작시간 선택</option>
		<option value="06">오전 06:00~</option>
		<option value="12">주간 12:00</option>
		<option value="13">13:00</option>
		<option value="14">14:00</option>
		<option value="15">15:00</option>
		<option value="16">16:00</option>
		<option value="17">17:00</option>
		<option value="18">야간18:00</option>
		<option value="19">19:00</option>
		<option value="20">20:00</option>
		<option value="21">21:00</option>
		<option value="22">22:00</option>
		<option value="23">23:00</option>
	</select> &nbsp;~&nbsp;
	종료시간 : 
	<select name="endTime" id="eTime">
		<option value="888" selected="selected" disabled="disabled">종료시간 선택</option>
		<option value="07">오전 07:00~</option>
		<option value="12">주간 12:00</option>
		<option value="13">13:00</option>
		<option value="14">14:00</option>
		<option value="15">15:00</option>
		<option value="16">16:00</option>
		<option value="17">17:00</option>
		<option value="18">야간18.00</option>
		<option value="19">19:00</option>
		<option value="20">20:00</option>
		<option value="21">21:00</option>
		<option value="22">22:00</option>
		<option value="23">23:00</option>
		<option value="24">24:00</option>
	</select>&nbsp;
	<input type="submit" value="구장검색" id="search_btn" class = "btn"/>
	<br/><br/>
	<div style="width:100%;">
		<table border="2" style="margin: auto">
			<thead>
				<tr>
					<th style="width:100px">구장이름</th>
					<th style="width:100px">코트</th>
					<th style="width:100px">구장위치</th>
					<th style="width:100px">예약날짜</th>
					<th style="width:100px">예약시간</th>
					<th style="width:100px">선택</th>
				</tr>
			</thead>
			<tbody>
			<%
// 				List<Map<String, Object>> reservation = (List<Map<String, Object>>) request.getAttribute("Reservation");
// 				int sum = 0;
// 				int num = 0;
				
// 				System.out.println(reservation);
			
// 				if(reservation != null) {
// 					for(int i = 0; i < reservation.size(); i++) {
// 						if(reservation.get(i).get("STADIUM_NAME") == reservation.get(i+1).get("STADIUM_NAME")){
// 							sum ++;
// 							num=num+sum+1;
// 						}else if(reservation.get(0).get("STADIUM_NAME") != reservation.get(1).get("STADIUM_NAME")){
// 							sum ++;
// 							num=num+sum;
// 							out.print("<tr>");
// 							out.print("<td>" + reservation.get(num-sum).get("STADIUM_NAME") + "</td>");
// 							out.print("<td>" + "<select name='endTime' id='eTime'>");
							
// 							for(int j=num-sum; j < num; j++){
// 								out.print("<option value='"+reservation.get(j).get("COURT")+"'>"); 
// 								out.print(reservation.get(j).get("COURT"));
// 								out.print("</option>"); 
// 							}
// 							out.print("</select>" + "</td>");
// 							out.print("<td>" + reservation.get(num-sum).get("ADDRESS") + "</td>");
// 							out.print("<td>" + request.getParameter("year")+"-"+request.getParameter("month")+"-"+request.getParameter("day")+ "</td>");
// 							out.print("<td>" +request.getParameter("startTime")+"~"+ request.getParameter("endTime")+ "</td>");
// 							out.print("<td>"+"</td>");
// 							sum=0;
// 						}else{
// 							num=num+sum+1;
// 							out.print("<tr>");
// 							out.print("<td>" + reservation.get(num-sum-1).get("STADIUM_NAME") + "</td>");
// 							out.print("<td>" + "<select name='endTime' id='eTime'>");
							
// 							for(int j=num-sum-1; j < num; j++){
// 								out.print("<option value='"+reservation.get(j).get("COURT")+"'>"); 
// 								out.print(reservation.get(j).get("COURT"));
// 								out.print("</option>"); 
// 							}
// 							out.print("</select>" + "</td>");
// 							out.print("<td>" + reservation.get(num-sum-1).get("ADDRESS") + "</td>");
// 							out.print("<td>" + request.getParameter("year")+"-"+request.getParameter("month")+"-"+request.getParameter("day")+ "</td>");
// 							out.print("<td>" +request.getParameter("startTime")+"~"+ request.getParameter("endTime")+ "</td>");
// 							out.print("<td>"+"</td>");
// 							sum=0;
// 						}
// 					}
// 				}
					
			%>			
				<c:forEach var="board" items="${Reservation}">
						<tr>
							<td>${board.STADIUM_NAME}</td>
							<td>${board.COURT}</td>
							<td>
								<c:set var="address" value="${board.ADDRESS}"/>
								${fn:substring(address, 4, fn:length(address))}
							</td>
							<td>${param.year}-${param.month}-${param.day}</td>
							<td>${param.startTime} ~ ${param.endTime}</td>
							<td>
								<a href='./eachStadiumInfo.do?siSeqNo=${board.SI_SEQ_NO}&stadiumName=${board.STADIUM_NAME}&court=${board.COURT}&year=${param.year}&month=${param.month}&day=${param.day}&start=${param.startTime}&end=${param.endTime}'>
									<input type="button" name="${board.STADIUM_NAME}" id="gone" value="${board.STADIUM_NAME}" class = "btn2"/>
								</a>
							</td>
						</tr>
				</c:forEach> 
			</tbody>
		</table>
	</div>
	reservation system create by mr.moon
</body>
</html>