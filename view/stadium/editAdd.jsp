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
		reg();
		getGeoInfo();
		checkBtn();
		
		// 전체 우클릭 금지시키기
		$(document).bind("contextmenu", function(){
			return false;
		});	//end bind
	}); 
	
	// empty infos on typing space 
	function emptyInfo() {
		if($("#address").val() == "") {
			alert("풋살장 주소를 입력해 주세요");
			$("#address").focus(); 
			return false;
		} else if($("#district").val() == "") {
			alert("풋살장이 위치한 구를 입력해 주세요");
			$("#district").focus(); 
			return false;
		} else if($("#lat").val() == "") {
			alert("풋살장 Y좌표를 입력해 주세요");
			$("#lat").focus(); 
			return false;
		} else if($("#lng").val() == "") {
			alert("풋살장 X좌표를 입력해 주세요");
			$("#lng").focus(); 
			return false;
		} else if($("#stadiumName").val() == "") {
			alert("풋살장 이름을 입력해 주세요");
			$("#stadiumName").focus(); 
			return false;
		} else if($("#court").val() == "") {
			alert("풋살장 코트를 입력해 주세요");
			$("#court").focus(); 
			return false;
		} else if($("#file1").val() == "" || $("#file1").val() == undefined) {
			alert("풋살장 대표사진을 올려 주세요");
			$("#file1").focus(); 
			return false;
		} else if($("#file2").val() == "" || $("#file2").val() == undefined) {
			alert("풋살장 약도사진을 올려 주세요");
			$("#file2").focus(); 
			return false;
		} else if($("#file3").val() == "" || $("#file3").val() == undefined) {
			alert("풋살장 요금정보을 올려 주세요");
			$("#file3").focus(); 
			return false;
		} else if($("#file4").val() == "" || $("#file4").val() == undefined) {
			alert("풋살장 기타정보를 올려 주세요");
			$("#file4").focus(); 
			return false;
		} else if($("#info").val() == "") {
			alert("풋살장에 관한 정보를 입력해 주세요");
			$("#info").focus(); 
			return false;
		}
			
	}
	
	function reg() {
		$("input[type=submit]").click(function(){
			emptyInfo();
			$("form").ajaxSubmit({
				url : "./editAdd.do",
				type : "post",
				success : function(result){
					if(result.code == 200) {
						alert(result.msg);
						location.assign("./allStadiumList.do");
					}
				}
			});
			return false;
		});	
	}
	
	function getGeoInfo() {
		$("input[name=searchBtn]").click(function() {
			var search=$("input[name=search]").val();
			$.ajax({
				url : "http://maps.googleapis.com/maps/api/geocode/json",
				type : "get",
				data : {"address" : search, "sensor" : "false"},
				success : function(result){
 					console.log(result);
					var html ="";
					html += "<select>";
					for(var i in result.results) {
						var postLen = result.results[i].address_components.length;
						// 공백을 인식하게 하려면 늘 항상 "" 앞에 ' 홋따옴표를 꼭 넣는다
						html += "<option address = '" + result.results[i].formatted_address 
								   + "' long_name = " + result.results[i].address_components[postLen - 1].long_name 
								   + " lat = " + result.results[i].geometry.location.lat 
								   + " lng = " + result.results[i].geometry.location.lng 
								 +  ">" 
							 + result.results[i].formatted_address + " / "
							 + result.results[i].address_components[postLen - 1].long_name + " / "
							 + result.results[i].geometry.location.lat  + " / "
							 + result.results[i].geometry.location.lng
							 + "</option>"; 
					} // end for
						html += "</select>";
						html += "<input type='button' value='선택' name='choice' onclick='checkBtn()'/>";
						console.log(html);
						// HTML 함수는 추가되는 게 아니고 덮어 쓸 수 있음
						$("#display").html(html);
// 						$(html).appendTo($("select[name=op]"));
				} //end success
			}); // end ajax
		}); //end click function
	}
	
	function checkBtn() {
		var address = $("option:selected").attr("address");
		var district = $("option:selected").attr("address").substring(11,14);
 		var lat = $("option:selected").attr("lat");
 		var lng = $("option:selected").attr("lng");

//  		$("input[name=address]").val(address+ "번지");
 		$("input[name=address]").val(address);
		$("input[name=district]").val(district);
		$("input[name=lat]").val(lat);
		$("input[name=lng]").val(lng);
	};	
</script>	
    
    <body>
    <!-- Top menu -->
    <%@include file="../main/topmain.jsp" %>
    <div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1>경기장 수정</h1>
            	</div>
           	</div>
       	</div>
	</div>
	<form method="post" action="editAdd.do" enctype="multipart/form-data">
	<div class = "services-container">
		<div class = "container">
			<div class="row">
				<div class="no-text-center panel-heading">
					<table class="table table-striped table-bordered table-hover text-muted no-text-center" style = "width:70%;">
						<tr>
							<td>주소검색</td>
							<td><input type="text" name="search" placeholder="번지, 도로명을 입력해 주세요" id="search"/>
							    <input type="button" value="검색" name="searchBtn"/>
							    <input type="hidden" name="siSeqNo" value="${stadiumInfo[0].SI_SEQ_NO}"> 
							</td>
						</tr>
						<tr>
							<td>검색결과</td>
							<td><div id="display"></div></td>
						</tr>
						<tr>
							<td>주소</td>
							<td>
								<input type="text" name="address" id="address" value="${stadiumInfo[0].ADDRESS}">
							</td>
						</tr>
						<tr>
							<td>구</td>
							<td><input type="text" name="district" id="district" value="${stadiumInfo[0].DISTRICT}"></td>
						</tr>
						<tr>
							<td>Y좌표</td>
							<td><input type="text" name="lat" id="lat"  value="${stadiumInfo[0].LAT}"></td>
						</tr>
						<tr>
							<td>X좌표</td>
							<td><input type="text" name="lng" id="lng"  value="${stadiumInfo[0].LNG}"></td>
						</tr>
						<tr>
							<td>풋살장 이름</td>
							<td><input type="text" name="stadiumName" id="stadiumName"  value="${stadiumInfo[0].STADIUM_NAME}"></td>
						</tr>
						<tr>
							<td>코트</td>
							<td><input type="text" name="court" id="court" value="${stadiumInfo[0].COURT}"></td>
						</tr>
						<tr>
							<td>구장대표사진</td>
							<td>
								<input type="file" name="file1" id="file1" >
								<img src="StadiumImage/${stadiumInfo[0].STADIUM_TITLE}" width="200px" height="100px">
							</td>
						</tr>
						<tr>
							<td>약도</td>
							<td>
								<input type="file" name="file2" id="file2">
								<img src="StadiumImage/${stadiumInfo[0].MAP}" width="200px" height="100px">
							</td>
						</tr>
						<tr>
							<td>요금</td>
							<td>
								<input type="file" name="file3" id="file3" >
								<img src="StadiumImage/${stadiumInfo[0].FARE}" width="200px" height="100px">
							</td>
						</tr>
						<tr>
							<td>기타사진</td>
							<td>
								<input type="file" name="file4" multiple id="file4">
								<c:forEach var="photos" items="${stadiumGalery}">
									<img src="StadiumImage/${photos.PHOTO}" width="200px" height="100px">
								</c:forEach>
							</td>
						</tr>
						<tr>
							<td>시설정보</td>
							<td> <textarea name="info" cols="50" rows="5" id="info">${stadiumInfo[0].INFO}</textarea></td>
						</tr>
					</table>
					<div class ="no-text-center panel-heading text-muted" align="center">
						<input type="submit" id="register" value="수정" class="L_Btn"/>
<!-- 						<input type="button" value="취소" onclick="location.reload()" class="L_Btn"/> -->
						<input type="button" value="취소" onclick="location.href='./eachStadiumInfo.do?stadiumName=${stadiumInfo[0].STADIUM_NAME}'" class="L_Btn"/>
					</div>
				</div>
			</div>
		</div>
	</div>
	</form>
	</body>
</html>