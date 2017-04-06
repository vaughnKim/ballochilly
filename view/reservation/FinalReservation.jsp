<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%
	String url = request.getHeader("referer");
	url = url.substring(url.indexOf("/", url.indexOf("http://") + 10));
	System.out.print(url);
	if(url.equals("/calendar.do") ) {
		url = "./addFinalReservation.do";
	} else{
		url = "./addReservation.do";
	}
	request.setAttribute("url" ,url);
%>
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
    #map-canvas, #map_canvas {
    	height: 350px;
      	width: 350px;
    }

    @media print {
    
    
      html, body {
        height: auto;
      }

      #map_canvas {
        height: 650px;
      }
      
    }
    #panel {
       top: 5px;
       background-color: #fff;
       padding: 5px;
     }
     
    </style>
    
<script>

	$(document).ready(function() {
		
		$("#inputLoc").hide();
		fReservation();
		inputLoc();
// 		alert($("#end").text());
		
	});
	
	var directionsDisplay;
    var directionsService = new google.maps.DirectionsService();
    var map;
 
    function initialize() {
    	
	    directionsDisplay = new google.maps.DirectionsRenderer();
		
		if(navigator.geolocation) {
			
			navigator.geolocation.getCurrentPosition (function (pos){
				
				
				lat = pos.coords.latitude;
				lng = pos.coords.longitude;
				
				var geocode = "http://maps.googleapis.com/maps/api/geocode/json?latlng="+lat+","+lng+"&sensor=false";
				var html = "";
				$.ajax({
					 
					url : geocode,
					type : "post",
					success : function(result) {
						
						if(result.status == 'OK') {
							
							var tag = "";
							var reallyAddress = "";
							var address = "";
							var test = "";
							
// 							for(var i = 0 ; i < result.results.length; i++) {
								
								test = result.results[1].formatted_address;
								address = test.substring(test.indexOf("한국", 0));
								
// 								if(address != "") {
									
// 									if(address != reallyAddress) {
										
										
// 									} 
									
// 									reallyAddress = address;
									
// 								}
								
// 							}
							html += "<option value = '" + result.results[0].formatted_address + "'>" + address + "</option>";
							
						}
						
						html += "<option value = '9999'>" + "직접입력하기" +"</option>"
						$("#start").html(html);
					}
					
					 
				});
				
			    var mapOptions = {
			    		
			        zoom:18,
			        mapTypeId: google.maps.MapTypeId.ROADMAP,
			        mapTypeControl: false,
			        center: new google.maps.LatLng(lat, lng)
			        
			    }
			    
			    map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
			    
			    var myIcon = new google.maps.MarkerImage('http://maps.google.com/mapfiles/ms/micons/red-dot.png', null, null, null, new google.maps.Size(40,40));
                var marker = new google.maps.Marker({
                    position: new google.maps.LatLng(lat,lng),
                    map: map,
                    draggable: false,
                    icon: myIcon
                    
                });
                
			    directionsDisplay.setMap(map);
			    
			});
			
		}
		
    }
 
    function calcRoute() {
    	
      	var start = document.getElementById('start').value;
      	var endText = $("#end").text(); 
//       	referer = referer.substring(referer.indexOf("/", referer.indexOf("http://") + 10));
      	var end = endText.substring(endText.indexOf("대한민국", 0));
//       	alert(end);
//         var end = document.getElementById('end').text;
        var mode = document.getElementById('mode').value;
        
        if($("#start > option:selected").val() == "9999") {
			
        	$("#start > option:selected").val($("#inputLoc").val());
			
		}
        
 
        var request = {
            origin:start,
            destination:end,
            travelMode: eval("google.maps.DirectionsTravelMode."+mode)
      };
        
        directionsService.route(request, function(response, status) {
        alert(status);  // 확인용 Alert..미사용시 삭제
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
        }
        
      });
        
    }
 
    google.maps.event.addDomListener(window, 'load', initialize);
	
	
	function inputLoc() {
		
// 		alert(3);
		$("#start").change(function(){
			
// 			alert(2);
    		if($("#start > option:selected").val() == "9999") {
    			
    			$("#inputLoc").show();
    			
    		}
    		
		});
		
	}
	
	function fReservation() {
		
		$("input[type=submit]").click(function(){
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
			
			var RYear = $("#year").val();
			var RMonth = $("#month").val();
			var Rday = $("#day").val();
			
			if((RYear+"-"+RMonth+"-"+Rday)<(toYear+"-"+toMonth+"-"+toDate)){
				alert("선택하신 날짜(지난 날짜)는 예약이 불가능합니다.")
				return false;
			} else{
				var input = confirm("정말 예약하시겠습니까?");
				if(input) {
					$.ajax({
						url : "${url}",
						type : "post",
						data : $("form").serialize(),
						success : function(data) {
							alert(data.msg);
							if(data.code == 200) {
								location.href = "./myReservation.do"; // 여기는 내 예약 정보 만들어지면 그리로 연결
							}	//end if
						}	//end succuess
					});	//end ajax
				} else {
					alert("예약이 취소되었습니다.");
					location.href="./Reservation-location-search.do";
					
				}
				return false;
			} //end else
			
		});
		
	}

</script>
<body>
	<%@include file="../main/topmain.jsp" %>
	<fieldset>
		<legend>최종예약</legend>
		<table border="1" align="center">
			<thead>
				<tr>
					<th width="150px">구장이름</th>
					<th width="150px">코트</th>
					<th width="150px">예약날짜</th>
					<th width="150px">예약시간</th>
				</tr>
			</thead>
			<% 
				String referer = request.getHeader("referer");
				referer = referer.substring(referer.indexOf("/", referer.indexOf("http://") + 10));
				request.setAttribute("referer", referer);
				System.out.println(referer);
			%>
			<tbody>
				<form>
				<c:if test="${referer != '/calendar.do'}">
					<tr>
						<td id="">${param.stadiumName}</td>
						<td>${param.court}</td>
						<td>${param.year}-${param.month}-${param.day}</td>
						<td>${param.start} ~ ${param.end}</td>
					</tr>
				</c:if>
				<c:if test="${referer == '/calendar.do'}">
					<c:forEach var="item" items="${fn:split(param.checkbox, ',')}">
						<c:set var="info" value="${fn:split(item, '&')}" />
						<tr>
							<td>${param.stadiumName}</td>
							<td>${fn:substring(info[0], info[0].indexOf('=') + 1, fn:length(info[0]))}</td> <!-- court=A 를 fn함수로 자른것-->  
							<td>${param.year}-${param.month}-${param.day}</td>
							<td>${fn:substring(info[1], info[1].indexOf('=') + 1, fn:length(info[1]))} ~ ${fn:substring(info[2], info[2].indexOf('=') + 1, fn:length(info[2]))}</td>
						</tr>
					</c:forEach>
					
<%-- 					<c:forEach var="i" begin="1" end="" step="1"> --%>
<!-- 					<tr> -->
<%-- 						<td id="">${param.stadiumName}</td> --%>
<%-- 						<td>${param.court}</td> --%>
<%-- 						<td>${param.year}-${param.month}-${param.day}</td> --%>
<%-- 						<td>${param.start} ~ ${param.end}</td> --%>
<!-- 					</tr> -->
<%-- 					</c:forEach> --%>
				</c:if>
					<tr>
						<td colspan="2" >
							<input type="submit" value="예약" class = "btn"/>
						</td>
						<td colspan="2" >
							<a href = "javascript:history.back()"><input type="button" value="취소" class = "btn"/></a>
						</td>
					</tr>
					
					
					<c:if test="${referer != '/calendar.do'}">
						<input type="hidden" name="year" id="year" value="${param.year}"/>
						<input type="hidden" name="month" id="month" value="${param.month}"/>
						<input type="hidden" name="day" id="day" value="${param.day}"/>
						<input type="hidden" name="startTime" value="${param.start}"/>
						<input type="hidden" name="endTime" value="${param.end}"/>
						<input type="hidden" name="court" value="${param.court}"/>
						<input type="hidden" name="siSeqNo" value="${param.siSeqNo}"/>
						<input type="hidden" name = "id" value = "${user.ID}" />
					</c:if>
					
					<c:if test="${referer == '/calendar.do'}">
						<c:forEach var="item" items="${fn:split(param.checkbox, ',')}">
							<c:set var="info" value="${fn:split(item, '&')}" />
							<input type="hidden" name="year" id="year" value="${param.year}"/>
							<input type="hidden" name="month" id="month" value="${param.month}"/>
							<input type="hidden" name="day" id="day" value="${param.day}"/>
							<input type="hidden" name="startTime" value="${fn:substring(info[1], info[1].indexOf('=') + 1, fn:length(info[1]))}"/>
							<input type="hidden" name="endTime" value="${fn:substring(info[2], info[2].indexOf('=') + 1, fn:length(info[2]))}"/>
							<input type="hidden" name="court" value="${fn:substring(info[0], info[0].indexOf('=') + 1, fn:length(info[0]))}"/>
<%-- 							<input type="hidden" name="siSeqNo" value="${param.siSeqNo}"/> --%>
							<input type="hidden" name = "id" value = "${user.ID}" />
							<input type="hidden" name="stadiumName" value="${param.stadiumName}"/>
						</c:forEach>
					</c:if>
				</form>
			</tbody>
		</table>
		<br/><br/>
		
	</fieldset>
	
	<div class = "row no-text-center">
		<div id="panel">
			<table border = "1">
				<tr>
					<td>현재위치</td>
					<td>
		            	<select id = "start">
		            	</select>
	            	</td>
	            	<td>
		            	<input type = "text" id = "inputLoc" placeholder="대전 x구 x동 xx번지"><br/>
	            	</td>
				</tr>
				<tr>
					<td>풋잘장 위치</td>
					<td colspan = "2">
						<lable id = "end">
							${param.stadiumAddress}
						</lable>
<%-- 						<input type="text" id="end" size = "30" value="${param.stadiumAddress}"/> --%>
					</td>
				</tr>
            	<tr>
            		<td colspan = "3">
						<input type = "hidden" value="TRANSIT" id = "mode"/>
		                <input type="button" value="길찾기" onclick="Javascript:calcRoute();" />
            		</td>
            	</tr>
            </table>
        </div>
        <br/><br/>
        <div id="map-canvas"></div>
	</div>
</body>
</html>