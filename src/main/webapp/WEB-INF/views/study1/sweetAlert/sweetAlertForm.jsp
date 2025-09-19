<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Sweet Alert</title>
	<script>
		'use strict';
		
		function ex(flag) {
			if(flag == 1) Swal.fire("안녕하세요1.");
			if(flag == 3) {
				Swal.fire({
					title: "이곳은 제목입니다1.",
					text: "이곳은 본문입니다1.",
					icon: "success"
				});
			}
		}
		
		let ex2 = () => Swal.fire("안녕하세요2.");
		
		// JQuery.
		$(() => {
			$("#ex3").on("click", () => {
				Swal.fire("이곳은 제목입니다2.","이곳은 본문입니다2.","success");
			});
			$("#ex4").on("click", () => {
				Swal.fire("이곳은 제목입니다.","이곳은 본문입니다.","error");
			});
			$("#ex5").on("click", () => {
				Swal.fire("이곳은 제목입니다.","이곳은 본문입니다.","info");
			});
			$("#ex6").on("click", () => {
				Swal.fire("이곳은 제목입니다.","이곳은 본문입니다.","warning");
			});
			$("#ex7").on("click", () => {
				Swal.fire("이곳은 제목입니다.","이곳은 본문입니다.","question");
			});
			
			// 확인, 취소.
			$("#confirm1").on("click", () => {
				Swal.fire({
					title: "이곳은 제목입니다1.",
					text : "이곳은 본문입니다1.",
					icon : "info",
					showCancelButton: true
				});
			});
			$("#confirm2").on("click", () => {
				Swal.fire({
					title: "이곳은 제목입니다2.",
					text : "이곳은 본문입니다2.",
					icon : "info",
					showCancelButton: true,
					confirmButtonText: '승인',
					cancelButtonText: '취소'
				});
			});
			$("#confirm3").on("click", () => {
				Swal.fire({
					title: "이곳은 제목입니다3.",
					text : "이곳은 본문입니다3.",
					icon : "info",
					showCancelButton: true,
					confirmButtonText: "승인",
					cancelButtonText: "취소",
					confirmButtonColor: "#55e",
					cancelButtonColor: "#e55"
				});
			});
			$("#confirm4").on("click", () => {
				Swal.fire({
					title: "이곳은 제목입니다4.",
					text : "이곳은 본문입니다4.",
					icon : "info",
					showCancelButton: true,
					confirmButtonText: "승인",
					cancelButtonText: "취소",
					confirmButtonColor: "#55e",
					cancelButtonColor: "#e55"
				}).then((res) => {
					if(res.isConfirmed) Swal.fire("승인되었습니다.","","success");
				});
			});
			$("#confirm5").on("click", () => {
				Swal.fire({
					title: "이곳은 제목입니다5.",
					text : "이곳은 본문입니다5.",
					icon : "info",
					showCancelButton: true,
					confirmButtonText: "승인",
					cancelButtonText: "취소",
					confirmButtonColor: "#55e",
					cancelButtonColor: "#e55"
				}).then((res) => {
					if(res.isConfirmed) Swal.fire("승인되었습니다.","","success");
					else Swal.fire("취소되었습니다.","","error");
				});
			});
			$("#confirm6").on("click", () => {
				Swal.fire({
					title: "이곳은 제목입니다6.",
					text : "이곳은 본문입니다6.",
					icon : "info",
					showCancelButton: true,
					showDenyButton: true,
					confirmButtonText: "승인",
					cancelButtonText: "취소",
					denyButtonText: "거부",
					confirmButtonColor: "#55e",
					cancelButtonColor: "#e55",
					denyButtonColor: "#515"
				}).then((res) => {
					if(res.isConfirmed) Swal.fire("승인되었습니다.","","success");
					else if(res.isDenied) Swal.fire("거부되었습니다.","","info");
					else Swal.fire("취소되었습니다.","","error");
				});
			});
			
			$("#prompt1").on("click", () => {
				(async () => {
					const {value : getName} = await Swal.fire({
						title: "이름을 입력하세요.",
						text : "이름은 한글로 입력하세요.",
						input: "text",
						inputPlaceholder: "이름을 입력해주세요."
					});
					
					if(getName) Swal.fire("이름: "+getName,"승인되었습니다.","success");
				})()
			});
			
			$("#image1").on("click", () => {
				swal.fire({
					title: "이미지입니다.",
					imageUrl: "https://cdn.pixabay.com/photo/2024/11/08/12/57/cat-9183327_960_720.jpg",
					imageAlt: "고양이"
				});
			});
			$("#image2").on("click", () => {
				swal.fire({
					title: "이미지입니다.",
					imageUrl: "https://cdn.pixabay.com/photo/2024/11/08/12/57/cat-9183327_960_720.jpg",
					imageWidth: 200,
					imageAlt: "고양이"
				});
			});
			$("#image3").on("click", () => {
				swal.fire({
					title: "이미지입니다.",
					imageUrl: "${ctp}/images/01.jpg",
					imageWidth: 200,
					imageAlt: "서버이미지"
				});
			});
			
			$("#html1").on("click", () => {
				swal.fire({
					title: "html연습1.",
					icon : "success",
					html : `
						<div class="mb-2">Welcome To <b>한국</b>!</div><br/>
						<a href="${ctp}/"><font size="5">HOME</font></a>
					`
				});
			});
		});
		
		function ajax1(idx) {
			alert("이곳은 ajax실행 전입니다.\nidx: "+idx);
			
			$.ajax({
				url : "${ctp}/study1/sweetAlert/ajax",
				type: "post",
				data: {idx : idx},
				success : (res) => {
					if(res != idx) swal.fire("결과: "+res,"ajax가 성공적으로 수행되었습니다.","success");
					else swal.fire("결과: "+res,"ajax 수행 실패.","error");
				},
				error : () => alert("전송오류")
			});
		}
	</script>
</head>
<body>
	<div class="container text-center">
		<h2>스윗 얼럿 연습</h2>
		<hr/>
		<div><button type="button" onclick="alert('안녕하세요.')" class="btn btn-secondary">일반 alert</button></div>
		<hr/>
		<div>
			<button type="button" onclick="ex(1)" class="btn btn-secondary me-1 mb-2">sweetAlert ex1</button>
			<button type="button" onclick="ex2()" class="btn btn-primary me-1 mb-2">sweetAlert ex2</button><br/>
			<button type="button" onclick="ex(3)" class="btn btn-success me-1 mb-2">sweetAlert success1</button>
			<button type="button" id="ex3" class="btn btn-success me-1 mb-2">sweetAlert success2</button>
			<button type="button" id="ex3_2" class="btn btn-success me-1 mb-2">sweetAlert success3</button><br/>
			<button type="button" id="ex4" class="btn btn-danger me-1 mb-2">error</button>
			<button type="button" id="ex5" class="btn btn-info me-1 mb-2">information</button>
			<button type="button" id="ex6" class="btn btn-warning me-1 mb-2">warning</button>
			<button type="button" id="ex7" class="btn btn-primary">question</button>
		</div>
		<hr/>
		<div>
			<button type="button" id="confirm1" class="btn btn-outline-success me-1 mb-2">confirm1</button>
			<button type="button" id="confirm2" class="btn btn-outline-primary me-1 mb-2">confirm2</button>
			<button type="button" id="confirm3" class="btn btn-outline-info me-1 mb-2">confirm3</button>
			<button type="button" id="confirm4" class="btn btn-outline-warning me-1 mb-2">confirm4</button><br/>
			<button type="button" id="confirm5" class="btn btn-outline-danger me-1 mb-2">confirm5</button>
			<button type="button" id="confirm6" class="btn btn-outline-danger me-1 mb-2">confirm6</button>
		</div>
		<hr/>
		<div>
			<button type="button" id="prompt1" class="btn btn-success me-1 mb-2">prompt</button><br/>
			<button type="button" id="image1" class="btn btn-primary me-1 mb-2">image1</button>
			<button type="button" id="image2" class="btn btn-info me-1 mb-2">image2</button>
			<button type="button" id="image3" class="btn btn-secondary me-1 mb-2">image3</button><br/>
			<button type="button" id="html1" class="btn btn-success me-1 mb-2">html1</button><br/>
			<button type="button" onclick="ajax1(100)" class="btn btn-success me-1 mb-2">ajax1</button><br/>
		</div>
		<p><br/></p>
	</div>
</body>
</html>