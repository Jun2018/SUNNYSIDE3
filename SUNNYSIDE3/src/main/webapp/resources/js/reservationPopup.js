//예매페이지 onclick="javascript:reservationPage('<c:out value='${vo.movieId}'/>');"
function reservationPage(movieId){
	$("#selectedMovieId").val(movieId);
	
	var pageWidth = 850;				//새창 띄울 페이지 크기
	var pageHeight = 557;
	var xWidth = $("body").width();		//띄우게 만들 페이지 크기
	var xHeight = $("body").height();
	var pX = (xWidth - pageWidth)/2;
	var pY = (xHeight - pageHeight)/2;
	
	if(pX < 0) pX = 450;				//창이 전체화면이 아니여서 x축 계산값이 -나올때 값을 임의조정 
	
	var opt = "width="+pageWidth+", height="+pageHeight+", left="+pX+", top="+pY+", status=0, toolbar=0, location=0, menubar=0, resizable=no";
	var url = "/sunnyside/reservation/reservation_main.jsp";
	var popup = window.open(url, "_blank", opt);
}