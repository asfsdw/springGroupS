<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>AJAX Object Form</title>
	<script>
		'use strict';
		
		// 지역으로 도시 추가(일반배열).
		function dodoCheck() {
			let dodo = $("#dodo").val();
			if(dodo.trim() == "") {
				alert("지역을 선택하세요.");
				return false;
			}
			
			$.ajax({
				url : "${ctp}/study1/ajax/AJAXObject1",
				type: "POST",
				data: {"dodo" : dodo},
				success : (res) => {
					let str = '<option>도시선택</option>';
					for(let i=0; i<res.length; i++) {
						if(res[i] == null) break;
						str += '<option>'+res[i]+'</option>';
					}
					$("#city").html(str);
				},
				error : () => alert("전송오류")
			});
		}
		
		// 선택한 지역과 도시를 demo에 출력.
		function fCheck() {
			let dodo = $("#dodo").val();
			let city = $("#city").val();
			if(dodo.trim() == "" || city.trim() == "") {
				alert("지역과 도시를 선택해주세요.");
				return false;
			}
			
			let str = "선택하신 지역은<br/><font color='red'>"+dodo+"</font>, <font color='blue'>"+city+"</font>입니다."
			$("#demo").html(str);
		}
		
		// 지역으로 도시 추가(arrayList).
		function dodoCheck2() {
			let dodo = $("#dodo2").val();
			if(dodo.trim() == "") {
				alert("지역을 선택하세요.");
				return false;
			}
			
			$.ajax({
				url : "${ctp}/study1/ajax/AJAXObject2",
				type: "POST",
				data: {"dodo" : dodo},
				success : (res) => {
					let str = '<option>도시선택</option>';
					for(let i=0; i<res.length; i++) {
						if(res[i] == null) break;
						str += '<option>'+res[i]+'</option>';
					}
					$("#city2").html(str);
				},
				error : () => alert("전송오류")
			});
		}
		
		// 선택한 지역과 도시를 demo에 출력.
		function fCheck2() {
			let dodo = $("#dodo2").val();
			let city = $("#city2").val();
			if(dodo.trim() == "" || city.trim() == "") {
				alert("지역과 도시를 선택해주세요.");
				return false;
			}
			
			let str = "선택하신 지역은<br/><font color='red'>"+dodo+"</font>, <font color='blue'>"+city+"</font>입니다."
			$("#demo").html(str);
		}
		
		// 지역으로 도시 추가(map).
		function dodoCheck3() {
			let dodo = $("#dodo3").val();
			if(dodo.trim() == "") {
				alert("지역을 선택하세요.");
				return false;
			}
			
			$.ajax({
				url : "${ctp}/study1/ajax/AJAXObject3",
				type: "POST",
				data: {"dodo" : dodo},
				success : (res) => {
					let str = '<option>도시선택</option>';
					console.log(res);
					for(let i=0; i<res.city.length; i++) {
						if(res.city[i] == null) break;
						str += '<option>'+res.city[i]+'</option>';
					}
					$("#city3").html(str);
				},
				error : () => alert("전송오류")
			});
		}
		
		// 선택한 지역과 도시를 demo에 출력.
		function fCheck3() {
			let dodo = $("#dodo3").val();
			let city = $("#city3").val();
			if(dodo.trim() == "" || city.trim() == "") {
				alert("지역과 도시를 선택해주세요.");
				return false;
			}
			
			let str = "선택하신 지역은<br/><font color='red'>"+dodo+"</font>, <font color='blue'>"+city+"</font>입니다."
			$("#demo").html(str);
		}
		
		// 아이디 검색.
		function midCheck1() {
			let mid = $("#mid").val();
			if(mid.trim() == "") {
				alert("검색할 아이디를 입력해주세요.");
				return false;
			}
			myform.submit();
		}
		// 아이디 검색(ajax).
		function midCheck2() {
			let mid = $("#mid").val();
			if(mid.trim() == "") {
				alert("검색할 아이디를 입력해주세요.");
				return false;
			}
			
			$.ajax({
				url : "${ctp}/study1/ajax/AJAXMidSearch2",
				type: "POST",
				data: {"mid" : mid},
				success : (res) => {
					let str = '';
					str += '번호: '+res.idx+'<br/>';
					str += '아이디: '+res.mid+'<br/>';
					str += '이름: '+res.name+'<br/>';
					str += '나이: '+res.age+'<br/>';
					str += '주소: '+res.address+'<br/>';
					$("#demo").html(str)+'<br/>';
				},
				error : () => alert("전송오류")
			});
		}
		// 아이디 검색(vos ajax).
		function midCheck3() {
			let mid = $("#mid").val();
			if(mid.trim() == "") {
				alert("검색할 아이디를 입력해주세요.");
				return false;
			}
			
			$.ajax({
				url : "${ctp}/study1/ajax/AJAXMidSearch3",
				type: "POST",
				success : (res) => {
					let str = '';
					str += '<table class="table table-hover">';
					str += '<tr class="table-secondary">';
					str += '<th>번호</th>';
					str += '<th>아이디</th>';
					str += '<th>이름</th>';
					str += '<th>나이</th>';
					str += '<th>주소</th>';
					str += '</tr>';
					for(let vo of res) {
						str += '<tr>';
						str += '<td>'+vo.idx+'</td>';
						str += '<td>'+vo.mid+'</td>';
						str += '<td>'+vo.name+'</td>';
						str += '<td>'+vo.age+'</td>';
						str += '<td>'+vo.address+'</td>';
						str += '</tr>';
					}
					str += '</table>';
					$("#demo").html(str);
				},
				error : () => alert("전송오류")
			});
		}
		// 아이디 검색(like).
		function midCheck4() {
			let mid = $("#mid").val();
			if(mid.trim() == "") {
				alert("검색할 아이디를 입력해주세요.");
				return false;
			}
			
			$.ajax({
				url : "${ctp}/study1/ajax/AJAXMidSearch4",
				type: "POST",
				data: {"mid" : mid},
				success : (res) => {
					let str = '';
					if(res != '') {
						str += '<table class="table table-hover">';
						str += '<tr class="table-secondary">';
						str += '<th>번호</th>';
						str += '<th>아이디</th>';
						str += '<th>이름</th>';
						str += '<th>나이</th>';
						str += '<th>주소</th>';
						str += '</tr>';
						for(let vo of res) {
							str += '<tr>';
							str += '<td>'+vo.idx+'</td>';
							str += '<td>'+vo.mid+'</td>';
							str += '<td>'+vo.name+'</td>';
							str += '<td>'+vo.age+'</td>';
							str += '<td>'+vo.address+'</td>';
							str += '</tr>';
						}
						str += '</table>';
					}
					else str += '찾으시는 자료가 존재하지 않습니다.';
					
					$("#demo").html(str);
				},
				error : () => alert("전송오류")
			});
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<h2>AJAX 객체전달 연습</h2>
		<hr/>
		<form>
			<h3>도시를 선택하세요(일반배열).</h3>
			<div class="input-group justify-content-center">
				<select name="dodo" id="dodo" onchange="dodoCheck()" class="form-select" style="flex: 0 0 150px;">
					<option>지역선택</option>
					<option>서울</option>
					<option>경기</option>
					<option>충북</option>
					<option>충남</option>
				</select>
				<select name="city" id="city" class="form-select" style="flex: 0 0 150px;">
					<option>도시선택</option>
				</select>
				<input type="button" value="선택" onclick="fCheck()" class="btn btn-success" />
				<input type="button" value="돌아가기" onclick="location.href='${ctp}/study1/ajax/AJAXForm';" class="btn btn-warning" />
			</div>
		</form>
		<hr/>
		
		<form>
			<h3>도시를 선택하세요(객체배열).</h3>
			<div class="input-group justify-content-center">
				<select name="dodo2" id="dodo2" onchange="dodoCheck2()" class="form-select" style="flex: 0 0 150px;">
					<option>지역선택</option>
					<option>서울</option>
					<option>경기</option>
					<option>충북</option>
					<option>충남</option>
				</select>
				<select name="city2" id="city2" class="form-select" style="flex: 0 0 150px;">
					<option>도시선택</option>
				</select>
				<input type="button" value="선택" onclick="fCheck2()" class="btn btn-success" />
				<input type="button" value="돌아가기" onclick="location.href='${ctp}/study1/ajax/AJAXForm';" class="btn btn-warning" />
			</div>
		</form>
		<hr/>
		<form>
			<h3>도시를 선택하세요(객체배열).</h3>
			<div class="input-group justify-content-center">
				<select name="dodo3" id="dodo3" onchange="dodoCheck3()" class="form-select" style="flex: 0 0 150px;">
					<option>지역선택</option>
					<option>서울</option>
					<option>경기</option>
					<option>충북</option>
					<option>충남</option>
				</select>
				<select name="city3" id="city3" class="form-select" style="flex: 0 0 150px;">
					<option>도시선택</option>
				</select>
				<input type="button" value="선택" onclick="fCheck3()" class="btn btn-success" />
				<input type="button" value="돌아가기" onclick="location.href='${ctp}/study1/ajax/AJAXForm';" class="btn btn-warning" />
			</div>
		</form>
		<hr/>
		<form name="myform" method="post" action="AJAXMidSearch">
		<h3>아이디 검색.</h3>
			<div class="input-group justify-content-center">
				<input type="text" name="mid" id="mid" value="admin" class="form-control" style="flex: 0 0 200px;" />
				<input type="button" value="검색1" onclick="midCheck1()" class="btn btn-success" />
				<input type="button" value="검색2(ajax)" onclick="midCheck2()" class="btn btn-primary" />
				<input type="button" value="검색3(vos ajax)" onclick="midCheck3()" class="btn btn-info" />
				<input type="button" value="검색4(like)" onclick="midCheck4()" class="btn btn-secondary" />
			</div>
		</form>
		<hr/>
		<div id="demo" style="font-size:2em"></div>
		<c:if test="${!empty vo}">
		<table class="table table-hover">
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>나이</th>
				<th>주소</th>
			</tr>
			<tr>
				<td>${vo.idx}</td>
				<td>${vo.mid}</td>
				<td>${vo.name}</td>
				<td>${vo.age}</td>
				<td>${vo.address}</td>
			</tr>
		</table>
		</c:if>
		<p><br/></p>
	</div>
</body>
</html>