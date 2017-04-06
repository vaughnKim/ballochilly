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
    
    	$().ready(function(){
    		
    		test();
    		tmEf();
    		wf();
    		tmn();
    		tmx();
//     		weather();
//     		yukeun();
//     		weatherWidth();
    		
    	});
    	
    	//								tmEf : 날짜
    	//								tmn 최저
    	//								tmx 최고
    	//								wf 날씨
    	
    	var newDate = new Date();
    	var yy = newDate.getFullYear();
    	var mm = newDate.getMonth()+1;
    	var dd = newDate.getDate();
    	var html ="";
    	var tt ="";
    	var tt2 = "";
    	var tt4 = "";
    	var tt5 = "";
    	
    	function test() {
    		
    		$.ajax({
    			
    			url : "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=3017058800",
    			data : "xml",
    			success : function(data) {
    				
    				html = "";
    				html += "<table id = 'myWeather'class='table table-striped table-bordered table-hover text-muted'>";
    				
    				html += "</tr>";
					html += "<tr>";
					html += "<th class = 'text-center'>날짜</th>"
    				
    				$(data).find("data").each(function(){
    					
    					var hour = $(this).find("hour").text();
    					var day = $(this).find("day").text();
    					
    					if(hour == "24"){
    						
	   						var days = $(this).find("day").text();
	   						
	   						if(days == "0") {
	   							days = mm + "/" + dd; 
	   						} else if(days == "1"){
	   							days = mm + "/" + (dd+1); 
	   						} else if(days == "2"){
	   							days = mm + "/" + (dd+2);
	   						}
	   						var tmx = $(this).find("tmx").text();
	   						var tmn = $(this).find("tmn").text();
	   						var temp = $(this).find("temp").text();
	   						var wfKor = $(this).find("wfKor").text();
	   						
   							html += "<td >";
   							html += days;
   							html += "</td>";
//    							html += "<td>";
//    							html += "test";
//    							html += "</td>";
//    							html += "</td>";
   							
    						
    					}
    					
    					
    				});
					
					$.ajax({
			    			
		    			url : "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108",
		    			data : "xml",
		    			success : function(data) {
		    				
		    				$(data).find("location").each(function(){
		    					
		    					var city = $(this).find("city").text();
		    					
		    					if(city == "대전") {
		    						
		    						var days = "";
		   							var days_2 = "";
		   							
		    						$(this).find("data").each(function(){
		    							
		    							var fullDays = $(this).find("tmEf").text()
		    							days = fullDays.substring(fullDays.indexOf("-", 0) + 1, fullDays.indexOf(" ", 0));
		    							var reallyDay = days.split("-");
		    							if(days != days_2) {
		    								html += "<td>";
		    								html += reallyDay[0] + "/" + reallyDay[1];
			    							days_2 = days;
											html += "</td>";
// 			    							alert(tt);
		    							}
		    							
									});
		    						
		    					}
		    					
		    				});
		    				
		    			}
		    			
		    		});  		
					
					
    				html += "</tr>";
					html += "<tr>";
					html += "<th class = 'text-center'>날씨</th>"
					
					$(data).find("data").each(function(){
    					
    					var hour = $(this).find("hour").text();
    					var day = $(this).find("day").text();
    					
    					if(hour == "24"){
    						
	   						var days = $(this).find("day").text();
	   						var tmx = $(this).find("tmx").text();
	   						var tmn = $(this).find("tmn").text();
	   						var temp = $(this).find("temp").text();
	   						var wfKor = $(this).find("wfKor").text();
	   						
    							
   							html += "<td>";
   							
   							if(wfKor == "맑음") {
    							html += "<img src = '/weather/NB01.png' /><br/>";
   							} else if (wfKor == "구름 조금") {
    							html += "<img src = '/weather/NB02.png' /><br/>";
   							} else if (wfKor == "구름 많음") {
    							html += "<img src = '/weather/NB03.png' /><br/>";
   							} else if (wfKor == "흐림") {
    							html += "<img src = '/weather/NB04.png' /><br/>";
   							} else if (wfKor == "구름많고 비") {
    							html += "<img src = '/weather/NB20.png' /><br/>";
   							} else if (wfKor == " 호우") {
    							html += "<img src = '/weather/NB07.png' /><br/>";
   							} else if (wfKor == "비") {
    							html += "<img src = '/weather/DB05.png' /><br/>";
   							}
   							html += wfKor;
   							html += "</td>";
    							
    						
    					}
    					
    					
    				});
					
					html += "</tr>";
					html += "<tr>";
					html += "<th class = 'text-center'>최고기온</th>"
    				
    				$(data).find("data").each(function(){
    					
    					var hour = $(this).find("hour").text();
    					var day = $(this).find("day").text();
    					
    					if(hour == "24"){
    						
	   						var days = $(this).find("day").text();
	   						var tmx = $(this).find("tmx").text();
	   						var tmn = $(this).find("tmn").text();
	   						var temp = $(this).find("temp").text();
	   						var wfKor = $(this).find("wfKor").text();
    							
   							html += "<td>";
   							html += tmx;
   							html += "</td>";
    							
    					}
    					
    					
    				});
    				
    				html += "</tr>";
					html += "<tr>";
					html += "<th class = 'text-center'>최저기온</th>"
    				
    				$(data).find("data").each(function(){
    					
    					var hour = $(this).find("hour").text();
    					var day = $(this).find("day").text();
    					
    					if(hour == "24"){
    						
	   						var days = $(this).find("day").text();
	   						var tmx = $(this).find("tmx").text();
	   						var tmn = $(this).find("tmn").text();
	   						var temp = $(this).find("temp").text();
	   						var wfKor = $(this).find("wfKor").text();
	   						
    							
   							html += "<td>";
   							html += tmn;
   							html += "</td>";
    							
    						
    					}
    					
    					
    				});
    				
    				
    				$("#weekWeather").html(html);
    				
    			}
    			
    			
    		});
    		
    	}
    	
    	function tmEf() {
    		
			$.ajax({
    			
    			url : "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108",
    			data : "xml",
    			success : function(data) {
    				
    				$(data).find("location").each(function(){
    					
    					var city = $(this).find("city").text();
    					
    					if(city == "대전") {
    						
    						var days = "";
   							var days_2 = "";
   							
    						$(this).find("data").each(function(){
    							
    							var fullDays = $(this).find("tmEf").text()
    							days = fullDays.substring(fullDays.indexOf("-", 0) + 1, fullDays.indexOf(" ", 0));
    							var reallyDay = days.split("-");
    							if(days != days_2) {
	    							tt += "<td width = '10%' class = 'text-center'>";
	    							tt += reallyDay[0] + "/" + reallyDay[1];
	    							tt += "</td>";
	    							days_2 = days;
    							}
    							
							});
    						
    					}
    					
    				});
//     				alert(tt);
    				$("#myWeather tr:first td:last-child").after(tt);
    				
    			}
    			
    		});
    		
    	}
    	
    	
    	function wf() {
    		
			$.ajax({
    			
    			url : "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108",
    			data : "xml",
    			success : function(data) {
    				
    				$(data).find("location").each(function(){
    					
    					var city = $(this).find("city").text();
    					
    					if(city == "대전") {
    						
    						var days = "";
   							var days_2 = "";
   							
   							$(this).find("data").each(function(){
    							
	//								tmEf : 날짜
	//								tmn 최저
	//								tmx 최고
	//								wf 날씨
								var fullDays = $(this).find("tmEf").text()
								days = fullDays.substring(fullDays.indexOf("-", 0) + 1, fullDays.indexOf(" ", 0));
								var weather = $(this).find("wf").text();
								if(days != days_2) {
	    							tt2 += "<td width = '10%' class = 'text-center'>";
	    							if(weather == "맑음") {
		    							tt2 += "<img src = '/weather/NB01.png' /><br/>";
	    							} else if (weather == "구름조금") {
		    							tt2 += "<img src = '/weather/NB02.png' /><br/>";
	    							} else if (weather == "구름많음") {
		    							tt2 += "<img src = '/weather/NB03.png' /><br/>";
	    							} else if (weather == "흐림") {
		    							tt2 += "<img src = '/weather/NB04.png' /><br/>";
	    							} else if (weather == "구름많고 비") {
		    							tt2 += "<img src = '/weather/NB20.png' /><br/>";
	    							} else if (weather == " 호우") {
		    							tt2 += "<img src = '/weather/NB07.png' /><br/>";
	    							} else if (weather == "비") {
		    							tt2 += "<img src = '/weather/NB05.png' /><br/>";
	    							}
	    							tt2 += weather;
	    							tt2 += "</td>";
	    							days_2 = days;
								}
							});
    						
    					}
    					
    				});
//     				alert(tt);
    				$("#myWeather tr:eq(1) td:last-child").after(tt2);
    				
    			}
    			
    		});
    		
    		
    	}
    	
    	function tmn() {
    		
			$.ajax({
    			
    			url : "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108",
    			data : "xml",
    			success : function(data) {
    				
    				$(data).find("location").each(function(){
    					
    					var city = $(this).find("city").text();
    					
    					if(city == "대전") {
    						
    						var days = "";
   							var days_2 = "";
   							
   							$(this).find("data").each(function(){
    							
	//								tmEf : 날짜
	//								tmn 최저
	//								tmx 최고
	//								wf 날씨
								var fullDays = $(this).find("tmEf").text()
								days = fullDays.substring(fullDays.indexOf("-", 0) + 1, fullDays.indexOf(" ", 0));
								var tmn = $(this).find("tmn").text();
								if(days != days_2) {
									
									tt4 += "<td width = '10%' class = 'text-center'>";
	    							tt4 += tmn + " 도";
	    							tt4 += "</td>";
	    							days_2 = days;
	    							
								}
								
							});
    						
    					}
    					
    				});
//     				alert(tt);
    				$("#myWeather tr:eq(2) td:last-child").after(tt4);
    				
    			}
    			
    		});
    		
    		
    	}
    	function tmx() {
    		
			$.ajax({
    			
    			url : "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108",
    			data : "xml",
    			success : function(data) {
    				
    				$(data).find("location").each(function(){
    					
    					var city = $(this).find("city").text();
    					
    					if(city == "대전") {
    						
    						var days = "";
   							var days_2 = "";
   							
   							$(this).find("data").each(function(){
    							
	//								tmEf : 날짜
	//								tmn 최저
	//								tmx 최고
	//								wf 날씨
								var fullDays = $(this).find("tmEf").text()
								days = fullDays.substring(fullDays.indexOf("-", 0) + 1, fullDays.indexOf(" ", 0));
								var tmx = $(this).find("tmx").text();
								
								if(days != days_2) {
									
									tt5 += "<td width = '10%' class = 'text-center'>";
	    							tt5 += tmx + " 도";
	    							tt5 += "</td>";
	    							days_2 = days;
	    							
								}
								
							});
    						
    					}
    					
    				});
//     				alert(tt);
    				$("#myWeather tr:eq(3) td:last-child").after(tt5);
    				
    			}
    			
    		});
    		
    		
    	}
    	
    	
    	function weatherWidth() {
    		
			$.ajax({
    			
    			url : "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108",
    			data : "xml",
    			success : function(data) {
    				
    				$(data).find("location").each(function(){
    					
    					var city = $(this).find("city").text();
    					
    					if(city == "대전") {
    						
//     						$("body").append(city + "<br>");
    						
    						var days = "";
   							var days_2 = "";
   							
   							var html = "<table class='table table-striped table-bordered table-hover text-muted'>";
   							html += "<tr>";
   							html += "<th class = 'text-center' width = '10%'>날짜</th>"
    						
    						$(this).find("data").each(function(){
    							
//    								tmEf : 날짜
//    								tmn 최저
//    								tmx 최고
//    								wf 날씨
    							var fullDays = $(this).find("tmEf").text()
    							days = fullDays.substring(fullDays.indexOf("-", 0) + 1, fullDays.indexOf(" ", 0));
    							var reallyDay = days.split("-");
    							if(days != days_2) {
	    							html += "<td width = '10%' class = 'text-center'>";
	    							html += reallyDay[0] + "/" + reallyDay[1];
	    							html += "</td>";
	    							days_2 = days;
    							}
    							
							});
   							html += "</tr>";
   							html += "<tr>";
   							html += "<th class = 'text-center'>날씨</th>"
    						
    						$(this).find("data").each(function(){
    							
//    								tmEf : 날짜
//    								tmn 최저
//    								tmx 최고
//    								wf 날씨
    							var fullDays = $(this).find("tmEf").text()
    							days = fullDays.substring(fullDays.indexOf("-", 0) + 1, fullDays.indexOf(" ", 0));
    							var weather = $(this).find("wf").text();
    							if(days != days_2) {
	    							html += "<td width = '10%' class = 'text-center'>";
	    							if(weather == "맑음") {
		    							html += "<img src = '/weather/NB01.png' /><br/>";
	    							} else if (weather == "구름조금") {
		    							html += "<img src = '/weather/NB02.png' /><br/>";
	    							} else if (weather == "구름많음") {
		    							html += "<img src = '/weather/NB03.png' /><br/>";
	    							} else if (weather == "흐림") {
		    							html += "<img src = '/weather/NB04.png' /><br/>";
	    							} else if (weather == "구름많고 비") {
		    							html += "<img src = '/weather/NB20.png' /><br/>";
	    							} else if (weather == " 호우") {
		    							html += "<img src = '/weather/NB07.png' /><br/>";
	    							} else if (weather == "비") {
		    							html += "<img src = '/weather/NB05.png' /><br/>";
	    							}
	    							html += weather;
	    							html += "</td>";
	    							days_2 = days;
    							}
							});
    						html += "</tr>";
    						html += "<tr>";
    						html += "<th class = 'text-center'>최저기온</th>"
    						
    						$(this).find("data").each(function(){
    							
//    								tmEf : 날짜
//    								tmn 최저
//    								tmx 최고
//    								wf 날씨
    							var fullDays = $(this).find("tmEf").text()
    							days = fullDays.substring(fullDays.indexOf("-", 0) + 1, fullDays.indexOf(" ", 0));
    							var tmn = $(this).find("tmn").text();
    							if(days != days_2) {
    								
    								html += "<td width = '10%' class = 'text-center'>";
	    							html += tmn + " 도";
	    							html += "</td>";
	    							days_2 = days;
	    							
    							}
    							
							});
    						
    						html += "</tr>";
    						html += "<tr>";
    						html += "<th class = 'text-center'>최고기온</th>"
    						
    						$(this).find("data").each(function(){
    							
//    								tmEf : 날짜
//    								tmn 최저
//    								tmx 최고
//    								wf 날씨
    							var fullDays = $(this).find("tmEf").text()
    							days = fullDays.substring(fullDays.indexOf("-", 0) + 1, fullDays.indexOf(" ", 0));
    							var tmx = $(this).find("tmx").text();
    							
								if(days != days_2) {
    								
    								html += "<td width = '10%' class = 'text-center'>";
	    							html += tmx + " 도";
	    							html += "</td>";
	    							days_2 = days;
	    							
    							}
    							
							});
    						
    						html += "</tr>";
    						
    						$("#test").html(html);
    						
    					}
    					
    				});
    				
    			}
    			
    		});
    		
    	}
    	
    	
    	function weatherHeight() {
    		
			$.ajax({
    			
    			url : "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108",
    			data : "xml",
    			success : function(data) {
    				
    				$(data).find("location").each(function(){
    					
    					var city = $(this).find("city").text();
    					
    					if(city == "대전") {
    						
    						$("body").append(city + "<br>");
    						
    						html = "";
    						html += "<table border = 1>";
    						html += "<tr>";
    						html += "<th>날짜</th>";
    						html += "<th>날씨</th>";
    						html += "<th>최저기온</th>";
    						html += "<th>최고기온</th>";
    						html += "</tr>";
    						
    						var days = "";
   							var days_2 = "";
    						
    						$(this).find("data").each(function(){
    							
    							var fullDays = $(this).find("tmEf").text()
    							days = fullDays.substring(fullDays.indexOf("-", 0) + 1, fullDays.indexOf(" ", 0));
    							var weather = $(this).find("wf").text();
    							var tmn = $(this).find("tmn").text();
    							var tmx = $(this).find("tmx").text();
    							
    							html += "<tr>";
    							if(days != days_2) {
	    							html += "<th>"; 
    								html += days;
	   								days_2 = days;
	    							html += "</th>";
	    							html += "<td>";
	    							if(weather == "맑음") {
		    							html += "<img src = '/weather/NB01.png' />";
	    							} else if (weather == "구름조금") {
		    							html += "<img src = '/weather/NB02.png' />";
	    							} else if (weather == "구름많음") {
		    							html += "<img src = '/weather/NB03.png' />";
	    							} else if (weather == "흐림") {
		    							html += "<img src = '/weather/NB04.png' />";
	    							} else if (weather == "구름많고 비") {
		    							html += "<img src = '/weather/NB20.png' />";
	    							} else if (weather == " 호우") {
		    							html += "<img src = '/weather/NB07.png' />";
	    							}
	    							html += "<br>";
	    							html += weather;
	    							html += "</td>";
	    							html += "<td>" + tmn + "</td>";
	    							html += "<td>" + tmx + "</td>";
    							}
    							html += "</tr>";
    							
    						});
    						
    						$("#test").html(html);
    					}
    					
    				});
    				
    			}
    			
    		});
    		
    		
    	}
    	
    	
//     	function test() {
    		
// 			$.ajax({
    			
//     			url : "http://www.kma.go.kr/weather/forecast/mid-term-rss3.jsp?stnId=108",
//     			data : "xml",
//     			success : function(data) {
    				
//     				$(data).find("location").each(function(){
    					
//     					var city = $(this).find("city").text();
    					
//     					if(city == "대전") {
    						
//     						$("body").append(city + "<br>");
    						
//     						$(this).find("data").each(function(){
// //     							tmEf : 날짜
// // 								tmn 최저
// // 								tmx 최고
// // 								wf 날씨
//     							var output = $(this).find("tmEf").text() 
//     										+ " " 
//     										+ $(this).find("wf").text()
//     										+ " "
//     										+ $(this).find("tmn").text()
//     										+ " "
//     										+ $(this).find("tmx").text();;
//     							$("body").append(output + "<br>");
    							
//     						});
//     					}
    					
//     				});
    				
//     			}
    			
//     		});
    		
    		
//     	}
    
    
    
    </script>
    
<body>

	<div id = "test">
	</div>
	
</body>
</html>