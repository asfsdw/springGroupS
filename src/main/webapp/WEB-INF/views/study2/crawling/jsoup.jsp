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
		
		function crawling3() {
			let searchString = document.getElementById("searchString").value;
			let page = document.getElementById("page").value;
			if(searchString.trim() == "") {
				alert("검색어를 입력하세요");
				document.getElementById("searchString").focus();
				return false;
			}
			if(page.trim() == "") page = 2;
			
			let search = "https://search.naver.com/search.naver?nso=&page="+page+"&query="+searchString+"&sm=tab_pge&start="+((page-2)*15+1)+"&where=web";
			let searchSelector = "span.sds-comps-text-content";
			
			$.ajax({
				url  : "${ctp}/study2/crawling/jsoup3",
				type : "post",
				data : {
				search : search,
				searchSelector : searchSelector
				},
				success: (vos) => {
					if(vos != '') {
						let str = '<table class="table table-bordered text-center">';
						str += '<tr class="table-secondary"><th>번호</th><th>제목</th><th>언론사</th><th>사진</th></tr>';
						for(let i=0; i<vos.length; i++) {
							str += '<tr>';
							str += '<td>'+(i+1)+'</td>';
							str += '<td>'+vos[i].item1+'</td>';
							str += '<td>'+vos[i].item2+'</td>';
							str += '<td>'+vos[i].item3+'</td>';
							str += '</tr>';
						}
						str += '</table>';
						$("#demo").html(str);
					}
					else $("#demo").html("<b>검색된 자료가 없습니다.</b>");
				},
				error : () => {
					alert("전송오류!");
				}
			});
		}
		
		function crawling4() {
			let searchString = document.getElementById("searchString2").value;
			let page = document.getElementById("page2").value;
			if(searchString.trim() == "") {
				alert("검색어를 입력하세요");
				document.getElementById("searchString").focus();
				return false;
			}
			if(page.trim() == "") page = 1;
			
			let search = "https://search.naver.com/search.naver?nso=&page="+page+"&query="+searchString+"&sm=tab_pge&start="+((page-2)*15+1)+"&where=web";
			let searchSelector = "div.sds-comps-vertical-layout div.sds-comps-vertical-layout";
			
			$.ajax({
				url  : "${ctp}/study2/crawling/jsoup4",
				type : "post",
				data : {
					search : search,
					searchSelector : searchSelector
				},
				success: (vos) => $("#demo").html(vos),
				error : () => alert("전송오류!")
			});
		}
		
		function crawling5() {
			$.ajax({
				url  : "${ctp}/study2/crawling/jsoup5",
				type : "post",
				success:function(vos) {
					if(vos != "") {
						let str = '<table class="table table-bordered text-center">';
						str += '<tr class="table-secondary"><th>번호</th><th>제목</th><th>사진</th><th>언론사</th></tr>';
						for(let i=0; i<vos.length; i++) {
							str += '<tr>';
							str += '<td>'+(i+1)+'</td>';
							str += '<td>'+vos[i].item1+'</td>';
							str += '<td>'+vos[i].item2+'</td>';
							str += '<td>'+vos[i].item3+'</td>';
							str += '</tr>';
						}
						str += '<tr><td colspan="4" class="p-0 m-0"></td></tr>';
						str += '</table>';
						$("#demo").html(str);
					}
					else $("#demo").html("검색된 자료가 없습니다.");
				},
				error : function() {
				alert("전송오류!");
				}
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
		<hr/>
		<div class="input-group">
			<div class="input-group-text">네이버 검색어로 검색1</div>
			<input type="text" name="searchString" id="searchString" value="케이팝 데몬 헌터스" class="form-control"/>
			<input type="number" name="page" id="page" value="2" min="1" class="form-control"/>
			<input type="button" value="네이버검색" onclick="crawling3()" class="btn btn-info"/>
		</div>
		<hr/>
		<div class="input-group">
			<div class="input-group-text">네이버 검색어로 검색2</div>
			<input type="text" name="searchString2" id="searchString2" value="케이팝 데몬 헌터스" class="form-control"/>
			<input type="number" name="page2" id="page2" value="2" min="1" class="form-control"/>
			<input type="button" value="네이버검색2" onclick="crawling4()" class="btn btn-warning"/>
		</div>
		<hr/>
		<div class="mb-3"><input type="button" value="크롤링3(다음 엔터테인먼트)" onclick="crawling5()" class="btn btn-secondary"/></div>
		<p><br/></p>
		<div id="demo"></div>
	</div>
	<h6 id="topBtn" class="text-end me-3"><img src="${ctp}/images/arrowTop.gif" title="위로이동" /></h6>
</body>
</html>