<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="kr">


    <head>
        <%@include file="../sub/subfile.jsp" %>
        <script src="./js/jquery.form.js"></script>
    </head>
    
    <script>
		
    	$().ready(function(){
    		
    		teamRegister();
    		chkTeamName();
    		inputTeamMemberNum();
    		teamEmblemView();
    		cancel();
    		
    	});
    	
    	var loc = $("#selectTeamLocation > option:selected").val();
    	var age = $("#selectTeamMemberAge > option:selected").val();
		var teamName = $("#teamName").val();
		var teamMemberNum = $("#teamMemberNum").val();
		
		function cancel() {
			
			$("#cancel").click(function(){
				
				location.href = "./teamInfo.do";
				
			});
			
		}
		
		
    	function teamRegister() {
    		
    		$("#success").click(function(){
    		
    			var loc = $("#selectTeamLocation > option:selected").val();
    			$("#teamLocation").val(loc);
    			var age = $("#selectTeamMemberAge > option:selected").val();
    			$("#teamMemberAge").val(age);
				
    			$("form").ajaxSubmit({
					
    				url : "./teamRegister.do",
    				type : "post",
    				success : function(data) {
	    				
//     					alert(data.code);
   						alert(data.msg);
    					if(data.code == 200) {
    						
		    				location.href = "./teamInfo.do";
    						
    					}
	    				
	    			}	//end success
	    			
	    		});	//end ajax
		    		
    			return false;
	    		
    		});	//end success btn
    		
    	}
    	
    	function chkTeamName(){
    		
    		$("#teamName").blur(function(){
    			
    			var teamName = $("#teamName").val();
    			
    			$.ajax({
    				
    				url : "./isExistTeamName.do",
    				type : "post",
    				data : {"teamName" : teamName},
    				success : function(data) {
    					
    					if(data.code == 200) {
	    					$("#chkTeamName").text(data.msg).css("color", "red");
    					} else if (data.code == 201){
	    					$("#chkTeamName").text(data.msg).css("color", "blue");
    					}
    					
    				}	//end success
    				
    			});	//end ajax
    			
    		});	//end blur
    		
    	}	//end chkTeamName
    	
    	function inputTeamMemberNum() {
    		
    		$("#teamMemberNum").blur(function(){
    			
    			var teamMemberNum = $("#teamMemberNum").val();
    			$("#teamMemberNum").val(teamMemberNum);
    			
    			if(teamMemberNum != "") {
    				if(chkNum(teamMemberNum)) {
    					$("#chkNum").text("숫자내요").css("color", "blue");
    				} else {
    					$("#chkNum").text("숫자만넣기").css("color", "red");
    				}
    			}
    		});
    	}
    	
    	
    	// 숫자만 입력 가능하게 설정된 기능
    	function chkNum(str) {
			
			if( typeof(str) == 'string'){
					 
				var size = str.length;
				var tempStr = "";
				for( var i = 0 ; i < size ; i ++){

					if( str[i] >= 0 && str[i] <= 9){
						tempStr += str[i];
					}	//end if

				}	//end for

				return tempStr;

			}	//end if

		}	// end chkEng(str)
		
		function teamEmblemView() {
			
			$("#teamEmblem").change(function(){
				
				$("form").ajaxSubmit({
					url : "./fileUpload.do",
					type : "post",
					success : function(data) {
//	 					alert(data.result);
//	 					console.log(data);
						$("#view").css({"background-image":"url(" + data.fileImage +")" ,
							            "background-size":"100px 100px" ,
							            "border-radius":"100px;"});
					}
				});
			
				return false;
				
			});
			
		}
    
    
    </script>
    
<body>
	<%@include file="../main/topmain.jsp" %>
	<div class="presentation-container">
       	<div class="container">
       		<div class="row">
        		<div class="col-sm-12 wow fadeInLeftBig animated" style="visibility: visible; animation-name: fadeInLeftBig; -webkit-animation-name: fadeInLeftBig;">
            		<h1><span class="violet">팀 등록</span></h1>
            	</div>
           	</div>
       	</div>
	</div>
	<div class = "services-container">
       	<div class = "container">
			<div class="row">
			</div>
			<form enctype="multipart/form-data" accept-charset="utf-8">
				<div class="row">
					<div class="no-text-center panel-heading">
						<table class="table table-striped table-bordered table-hover text-muted no-text-center" style = "width:70%;">
							<tr>
								<td width = "20%">팀명</td>
								<td>
									<input type = "text" name = "teamName" id = "teamName"/>
									<label id = "chkTeamName"></label>
								</td>
							</tr>
							<tr>
								<td>지역</td>
								<td class = "text-left">
								<select id = "selectTeamLocation">
									<option value = "7777" disabled = "disabled" selected = "selected">선택하세요</option>
									<option value = "서구">서구</option>
									<option value = "동구">동구</option>
									<option value = "유성구">유성구</option>
									<option value = "대덕구">대덕구</option>
									<option value = "중구">중구</option>
								</select>
							</td>
							</tr>
							<tr>
								<td>인원수</td>
								<td>
									<input type = "text" size = "3" name = "teamMemberNum" id = "teamMemberNum"/>명
									<label id = "chkNum"></label>
								</td>
							</tr>
							<tr>
								<td>연령층</td>
								<td class = "text-left">
									<select id = "selectTeamMemberAge" >
				    					<option value = "6666" disabled = "disabled" selected = "selected">선택하세요</option>
			    						<option value ="유소년">유소년</option>
			    						<option value ="10대">10대</option>
			    						<option value ="20대">20대</option>
			    						<option value ="30대">30대</option>
			    						<option value ="40대">40대</option>
			    						<option value ="50대">50대</option>
			    						<option value ="60대">60대</option>
			    						<option value ="70대">70대</option>
			    						<option value ="80대">80대</option>
			    					</select>
			    				</td>
							</tr>
							<tr>
								<td>소개</td>
								<td><textarea name = "teamInfo"></textarea></td>
							</tr>
							<tr>
								<td>엠블럼</td>
								<td>
									<label>최적사이즈 100px X 100px</label>
									<input type = "file" name = "teamEmblem" id = "teamEmblem" style="border-radius: 100px;"/>
								</td>
							</tr>
							<tr>
								<td>미리보기</td>
								<td>
									<div id = "view" style = "width:100px; height:100px; border:1px solid wheat; border-radius: 100px;" >
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class ="no-text-center panel-heading text-muted" align="center">
		    		<input type = "hidden" id = "teamLocation" name = "teamLocation" />
		    		<input type = "hidden" id = "teamMemberAge" name = "teamMemberAge" />
		    		<input type = "hidden" id = "id" name = "id" value = "${id}"/>
		    		<input type = "submit" id = "success" value ="등록완료" class = "btn"/>
		    		<input type = "reset" id = "reset" value ="다시입력" class = "btn"/>
		    		<input type = "button" id = "cancel" value ="돌아가기" class = "btn"/>
		    	</div>
	    	</form>
		</div>
	</div>

</body>
</html>