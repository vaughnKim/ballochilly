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
    $(document).ready(function() {
    	
    	
        $( "#location").change( function(){
            var district = $( "#location > option:selected" ).val();
           
           var html = '<option value="999" selected="selected" disabled="disabled">구장을 선택해 주세요.</option>';
                 
                 $.ajax({
                       url : "./MainSimpleReservation.do" ,
                       type : "post",
                       data : { "district" : district},
                       success : function(data){
                         for ( var i = 0 ; i < data.Simple.length ; i++) {
                             html += '<option>' + data.Simple[i].STADIUM_NAME +'</option>' ;
                      	 }
                         $("#stadium").html(html);
                 	   }
                 
				});
    	});
        
        $("#stadium").change(function(){
        	var selectStadium = $("#stadium > option:selected").val();
        	var html = "";
        	
			$.ajax({
                url : "./MainSimpleReservation.do" ,
                type : "post",
                data : {"stadiumName" : selectStadium},
                success : function(data){
//                 	alert(data.courtNo);
//                 	alert(selectStadium);
//                 	alert(data.court[0].COURT);
//                 	alert(data.court[0].ADDRESS);
                	html += '<input type="hidden" name="stadiumName" value="'+ selectStadium +'"/>';
                	html += '<input type="hidden" name="courtNo" value="'+ data.courtNo +'"/>';
                	html += '<input type="hidden" name="stadiumAddress" value="'+ data.court[0].ADDRESS +'"/>';
                	for(var j = 0; j < data.courtNo; j++){
	                	html +='<input type="hidden" name="court" value="'+data.court[j].COURT+'"/>';
                	}
                	$("#locationform").html(html);
                }
          	   });
        });
        
        $("#Reservation_Btn2").click(function(){
			$("form")[1].action = "./calendar.do";
			$("form")[1].submit();
			
			return false;
		});
    	
    	
		$("#Reservation_Btn").click(function(){//예약가능 구장 검색 버튼 함수
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
			$("#endTime").val(endTime)
			
			$("form")[0].action = "./Reservation-date-search.do";
			$("form")[0].submit();

			return false;
		});
		
		
// 		$("#Reservation_Btn3").click(function(){
// 			var today = new Date();
// 			var toYear = today.getFullYear();
// 			var toMonth = today.getMonth()+1;
// 			if(toMonth < 10) {
// 				toMonth = "0"+toMonth;
// 			}
// 			var toDate = today.getDate();
// 			if(toDate < 10) {
// 				toDate = "0"+toDate;
// 			}
// 			var hour = today.getHours();
// 			var reservationDate = $("#reservationDate2").val();
				
// 			var startTime2 = $("#sTime2 > option:selected").val();
// 			var endTime2 = $("#eTime2 > option:selected").val();
// 			if(reservationDate == "") {
// 				alert("날짜를 선택해주세요.")
// 				return false;
// 			}else if(reservationDate < (toYear+"-"+toMonth+"-"+toDate)) {
// 				alert("지난 날짜는 선택할 수 없습니다.");
// 				return false;
// 			}else if(startTime2 == "999") {
// 				alert("시작시간을 선택해주세요.");
// 				return false;
// 			} else if(endTime2 == "888"){
// 				alert("종료시간을 선택해주세요.");
// 				return false;
// 			}else if(startTime2 >= endTime2){
// 				alert("시간선택이 잘못되었습니다.");
// 				return false;
// 			}else if(reservationDate == (toYear+"-"+toMonth+"-"+toDate)){
// 				if(startTime2 <= hour){
// 					alert("지난 시작시간은 선택할 수 없습니다.");
// 					return false;
						
// 				} 
// 			}
// 			var startTime = $("#sTime2 > option:selected").val();
// 			var endTime = $("#eTime2 > option:selected").val();
// 			var date = reservationDate.split("-");
// 			var year = date[0];
// 			var month = date[1];
// 			var day = date[2];
			
			
// 			$("#year2").val(year);
// 			$("#month2").val(month);
// 			$("#day2").val(day);
// 			$("#startTime2").val(startTime);
// 			$("#endTime2").val(endTime);
// 			$("#endTime2").val(endTime)
			
// 			$("form")[2].action = "./FinalReservation.do";
// 			$("form")[2].submit();

// 			return false;
// 		});
		
//         $( "#location2").change( function(){
//             alert("3");
//             var district = $( "#location2 > option:selected" ).val();
           
//            var html = '<option value="999" selected="selected" disabled="disabled">구장을 선택해 주세요.</option>';
                 
//                  $.ajax({
//                        url : "./MainSimpleReservation.do" ,
//                        type : "post",
//                        data : { "district" : district},
//                        success : function(data){
//                          for ( var i = 0 ; i < data.Simple.length ; i++) {
//                              html += '<option>' + data.Simple[i].STADIUM_NAME +'</option>' ;
//                       	 }
//                          $("#stadium2").html(html);
//                  	   }
                 
// 				});
//     	});
        
//         $("#stadium2").change(function(){
//         	var selectStadium = $("#stadium2 > option:selected").val();
//         	var html = "";
        	
// 			$.ajax({
//                 url : "./MainSimpleReservation.do" ,
//                 type : "post",
//                 data : {"stadiumName" : selectStadium},
//                 success : function(data){
//                 	alert(data.courtNo);
//                 	alert(selectStadium);
//                 	alert(data.court[0].COURT);
//                 	alert(data.court[0].ADDRESS);
//                 	html += '<input type="hidden" name="stadiumName" value="'+ selectStadium +'"/>';
//                 	html += '<input type="hidden" name="courtNo" value="'+ data.courtNo +'"/>';
//                 	html += '<input type="hidden" name="stadiumAddress" value="'+ data.court[0].ADDRESS +'"/>';
//                 	$("#fastForm").html(html);
                	
//                 	for ( var i = 0 ; i < data.courtNo ; i++) {
//                         html += '<option>' + data.court[i].COURT +'</option>' ;
//                  	 }
//                 	$("#selectCourt").html(html);
//                 }
//           	   });
//         });
        
//         $("#selectCourt").change(function(){
//         	var selectCourt = $("#selectCourt > option:selected").val();
//         	var html="";
//         	html += '<input type="hidden" name="court" value="'+ selectCourt +'"/>';
//         	$("#fastForm").html(html);
//         });
		
	});
    </script>
    
    <style>
    	
   	.content {

		padding:5em;
		border:3px solid red;

	}
	
	#tab input:nth-of-type(1):checked ~ label:nth-of-type(1), label[for=tab1]:hover {   
	
		background-color: dodgerblue;
		color:#ffffff;

	}

	#tab input:nth-of-type(2):checked ~ label:nth-of-type(2), label[for=tab2]:hover {    

		background-color: darkslateblue;
		color:#ffffff;

	}
	

	#tab1, .tab1_content, 
	#tab2, .tab2_content{

 		display:none; 

	}

	#tab input:nth-of-type(1):checked ~ div:nth-of-type(1),
  	#tab input:nth-of-type(2):checked ~ div:nth-of-type(2){

		display : block;

	}

	#tab input:nth-of-type(1):checked ~ .content{

		 border-color : dodgerblue;

	}

	#tab input:nth-of-type(2):checked ~ .content{

		 border-color : darkslateblue;

	}
	
	
	.test2 {
	
		display: inline-block;
		max-width: 50%;
		margin-bottom: 0px;
		font-weight: 350;
		font-size: 20px;
	
	}

    </style>
    
<body>
	<div class="presentation-container">
       	<div class="container" style="padding:0px; width:400px;">
           	<div id="tab">
	           	<input type="radio" id="tab1" name="tab" checked/>
				<input type="radio" id="tab2" name="tab" />
<!-- 				<input type="radio" id="tab3" name="tab" /> -->
				
				<label for="tab1" class = "test2" style ="cursor: pointer;">&nbsp;날짜 / 시간별 예약&nbsp;</label>
				<label for="tab2" class = "test2" style ="cursor: pointer;">&nbsp;지역 / 구장별 예약&nbsp;</label>
<!-- 				<label for="tab3" class = "test">간편 빠른 예약</label> -->
				
	           	<div class ="tab1_content content" style="padding:0px;">
					<div class="col-sm-12 wow" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
	            		<h4>날짜/시간별 예약</h4>
	            	</div>
		           	<div class="row" style="margin:0px;">
		           		<table class="table table-striped table-bordered table-hover text-muted" style="width: 300; height: 200;">
		           			<form method="post">
								<input type="hidden" name="year" id="year"/>
								<input type="hidden" name="month" id="month"/>
								<input type="hidden" name="day" id="day"/>
								<input type="hidden" name="startTime" id="startTime"/>
								<input type="hidden" name="endTime" id="endTime"/>
							</form>
			           		<tr>
			           			<th class = "text-center" width = "30%">예약 일자</th>
			           			<td>
			           				<input type="date" name="reservationDate"  id="reservationDate" style="line-height:15px;"/>
			           			</td>
			           		</tr>
				           	<tr>
				           		<th class = "text-center" width = "30%">시작 시간</th>
				           		<td>
			           				<select name="startTime" id="sTime">
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
			           				</select> 
			           			</td>
				           	</tr>
				           	<tr>
				           		<th class = "text-center" width = "30%">종료 시간</th>
				           		<td>
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
			           				</select> 
			           			</td>
				           	</tr>
				           	
			           	</table>
			           	<a href=""><img alt="" src="mainImg/Reservation_Btn.png" id="Reservation_Btn"></a>
			        </div>
				 </div>
				 
				 <div class ="tab2_content content" style="padding:0px;">
				 	<div class="col-sm-12 wow " style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
	            		<h4>지역/구장별 예약</h4>
	            	</div>
	            	<div class="row" style="margin:0px;">
						<table class="table table-striped table-bordered table-hover text-muted">
							<form id="locationform" method="post">
<!-- 							여기에 들어갈 hidden값들은 script에 cange함수에 ajax의 success에서 html로 찍어줌 -->
<!-- 							마지막에 함수 끝에 return fales;를 써줘야 이 폼에 해당하는 img버튼의 submit이 작동했음 -->
							</form>
							<tr>
					           		<th class = "text-center" width = "30%">지역 선택</th>
					           		<td>
				           				<select name="location" id="location">
				           					<option value="999" selected="selected" disabled="disabled">지역을 선택해 주세요.</option>
											<option value="대덕구">대덕구</option>
											<option value="동구">동구</option>
											<option value="서구">서구</option>
											<option value="유성구">유성구</option>
											<option value="중구">중구</option>
				           				</select> 
				           			</td>
					           	</tr>
							<tr>
				           		<th class = "text-center" width = "30%">구장 선택</th>
				           		<td>
			           				<select name="stadium" id="stadium">
			           					
			           				</select> 
			           			</td>
				           	</tr>
						</table>
					</div>
					<a href=""><img alt="" src="mainImg/Reservation_Btn.png" id="Reservation_Btn2"></a>
				 </div>
<!-- 				 <div class ="tab3_content content"> -->
<!-- 				 	<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;"> -->
<!-- 	            		<h1>간편 빠른 예약</h1> -->
<!-- 	            	</div> -->
<!-- 		           	<div class="row"> -->
<!-- 		           		<table class="table table-striped table-bordered table-hover text-muted"> -->
<!-- 		           			<form method="post" id="fastForm"> -->
<!-- 								<input type="hidden" name="year" id="year2"/> -->
<!-- 								<input type="hidden" name="month" id="month2"/> -->
<!-- 								<input type="hidden" name="day" id="day2"/> -->
<!-- 								<input type="hidden" name="start" id="startTime2"/> -->
<!-- 								<input type="hidden" name="end" id="endTime2"/> -->
<!-- 							</form> -->
<!-- 			           		<tr> -->
<!-- 			           			<th class = "text-center" width = "30%">예약 일자</th> -->
<!-- 			           			<td> -->
<!-- 			           				<input type="date" name="reservationDate"  id="reservationDate2"/> -->
<!-- 			           			</td> -->
<!-- 			           		</tr> -->
<!-- 				           	<tr> -->
<!-- 				           		<th class = "text-center" width = "30%">시작 시간</th> -->
<!-- 				           		<td> -->
<!-- 			           				<select name="startTime" id="sTime2"> -->
<!-- 			           					<option value="999" selected="selected" disabled="disabled">시작시간 선택</option> -->
<!-- 										<option value="06">오전 06:00~</option> -->
<!-- 										<option value="12">주간 12:00</option> -->
<!-- 										<option value="13">13:00</option> -->
<!-- 										<option value="14">14:00</option> -->
<!-- 										<option value="15">15:00</option> -->
<!-- 										<option value="16">16:00</option> -->
<!-- 										<option value="17">17:00</option> -->
<!-- 										<option value="18">야간18:00</option> -->
<!-- 										<option value="19">19:00</option> -->
<!-- 										<option value="20">20:00</option> -->
<!-- 										<option value="21">21:00</option> -->
<!-- 										<option value="22">22:00</option> -->
<!-- 										<option value="23">23:00</option> -->
<!-- 			           				</select>  -->
<!-- 			           			</td> -->
<!-- 				           	</tr> -->
<!-- 				           	<tr> -->
<!-- 				           		<th class = "text-center" width = "30%">종료 시간</th> -->
<!-- 				           		<td> -->
<!-- 			           				<select name="endTime" id="eTime2"> -->
<!-- 			           					<option value="888" selected="selected" disabled="disabled">종료시간 선택</option> -->
<!-- 										<option value="07">오전 07:00~</option> -->
<!-- 										<option value="12">주간 12:00</option> -->
<!-- 										<option value="13">13:00</option> -->
<!-- 										<option value="14">14:00</option> -->
<!-- 										<option value="15">15:00</option> -->
<!-- 										<option value="16">16:00</option> -->
<!-- 										<option value="17">17:00</option> -->
<!-- 										<option value="18">야간18.00</option> -->
<!-- 										<option value="19">19:00</option> -->
<!-- 										<option value="20">20:00</option> -->
<!-- 										<option value="21">21:00</option> -->
<!-- 										<option value="22">22:00</option> -->
<!-- 										<option value="23">23:00</option> -->
<!-- 										<option value="24">24:00</option> -->
<!-- 			           				</select>  -->
<!-- 			           			</td> -->
<!-- 				           	</tr> -->
<!-- 				           	<tr> -->
<!-- 				           		<th class = "text-center" width = "30%">지역 선택</th> -->
<!-- 				           		<td> -->
<!-- 			           				<select name="location" id="location2"> -->
<!-- 			           					<option value="999" selected="selected" disabled="disabled">지역을 선택해 주세요.</option> -->
<!-- 										<option value="대덕구">대덕구</option> -->
<!-- 										<option value="동구">동구</option> -->
<!-- 										<option value="서구">서구</option> -->
<!-- 										<option value="유성구">유성구</option> -->
<!-- 										<option value="중구">중구</option> -->
<!-- 			           				</select>  -->
<!-- 			           			</td> -->
<!-- 				           	</tr> -->
<!-- 							<tr> -->
<!-- 				           		<th class = "text-center" width = "30%">구장 선택</th> -->
<!-- 				           		<td> -->
<!-- 			           				<select name="stadium" id="stadium2"> -->
			           					
<!-- 			           				</select>  -->
<!-- 			           			</td> -->
<!-- 				           	</tr> -->
<!-- 							<tr> -->
<!-- 				           		<th class = "text-center" width = "30%">코트 선택</th> -->
<!-- 				           		<td> -->
<!-- 			           				<select name="selectCourt" id="selectCourt"> -->
			           					
<!-- 			           				</select>  -->
<!-- 			           			</td> -->
<!-- 				           	</tr> -->
<!-- 				    	</table> -->
<!-- 					</div> -->
<!-- 			    	<a href=""><img alt="" src="mainImg/Reservation_Btn.png" id="Reservation_Btn3"></a> -->
<!-- 				</div> -->
<!-- 			위에 div가 tab end -->
	       	</div>
		</div>
	</div>
</body>
</html>