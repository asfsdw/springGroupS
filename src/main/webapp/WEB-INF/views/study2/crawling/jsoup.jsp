<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>jsoup</title>
	<script>
		'use strict';
		
		// 스크롤 동작.
		$(window).scroll(function(){
			if($(this).scrollTop() > 100) $("#topBtn").addClass("on");
			else $("#topBtn").removeClass("on");
			
			$("#topBtn").click(function(){
				window.scrollTo({top:0, behavior: "smooth"});
			});
		});
		
		function crawling1() {
			let url = $("#url").val();
			let selector = $("#selector").val();
			
			$.ajax({
				url : "${ctp}/study2/crawling/Jsoup",
				type: "post",
				data: {
					"url" : url,
					"selector" : selector
				},
				success : (res) => {
					if(res != "") {
						let str = "";
						console.log(res);
						for(let i=0; i<res.length; i++) {
							str += res[i]+"<br>";
						}
						
						$("#demo").html(str);
					}
					else $("#demo").html("검색된 자료가 없습니다.");
				},
				error : () => alert("전송오류")
			});
		}
		
		function crawling2() {
			let url = "https://news.naver.com/";
			
			$.ajax({
				url : "${ctp}/study2/crawling/Jsoup2",
				type: "post",
				data: {
					"url" : url,
					"item1" : "strong.cnf_news_title",
					"item2" : "div.cnf_news_thumb",
					"item3" : "em.cnf_journal_name"
				},
				success : (res) => {
					let str = "";
					if(res != "") {
						str += '<table class="table table-bordered text-center">';
						str += '<tr class="table-secondary"><th>번호</th><th>언론사</th><th>사진</th><th>제목</th></tr>';
						for(let i=0; i<res.length; i++) {
							str += '<tr><td>'+i+'</td><td>'+res[i].item1+'</td><td>'+res[i].item2+'</td><td>'+res[i].item3+'</td></tr>';
						}
						str += '</table>';
						
						$("#demo").html(str);
					}
					else $("#demo").html("검색된 자료가 없습니다.");
				},
				error : () => alert("전송오류")
			});
		}
	</script>
	<style>
		h6 {
			position: fixed;
			right: 1rem;
			bottom: -50px;
			transition: 0.7s ease;
		}
		.on {
			opacity: 0.8;
			cursor: pointer;
			bottom: 0;
		}
	</style>
</head>
<body>
	<div class="container text-center">
		<h2>Crawling 연습</h2>
		<hr/>
		<div>크롤링할 웹 주소</div>
		<div class="input-group">
			<select id="url" name="url" class="form-control">
				<option value="">URL 선택</option>
				<option value="https://news.naver.com/">네이버 뉴스 검색</option>
			</select>
			<select id="selector" name="selector" onchange="crawling1()" class="form-control">
				<option value="">SELECTOR 선택</option>
				<option>strong.cnf_news_title</option>
				<option>div.cnf_news_thumb</option>
			</select>
		</div>
		<hr/>
		<div class="mb-3"><input type="button" value="크롤링2(네이버 헤드라인뉴스)한번에가져오기" onclick="crawling2()" class="btn btn-primary"/></div>
		<p><br/></p>
		<div id="demo"></div>
	</div>
	<h6 id="topBtn" class="text-end me-3"><img src="${ctp}/images/arrowTop.gif" title="위로이동" /></h6>
</body>
</html>