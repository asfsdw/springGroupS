<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<title>menu</title>
	<style>
		th {
			background-color: #eee !important;
		}
	</style>
	<script>
		'use strict';
		
		function postCheck(flag) {
			if(flag == 1) myform.action = "${ctp}/study1/mapping/Test31";
			if(flag == 2) myform.action = "${ctp}/study1/mapping/Test32";
			if(flag == 3) myform.action = "${ctp}/study1/mapping/Test33";
			if(flag == 4) myform.action = "${ctp}/study1/mapping/Test34";
			
			myform.submit();
		}
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
	<p><br/></p>
	<div class="container">
		<h2 class="text-center">매핑 연습</h2>
		<p><br/></p>
		<div class="text-center">
			<hr/>
			<p><b>Query String방식: ?변수=값</b></p>
			<p>
				<a href="Test1?mid=hkd1234&pwd=1234" class="btn btn-success">test1</a> &nbsp;&nbsp;
				<a href="Test2?mid=kms1234&pwd=1234" class="btn btn-primary">test2</a> &nbsp;&nbsp;
				<a href="Test3?mid=ikj1234&pwd=1234" class="btn btn-secondary">test3</a> &nbsp;&nbsp;
				<a href="Test4?mid=snm1234&pwd=1234&sex=2" class="btn btn-info">test4</a> &nbsp;&nbsp;
				<a href="Test5?mid=snm1234&pwd=1234&name=소나무&gender=남자&age=20" class="btn btn-dark">test5</a> &nbsp;&nbsp;
				<br/>
				<br/>
				<a href="Test6?mid=ohn1234&pwd=1234&name=오하늘&gender=여자&age=22" class="btn btn-outline-success">test6</a> &nbsp;&nbsp;
				<a href="Test7?mid=gid1234&pwd=1234&name=고인돌&gender=남자&age=66" class="btn btn-outline-primary">test7</a> &nbsp;&nbsp;
				<a href="Test8?mid=atm1234&pwd=1234&name=아톰&gender=중성&age=12" class="btn btn-outline-secondary">test8</a> &nbsp;&nbsp;
				<a href="Test9?mid=btm1234&pwd=1234&name=비톰&gender=중성&age=44" class="btn btn-outline-info">test9</a> &nbsp;&nbsp;
			</p>
			<hr/>
			<p><b>Path Variable방식: /값1/값2</b></p>
			<p>
				<a href="Test21/hkd1234/1234" class="btn btn-success">test21</a> &nbsp;&nbsp;
				<a href="Test22/kms1234/1234" class="btn btn-primary">test22</a> &nbsp;&nbsp;
				<a href="1234/Test23/ikj1234" class="btn btn-secondary">test23</a> &nbsp;&nbsp;
				<a href="1234/asdf/Test24/ohn1234" class="btn btn-info">test24</a> &nbsp;&nbsp;
				<a href="Test25/abcd/btm1234/1234/1234/비톰/가나다/중성/44" class="btn btn-dark">test25</a> &nbsp;&nbsp;
			</p>
			<hr/>
			<p><b>post방식</b></p>
			<form name="myform" method="post">
				<table class="table table-bordered">
					<tr>
    	    <th>아이디</th>
    	    <td><input type="text" name="mid" id="mid" value="admin" class="form-control"/></td>
    	  </tr>
    	  <tr>
    	    <th>비밀번호</th>
    	    <td><input type="password" name="pwd" id="pwd" value="1234" class="form-control"/></td>
    	  </tr>
    	  <tr>
    	    <th>성명</th>
    	    <td><input type="text" name="name" id="name" value="관리자" class="form-control"/></td>
    	  </tr>
    	  <tr>
    	    <th>별명</th>
    	    <td><input type="text" name="nickName" id="nickName" value="관리맨" class="form-control"/></td>
    	  </tr>
    	  <tr>
    	    <th>나이</th>
    	    <td><input type="number" name="age" id="age" value="22" class="form-control"/></td>
    	  </tr>
    	  <tr>
    	    <th>성별</th>
    	    <td class="text-start">
    	      &nbsp;&nbsp;<input type="radio" name="strGender" id="gender1" class="mr-1" value="남자"/>남자 &nbsp;&nbsp;
    	      <input type="radio" name="strGender" id="gender2" class="mr-1" value="여자" checked />여자
    	    </td>
    	  </tr>
				</table>
				<p>
					<input type="button" value="post1" onclick="postCheck(1)" class="btn btn-success" />&nbsp;&nbsp;
					<input type="button" value="post2" onclick="postCheck(2)" class="btn btn-primary" />&nbsp;&nbsp;
					<input type="button" value="post3" onclick="postCheck(3)" class="btn btn-secondary" />
					<input type="button" value="post4" onclick="postCheck(4)" class="btn btn-info" />
				</p>
			</form>
		</div>
	</div>
	<p><br/></p>
	<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>