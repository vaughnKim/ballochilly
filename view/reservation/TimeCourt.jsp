<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="kr">

<head>
    <%@include file="../sub/subfile.jsp" %>

</head>
<body>
	<h2>${param.stadiumName}&nbsp;(${dateList[0].nowMonth}월&nbsp;${day}일)</h2>
	<!--${day}로 쓸 수 있는 것은 Service에서 returnMap.put("day", map.get("day"));처리해줘서 가능 -->
	<div class = "container">
		<div class = "row">
			<div class ="no-text-center panel-heading text-muted">
				<table class="table table-striped table-bordered table-hover text-center tableSchedule">
					<tr align="center">
						<th class = "text-center" width = "20%">시간/코트</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<th class = "text-center" width = "20%">${paramValues.court[i-1]}구장</th>
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">오전 6:00~</th>
						
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="6" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${6 >= board.START_TIME && 6 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox"  class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=6&endTime=12"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">오후12:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="12" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${12 >= board.START_TIME && 12 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=12&endTime=13"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">13:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="13" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${13 >= board.START_TIME && 13 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=13&endTime=14"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">14:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="14" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${14 >= board.START_TIME && 14 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=14&endTime=15"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">15:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="15" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${15 >= board.START_TIME && 15 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=15&endTime=16"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">16:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="16" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${16 >= board.START_TIME && 16 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=16&endTime=17"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">17:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="17" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${17 >= board.START_TIME && 17 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=17&endTime=18"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">야간18:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="18" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${18 >= board.START_TIME && 18 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=18&endTime=19"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">19:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="19" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${19 >= board.START_TIME && 19 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=19&endTime=20"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">20:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="20" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${20 >= board.START_TIME && 20 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=20&endTime=21"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">21:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="21" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${21 >= board.START_TIME && 21 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=21&endTime=22"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">22:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="22" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${22 >= board.START_TIME && 22 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=22&endTime=23"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
					<tr>
						<th style ="{text-align:center}">23:00</th>
						<c:forEach var="i" begin="1" end="${fn:length(paramValues.court)}" step="1">
							<c:forEach var="board" items="${ReservationList}">
								<input type="hidden" name="23" value="${board.START_TIME}">
								<c:if test ="${paramValues.court[i-1] == board.COURT}">
									<c:if test = "${23 >= board.START_TIME && 23 < board.END_TIME}">
										<th>예약자 : ${board.ID}</th>
										<c:set var="flag" value="true" />
									</c:if>
								</c:if>
							</c:forEach>
							<c:if test ="${paramValues.court[i-1] != board.COURT && flag != true}">
								<td><input type = "checkbox" class = "courtChkBox" value="court=${paramValues.court[i-1]}&startTime=23&endTime=24"/></td>
							</c:if>
							<c:remove var="flag" />
						</c:forEach>
					</tr>
				
				</table>
				<div>
					<form method="post" action="./FinalReservation.do">
						<input type="hidden" name="stadiumAddress" value="${param.stadiumAddress}"/>
						<input type="hidden" name="stadiumName" value="${param.stadiumName}"/>
						<input type="hidden" name="year" value="${dateList[0].nowYear}"/>
						<input type="hidden" name="month" id="month" value="${dateList[0].nowMonth}"/>
						<input type="hidden" name="day" id="day" value="${day}"/>
						<input type="submit" value="예약하기" id = "reservation" class="btn"/>
						<input type="hidden" name="checkbox" id="checkbox" />
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>