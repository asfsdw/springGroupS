<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>Mail Form</title>
	<script>
		'use strict'
		let str = "";
		let cnt = 1;
		
		// 주소록에 이메일 추가.
		function emailAdd() {
			let emailAddress = $("#emailAddress").val();
			if(emailAddress.trim() == "") {
				alert("이메일주소를 입력해주세요.");
				$("#emailAddress").focus();
				return false;
			}
			else {
				// 이메일의 주인을 물어본 후, 유저가 적은 이름으로 저장.
				let name = prompt("저장할 이름을 입력해주세요.");
				str += '<tr id="mailAddress'+cnt+'">';
				str += '<td>'+cnt+'</td>';
				str += '<td>'+name+'</td>';
				str += '<td id="emailAddress'+cnt+'">'+emailAddress+'</td>';
				// 받는 사람에 주입할 이메일을 선택한 후, 자동으로 modal 창을 닫기 위해 data-bs-dismiss="modal"를 추가해준다.
				str += '<td><input type="button" value="선택" onclick="emailSelect('+cnt+')" class="btn btn-success btn-sm" data-bs-dismiss="modal" /></td>';
				str += '<td><input type="button" value="삭제" onclick="emailDelete('+cnt+')" class="btn btn-danger btn-sm" /></td>';
				str += '</tr>';
			}
			// 주소록에 이름과 이메일 추가.
			$("#jusorok").append(str);
			// 메일주소 입력 폼 초기화.
			$("#emailAddress").val("");
			// str 초기화.
			str = "";
			cnt++;
		}
		// 주소록 주입.
		function emailSelect(selectCnt) {
			$("#toMail").val($("#emailAddress"+selectCnt).text());
		}
		// 주소록 삭제.
		function emailDelete(deleteCnt) {
			$("#mailAddress"+deleteCnt).remove();
		}
	</script>
  <style>
    th {
      background-color: #eee !important;
      text-align: center;
    }
  </style>
</head>
<body>
	<div class="container text-center">
		<h2>이메일 인증 연습</h2>
		<hr/>
		<h2 class="text-center mb-3">메 일 보 내 기</h2>
		<div class="text-end">(받는 사람의 메일주소를 정확히 입력하셔야 합니다.)</div>
		<form name="myform" method="post">
			<table class="table table-bordered">
				<tr>
					<th>받는사람</th>
					<td>
						<div class="input-group">
							<input type="text" name="toMail" id="toMail" placeholder="받는사람 메일주소를 입력하세요" autofocus required class="form-control" />
							<input type="button" value="주소록" data-bs-toggle="modal" data-bs-target="#myModal" class="btn btn-success" />
						</div>
					</td>
				</tr>
				<tr>
					<th>메일제목</th>
					<td><input type="text" name="title" placeholder="메일 제목을 입력하세요" required class="form-control" /></td>
				</tr>
				<tr>
					<th>메일내용</th>
					<td><textarea rows="7" name="content" placeholder="메일 내용을 입력하세요" required class="form-control"></textarea></td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="submit" value="메일보내기" class="btn btn-success me-2" />
						<input type="reset" value="다시쓰기" class="btn btn-warning" />
					</td>
				</tr>
			</table>
		</form>
		<hr/>
		<pre class="text-start">
 <font size="5">메일서버(SMTP/POP3/IMAP)</font>
 <font size="3"><b>SMPT(Simple Mail Transfer Protocol)</b></font>
  -인터넷에서 메일 주고 받기 위해 이용되는 프로토콜(규약).
  -RFC2821에 따라 규정한 사용 TCP포트번호는 25번이고,
   메일 서버간 송수신 뿐만 아니라 메일 클라에서 메일 서버로 메일을 보낼때에도 사용된다.
   우리가 메일을 보낼때는 바로 상대편의 컴퓨터로 메일을 송신하는것이 아니라,
   중간에 메일서버라는 곳을 몇군데 거치게 된다.
   메일서버에 메일이 보관되고 그것을 다시 다른 메일서버에 보내면서
   결국 보내고자하는 end-user에게 전해진다.
  -일반적으로 메일서버 간 메일을 주고받을때는 SMTP를 사용한다.
  
 <font size="3"><b>POP3(Post Office Protocol)</b></font>
  -받는메일이라고 불리는 POP 서버(version3) 이메일을 받아오는 표준 프로토콜.
   TCP포트번호는 110번
  -메일 서버에서 이메일을 로컬 PC로 수신받을 수 있는 client / server 프로토콜이다.
   메일 서버에 저장되어있는 메일을 로컬 pc로 가져오는 역할.
   pop3는 서버에서 메일을 받아오는 즉시 삭제되도록 만들어졌지만 서버저장 설정가능.
   스토리지용량에 제한있는 경우 유리하다.
   
 <font size="3"><b>IMAP(Internet Message Access Protocol)</b></font>
  -POP와 같이 메일 서버 종류 중 하나이다. TCP포트번호는 143번를 사용한다.
  -POP와는 달리 중앙 서버에서 동기화가 이뤄지기 때문에
   모든 장치에서 동일한 이메일 폴더를 확인할 수 있다.
  -스마트폰, 태블릿, PC모두 동일한 받은메일/보낸메일/기타폴더 등
   모든 이메일 메시지를 볼 수 있다.
  -서버에 이메일이 남겨진 상태로 사용자에게 이메일을 보여준다.
   그렇게 때문에 사용자는 언제 어디서나 원하는 메일을 열람할 수 있다.
  -메일이 서버에 저장되어있기 때문에 로컬pc에 문제가 생겨도
   이메일에는 아무 영향을 미치지 않는다.
		</pre>
		<p><br/></p>
	</div>
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 id="modal-title" class="modal-title">주소록</h4>
					<span id="modal-titleOption"></span>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<div class="input-group">
						<input type="text" name="emailAddress" id="emailAddress" placeholder="메일주소를 입력해주세요." class="form-control mb-2" />
						<input type="button" value="주소추가" onclick="emailAdd()" class="btn btn-success btn-sm mb-2" />
					</div>
					<table id="jusorok" class="table table-hover text-center">
						<tr class="table-secondary">
							<th>번호</th>
							<th>이름</th>
							<th>메일주소</th>
							<th>메일선택</th>
							<th>메일삭제</th>
						</tr>
					</table>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>