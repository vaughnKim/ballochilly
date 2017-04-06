<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">

    <head>
        <%@include file="../sub/subfile.jsp" %>
    </head>
    
    <script>
    	
    	$().ready(function(){
    		
    		$("#memo").draggable();
    		$("#userInfo").draggable();
//     		bodyChilk();
    		
    		selectTd();
    		masterDelete();
    		inputBtn();
    		cancelBtn();
    		byeBtn();
    		closeUserInfo();
    		
//     		test1();
    		
    		// 삭제를 할 때는 이것을 활용
//     		$('#reservationInfo tr td').click(function(){
    			
    			// 예약 취소할 때는 이것을 활용
//     			alert($(this).attr("rv-seq-no"));
    			
    			// 예약 할 때 이걸 활용 이걸로 시작시간과 종료시간을 정해줄 수 있다.
    			// 종료시간은 시작시간을 숫자형으로 변환시키고, 그 후 시작시간 +1을 해주면 된다.
    			// 대신 다시 생각해 봐야 할 것은 오전 06시에 예약하는 경우는 ....?
    			// 일단 생략 06시에 예약하는 경우는 일단 생략하는걸로
    			// 어떻게 해주어야하는지??
//     			alert($(this).attr("startTime"));
    			
    			// 예약 할 때 활용할 수 있는 코트 번호
//     			alert($(this).attr("court-num"));
    			
    			
//     		});
   			// 예약할 때는 이것을 활용
   			// 예약할 때 필요한 정보들 : 풋살구장명, 사람ID, 시작시간, 종료시간, 년, 월, 일, 코트 번호
   			// 만약에 빈 곳을 클릭했을 때에는 어떤 정보를 가지고 오냐면,
   			// 이 때 파람값으로 넘겨오는 년, 월, 일, 풋살구장명을 가져오고,
   			// 그 외에 필요한 정보인 사람 ID를 입력할 수 있게 
   			// 또한 시작시간, 종료시간인데,
   			// 종료시간은 시작시간 + 1을 해주면 되고,
   			// 시작시간은 th에 있는 정보를 가져오면되고....
   			// 코트 번호는????
    		
   			// 우선 td를 클릭하면 그 부모인 th의 text를 가져오게 하면 될 듯?
    		
    	});
//     	function bodyChilk() {
    		
//     		$("body").not(("#memo, #userInfo")).mousedown(function(event){
    			
//     			var btn = event.which;
    			
//     			if(btn == 1) {
    				
//     				$("#memo").hide();
//     				$("#userInfo").hide();
    				
//     			}
    			
//     		});
    		
//     	}
    	
//     	function test1() {
    		
//     		$("#memo").click(function(){
//     			alert(3);
//     			return false;
    			
//     		});
    		
//     	}
    	
    	
    	function selectTd() {
    		
    		$("#reservationInfo tr td").mousedown(function(event){
//     			alert($(this).attr("startTime"));
//     			alert($(this).attr("court-num"));
// 				userCourt, userStartTime, userEndTime
//     			alert($(this).text());
					
				var stadiumName = '${param.masterName}';
				var court = $(this).attr("court-num");

				
    			if($(this).text().trim() == "") {
    				
					$.ajax({
						
						url : "./selectSiSeqNo.admin",
						type : "post",
						data : {"stadiumName" : stadiumName, "court" : court }, 
						success : function(data){
							
							$("#courtName").val(data.selectSiNumber);
							
						}
						
					});
	    			var startTime = $(this).attr("startTime"); 
	    			var court = $(this).attr("court-num"); 
					var endTime = "";
					endTime = (startTime * 1) + 1;
					
					$("#userCourt").text(court);
					$("#userStartTime").text(startTime);
					$("#userEndTime").text(endTime);
					
	    			var btn = event.which;
	    			
	    			// 마우스 좌클릭 할 때!
	    			if(btn == 1) {
	    				
	    				var x = event.pageX;
	    				var y = event.pageY;
	    				$("#memo").css({"left" : x, "top" : y});
	    				$("#memo").show();
	    				$("#userInfo").hide();
	    				
	    				return false;
	    				
	    			} 
    				
    			} else {
    				
    				var userId = $(this).find("label").text();
    				var x = event.pageX;
    				var y = event.pageY;
    				$("#userInfo").css({"left" : x, "top" : y});
    				$("#memo").hide();
    				
    				$.ajax({
    					
    					url : "./userInfo.admin",
    					type : "post",
    					data : {"userId" : userId},
    					success : function(data) {
    						
//     						alert(data.selectReservationUserInfo[0].PHONE);
   							$("#userInfo").show();
   							$("#reservationName").text(data.selectReservationUserInfo[0].NAME);
   							$("#reservationPhoneNumber").text(data.selectReservationUserInfo[0].PHONE);
   							$("#reservationEmail").text(data.selectReservationUserInfo[0].EMAIL);
    						
    					}
    					
    				});
    				
//     				alert("이미 예약자가 있습니다.");
//     				event.stopPropagation();
//     				return false;
    				
    			}
    			
    		});
    		
    		
    	}
    	
    	function inputBtn() {
    		
    		$("#inputBtn").click(function(){
    			
    			var siSeqNo = $("#courtName").val();
    			var court = $("#userCourt").text();
				var startTime = $("#userStartTime").text();
				var endTime = $("#userEndTime").text();
				var year = '${param.year}';
				var month = '${param.month}';
				var day = '${param.day}';
				var id = $("#reservaionName").val();
				var info = $("#reservationPhone").val();
				
				$.ajax({
					
					url :"./masterReservation.admin",
					type :"post",
					data : {"siSeqNo" : siSeqNo
						  , "court" : court
						  , "startTime" : startTime
						  , "endTime" : endTime
						  , "year" : year
						  , "month" : month
						  , "day" : day
						  , "id" : id
						  , "info" : info},
					success : function(data) {
						alert(data.msg);
						if(data.code == 200) {
							location.reload();
						}
					}
					
				});
				
    		});
    		
    	}
    	
    	function closeUserInfo() {
    		
    		$("#closeUserInfo").click(function(){
    			
    			$("#userInfo").hide();
    			
    		});
    		
    	}
    	
    	function cancelBtn() {
    		
    		$("#cancelBtn").click(function(){
    			
    			$("#memo").hide();
    			
    		});
    		
    	}
    	
    	function byeBtn() {
    		
    		$("#byeBtn").click(function(){
    			
    			opener.location.reload();
    			window.close();
    			
    		});
    		
    	}
    	
    	function masterDelete() {
// 				   rv-seq-no2 = "${myList.RV_SEQ_NO}"
// 				   class = "rvSeqNo_ rvSeqNo_${myList.RV_SEQ_NO}"/>
    		$(".rvSeqNo_").mousedown(function(){
    			
    			var rvSeqNo = $(this).attr("rv-seq-no2");
				
    			var input = confirm("정말 취소하시겠습니까?");
    			
				if(input){
					
	    			$.ajax({
	    				
	    				url : "./masterDelete.admin",
	    				type : "post",
	    				data : {"rvSeqNo" : rvSeqNo},
	    				success : function(data) {
	    					alert(data.msg);
	    					if(data.code == 200) {
								location.reload();
							}
	    				}
	    				
	    			});
	    			
	    			return false;
				}
    			
    		});
    		
    	}
    	
    
    </script>
    
    <style>
    
	   	#memo {
			display : none;
			border : 1px solid red;
			position : absolute;
			left : 0; top : 0;
			width : 220px; height : 163px;
			background-color: white;
		}
    
	   	#userInfo {
			display : none;
			border : 1px solid blue;
			position : absolute;
			left : 0; top : 0;
			width : 270px; height : 90px;
			background-color: white;
		}
    
    </style>
    
<body>

	<div id = "userInfo">
		<div>
			<table>
				<tr>
					<td>예약자 &nbsp;&nbsp;</td>
					<td id = "reservationName"></td>
				</tr>
				<tr>
					<td>폰번호 &nbsp;&nbsp;</td>
					<td id = "reservationPhoneNumber"></td>
				</tr>
				<tr>
					<td>이메일 &nbsp;&nbsp;</td>
					<td id = "reservationEmail"></td>
				</tr>
			</table>
			<input type = "button" value = "닫기" id = "closeUserInfo" class = "mini-btn"/>		
		</div>
	</div>

	<div id = "memo">
		<div>
			<table>
				<tr>
					<td>풋살장</td>
					<td>${param.masterName}</td>
				</tr>
				<tr>
					<td>코트</td>
					<td id = "userCourt"></td>
				</tr>
				<tr>
					<td><label>예약자 </label></td>
					<td><input type = "text" id = "reservaionName"/> <br/></td>
				</tr>
				<tr>
					<td><label>폰넘버 </label></td>
					<td><input type = "text" id = "reservationPhone"/> <br/></td>
				</tr>
				<tr>
					<td>시작시간</td>
					<td id = "userStartTime"></td>
				</tr>
				<tr>
					<td>종료시간</td>
					<td id = "userEndTime">3</td>
				</tr>
			</table>
			<input type = "button" value = "입력" id = "inputBtn" class = "mini-btn"/>
			<input type = "button" value = "취소" id = "cancelBtn" class = "mini-btn"/><br/>
			<input type = "hidden" id = "courtName"/>
		</div>
	</div>

	<h3>${param.masterName}</h3>
	
	<table border = "1" id = "reservationInfo" style = "margin:auto;">
		<tr>
			<th width ="20%" style ="text-align: center;">시간/코트</th>
			<c:forEach items="${cntCourt}" var = "cnt">
				<th width ="20%" style ="text-align: center;">${cnt.COURT}</th>
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">오후 12:00</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
					<c:if test="${myList.START_TIME == 12 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>
				<c:if test="${myList.START_TIME != 12 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "12" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">13</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
					<c:if test="${myList.START_TIME == 13 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>
				<c:if test="${myList.START_TIME != 13 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "13" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">14</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
					<c:if test="${myList.START_TIME == 14 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>
				<c:if test="${myList.START_TIME != 14 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "14" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">15</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
<%-- 					${myList.START_TIME} --%>
					<c:if test="${myList.START_TIME == 15 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>
				<c:if test="${myList.START_TIME != 15 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "15" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">16</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
					<c:if test="${myList.START_TIME == 16 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>
				<c:if test="${myList.START_TIME != 16 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "16" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">17</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
					<c:if test="${myList.START_TIME == 17 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>
				<c:if test="${myList.START_TIME != 17 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "17" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">18</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
					<c:if test="${myList.START_TIME == 18 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>
				<c:if test="${myList.START_TIME != 18 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "18" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">19</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
					<c:if test="${myList.START_TIME == 19 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>
				<c:if test="${myList.START_TIME != 19 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "19" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">20</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
					<c:if test="${myList.START_TIME == 20 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>
				<c:if test="${myList.START_TIME != 20 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "20" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">21</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
					<c:if test="${myList.START_TIME == 21 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>
				<c:if test="${myList.START_TIME != 21 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "21" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">22</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
					<c:if test="${myList.START_TIME == 22 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>
				<c:if test="${myList.START_TIME != 22 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "22" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
		<tr>
			<th style ="text-align: center;">23</th>
			<c:forEach items="${cntCourt}" var = "cnt" varStatus="i">
				<c:forEach items ="${myReservation}" var = "myList">
					<c:if test="${myList.START_TIME == 23 && myList.COURT == cnt.COURT}">
						<td rv-seq-no = "${myList.RV_SEQ_NO}" style = "cursor: pointer;">
							<label style = "cursor: pointer;">${myList.ID}</label>
							<input type = "button" 
								   value ="취소" 
								   rv-seq-no2 = "${myList.RV_SEQ_NO}"
								   class = "rvSeqNo_ 
								   			rvSeqNo_${myList.RV_SEQ_NO}
								   			mini-btn"/>
						</td>
						<c:set var="flag" value="true" />
					</c:if>
				</c:forEach>		
				<c:if test="${myList.START_TIME != 23 && myList.COURT != cnt.COURT && flag != true}">
					<td startTime = "23" court-num = "${cnt.COURT}" style = "cursor: pointer;">
					</td>
				</c:if>
				<c:remove var="flag" />
			</c:forEach>
		</tr>
		
	</table> <br/>
	
	<input type = "button" value ="팝업닫기" id = "byeBtn" class = "btn"/>
	
</body>
</html>