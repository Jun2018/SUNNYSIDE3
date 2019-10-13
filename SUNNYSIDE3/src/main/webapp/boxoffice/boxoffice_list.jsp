<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.sunnyside.movie.service.LHJ_MovieVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="context" value="${pageContext.request.contextPath }" />
<%

	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->

<!------ Include the above in your HEAD tag ---------->
<link href="${context}/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="../resources/css/movie_list.css" rel="stylesheet" type="text/css"> 

<!-- IE8 에서 HTML5 요소와 미디어 쿼리를 위한 HTML5 shim 와 Respond.js -->
<!-- WARNING: Respond.js 는 당신이 file:// 을 통해 페이지를 볼 때는 동작하지 않습니다. -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body>

	<div class="container ">
	<!-- div title --> 
	<div class="page-header">
		<h1>박스오피스</h1>
	</div>
	<!--// div title -->
	
	<div class="container_inner default_template_holder clearfix page_container_inner"><div class="vc_row wpb_row section vc_row-fluid" style=" padding-top:0px; text-align:left;"><div class=" full_section_inner clearfix"><div class="vc_col-sm-12 wpb_column vc_column_container"><div class="wpb_wrapper"><div class="projects_holder_outer v3 portfolio_with_space portfolio_standard "><div class="projects_holder clearfix v3 standard">
		<c:choose>
			<c:when test="${list.size()>0}">
				<c:forEach var="vo" items="${list}">					
					<article class="mix mix_all" style="display: inline-block; opacity: 1; ">
						<!-- 포스터 영역 -->
						<div class="image_holder">			
							<!-- 이미지  -->
							<span class="image">
								<img width="110" height="82" src="<c:out value='${vo.poster}'/>" alt="영화포스터">
							</span>
							<!--// 이미지  -->			
							<!-- 예매하기, 상세보기 버튼 -->
							<span class="text_holder"><span class="text_outer"><span class="text_inner"><span class="feature_holder"><span class="feature_holder_icons">
								<a class="lightbox qbutton small white" href="#">예매하기</a>
								<a class="lightbox qbutton small white" href="#">상세보기</a>
							</span></span></span></span></span>			
							<!--// 예매하기, 상세보기 버튼 -->			
						</div>
						<!--// 포스터 영역 -->
						
						<!-- 영화정보 영역 -->		
						<div class="portfolio_description ">
							<!-- 영화제목 -->
							<h5 class="portfolio_title">
								<a href="#"><c:out value="${vo.kortitle}"/></a>
							</h5>
							<!--// 영화제목 -->
							<!-- 영화정보 -->
							<span class="project_category">관람 평점 <c:out value="${vo.visitorRate}"/></span>
							<!--// 영화정보 -->
						</div>
						<!--// 영화정보 영역 -->
					</article>	
				</c:forEach>        			
			</c:when>        	
			<c:otherwise>
				<h1>데이터가 없습니다.</h1>
			</c:otherwise>
		</c:choose>
		
	</div></div></div></div></div></div></div></div>
</body>
</html>