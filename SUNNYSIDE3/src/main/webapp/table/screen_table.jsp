<%@page import="kr.co.sunnyside.cmn.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="context" value="${pageContext.request.contextPath }" />
<%
	//영화테이블페이징정보
	int maxNum = 0;
	int currPageNo = 1; 
	int rowPerPage = 10;
	int bottomCount = 10;
	String url = "";
	String scriptName = "paging";
	
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
    	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    	<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>영화편성</title>
		<link href="${context}/resources/css/bootstrap.min.css" rel="stylesheet">
		<link href="${context}/resources/css/jquery-ui.css" rel="stylesheet">
		<link  href="${context}/resources/css/jquery.timepicker.min.css" rel="stylesheet">
		<style type="text/css">
			.case {
				border: 1px solid black;
				padding: 10px;
			}
			.movieValidate {
				position: absolute;
				top: 0;
				left: 0;
				width: 500px;
				height: 400px;
				padding: 15px;
				font-weight: bold;
				text-align: center;
				background-color: white;
				border: 1px solid black;
				z-index: 96;
				display: none;
			}
			.loadingLayer {
				position: absolute;
				width: 200px;
				height: 50px;
				padding: 15px;
				font-weight: bold;
				text-align: center;
				background-color: white;
				border: 1px solid black;
				z-index: 100;
				display: none;
			}
			.dim {
				position: absolute;
				top: 0;
				left: 0;
				width: 100%;
				height: 100%;
				background-color: black;
				opacity: 0.1;
				z-index: 95;
				display: none;
			}
			.selectedMovie {
				display: none;
			}
			.layer-MovieTable {
				position: absolute;
				width: 700px;
				height: 620px;
				display: none;
				background-color: white;
				border: 1px solid black;
				padding: 10px;
				z-index: 20;
			}
			.movieInfo {
				position: absolute;
				width: 500px;
				height: 100%;
				display: none;
				background-color: white;
				border: 1px solid black;
				padding: 10px;
				z-index: 20;
			}
			.movieTable-dim {
				position: absolute;
				top: 0;
				left: 0;
				width: 100%;
				height: 100%;
				background-color: black;
				opacity: 0.1;
				z-index: 10;
				display: none;
			}
		</style>
	</head>
	<body>
		<div class="container">
			<div class="loadingLayer">
				<p>...작업중입니다...</p>
			</div>
			<div class="dim"></div>
			<div class="case">
				<label>지점 현황</label>
				<input type="hidden" id="hd_branchId" value="">
				<input type="hidden" id="hd_branchNm" value="">
				<button id="branchRetrive" class="btn btn-primary btn-xs">지점조회</button>
				<div class="table-responsive">
					<table id="branchTable" class="table table-hover table-bordered">
						<thead class="bg-primary">
							<tr>
								<td hidden="hidden">지점ID</td>
								<td>지점명</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="99">No Data</td>
							</tr>
						</tbody>
					</table>
				</div>
	
				<label>상영관 현황</label>
				<input type="hidden" id="hd_roomId" value="">
				<input type="hidden" id="hd_roomNm" value="">
				<div class="table-responsive">
					<table id="roomTable" class="table table-hover table-bordered">
						<thead class="bg-primary">
							<tr>
								<td hidden="hidden">상영관ID</td>
								<td>상영관명</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="99">지점을 선택해주세요.</td>
							</tr>
						</tbody>
					</table>
				</div>
	
				<label>편성된 영화 현황</label>
				<input type="hidden" id="hd_screenId" value="">
				<div class="table-responsive">
					<table id="planedMovieTable" class="table table-hover table-bordered">
						<thead class="bg-primary">
							<tr>
								<td hidden="hidden">스크린ID</td>
								<td>제목</td>
								<td>상영날짜</td>
								<td>시작시간</td>
								<td>종료시간</td>
								<td>회차</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="99">상영관을 선택해주세요.</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="row">
					<div class="col-md-2">
						<button id="moviePlan" class="btn btn-default">영화추가</button>
					</div>
					<div class="col-md-10 text-right">
						<button id="planDelete" class="btn btn-default">제거</button>
					</div>
				</div>
			</div>	
			<div class="movieTable-dim"></div>	
			<div class="layer-MovieTable">
				<input type="hidden" id="hd_movieId" value="">
				<input type="hidden" id="hd_movieNm" value="">
				<input type="hidden" id="hd_movieRTime" value="">
				<input type="hidden" id="hd_searchDiv" value="">
				<input type="hidden" id="hd_searchWord" value="">
				<div class="row">
					<div class="col-md-2">
						<label>영화</label>
						<button id="movieRetrive" class="btn btn-primary btn-xs">조회</button>
					</div>
					<div class="col-md-10 text-right">
						<select id="searchDiv">
							<option value="10">제목</option>
						</select>
						<input type="text" id="searchWord" value="">
						<button id="searchBtn" class="btn btn-default">검색</button>
					</div>
				</div>
				<div class="table-responsive">
					<table id="movieTable" class="table table-hover table-bordered">
						<thead class="bg-primary">
							<tr>
								<td hidden="hidden">총게시물수</td>
								<td hidden="hidden">영화ID</td>
								<td>제목</td>
								<td>러닝타임</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td colspan="99">...</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="movieTablePaging"></div>
				<div class="row">
					<div class="col-md-1">
						<button id="moviePlan-add" class="btn btn-default">선택</button>
					</div>
					<div class="col-md-11 text-right">
						<button id="moviePlan-info" class="btn btn-default">영화정보</button>
						<button id="moviePlan-cancel" class="btn btn-default">취소</button>
					</div>
				</div>
			</div>
			
			<div class="movieInfo">
				<div id="infoBox"></div>
				<div class="row">
					<div class="col-md-12 text-right">
						<button id="infoExit" class="btn btn-default">확인</button>
					</div>
				</div>
			</div>

			<div class="selectedMovie">
				<hr/>
				<label>선택한 영화</label>
				<table id="selectedMovieTable" class="table table-hover table-bordered">
					<thead class="bg-primary">
						<tr>
							<td>영화ID</td>
							<td>제목</td>
							<td>러닝타임</td>
						</tr>
					</thead>
					<tbody>
					
					</tbody>
				</table>
				<div class="case">
					<h4>상영시간설정</h4>&nbsp;&nbsp;&nbsp;&nbsp;
					<label for="datePicker">시작날짜</label> <input type="text" id="datePicker">
					<label for="timePicker">시작시간</label> <input type="text" id="timePicker">
					<br/>&nbsp;&nbsp;&nbsp;&nbsp;
					<button id="testBtn" class="btn btn-danger">검사</button>
					<br/>&nbsp;&nbsp;&nbsp;&nbsp;
					<label>종료날짜</label> <input type="text" id="endDate" disabled="disabled">
					<label>종료시간</label> <input  type="text" id="endTime" disabled="disabled">
					<br/>
					<h4>가격설정</h4>&nbsp;&nbsp;&nbsp;&nbsp;
					<label for="adultCost">성인가격</label> <input type="text" id="adultCost">
					<label for="studentCost">학생가격</label> <input type="text" id="studentCost">
					<br/>
					<h4>회차</h4>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="text" id="episode" size="1" max="2" min="1"> <label for="episode">회차</label>
					<br/>
					<br/>
					<button id="finalValidateMovie" class="btn btn-default btn-sm">편성</button>
				</div>
			</div>
			
			<div class="movieValidate">
			
			<button id="planBtn" class="btn btn-xs">확인</button>
			<button id="planCancel" class="btn btn-xs">취소</button>
			</div>
		</div>
		<script src="${context}/resources/js/jquery-1.12.4.js"></script>
		<script src="${context}/resources/js/bootstrap.min.js"></script>
		<script src="${context}/resources/js/jquery-ui.js"></script>
		<script src="${context}/resources/js/jquery.timepicker.min.js"></script>
		
		<script type="text/javascript">
    		$(document).ready(function(){
    			//alert("ready");
    		});
    		
    		//로딩
    		function loading(bool){
    			if(bool == true){
    				var width = $(".loadingLayer").width();
        			var height = $(".loadingLayer").height();
        			var outWidth = $("body").width();
        			var outHeight = $(".container").height();
        			
        			$(".loadingLayer").css("top", (outHeight-height)/2);
        			$(".loadingLayer").css("left", (outWidth-width)/2);
        			
        			$(".loadingLayer").css("display", "block");
        			$(".dim").css("display", "block");
    			}else{
    				$(".loadingLayer").css("display", "none");
    				$(".dim").css("display", "none");
    			}
    		}
    		
    		//datepicker 설정
    		$.datepicker.setDefaults({
                dateFormat: 'yy-mm-dd' //Input Display Format 변경
                ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
                ,changeYear: true //콤보박스에서 년 선택 가능
                ,changeMonth: true //콤보박스에서 월 선택 가능                
                ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
                ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
                ,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
                ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
                ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
                ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
                ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
                ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
                ,minDate: "+0D" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                ,maxDate: "+3M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
            });
    		
    		//datePicker 부여
    		$("#datePicker").datepicker();
    		
    		//timepicker 부여
    		$("#timePicker").timepicker({
    		    timeFormat: 'HH:mm',
    		    interval: 1,
    		    minTime: '00:00',
    		    maxTime: '23:59',
    		    defaultTime: '00:00',
    		    startTime: '00:00',
    		    dynamic: true,
    		    dropdown: true,
    		    scrollbar: true
    		});
    		
    		 //datePicker의 초기값을 오늘 날짜로 설정
            $("#datePicker").datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
            
            $("#testBtn").on("click", function(){
            	var runningTime = parseInt($("#hd_movieRTime").val());	//러닝타임
            	var startDate = $("#datePicker").val();		//시작날짜
            	var startTime = $("#timePicker").val();		//시작시간
            	var sDateArr = startDate.split("-");		//날짜분리	
            	var sTimeArr = startTime.split(":");		//시작시간분리

            	var year = parseInt(sDateArr[0]);			//시작 년도
            	var month = parseInt(sDateArr[1]);			//시작 달
            	var day = parseInt(sDateArr[2]);			//시작 날
            	var hour = parseInt(sTimeArr[0]);			//시작 시
            	var minute = parseInt(sTimeArr[1]);			//시작 분

            	var endMinute = eval(runningTime + minute);	//종료 분
            	var plusHour = 0;							//종료시간을 만들어 줄 변수

            	while(endMinute >= 60){
            		endMinute = eval(endMinute-60);
            		plusHour++;
            	}
            	
            	var endHour = eval(hour+plusHour);			//종료 시
            	var plusDay = 0;							//종료날을 만들어 줄 변수
            	while(endHour >= 24){
            		endHour = eval(endHour-24);
            		plusDay++;
            	}
            	
            	var date = new Date(year, month-1, day);
            	date.setDate(date.getDate() + plusDay);
            	
            	var ENDDATE = eval(date.getYear()+1900) + "-" + eval(date.getMonth()+1) + "-" + date.getDate();
            	var ENDTIME = endHour + ":" + endMinute;
            	$("#endDate").val(ENDDATE);
            	$("#endTime").val(ENDTIME);
            });
            
            //지점조회
            $("#branchRetrive").on("click", function(){
            	loading(true);
            	$.ajax({
    				type : "POST",
    				url : "${context}/branchInfo/do_retrieveList.do",
    				dataType : "html",
    				data : {
    				}, 
    				success: function(data){
    					branchArr = JSON.parse(data);
    					if(branchArr.length > 0){
    						$("#branchTable>tbody>tr").detach();
    						for(var i=0 ; i<branchArr.length ; i++){
    							$("#branchTable>tbody").append(
    									"<tr>"+
    									"<td hidden='hidden'>"+branchArr[i].branchId+"</td>"+
    									"<td>"+branchArr[i].branchNm+"</td>"+
    									"</tr>"
    							);
    						}
    					}
        			},
        			complete:function(data){
        				loading(false);
        			},
        			error:function(xhr,status,error){
        				
        			}
        		});
            });

            //지점선택시 상영관조회
            $("#branchTable>tbody").on("click","tr", function(){
            	var tr = $(this);
            	var td = tr.children();
            	$("#branchTable>tbody>tr").css("background-color", "");	//tr색 초기화
    			$(tr).css("background-color", "red");					//선택tr 색표시
    			
            	if(td.eq(1).length == 0)return;
            	
            	$("#hd_screenId").val("");
            	$("#hd_roomId").val("");
            	$("#hd_roomNm").val("");
            	$("#hd_branchId").val(td.eq(0).text());
            	$("#hd_branchNm").val(td.eq(1).text());
            	loading(true);
            	var searchWord = td.eq(0).text();
    			var searchDiv = "10";
            	$.ajax({
    				type : "POST",
    				url : "${context}/room/do_retrieve.do",
    				dataType : "html",
    				data : {
    					"searchWord" : searchWord,
    					"searchDiv" : searchDiv 
    				}, 
    			success: function(data){
    				var roomArr = JSON.parse(data);
    				$("#roomTable>tbody>tr").detach();
    				if(roomArr.length > 0){
    					for(var i=0 ; i< roomArr.length ; i++){
        					$("#roomTable>tbody").append(
        							"<tr>"+
        							"<td hidden='hidden'>"+roomArr[i].roomId+"</td>"+
        							"<td>"+roomArr[i].roomNm+"</td>"+
        							"</tr>");
        				}
    				}else{
    					$("#roomTable>tbody").append(
    						"<tr><td colspan='99'>상영관이 없습니다.</td></tr>");
    				}
    			},
    			complete:function(data){
    				loading(false);
    			},
    			error:function(xhr,status,error){

    			}
    			}); 
            });
            
          	//상영관선택시 편성영화조회
            $("#roomTable>tbody").on("click","tr", function(){
            	var tr = $(this);
            	var td = tr.children();
            	$("#roomTable>tbody>tr").css("background-color", "");	//tr색 초기화
    			$(tr).css("background-color", "red");						//선택tr 색표시
    			
            	if(td.eq(1).length == 0)return;
    			
            	$("#hd_screenId").val("");
            	$("#hd_roomId").val(td.eq(0).text());
            	$("#hd_roomNm").val(td.eq(1).text());
            	var roomId = $("#hd_roomId").val();
            	create_RoomTable(roomId);
            });
          	
          	function create_RoomTable(roomId){
          		loading(true);
            	var searchWord = roomId;
    			var searchDiv = "20";
            	$.ajax({
    				type : "POST",
    				url : "${context}/screenInfo/do_retrieve.do",
    				dataType : "html",
    				data : {
    					"searchWord" : searchWord,
    					"searchDiv" : searchDiv 
    				}, 
    			success: function(data){
    				var plandMovieArr = JSON.parse(data);
    				$("#planedMovieTable>tbody>tr").detach();
    				if(plandMovieArr.length > 0){
    					for(var i=0 ; i< plandMovieArr.length ; i++){
    						var screenDt = plandMovieArr[i].screenDt;
    						var endTime = plandMovieArr[i].endTime;
    						var date = screenDt.split(" ");
    						var eTime = endTime.split(" ");
        					$("#planedMovieTable>tbody").append(
        							"<tr>"+
        							"<td hidden='hidden'>"+plandMovieArr[i].screenId+"</td>"+
        							"<td>"+plandMovieArr[i].korTitle+"("+plandMovieArr[i].engTitle+")</td>"+
        							"<td>"+date[0]+"</td>"+
        							"<td>"+plandMovieArr[i].startTime+"</td>"+
        							"<td>"+eTime[1]+"</td>"+
        							"<td>"+plandMovieArr[i].episode+"</td>"+        							
        							"</tr>");
        				}
    				}else{
    					$("#planedMovieTable>tbody").append(
    						"<tr><td colspan='99'>편성된 영화가 없습니다.</td></tr>");
    				}
    			},
    			complete:function(data){
    				loading(false);
    			},
    			error:function(xhr,status,error){

    			}
    			}); 
          	}
          	
          	//영화추가버튼
          	$("#moviePlan").on("click", function(){
          		var roomId = $("#hd_roomId").val();
          		
          		if(roomId.length == 0){
          			alert("상영관을 선택해주세요.");
          			return;
          		}
          		
   				var width = $(".layer-MovieTable").width();
       			var height = $(".layer-MovieTable").height();
       			var outWidth = $("body").width();
       			var outHeight = $("body").height();
       			
       			$(".layer-MovieTable").css("top", (outHeight/3));
       			$(".layer-MovieTable").css("left", (outWidth-width)/2);

       			$(".movieTable-dim").css("display", "block");
          		$(".layer-MovieTable").css("display", "block");

          	});
          	
          	//편성취소버튼
          	$("#moviePlan-cancel").on("click", function(){
          		$(".layer-MovieTable").css("display", "none");
				$(".movieTable-dim").css("display", "none");
          	});
          	
          	//편성할 영화선택버튼
          	$("#moviePlan-add").on("click", function(){
          		$(".layer-MovieTable").css("display", "none");
				$(".movieTable-dim").css("display", "none");
				
				var movieId = $("#hd_movieId").val();
				var movieNm = $("#hd_movieNm").val();
				var movierunningTime = $("#hd_movieRTime").val();
				
				if(movieId.length == 0){
					alert("편성할 영화를 선택해주세요.");
					return;
				}
				
				$(".selectedMovie").css("display", "block");
				$("#selectedMovieTable>tbody>tr").detach();
				$("#selectedMovieTable>tbody").append(
					"<tr>"+
					"<td>"+movieId+"</td>"+
					"<td>"+movieNm+"</td>"+
					"<td>"+movierunningTime+"</td>"+
					"</tr>"	
				);
          	});
          	
          	//편성할 영화 조회
          	$("#movieRetrive").on("click", function(){
          		$("#hd_searchDiv").val("");		//검색구분 초기화
          		$("#hd_searchWord").val("");	//검색어 초기화
          		movieRerieve();
          	});
          	
          	//전체영화조회
          	function movieRerieve(){
          		loading(true);
            	$.ajax({
    				type : "POST",
    				url : "${context}/screenInfo/do_retrieve_movie.do",
    				dataType : "html",
    				data : {
    					"searchDiv" : $("#hd_searchDiv").val(),
    					"searchWord" : $("#hd_searchWord").val()
    				}, 
    			success: function(data){
    				var movieArr = JSON.parse(data);
    				$("#movieTable>tbody>tr").detach();
    				if(movieArr.length > 0){
    					for(var i=0 ; i< movieArr.length ; i++){
        					$("#movieTable>tbody").append(
        							"<tr>"+
        							"<td hidden='hidden'>"+movieArr[i].totalCnt+"</td>"+
        							"<td hidden='hidden'>"+movieArr[i].movieId+"</td>"+
        							"<td>"+movieArr[i].kortitle+"("+movieArr[i].engtitle+")</td>"+
        							"<td>"+movieArr[i].runningTime+"</td>"+
        							"</tr>"
        					);
        				}
    					var totalCnt = movieArr[0].totalCnt;
    					movieTablePaging(totalCnt, 1, 10, 10, "<%=scriptName%>");
    				}else{
    					$("#movieTable>tbody").append(
    						"<tr><td colspan='99'>영화가 없습니다.</td></tr>");
    				}
    			},
    			complete:function(data){
    				loading(false);
    			},
    			error:function(xhr,status,error){

    			}
    			});
          	}
          	
			//편성된 영화목록 선택시
			$("#planedMovieTable>tbody").on("click","tr", function(){
				var tr = $(this);
			  	var td = tr.children();
				$("#planedMovieTable>tbody>tr").css("background-color", "");	//tr색 초기화
				$(tr).css("background-color", "red");							//선택tr 색표시
				
				$("#hd_screenId").val(td.eq(0).text());
			});
			
			//영화정보버튼
			$("#moviePlan-info").on("click", function(){
				var width = $(".movieInfo").width();
       			var outWidth = $("body").width();
       			
       			$(".movieInfo").css("top", "0px");
       			$(".movieInfo").css("left", (outWidth-width)/2);

          		$(".movieInfo").css("display", "block");
          		
          		var movieId = $("#hd_movieId").val();
          		if(movieId.length != 0){
          			$.ajax({
        				type : "POST",
        				url : "${context}/screening/do_selectOne_movie.do",
        				dataType : "html",
        				data : {
        					"movieId" : movieId
        				}, 
        			success: function(data){
        				var movieVO = JSON.parse(data);
        				$(".movieInfo>#infoBox").detach();
        				$(".movieInfo").append(
        					"<div id='infoBox'>"+
        					"<img alt='poster' src='"+movieVO.poster+"'>"+	
        					"<p>제목 : "+movieVO.kortitle+"("+movieVO.engtitle+")</p>"+
        					"<p>이용가 : "+movieVO.limitage+"</p>"+
        					"<p>감독 : "+movieVO.derector+"</p>"+
        					"<p>출연 : "+movieVO.cast+"</p>"+
        					"<p>개봉일 : "+movieVO.relDate+"</p>"+
        					"<p>러닝타임 : "+movieVO.runningTime+"</p>"+
        					"<p>시놉시스\n"+movieVO.synopsis+"</p>"+
        					"<p>전문가평점 : "+movieVO.expertRate+"</p>"+
        					"<p>관객평점 : "+movieVO.visitorRate+"</p>"+
        					"</div>"
        				);
        			},
        			complete:function(data){
        				loading(false);
        			},
        			error:function(xhr,status,error){

        			}
        			});
          		}else{
          			$(".movieInfo>#infoBox").detach();
          			$(".movieInfo").append("<div id='infoBox'><p>No Data</p></div>");
          		}          		
			});
			
			//영화정보나가기버튼
			$("#infoExit").on("click", function(){
				$(".movieInfo").css("display", "none");
			});

			/** 
				영화테이블 페이징
				maxNum : 총 글수
				currPage : 현재 페이지
				rowPerPage : 한페이지에 보여질 글수
				bottomCount : 바닥에  보여질 페이지수
			*/
			function movieTablePaging(maxNum, currPageNo, rowPerPage, bottomCount, scriptName){
				var maxNum = maxNum;
				var currPageNo = currPageNo;
				var rowPerPage = rowPerPage;
				var bottomCount = bottomCount;
				var maxPageNo = Math.floor(maxNum/rowPerPage);											
				var startPageNo	= eval( (Math.floor( eval(currPageNo-1) /bottomCount)) *bottomCount + 1);
				var endPageNo = (Math.floor( eval(currPageNo-1) /bottomCount)+1) *bottomCount;
				var nowBlockNo = eval( Math.floor( eval(currPageNo-1)/bottomCount) + 1);				
				var maxBlockNo = eval( Math.floor( eval(maxNum-1)/bottomCount) +1);

				$(".movieTablePaging>table").detach();
				
				if(nowBlockNo > 1 && nowBlockNo <= maxBlockNo){
					$(".movieTablePaging").append(
						'<li class="page-item"><a class="page-link" href="#" onclick="javascript:'+scriptName+'(1);">&laquo;</a></td>'
					);
				}
				
				if(startPageNo > bottomCount) {
					$(".movieTablePaging").append(
						'<li class="page-item"><a class="page-link" href="#" onclick="javascript:'+scriptName+'('+eval(startPageNo-1)+');"><</a></td>'
					);
				}
				
				for(var idx=startPageNo ; idx<=maxPageNo && idx<=endPageNo; idx++) {
					$(".movieTablePaging").append(
						'<li class="page-item"><a class="page-link" href="#" onclick="javascript:'+scriptName+'('+idx+');">'+idx+'</a></li>'
					);
				}
				
				if(maxPageNo >= idx) {
					$(".movieTablePaging").append(
						'<li class="page-item"><a class="page-link" href="#" onclick="javascript:'+scriptName+'('+eval((nowBlockNo*bottomCount)+1) +');">></a></td>'
					);
				}
				
				if(maxPageNo >= idx){
					$(".movieTablePaging").append(
						'<li class="page-item"><a class="page-link" href="#" onclick="javascript:'+scriptName+'('+maxPageNo+');">&raquo;</a></td>'
					);
				}

				$(".movieTablePaging").wrapInner(
						'<ul class="pagination"></ul>'
				);
				$(".movieTablePaging").wrapInner(
						'<table border="0" align="center" cellpadding="0" cellspacing="0" width="100%">'+
						'<tr><td align="center"></td></tr></table>'
				);
			}
			
			//페이징
			function paging(idx) {
				loading(true);
				$.ajax({
    				type : "POST",
    				url : "${context}/screenInfo/do_retrieve_movie.do",
    				dataType : "html",
    				data : {
    					"pageNum" : idx,
    					"searchDiv" : $("#hd_searchDiv").val(),
    					"searchWord" : $("#hd_searchWord").val()
    				}, 
    			success: function(data){
    				var movieArr = JSON.parse(data);
    				if(movieArr.length > 0){
    					$("#movieTable>tbody>tr").detach();
    					for(var i=0 ; i< movieArr.length ; i++){
        					$("#movieTable>tbody").append(
        							"<tr>"+
        							"<td hidden='hidden'>"+movieArr[i]+totalCnt+"</td>"+
        							"<td hidden='hidden'>"+movieArr[i].movieId+"</td>"+
        							"<td>"+movieArr[i].kortitle+"("+movieArr[i].engtitle+")</td>"+
        							"<td>"+movieArr[i].runningTime+"</td>"+
        							"</tr>"
        					);
        				}
    					var totalCnt = movieArr[0].totalCnt;
    					movieTablePaging(totalCnt, idx, 10, 10, "<%=scriptName%>");
    				}
    			},
    			complete:function(data){
    				loading(false);
    			},
    			error:function(xhr,status,error){

    			}
    			});
			};
			
			//영화검색버튼
			$("#searchBtn").on("click", function(){
				movieSearch();
			});
			
			//영화검색엔터키인식
			$("#searchWord").keydown(function(key){
				if(key.keyCode == 13){
					movieSearch();
		        }
			});
			
			//영화검색
			function movieSearch(){
				$("#hd_searchDiv").val($("#searchDiv").val());
				$("#hd_searchWord").val($("#searchWord").val());
				movieRerieve();
			}
			
			//영화클릭시
            $("#movieTable>tbody").on("click","tr", function(){
            	var tr = $(this);
            	var td = tr.children();
            	$("#movieTable>tbody>tr").css("background-color", "");	//tr색 초기화
    			$(tr).css("background-color", "red");					//선택tr 색표시

            	if(td.eq(1).length == 0)return;
    			
    			$("#hd_movieId").val(td.eq(1).text());
    			$("#hd_movieNm").val(td.eq(2).text());
    			$("#hd_movieRTime").val(td.eq(3).text());
            });
			
			$("#finalValidateMovie").on("click", function(){
				fianlValidateMovie();
			});
			
			function fianlValidateMovie(){
				var endDate = $("#endDate").val(); 
				var endTime = $("#endTime").val();
				var adultCost = $("#adultCost").val();
				var studentCost = $("#studentCost").val();
				var episode = $("#episode").val();
				var branchId = $("#hd_branchId").val();
				var branchNm = $("#hd_branchNm").val();
				var roomId = $("#hd_roomId").val();
				var roomNm = $("#hd_roomNm").val();
				var movieId = $("#hd_movieId").val();
				var movieNm = $("#hd_movieNm").val();
				var startTime = $("#timePicker").val();
				var startDate = $("#datePicker").val();
				if(branchId.length == 0){ alert("선택한 지점이 없습니다."); return;}
				if(roomId.length == 0){ alert("선택한 상영관이 없습니다."); return;}
				if(movieId.length == 0){ alert("선택한 영화가 없습니다."); return;}
				if(endDate.length == 0 || endTime.length == 0 ){alert("상영시간을 확인해주세요."); return;}
				if(adultCost.length == 0 || studentCost.length == 0){alert("가격을 확인해주세요."); return;}
				if(episode == 0){ alert("회차를 확인해주세요."); return;}
				
				var width = $(".movieValidate").width();
       			var height = $(".movieValidate").height();
       			var outWidth = $("body").width();
       			var outHeight = $("body").height();
       			$(".movieValidate").css("top", (outHeight/3));
       			$(".movieValidate").css("left", (outWidth-width)/2);

				$(".movieValidate>.vali").detach();
				$(".movieValidate").prepend(
					"<div class='vali'>"+
					"<label>지점 : </label>"+branchNm+"<br/>"+
					"<label>상영관 : </label>"+roomNm+"<br/>"+
					"<label>영화 : </label>"+movieNm+"<br/>"+
					"<label>상영시작일 : </label>"+startDate+"<br/>"+
					"<label>상영시간 : </label>"+startTime+"&nbsp;~&nbsp;"+endTime+"<br/>"+
					"<label>상영종료일 : </label>"+endDate+"<br/>"+
					"<label>성인가격 : </label>"+adultCost+"<br/>"+
					"<label>학생가격 : </label>"+studentCost+"<br/>"+
					"<label>회차 : </label>"+episode+"<br/>"+
					"<br/><pre>이대로 편성을 진행합니다.</pre>"+
					"<div>"
				);
				$(".dim").css("display", "block");
				$(".movieValidate").css("display", "block");					
			}
				
				
			$("#planBtn").on("click", function(){
				add_NewScreenMovie();				
			});
			
			function add_NewScreenMovie(){
				loading(true);
				var eDate = $("#endDate").val(); 
				var eTime = $("#endTime").val();
				var adultCost = $("#adultCost").val();
				var studentCost = $("#studentCost").val();
				var episode = $("#episode").val();
				var branchId = $("#hd_branchId").val();
				var roomId = $("#hd_roomId").val();
				var movieId = $("#hd_movieId").val();
				var sTime = $("#timePicker").val();
				var sDate = $("#datePicker").val();
				var startTime = sDate + " " + sTime;
				var endTime = eDate + " " + eTime;
				var screenDt = eDate;
				
				$.ajax({
    				type : "POST",
    				url : "${context}/screenInfo/do_save.do",
    				dataType : "html",
    				data : {
    					"roomId" : roomId,
    					"branchId" : branchId,
    					"movieId" : movieId,
    					"startTime" : startTime,
    					"endTime" : endTime,
    					"screenDt" : screenDt,
    					"adultCost" : adultCost,
    					"studentCost" : studentCost,
    					"episode" : episode
    				}, 
    			success: function(data){
    				var msg = JSON.parse(data);
    				if(msg.msgId == 1){
    					alert("성공");
    				}else{
    					alert("실패");
    				}
    			},
    			complete:function(data){
    				planCancel();
    				selectedMovie_Off();
    				var roomId = $("#hd_roomId").val();
                	create_RoomTable(roomId);
    				loading(false);
    			},
    			error:function(xhr,status,error){

    			}
    			});
			}
			
			function selectedMovie_Off(){
				$("#endDate").val("");
				$("#endTime").val("");
				$("#adultCost").val("");
				$("#studentCost").val("");
				$("#episode").val("");
				$(".selectedMovie").css("display", "none");
				$("#selectedMovieTable>tbody>tr").detach();
			}
			
			$("#planCancel").on("click", function(){
				planCancel();
			});
			
			function planCancel(){
				$(".dim").css("display", "none");
				$(".movieValidate").css("display", "none");
			}
			
			$("#planDelete").on("click", function(){
				var screenId = $("#hd_screenId").val();
				
				if(screenId.length == 0){ alert("선택된 영화가 없습니다."); return;}
				
				if(confirm("선택된 편성영화를 삭제합니까?")==false) return;
				
				delete_Plan(screenId);
			});
			
			function delete_Plan(screenId){
				
				$.ajax({
    				type : "POST",
    				url : "${context}/screenInfo/do_delete.do",
    				dataType : "html",
    				data : {
    					"screenId" : screenId
    				}, 
    			success: function(data){
    				var msg = JSON.parse(data);
    				if(msg.msgId == 1){
    					alert("성공");
    				}else{
    					alert("실패");
    				}
    			},
    			complete:function(data){
    				selectedMovie_Off();
    				var roomId = $("#hd_roomId").val();
                	create_RoomTable(roomId);
    				loading(false);
    			},
    			error:function(xhr,status,error){

    			}
    			});
				
				
			}
			
    	</script>
	</body>
</html>